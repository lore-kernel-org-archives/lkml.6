Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163684AbeCBAJQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 19:09:16 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36289 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163111AbeCBAJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 19:09:12 -0500
X-Google-Smtp-Source: AG47ELveTssYvMrFjpbGMQgi+VY8DyDXAjo5eEw8DiYRjb5RF/5zrXKpdlIZyvAO1e0TWm/2/7bltw==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), moritz.fischer@ettus.com
Subject: [PATCH net-next v3 1/5] net: phy: aquantia: Utilize genphy_c45_aneg_done()
Date: Thu,  1 Mar 2018 16:08:55 -0800
Message-Id: <20180302000859.17309-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180302000859.17309-1-f.fainelli@gmail.com>
References: <20180302000859.17309-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver duplicates what the generic function does, so use the generic
function intead.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/aquantia.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index e8ae50e1255e..319edc9c8ec7 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -38,14 +38,6 @@ static int aquantia_config_aneg(struct phy_device *phydev)
 	return 0;
 }
 
-static int aquantia_aneg_done(struct phy_device *phydev)
-{
-	int reg;
-
-	reg = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
-	return (reg < 0) ? reg : (reg & BMSR_ANEGCOMPLETE);
-}
-
 static int aquantia_config_intr(struct phy_device *phydev)
 {
 	int err;
@@ -125,7 +117,7 @@ static struct phy_driver aquantia_driver[] = {
 	.name		= "Aquantia AQ1202",
 	.features	= PHY_AQUANTIA_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
-	.aneg_done	= aquantia_aneg_done,
+	.aneg_done	= genphy_c45_aneg_done,
 	.config_aneg    = aquantia_config_aneg,
 	.config_intr	= aquantia_config_intr,
 	.ack_interrupt	= aquantia_ack_interrupt,
@@ -137,7 +129,7 @@ static struct phy_driver aquantia_driver[] = {
 	.name		= "Aquantia AQ2104",
 	.features	= PHY_AQUANTIA_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
-	.aneg_done	= aquantia_aneg_done,
+	.aneg_done	= genphy_c45_aneg_done,
 	.config_aneg    = aquantia_config_aneg,
 	.config_intr	= aquantia_config_intr,
 	.ack_interrupt	= aquantia_ack_interrupt,
@@ -149,7 +141,7 @@ static struct phy_driver aquantia_driver[] = {
 	.name		= "Aquantia AQR105",
 	.features	= PHY_AQUANTIA_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
-	.aneg_done	= aquantia_aneg_done,
+	.aneg_done	= genphy_c45_aneg_done,
 	.config_aneg    = aquantia_config_aneg,
 	.config_intr	= aquantia_config_intr,
 	.ack_interrupt	= aquantia_ack_interrupt,
@@ -161,7 +153,7 @@ static struct phy_driver aquantia_driver[] = {
 	.name		= "Aquantia AQR106",
 	.features	= PHY_AQUANTIA_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
-	.aneg_done	= aquantia_aneg_done,
+	.aneg_done	= genphy_c45_aneg_done,
 	.config_aneg    = aquantia_config_aneg,
 	.config_intr	= aquantia_config_intr,
 	.ack_interrupt	= aquantia_ack_interrupt,
@@ -173,7 +165,7 @@ static struct phy_driver aquantia_driver[] = {
 	.name		= "Aquantia AQR107",
 	.features	= PHY_AQUANTIA_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
-	.aneg_done	= aquantia_aneg_done,
+	.aneg_done	= genphy_c45_aneg_done,
 	.config_aneg    = aquantia_config_aneg,
 	.config_intr	= aquantia_config_intr,
 	.ack_interrupt	= aquantia_ack_interrupt,
@@ -185,7 +177,7 @@ static struct phy_driver aquantia_driver[] = {
 	.name		= "Aquantia AQR405",
 	.features	= PHY_AQUANTIA_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
-	.aneg_done	= aquantia_aneg_done,
+	.aneg_done	= genphy_c45_aneg_done,
 	.config_aneg    = aquantia_config_aneg,
 	.config_intr	= aquantia_config_intr,
 	.ack_interrupt	= aquantia_ack_interrupt,
-- 
2.14.1
