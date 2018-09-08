Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554BDC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2769206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2769206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeIHQTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 12:19:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37821 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbeIHQTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 12:19:11 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 77C87F3782201;
        Sat,  8 Sep 2018 19:33:39 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Sat, 8 Sep 2018 19:33:38 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <johannes@sipsolutions.net>, <davem@davemloft.net>
CC:     <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] cfg80211: remove unnecessary null pointer check in cfg80211_netdev_notifier_call
Date:   Sat, 8 Sep 2018 19:21:28 +0800
Message-ID: <1536405688-26239-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iterator in list_for_each_entry_safe is never null, therefore, remove
the redundant null pointer check.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 net/wireless/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index a88551f..4d5215e 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1238,7 +1238,7 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 
 		list_for_each_entry_safe(pos, tmp,
 					 &rdev->sched_scan_req_list, list) {
-			if (WARN_ON(pos && pos->dev == wdev->netdev))
+			if (WARN_ON(pos->dev == wdev->netdev))
 				cfg80211_stop_sched_scan_req(rdev, pos, false);
 		}
 
-- 
1.7.12.4

