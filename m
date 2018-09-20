Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C0AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201AA21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201AA21521
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbeITIM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:12:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12629 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbeITIM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:12:59 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F41867589DD2E;
        Thu, 20 Sep 2018 10:31:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 10:31:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        zhong jiang <zhongjiang@huawei.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] atl1: remove set but not used variable 'advertising'
Date:   Thu, 20 Sep 2018 02:41:30 +0000
Message-ID: <1537411290-5132-1-git-send-email-yuehaibing@huawei.com>
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

drivers/net/ethernet/atheros/atlx/atl1.c: In function 'atl1_set_link_ksettings':
drivers/net/ethernet/atheros/atlx/atl1.c:3280:6: warning:
 variable 'advertising' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index 72e7fa7..63edc57 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -3277,7 +3277,6 @@ static int atl1_set_link_ksettings(struct net_device *netdev,
 	u16 phy_data;
 	int ret_val = 0;
 	u16 old_media_type = hw->media_type;
-	u32 advertising;
 
 	if (netif_running(adapter->netdev)) {
 		if (netif_msg_link(adapter))
@@ -3311,25 +3310,7 @@ static int atl1_set_link_ksettings(struct net_device *netdev,
 				hw->media_type = MEDIA_TYPE_10M_HALF;
 		}
 	}
-	switch (hw->media_type) {
-	case MEDIA_TYPE_AUTO_SENSOR:
-		advertising =
-		    ADVERTISED_10baseT_Half |
-		    ADVERTISED_10baseT_Full |
-		    ADVERTISED_100baseT_Half |
-		    ADVERTISED_100baseT_Full |
-		    ADVERTISED_1000baseT_Full |
-		    ADVERTISED_Autoneg | ADVERTISED_TP;
-		break;
-	case MEDIA_TYPE_1000M_FULL:
-		advertising =
-		    ADVERTISED_1000baseT_Full |
-		    ADVERTISED_Autoneg | ADVERTISED_TP;
-		break;
-	default:
-		advertising = 0;
-		break;
-	}
+
 	if (atl1_phy_setup_autoneg_adv(hw)) {
 		ret_val = -EINVAL;
 		if (netif_msg_link(adapter))

