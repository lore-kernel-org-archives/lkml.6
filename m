Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A902C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC6F20652
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC6F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeIHRx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 13:53:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35426 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbeIHRx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 13:53:27 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 63CDFEDF68AD3;
        Sat,  8 Sep 2018 21:07:40 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Sat, 8 Sep 2018 21:07:38 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <colyli@suse.de>, <kent.overstreet@gmail.com>
CC:     <linux-bcache@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] bcache: remove redundant condition before debugfs_remove
Date:   Sat, 8 Sep 2018 20:55:27 +0800
Message-ID: <1536411327-30127-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_remove has taken the IS_ERR_OR_NULL into account. Just
remove the unnecessary condition.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/md/bcache/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 2d26f9e..a3d2a94 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1506,8 +1506,7 @@ static void cache_set_free(struct closure *cl)
 	struct cache *ca;
 	unsigned int i;
 
-	if (!IS_ERR_OR_NULL(c->debug))
-		debugfs_remove(c->debug);
+	debugfs_remove(c->debug);
 
 	bch_open_buckets_free(c);
 	bch_btree_cache_free(c);
-- 
1.7.12.4

