//
//  ViewController.swift
//  JSON
//
//  Created by Chotipat on 9/17/2559 BE.
//  Copyright © 2559 Chotipat. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import CoreData

class ViewController: UITableViewController {
    var person = [NSManagedObject]()
    var ar_id = [String]()
    var url_link = [String]()
    
    var URL = "https://toyotaprivilegedev.azurewebsites.net/tprivilege_p3_service/?mode=ar&version=1"
    override func viewDidLoad() {
       // print(getShopDataFromJSON())
        super.viewDidLoad()
        checkData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func callAlmo(url : String){
        //Alamofire.request()
        
    }
    
    func checkData(){
        //let coredata = CoreData()
        Alamofire.request(.GET, URL).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let name = json["db"]
                    
                    for item in name.arrayValue{
                      let items = item["ar_id"].string as String!
                       // print(item["url_link"].stringValue)

                        self.ar_id.append(items)
                        self.url_link.append(item["url_link"].stringValue)
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        cell.textLabel?.text = url_link[indexPath.row]
        
        return cell
    }

}

