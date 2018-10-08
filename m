Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1698DC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F3F2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F3F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeJHRSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:18:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38936 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeJHRSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:18:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1DAA2208B5; Mon,  8 Oct 2018 12:07:50 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id D61EB208B7;
        Mon,  8 Oct 2018 12:07:39 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v3 4/6] net: phy: mscc: remove unneeded parenthesis
Date:   Mon,  8 Oct 2018 12:07:26 +0200
Message-Id: <20181008100728.24959-5-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008100728.24959-1-quentin.schulz@bootlin.com>
References: <20181008100728.24959-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The == operator precedes the || operator, so we can remove the
parenthesis around (a == b) || (c == d).

The condition is rather explicit and short so removing the parenthesis
definitely does not make it harder to read.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index d304fb4df23c..0ff7803ed16b 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -300,7 +300,7 @@ static int vsc85xx_mdix_set(struct phy_device *phydev, u8 mdix)
 	u16 reg_val;
 
 	reg_val = phy_read(phydev, MSCC_PHY_BYPASS_CONTROL);
-	if ((mdix == ETH_TP_MDI) || (mdix == ETH_TP_MDI_X)) {
+	if (mdix == ETH_TP_MDI || mdix == ETH_TP_MDI_X) {
 		reg_val |= (DISABLE_PAIR_SWAP_CORR_MASK |
 			    DISABLE_POLARITY_CORR_MASK  |
 			    DISABLE_HP_AUTO_MDIX_MASK);
-- 
2.17.1

