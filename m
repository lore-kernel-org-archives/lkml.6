Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA84C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9EB20862
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9EB20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbeKLL25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:28:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14647 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729529AbeKLL24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:28:56 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D5B506E5291FA;
        Mon, 12 Nov 2018 09:38:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Mon, 12 Nov 2018 09:37:58 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     YueHaibing <yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH net-next] net: phy: marvell: remove set but not used variable 'pause'
Date:   Mon, 12 Nov 2018 01:47:30 +0000
Message-ID: <1541987250-18687-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/phy/marvell.c: In function 'm88e1510_config_init':
drivers/net/phy/marvell.c:850:7: warning:
 variable 'pause' set but not used [-Wunused-but-set-variable]

It not used any more after commit 3c1bcc8614db ("net: ethernet: Convert phydev
advertize and supported from u32 to link mode")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/phy/marvell.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 36a0db8..6a98819 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -847,7 +847,6 @@ static int m88e1510_config_init(struct phy_device *phydev)
 
 	/* SGMII-to-Copper mode initialization */
 	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
-		u32 pause;
 
 		/* Select page 18 */
 		err = marvell_set_page(phydev, 18);
@@ -878,7 +877,6 @@ static int m88e1510_config_init(struct phy_device *phydev)
 		 * This means we can never be truely sure what was advertised,
 		 * so disable Pause support.
 		 */
-		pause = SUPPORTED_Pause | SUPPORTED_Asym_Pause;
 		linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
 				   phydev->supported);
 		linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,



