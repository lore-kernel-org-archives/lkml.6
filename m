Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2D0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9025921547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9025921547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbeIUHpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:45:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbeIUHpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:45:41 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1ACD0FC5E585;
        Fri, 21 Sep 2018 09:59:10 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 09:59:08 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mhiramat@kernel.org>, <mingo@kernel.org>, <tglx@linutronix.de>,
        <keescook@chromium.org>, <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH] error-injection: remove meaningless null pointer check before debugfs_remove_recursive
Date:   Fri, 21 Sep 2018 09:46:44 +0800
Message-ID: <1537494404-16473-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_remove_recursive has taken the null pointer into account.
just remove the null check before debugfs_remove_recursive.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 kernel/fail_function.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index bc80a4e..17f75b5 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -173,8 +173,7 @@ static void fei_debugfs_remove_attr(struct fei_attr *attr)
 	struct dentry *dir;
 
 	dir = debugfs_lookup(attr->kp.symbol_name, fei_debugfs_dir);
-	if (dir)
-		debugfs_remove_recursive(dir);
+	debugfs_remove_recursive(dir);
 }
 
 static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
-- 
1.7.12.4

