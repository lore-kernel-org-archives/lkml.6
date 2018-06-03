Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeFCURH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 16:17:07 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:35632 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFCURG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 16:17:06 -0400
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sun, 03 Jun 2018 22:17:05 +0200
X-ME-IP: 90.55.202.35
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pxa: zylonite: use the new ac97 bus support
Date: Sun,  3 Jun 2018 22:17:02 +0200
Message-Id: <20180603201702.15919-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the PXA is converted to new ac97 bus support, the wm9713 is
automatically detected and probed. Remove it from the platform bus.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/zylonite.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index d69de312d8d9..52e70a5c1281 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -47,16 +47,6 @@ int wm9713_irq;
 int lcd_id;
 int lcd_orientation;
 
-struct platform_device pxa_device_wm9713_audio = {
-	.name		= "wm9713-codec",
-	.id		= -1,
-};
-
-static void __init zylonite_init_wm9713_audio(void)
-{
-	platform_device_register(&pxa_device_wm9713_audio);
-}
-
 static struct resource smc91x_resources[] = {
 	[0] = {
 		.start	= ZYLONITE_ETH_PHYS + 0x300,
@@ -428,7 +418,6 @@ static void __init zylonite_init(void)
 	zylonite_init_nand();
 	zylonite_init_leds();
 	zylonite_init_ohci();
-	zylonite_init_wm9713_audio();
 }
 
 MACHINE_START(ZYLONITE, "PXA3xx Platform Development Kit (aka Zylonite)")
-- 
2.11.0
