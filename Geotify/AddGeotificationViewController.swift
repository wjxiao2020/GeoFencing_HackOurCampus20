/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import MapKit
import CoreLocation

protocol AddGeotificationsViewControllerDelegate {
  func addGeotificationViewController(_ controller: AddGeotificationViewController, didAddCoordinate coordinate: CLLocationCoordinate2D,
                                      radius: Double, identifier: String, note: String, eventType: Geotification.EventType)
}

class AddGeotificationViewController: UITableViewController {
  
  @IBOutlet var addButton: UIBarButtonItem!
  @IBOutlet var zoomButton: UIBarButtonItem!
  @IBOutlet weak var eventTypeSegmentedControl: UISegmentedControl!
  @IBOutlet weak var radiusTextField: UITextField!
  @IBOutlet weak var noteTextField: UITextField!
  @IBOutlet weak var mapView: MKMapView!
  
  var delegate: AddGeotificationsViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("Second view whats the position")
    print(mapView.userLocation.coordinate)
    
    let curLoc = CLLocation(latitude: 0.000000, longitude: 0.000000)
    let Regionradius = 1000.0
    let region = MKCoordinateRegionMakeWithDistance(curLoc.coordinate, CLLocationDistance(Regionradius), CLLocationDistance(Regionradius))
    mapView.setRegion(region, animated: false)
    
    navigationItem.rightBarButtonItems = [addButton, zoomButton]
    addButton.isEnabled = false
  }
  
  @IBAction func textFieldEditingChanged(sender: UITextField) {
    addButton.isEnabled = !radiusTextField.text!.isEmpty && !noteTextField.text!.isEmpty
  }
  
  @IBAction func onCancel(sender: AnyObject) {
    dismiss(animated: true, completion: nil)
  }
  
  
  
  
  
  @IBAction private func onAdd(sender: AnyObject){
    
    

//    mapView.delegate = self as! MKMapViewDelegate
    
  
  //currently array of crowded locations has n number of elements, if previous is lower than n, update n and push to segue
  

    
    
//    func setCenter(_ coordinate: CLLocationCoordinate2D,
//                   animated: Bool){
//          let coordinate = CLLocationCoordinate2D.init(latitude: 0.000000, longitude: 0.000000)
//
//
//    }
//    setCenter(CLLocationCoordinate2D, animated: false)
//

    let coordinate = mapView.centerCoordinate
    
    let radius = Double(radiusTextField.text!) ?? 0
    let identifier = NSUUID().uuidString
    let note = noteTextField.text
    let eventType: Geotification.EventType = (eventTypeSegmentedControl.selectedSegmentIndex == 0) ? .onEntry : .onExit
    delegate?.addGeotificationViewController(self, didAddCoordinate: coordinate, radius: radius, identifier: identifier, note: note!, eventType: eventType)
  }
  
  @IBAction private func onZoomToCurrentLocation(sender: AnyObject) {
    mapView.setCenter(mapView.userLocation.coordinate, animated: true)
    print("RUNNINGTo")
    print(mapView.userLocation.coordinate)
    //mapView.zoomToUserLocation()
  }
}
