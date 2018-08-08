Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FE2C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ADB21742
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90ADB21742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeHHOT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:19:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51625 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726756AbeHHOT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:19:28 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 72C3871D9A82D;
        Wed,  8 Aug 2018 20:00:02 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Wed, 8 Aug 2018
 19:59:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <keescook@chromium.org>, <edumazet@google.com>,
        <linux-decnet-user@lists.sourceforge.net>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] decnet: fix using plain integer as NULL warning
Date:   Wed, 8 Aug 2018 19:59:32 +0800
Message-ID: <20180808115932.12944-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warning:
net/decnet/dn_route.c:407:30: warning: Using plain integer as NULL pointer
net/decnet/dn_route.c:1923:22: warning: Using plain integer as NULL pointer

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/decnet/dn_route.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/decnet/dn_route.c b/net/decnet/dn_route.c
index 3107a2e..1c002c0 100644
--- a/net/decnet/dn_route.c
+++ b/net/decnet/dn_route.c
@@ -404,7 +404,7 @@ void dn_rt_cache_flush(int delay)
 
 	if (delay <= 0) {
 		spin_unlock_bh(&dn_rt_flush_lock);
-		dn_run_flush(0);
+		dn_run_flush(NULL);
 		return;
 	}
 
@@ -1920,7 +1920,7 @@ void __init dn_route_init(void)
 void __exit dn_route_cleanup(void)
 {
 	del_timer(&dn_route_timer);
-	dn_run_flush(0);
+	dn_run_flush(NULL);
 
 	remove_proc_entry("decnet_cache", init_net.proc_net);
 	dst_entries_destroy(&dn_dst_ops);
-- 
2.7.0


