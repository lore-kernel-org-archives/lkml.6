Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEB42083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfBYQOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:14:15 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:32773 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbfBYQOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:14:15 -0500
X-Originating-IP: 90.88.23.190
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 57AD8E000D;
        Mon, 25 Feb 2019 16:14:10 +0000 (UTC)
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
Subject: [PATCH net-next 0/2] net: phy: marvell10g: Clean .get_features by using C45 helpers
Date:   Mon, 25 Feb 2019 17:14:05 +0100
Message-Id: <20190225161407.19510-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent work on C45 helpers by Heiner made the
genphy_c45_pma_read_abilities function generic enough to use as a
default .get_featutes implementation.

This series removes the remaining redundant code in
mv3310_get_features(), and makes the 2110 PHY use
genphy_c45_pma_read_abilities() directly, since it doesn't have the
issue with the wrong abilities being reported.

Maxime Chevallier (2):
  net: phy: marvell10g: Let genphy_c45_pma_read_abilities set Aneg bit
  net: phy: marvell10g: Use the generic C45 helper to read the 2110
    features

 drivers/net/phy/marvell10g.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

-- 
2.19.2

