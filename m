Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2243AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC662081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC662081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436823AbeKWAEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:04:47 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55788 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388885AbeKWAEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:04:47 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3767020DC4; Thu, 22 Nov 2018 14:25:25 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id E608920DBF;
        Thu, 22 Nov 2018 14:25:14 +0100 (CET)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next] net: phy: vitesse: remove duplicate support for VSC8574
Date:   Thu, 22 Nov 2018 14:24:32 +0100
Message-Id: <20181122132432.348-1-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A more featureful support for VSC8574 was recently added to the
Microsemi (mscc.c) driver. I checked that features supported in the
Vitesse driver are also supported in the Microsemi driver.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/vitesse.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index 4ca513feba0e..0646af458f6a 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -70,7 +70,6 @@
 #define PHY_ID_VSC8244			0x000fc6c0
 #define PHY_ID_VSC8514			0x00070670
 #define PHY_ID_VSC8572			0x000704d0
-#define PHY_ID_VSC8574			0x000704a0
 #define PHY_ID_VSC8601			0x00070420
 #define PHY_ID_VSC7385			0x00070450
 #define PHY_ID_VSC7388			0x00070480
@@ -303,7 +302,6 @@ static int vsc82xx_config_intr(struct phy_device *phydev)
 			 phydev->drv->phy_id == PHY_ID_VSC8244 ||
 			 phydev->drv->phy_id == PHY_ID_VSC8514 ||
 			 phydev->drv->phy_id == PHY_ID_VSC8572 ||
-			 phydev->drv->phy_id == PHY_ID_VSC8574 ||
 			 phydev->drv->phy_id == PHY_ID_VSC8601) ?
 				MII_VSC8244_IMASK_MASK :
 				MII_VSC8221_IMASK_MASK);
@@ -430,15 +428,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.config_aneg    = &vsc82x4_config_aneg,
 	.ack_interrupt  = &vsc824x_ack_interrupt,
 	.config_intr    = &vsc82xx_config_intr,
-}, {
-	.phy_id         = PHY_ID_VSC8574,
-	.name           = "Vitesse VSC8574",
-	.phy_id_mask    = 0x000ffff0,
-	.features       = PHY_GBIT_FEATURES,
-	.config_init    = &vsc824x_config_init,
-	.config_aneg    = &vsc82x4_config_aneg,
-	.ack_interrupt  = &vsc824x_ack_interrupt,
-	.config_intr    = &vsc82xx_config_intr,
 }, {
 	.phy_id         = PHY_ID_VSC8601,
 	.name           = "Vitesse VSC8601",
@@ -519,7 +508,6 @@ static struct mdio_device_id __maybe_unused vitesse_tbl[] = {
 	{ PHY_ID_VSC8244, 0x000fffc0 },
 	{ PHY_ID_VSC8514, 0x000ffff0 },
 	{ PHY_ID_VSC8572, 0x000ffff0 },
-	{ PHY_ID_VSC8574, 0x000ffff0 },
 	{ PHY_ID_VSC7385, 0x000ffff0 },
 	{ PHY_ID_VSC7388, 0x000ffff0 },
 	{ PHY_ID_VSC7395, 0x000ffff0 },
-- 
2.17.1

