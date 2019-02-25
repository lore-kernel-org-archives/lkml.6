Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96218C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E11E2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfBYQOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:14:20 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43771 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfBYQOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:14:19 -0500
X-Originating-IP: 90.88.23.190
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B4019E0008;
        Mon, 25 Feb 2019 16:14:15 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com
Subject: [PATCH net-next 2/2] net: phy: marvell10g: Use the generic C45 helper to read the 2110 features
Date:   Mon, 25 Feb 2019 17:14:07 +0100
Message-Id: <20190225161407.19510-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190225161407.19510-1-maxime.chevallier@bootlin.com>
References: <20190225161407.19510-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contrary to the 3310, the 2110 PHY correctly reports it's 2.5G/5G
abilities. We can therefore use the genphy_c45_pma_read_abilities helper
to build the list of features.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index ab71da55c1e0..79106e70010f 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -472,7 +472,7 @@ static struct phy_driver mv3310_drivers[] = {
 		.phy_id		= MARVELL_PHY_ID_88E2110,
 		.phy_id_mask	= MARVELL_PHY_ID_MASK,
 		.name		= "mv88x2110",
-		.features	= PHY_10GBIT_FEATURES,
+		.get_features	= genphy_c45_pma_read_abilities,
 		.probe		= mv3310_probe,
 		.soft_reset	= gen10g_no_soft_reset,
 		.config_init	= mv3310_config_init,
-- 
2.19.2

