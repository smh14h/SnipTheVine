
//  GameScene.swift
//  SnipTheVine

/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  private var crocodile: SKSpriteNode!
  private var prize: SKSpriteNode!
  private var particles: SKEmitterNode?
  
  override func didMove(to view: SKView) {
    setUpPhysics()
    setUpScenery()
    setUpPrize()
    setUpVines()
    setUpCrocodile()
    
    setUpAudio()
  }
  
  //MARK: - Level setup
  
  fileprivate func setUpPhysics() {
    physicsWorld.contactDelegate = self
    physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
    physicsWorld.speed = 1.0
    
  }
  
  fileprivate func setUpScenery() {
    
    let background = SKSpriteNode(imageNamed: ImageName.Background)
    background.anchorPoint = CGPoint(x: 0, y: 0)
    background.position = CGPoint(x: 0, y: 0)
    background.zPosition = Layer.Background
    background.size = CGSize(width: size.width, height: size.height)
    addChild(background)
    
    let water = SKSpriteNode(imageNamed: ImageName.Water)
    water.anchorPoint = CGPoint(x: 0, y: 0)
    water.position = CGPoint(x: 0, y: 0)
    water.zPosition = Layer.Foreground
    water.size = CGSize(width: size.width, height: size.height * 0.2139)
    addChild(water)
    
  }
  
  fileprivate func setUpPrize() {
    prize = SKSpriteNode(imageNamed: ImageName.Prize)
    prize.position = CGPoint(x: size.width * 0.5, y: size.height * 0.7)
    prize.zPosition = Layer.Prize
    prize.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: ImageName.Prize), size: prize.size)
    prize.physicsBody?.categoryBitMask = PhysicsCategory.Prize
    prize.physicsBody?.collisionBitMask = 0
    prize.physicsBody?.density = 0.5
    
    addChild(prize)
    
  }
  
  //MARK: - Vine methods
  
  fileprivate func setUpVines() {
    // 1 load vine data
    let dataFile = Bundle.main.path(forResource: GameConfiguration.VineDataFile, ofType: nil)
    let vines = NSArray(contentsOfFile: dataFile!) as! [NSDictionary]
    
    // 2 add vines
    for i in 0..<vines.count {
      // 3 create vine
      let vineData = vines[i]
      let length = Int(vineData["length"] as! NSNumber)
      let relAnchorPoint = CGPointFromString(vineData["relAnchorPoint"] as! String)
      let anchorPoint = CGPoint(x: relAnchorPoint.x * size.width,
                                y: relAnchorPoint.y * size.height)
      let vine = VineNode(length: length, anchorPoint: anchorPoint, name: "\(i)")
      
      // 4 add to scene
      vine.addToScene(self)
      
      // 5 connect the other end of the vine to the prize
      vine.attachToPrize(prize)
    }
    
  }
  
  //MARK: - Croc methods
  
  fileprivate func setUpCrocodile() {
    crocodile = SKSpriteNode(imageNamed: ImageName.CrocMouthClosed)
    crocodile.position = CGPoint(x: size.width * 0.75, y: size.height * 0.312)
    crocodile.zPosition = Layer.Crocodile
    crocodile.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: ImageName.CrocMask), size: crocodile.size)
    crocodile.physicsBody?.categoryBitMask = PhysicsCategory.Crocodile
    crocodile.physicsBody?.collisionBitMask = 0
    crocodile.physicsBody?.contactTestBitMask = PhysicsCategory.Prize
    crocodile.physicsBody?.isDynamic = false
    
    addChild(crocodile)
    
    animateCrocodile()
    
  }
  
  fileprivate func animateCrocodile() {
    let duration = 2.0 + drand48() * 2.0
    let open = SKAction.setTexture(SKTexture(imageNamed: ImageName.CrocMouthOpen))
    let wait = SKAction.wait(forDuration: duration)
    let close = SKAction.setTexture(SKTexture(imageNamed: ImageName.CrocMouthClosed))
    let sequence = SKAction.sequence([wait, open, wait, close])
    
    crocodile.run(SKAction.repeatForever(sequence))
    
  }
  
  fileprivate func runNomNomAnimationWithDelay(_ delay: TimeInterval) {
    
    
  }
  
  //MARK: - Touch handling
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    particles?.removeFromParent()
    particles = nil
  }
  
  fileprivate func showMoveParticles(touchPosition: CGPoint) {
    if particles == nil {
      particles = SKEmitterNode(fileNamed: "Particle.sks")
      particles!.zPosition = 1
      particles!.targetNode = self
      addChild(particles!)
    }
    particles!.position = touchPosition
  }
  
  //MARK: - Game logic
  
  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    
    
  }
  
  fileprivate func checkIfVineCutWithBody(_ body: SKPhysicsBody) {
    
    
  }
  
  fileprivate func switchToNewGameWithTransition(_ transition: SKTransition) {
    
    
  }
  
  //MARK: - Audio
  
  fileprivate func setUpAudio() {
    
    
  }
  
}
