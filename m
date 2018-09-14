Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C642DFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8400F20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8400F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeINNsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:48:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34131 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbeINNr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:47:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 85D77208D9; Fri, 14 Sep 2018 10:34:02 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4E753207D4;
        Fri, 14 Sep 2018 10:34:02 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next 3/5] net: phy: mscc: remove unneeded parenthesis
Date:   Fri, 14 Sep 2018 10:33:45 +0200
Message-Id: <e3a1a9940e18c69ecf9aaecc3e2d9bf2a180a939.1536913944.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The == operator precedes the || operator, so we can remove the
parenthesis around (a == b) || (c == d).

The condition is rather explicit and short so removing the parenthesis
definitely does not make it harder to read.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index c0a9ea9..734d9fb 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -301,7 +301,7 @@ static int vsc85xx_mdix_set(struct phy_device *phydev, u8 mdix)
 	u16 reg_val;
 
 	reg_val = phy_read(phydev, MSCC_PHY_BYPASS_CONTROL);
-	if ((mdix == ETH_TP_MDI) || (mdix == ETH_TP_MDI_X)) {
+	if (mdix == ETH_TP_MDI || mdix == ETH_TP_MDI_X) {
 		reg_val |= (DISABLE_PAIR_SWAP_CORR_MASK |
 			    DISABLE_POLARITY_CORR_MASK  |
 			    DISABLE_HP_AUTO_MDIX_MASK);
-- 
git-series 0.9.1
