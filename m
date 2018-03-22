Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeCVWeN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:34:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41881 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeCVWeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:34:08 -0400
X-Google-Smtp-Source: AG47ELuaLzGZnRQGkLFXab+iI+kwMSZ3ui+fxiVz+z1horoeNkUPTB8f7GSbrdy7TOrGyThabTZZDA==
From: Mathias Kresin <dev@kresin.me>
To: andrew@lunn.ch, f.fainelli@gmail.com, hauke@hauke-m.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: phy: intel-xway: add VR9 version number
Date: Thu, 22 Mar 2018 23:31:38 +0100
Message-Id: <1521757899-27813-1-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VR9 phy ids are matching only for the SoC version 1.2. Rename the
macros and change the names to take this into account.

Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 drivers/net/phy/intel-xway.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/intel-xway.c b/drivers/net/phy/intel-xway.c
index a11f80c..c7eff67 100644
--- a/drivers/net/phy/intel-xway.c
+++ b/drivers/net/phy/intel-xway.c
@@ -149,8 +149,8 @@
 #define PHY_ID_PHY22F_1_4		0xD565A410
 #define PHY_ID_PHY11G_1_5		0xD565A401
 #define PHY_ID_PHY22F_1_5		0xD565A411
-#define PHY_ID_PHY11G_VR9		0xD565A409
-#define PHY_ID_PHY22F_VR9		0xD565A419
+#define PHY_ID_PHY11G_VR9_1_2		0xD565A409
+#define PHY_ID_PHY22F_VR9_1_2		0xD565A419
 
 static int xway_gphy_config_init(struct phy_device *phydev)
 {
@@ -312,9 +312,9 @@ static struct phy_driver xway_gphy[] = {
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 	}, {
-		.phy_id		= PHY_ID_PHY11G_VR9,
+		.phy_id		= PHY_ID_PHY11G_VR9_1_2,
 		.phy_id_mask	= 0xffffffff,
-		.name		= "Intel XWAY PHY11G (xRX integrated)",
+		.name		= "Intel XWAY PHY11G (xRX v1.2 integrated)",
 		.features	= PHY_GBIT_FEATURES,
 		.flags		= PHY_HAS_INTERRUPT,
 		.config_init	= xway_gphy_config_init,
@@ -324,9 +324,9 @@ static struct phy_driver xway_gphy[] = {
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 	}, {
-		.phy_id		= PHY_ID_PHY22F_VR9,
+		.phy_id		= PHY_ID_PHY22F_VR9_1_2,
 		.phy_id_mask	= 0xffffffff,
-		.name		= "Intel XWAY PHY22F (xRX integrated)",
+		.name		= "Intel XWAY PHY22F (xRX v1.2 integrated)",
 		.features	= PHY_BASIC_FEATURES,
 		.flags		= PHY_HAS_INTERRUPT,
 		.config_init	= xway_gphy_config_init,
@@ -346,8 +346,8 @@ static struct mdio_device_id __maybe_unused xway_gphy_tbl[] = {
 	{ PHY_ID_PHY22F_1_4, 0xffffffff },
 	{ PHY_ID_PHY11G_1_5, 0xffffffff },
 	{ PHY_ID_PHY22F_1_5, 0xffffffff },
-	{ PHY_ID_PHY11G_VR9, 0xffffffff },
-	{ PHY_ID_PHY22F_VR9, 0xffffffff },
+	{ PHY_ID_PHY11G_VR9_1_2, 0xffffffff },
+	{ PHY_ID_PHY22F_VR9_1_2, 0xffffffff },
 	{ }
 };
 MODULE_DEVICE_TABLE(mdio, xway_gphy_tbl);
-- 
2.7.4
