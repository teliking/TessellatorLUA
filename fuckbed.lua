function onActorTick(actor)
   local player = getLocalPlayer()
   if player ~= actor then return end
   
   local pos = getActorPosition(player)
   local region = getRegion(player)
   
   -- 定义搜索范围
   local range = 4
   local px = math.floor(pos.x)
   local py = math.floor(pos.y)
   local pz = math.floor(pos.z)

   -- 搜索周围方块
   for x = px - range, px + range do
       for y = py - range, py + range do
           for z = pz - range, pz + range do
               local block = getBlock(region, x, y, z)
               if block then
                   local name = getBlockName(block)
                   -- 检查方块名是否包含"bed"
                   if string.find(name, "bed") then
                       -- 发现床就破坏
                       destroyBlock(player, x, y, z, 0)
                       displayMessage("发现床! 位置: " .. x .. "," .. y .. "," .. z)
                       
                       -- 可选：显示更多信息
                       local trueName = getBlockNameTrue(block)
                       showTip("破坏方块: " .. trueName)
                       return  -- 每次只破坏一个
                   end
               end
           end
       end
   end
end