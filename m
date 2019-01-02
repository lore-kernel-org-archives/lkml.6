Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1E1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F36D218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfABN7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 08:59:45 -0500
Received: from foss.arm.com ([217.140.101.70]:59540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbfABN7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 08:59:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC29FF;
        Wed,  2 Jan 2019 05:59:43 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79B7C3F5CF;
        Wed,  2 Jan 2019 05:59:42 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, morten.rasmussen@arm.com,
        quentin.perret@arm.com, Dietmar.Eggemann@arm.com
Subject: [PATCH] sched/fair: Remove unneeded prototype of capacity_of()
Date:   Wed,  2 Jan 2019 13:55:49 +0000
Message-Id: <20190102135549.6929-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prototype of that function was already hoisted up in

  commit 3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")

but that seems to have been missed. Get rid of the extra prototype.

Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6483834f1278..6d653947a829 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5083,7 +5083,6 @@ static inline void hrtick_update(struct rq *rq)
 
 #ifdef CONFIG_SMP
 static inline unsigned long cpu_util(int cpu);
-static unsigned long capacity_of(int cpu);
 
 static inline bool cpu_overutilized(int cpu)
 {
--
2.20.1

