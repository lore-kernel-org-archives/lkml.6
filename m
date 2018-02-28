Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934350AbeB1T7I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:59:08 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33356 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934303AbeB1T7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:59:05 -0500
X-Google-Smtp-Source: AG47ELuZOmgIROgevONihoMu7C9MCoNK/gqEucDnJ+Jwhv6h8u3PH5ZcLgwPrUn59jSUNWGqJ0LZ1A==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), moritz.fischer@ettus.com
Subject: [PATCH net-next v2 5/5] net: phy: marvell10g: Utilize gen10g_soft_reset()
Date: Wed, 28 Feb 2018 11:58:49 -0800
Message-Id: <20180228195849.17770-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180228195849.17770-1-f.fainelli@gmail.com>
References: <20180228195849.17770-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do the same thing as the generic function: nothing, so utilize it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/marvell10g.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 8a0bd98fdec7..4f1efa02a930 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -71,15 +71,6 @@ static int mv3310_probe(struct phy_device *phydev)
 	return 0;
 }
 
-/*
- * Resetting the MV88X3310 causes it to become non-responsive.  Avoid
- * setting the reset bit(s).
- */
-static int mv3310_soft_reset(struct phy_device *phydev)
-{
-	return 0;
-}
-
 static int mv3310_config_init(struct phy_device *phydev)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
@@ -377,7 +368,7 @@ static struct phy_driver mv3310_drivers[] = {
 				  SUPPORTED_10000baseT_Full |
 				  SUPPORTED_Backplane,
 		.probe		= mv3310_probe,
-		.soft_reset	= mv3310_soft_reset,
+		.soft_reset	= gen10g_no_soft_reset,
 		.config_init	= mv3310_config_init,
 		.config_aneg	= mv3310_config_aneg,
 		.aneg_done	= mv3310_aneg_done,
-- 
2.14.1
