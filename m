Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9ECFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BD020866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BD020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbeINNrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:47:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34136 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbeINNr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:47:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B2888208DC; Fri, 14 Sep 2018 10:34:02 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7A59920731;
        Fri, 14 Sep 2018 10:34:02 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next 4/5] net: phy: mscc: shorten `x != 0` condition to `x`
Date:   Fri, 14 Sep 2018 10:33:46 +0200
Message-Id: <2efac3971c41837fec6001018c1275d81286512a.1536913944.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`if (x != 0)` is basically a more verbose version of `if (x)` so let's
use the latter so it's consistent throughout the whole driver.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 734d9fb..efa9352 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -311,11 +311,11 @@ static int vsc85xx_mdix_set(struct phy_device *phydev, u8 mdix)
 			     DISABLE_HP_AUTO_MDIX_MASK);
 	}
 	rc = phy_write(phydev, MSCC_PHY_BYPASS_CONTROL, reg_val);
-	if (rc != 0)
+	if (rc)
 		return rc;
 
 	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED);
-	if (rc != 0)
+	if (rc)
 		return rc;
 
 	reg_val = phy_read(phydev, MSCC_PHY_EXT_MODE_CNTL);
@@ -325,11 +325,11 @@ static int vsc85xx_mdix_set(struct phy_device *phydev, u8 mdix)
 	else if (mdix == ETH_TP_MDI_X)
 		reg_val |= FORCE_MDI_CROSSOVER_MDIX;
 	rc = phy_write(phydev, MSCC_PHY_EXT_MODE_CNTL, reg_val);
-	if (rc != 0)
+	if (rc)
 		return rc;
 
 	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_STANDARD);
-	if (rc != 0)
+	if (rc)
 		return rc;
 
 	return genphy_restart_aneg(phydev);
@@ -341,7 +341,7 @@ static int vsc85xx_downshift_get(struct phy_device *phydev, u8 *count)
 	u16 reg_val;
 
 	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED);
-	if (rc != 0)
+	if (rc)
 		goto out;
 
 	reg_val = phy_read(phydev, MSCC_PHY_ACTIPHY_CNTL);
@@ -373,14 +373,14 @@ static int vsc85xx_downshift_set(struct phy_device *phydev, u8 count)
 	}
 
 	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED);
-	if (rc != 0)
+	if (rc)
 		goto out;
 
 	reg_val = phy_read(phydev, MSCC_PHY_ACTIPHY_CNTL);
 	reg_val &= ~(DOWNSHIFT_CNTL_MASK);
 	reg_val |= count;
 	rc = phy_write(phydev, MSCC_PHY_ACTIPHY_CNTL, reg_val);
-	if (rc != 0)
+	if (rc)
 		goto out;
 
 	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_STANDARD);
@@ -401,7 +401,7 @@ static int vsc85xx_wol_set(struct phy_device *phydev,
 
 	mutex_lock(&phydev->lock);
 	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED_2);
-	if (rc != 0)
+	if (rc)
 		goto out_unlock;
 
 	if (wol->wolopts & WAKE_MAGIC) {
@@ -439,7 +439,7 @@ static int vsc85xx_wol_set(struct phy_device *phydev,
 	phy_write(phydev, MSCC_PHY_WOL_MAC_CONTROL, reg_val);
 
 	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_STANDARD);
-	if (rc != 0)
+	if (rc)
 		goto out_unlock;
 
 	if (wol->wolopts & WAKE_MAGIC) {
@@ -447,14 +447,14 @@ static int vsc85xx_wol_set(struct phy_device *phydev,
 		reg_val = phy_read(phydev, MII_VSC85XX_INT_MASK);
 		reg_val |= MII_VSC85XX_INT_MASK_WOL;
 		rc = phy_write(phydev, MII_VSC85XX_INT_MASK, reg_val);
-		if (rc != 0)
+		if (rc)
 			goto out_unlock;
 	} else {
 		/* Disable the WOL interrupt */
 		reg_val = phy_read(phydev, MII_VSC85XX_INT_MASK);
 		reg_val &= (~MII_VSC85XX_INT_MASK_WOL);
 		rc = phy_write(phydev, MII_VSC85XX_INT_MASK, reg_val);
-		if (rc != 0)
+		if (rc)
 			goto out_unlock;
 	}
 	/* Clear WOL iterrupt status */
@@ -595,13 +595,13 @@ static int vsc85xx_edge_rate_cntl_set(struct phy_device *phydev, u8 edge_rate)
 
 	mutex_lock(&phydev->lock);
 	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED_2);
-	if (rc != 0)
+	if (rc)
 		goto out_unlock;
 	reg_val = phy_read(phydev, MSCC_PHY_WOL_MAC_CONTROL);
 	reg_val &= ~(EDGE_RATE_CNTL_MASK);
 	reg_val |= (edge_rate << EDGE_RATE_CNTL_POS);
 	rc = phy_write(phydev, MSCC_PHY_WOL_MAC_CONTROL, reg_val);
-	if (rc != 0)
+	if (rc)
 		goto out_unlock;
 	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_STANDARD);
 
@@ -636,7 +636,7 @@ static int vsc85xx_mac_if_set(struct phy_device *phydev,
 		goto out_unlock;
 	}
 	rc = phy_write(phydev, MSCC_PHY_EXT_PHY_CNTL_1, reg_val);
-	if (rc != 0)
+	if (rc)
 		goto out_unlock;
 
 	rc = genphy_soft_reset(phydev);
@@ -655,7 +655,7 @@ static int vsc85xx_default_config(struct phy_device *phydev)
 	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
 	mutex_lock(&phydev->lock);
 	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED_2);
-	if (rc != 0)
+	if (rc)
 		goto out_unlock;
 
 	reg_val = phy_read(phydev, MSCC_PHY_RGMII_CNTL);
-- 
git-series 0.9.1
