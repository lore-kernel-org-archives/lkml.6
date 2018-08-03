Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50673C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E6C21582
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E6C21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbeHCOp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:45:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729867AbeHCOp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:45:28 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 22E4EEA30916C;
        Fri,  3 Aug 2018 20:49:12 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Fri, 3 Aug 2018 20:49:09 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/topology: Make some local variable static
Date:   Fri, 3 Aug 2018 20:37:32 +0800
Message-ID: <1533299852-26941-1-git-send-email-zhongjiang@huawei.com>
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

kernel/sched/topology.c:10:15: warning: symbol 'sched_domains_tmpmask' was not declared. Should it be static?
kernel/sched/topology.c:11:15: warning: symbol 'sched_domains_tmpmask2' was not declared. Should it be static?

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 56a0fed..cf3d756 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -7,8 +7,8 @@
 DEFINE_MUTEX(sched_domains_mutex);
 
 /* Protected by sched_domains_mutex: */
-cpumask_var_t sched_domains_tmpmask;
-cpumask_var_t sched_domains_tmpmask2;
+static cpumask_var_t sched_domains_tmpmask;
+static cpumask_var_t sched_domains_tmpmask2;
 
 #ifdef CONFIG_SCHED_DEBUG
 
-- 
1.7.12.4

