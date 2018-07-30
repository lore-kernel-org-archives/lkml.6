Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FF9FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E181520892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E181520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbeG3O2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:28:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59084 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730125AbeG3O2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:28:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CFF2D207AC; Mon, 30 Jul 2018 14:53:28 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 94A9F20703;
        Mon, 30 Jul 2018 14:53:28 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next] net: phy: mscc: the extended page access register is 16 bits
Date:   Mon, 30 Jul 2018 14:53:13 +0200
Message-Id: <20180730125313.3405-1-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Extended Page Access is a 16-bit register, so change the page
parameter of vsc85xx_phy_page_set to a u16.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 650c2667d523..84ca9ff40ae0 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -123,7 +123,7 @@ static const struct vsc8531_edge_rate_table edge_table[] = {
 };
 #endif /* CONFIG_OF_MDIO */
 
-static int vsc85xx_phy_page_set(struct phy_device *phydev, u8 page)
+static int vsc85xx_phy_page_set(struct phy_device *phydev, u16 page)
 {
 	int rc;
 
-- 
2.17.1

