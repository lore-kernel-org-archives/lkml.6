Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D14C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E53F20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfARPYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:24:46 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51344 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbfARPYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:24:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8626120898; Fri, 18 Jan 2019 16:24:23 +0100 (CET)
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9E4C8209C0;
        Fri, 18 Jan 2019 16:24:04 +0100 (CET)
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
Subject: [PATCH net-next 6/7] net: mvpp2: Add 2.5GBaseT support
Date:   Fri, 18 Jan 2019 16:23:51 +0100
Message-Id: <20190118152352.26417-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PPv2 controller is able to support 2.5G speeds, allowing to use
2.5GBASET in conjunction with PHYs that use 2500BASEX as their MII
interface when using this mode.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 16066c2d5b3a..82f210c7e3e9 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4414,6 +4414,7 @@ static void mvpp2_phylink_validate(struct net_device *dev,
 	case PHY_INTERFACE_MODE_2500BASEX:
 		phylink_set(mask, 1000baseT_Full);
 		phylink_set(mask, 1000baseX_Full);
+		phylink_set(mask, 2500baseT_Full);
 		phylink_set(mask, 2500baseX_Full);
 		break;
 	default:
-- 
2.19.2

