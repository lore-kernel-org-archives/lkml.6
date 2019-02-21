Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E216C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0585D20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfBUJvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:51:45 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:53873 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfBUJvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:51:41 -0500
X-Originating-IP: 90.88.23.190
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 8995EC000A;
        Thu, 21 Feb 2019 09:51:37 +0000 (UTC)
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
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 2/7] net: phy: marvell10g: Use linkmode_set_bit helper instead of __set_bit
Date:   Thu, 21 Feb 2019 10:51:23 +0100
Message-Id: <20190221095128.28188-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
References: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cosmetic patch making use of helpers dedicated to linkmodes handling.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 65ef469adf58..8e2d6039b9b3 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -252,8 +252,8 @@ static int mv3310_get_features(struct phy_device *phydev)
 			return val;
 
 		if (val & MDIO_AN_STAT1_ABLE)
-			__set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
-				  phydev->supported);
+			linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+					 phydev->supported);
 	}
 
 	ret = genphy_c45_pma_read_abilities(phydev);
-- 
2.19.2

