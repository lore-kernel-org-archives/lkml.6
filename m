Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6052CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E4221582
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E4221582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbeHCOsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:48:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10629 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728284AbeHCOsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:48:03 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8D170267AE6C;
        Fri,  3 Aug 2018 20:51:44 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Fri, 3 Aug 2018 20:51:39 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel/kthread:  Make function __kthread_queue_delayed_work static
Date:   Fri, 3 Aug 2018 20:40:02 +0800
Message-ID: <1533300002-27105-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning.

kernel/kthread.c:859:6: warning: symbol '__kthread_queue_delayed_work' was not declared. Should it be static?

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 kernel/kthread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 087d18d..3c661a0 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -856,7 +856,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 }
 EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
 
-void __kthread_queue_delayed_work(struct kthread_worker *worker,
+static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 				  struct kthread_delayed_work *dwork,
 				  unsigned long delay)
 {
-- 
1.7.12.4

