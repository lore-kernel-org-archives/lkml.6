Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711A6C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 02:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492792085B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 02:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfA2CyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 21:54:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2790 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbfA2CyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 21:54:18 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A7540E6FE2654CBDFCCD;
        Tue, 29 Jan 2019 10:54:16 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Tue, 29 Jan 2019
 10:54:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <stefanr@s5r6.in-berlin.de>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>,
        <linux1394-devel@lists.sourceforge.net>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] firewire: net: remove set but not used variable  'guid'
Date:   Tue, 29 Jan 2019 10:54:05 +0800
Message-ID: <20190129025405.17896-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/firewire/net.c:488:9:
 warning: variable 'guid' set but not used [-Wunused-but-set-variable]

It not used since commit 6752c8db8e0c ("firewire net, ipv4 arp:
Extend hardware address and remove driver-level packet inspection.")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/firewire/net.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 82ba110..5dcb991 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -485,7 +485,6 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 {
 	struct fwnet_device *dev;
 	int status;
-	__be64 guid;
 
 	switch (ether_type) {
 	case ETH_P_ARP:
@@ -507,7 +506,6 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 	 * Parse the encapsulation header. This actually does the job of
 	 * converting to an ethernet-like pseudo frame header.
 	 */
-	guid = cpu_to_be64(dev->card->guid);
 	if (dev_hard_header(skb, net, ether_type,
 			   is_broadcast ? net->broadcast : net->dev_addr,
 			   NULL, skb->len) >= 0) {
-- 
2.7.0


