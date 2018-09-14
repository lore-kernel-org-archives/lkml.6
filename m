Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE94ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8782083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8782083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeINUnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:43:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbeINUnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:43:15 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 10199B2CE875B;
        Fri, 14 Sep 2018 23:28:09 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Fri, 14 Sep 2018 23:28:05 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>,
        <akpm@linux-foundation.org>
CC:     <ocfs2-devel@oss.oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ocfs2: Fix a GCC compiled warning.
Date:   Fri, 14 Sep 2018 23:15:48 +0800
Message-ID: <1536938148-32110-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compile warning:

fs/ocfs2/dlmglue.c:99:30: warning: lockdep_keys defined but not used [-Wunused-variable]
 static struct lock_class_key lockdep_keys[OCFS2_NUM_LOCK_TYPES];

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 fs/ocfs2/dlmglue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 040ddb6..7c83582 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -96,7 +96,9 @@ struct ocfs2_unblock_ctl {
 };
 
 /* Lockdep class keys */
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key lockdep_keys[OCFS2_NUM_LOCK_TYPES];
+#endif
 
 static int ocfs2_check_meta_downconvert(struct ocfs2_lock_res *lockres,
 					int new_level);
-- 
1.7.12.4

