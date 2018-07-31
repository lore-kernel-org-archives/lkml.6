Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4731BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C7820841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C7820841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeGaSRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:17:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41899 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbeGaSRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:17:44 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 12D551383AF03;
        Wed,  1 Aug 2018 00:36:33 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.399.0; Wed, 1 Aug 2018 00:36:32 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <tglx@linutronix.de>, <longman@redhat.com>
CC:     <arnd@arndb.de>, <yang.shi@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] lib/debugobjects: remove redundant check when free the object
Date:   Wed, 1 Aug 2018 00:24:58 +0800
Message-ID: <1533054298-35824-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmem_cache_destroy has taken the null check into account. so just
remove the unnecessary check.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 lib/debugobjects.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 994be48..7a6d80b 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1185,8 +1185,7 @@ void __init debug_objects_mem_init(void)
 
 	if (!obj_cache || debug_objects_replace_static_objects()) {
 		debug_objects_enabled = 0;
-		if (obj_cache)
-			kmem_cache_destroy(obj_cache);
+		kmem_cache_destroy(obj_cache);
 		pr_warn("out of memory.\n");
 	} else
 		debug_objects_selftest();
-- 
1.7.12.4

