Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCAAC65BD7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DCA2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DCA2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeJHRSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:18:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38944 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbeJHRSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:18:49 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 56827208B7; Mon,  8 Oct 2018 12:07:50 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 134FA208C2;
        Mon,  8 Oct 2018 12:07:40 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v3 5/6] net: phy: mscc: shorten `x != 0` condition to `x`
Date:   Mon,  8 Oct 2018 12:07:27 +0200
Message-Id: <20181008100728.24959-6-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008100728.24959-1-quentin.schulz@bootlin.com>
References: <20181008100728.24959-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`if (x != 0)` is basically a more verbose version of `if (x)` so let's
use the latter so it's consistent throughout the whole driver.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 0ff7803ed16b..6bfdc168c62b 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -310,7 +310,7 @@ static int vsc85xx_mdix_set(struct phy_device *phydev, u8 mdix)
 			     DISABLE_HP_AUTO_MDIX_MASK);
 	}
 	rc = phy_write(phydev, MSCC_PHY_BYPASS_CONTROL, reg_val);
-	if (rc != 0)
+	if (rc)
 		return rc;
 
 	reg_val = 0;
@@ -425,14 +425,14 @@ static int vsc85xx_wol_set(struct phy_device *phydev,
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
@@ -603,7 +603,7 @@ static int vsc85xx_mac_if_set(struct phy_device *phydev,
 		goto out_unlock;
 	}
 	rc = phy_write(phydev, MSCC_PHY_EXT_PHY_CNTL_1, reg_val);
-	if (rc != 0)
+	if (rc)
 		goto out_unlock;
 
 	rc = genphy_soft_reset(phydev);
-- 
2.17.1

