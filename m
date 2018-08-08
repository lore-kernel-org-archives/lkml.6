Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D71C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C5D21A27
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C5D21A27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeHHRcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:32:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726875AbeHHRcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:32:32 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8F07B3BD0384D;
        Wed,  8 Aug 2018 23:12:19 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Wed, 8 Aug 2018 23:12:16 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <axboe@kernel.dk>, <ed.cashin@acm.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/block/aoe/aoedev: NULL check is not needed for mempool_destroy
Date:   Wed, 8 Aug 2018 23:00:35 +0800
Message-ID: <1533740435-12088-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mempool_destroy has taken the null pointer into account. So it is safe
to remove the null check.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/block/aoe/aoedev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 697f735..41060e9 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -284,8 +284,8 @@
 	e = t + d->ntargets;
 	for (; t < e && *t; t++)
 		freetgt(d, *t);
-	if (d->bufpool)
-		mempool_destroy(d->bufpool);
+
+	mempool_destroy(d->bufpool);
 	skbpoolfree(d);
 	minor_free(d->sysminor);
 
-- 
1.7.12.4

