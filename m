Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F81DECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9040D21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9040D21521
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbeITHun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:50:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbeITHum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:50:42 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3641D244FBED3;
        Thu, 20 Sep 2018 10:09:50 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 10:08:26 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: toshiba: remove a redundant local variable 'index_specified'
Date:   Thu, 20 Sep 2018 09:56:05 +0800
Message-ID: <1537408565-22315-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable 'index_specified' is never used after being assigned.
hence it should be redundant adn can be removed.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
index 302079e..00ab417 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
@@ -1094,7 +1094,7 @@ static int gelic_wl_get_encode(struct net_device *netdev,
 	struct gelic_wl_info *wl = port_wl(netdev_priv(netdev));
 	struct iw_point *enc = &data->encoding;
 	unsigned long irqflag;
-	unsigned int key_index, index_specified;
+	unsigned int key_index;
 	int ret = 0;
 
 	pr_debug("%s: <-\n", __func__);
@@ -1105,13 +1105,10 @@ static int gelic_wl_get_encode(struct net_device *netdev,
 		return -EINVAL;
 
 	spin_lock_irqsave(&wl->lock, irqflag);
-	if (key_index) {
-		index_specified = 1;
+	if (key_index)
 		key_index--;
-	} else {
-		index_specified = 0;
+	else
 		key_index = wl->current_key;
-	}
 
 	if (wl->group_cipher_method == GELIC_WL_CIPHER_WEP) {
 		switch (wl->auth_method) {
-- 
1.7.12.4

