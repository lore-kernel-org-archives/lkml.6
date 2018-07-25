Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3800C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7894320843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7894320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbeGYPjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:39:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49149 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbeGYPjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:39:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PERYpj402392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:27:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PERYV8402389;
        Wed, 25 Jul 2018 07:27:34 -0700
Date:   Wed, 25 Jul 2018 07:27:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-10864a9e222048a862da2c21efa28929a4dfed15@git.kernel.org>
Cc:     srikar@linux.vnet.ibm.com, peterz@infradead.org, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, riel@surriel.com, tglx@linutronix.de,
        mgorman@techsingularity.net
Reply-To: mgorman@techsingularity.net, riel@surriel.com,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          srikar@linux.vnet.ibm.com, hpa@zytor.com, peterz@infradead.org
In-Reply-To: <1529514181-9842-9-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-9-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Remove unused task_capacity from
 'struct numa_stats'
Git-Commit-ID: 10864a9e222048a862da2c21efa28929a4dfed15
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  10864a9e222048a862da2c21efa28929a4dfed15
Gitweb:     https://git.kernel.org/tip/10864a9e222048a862da2c21efa28929a4dfed15
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Wed, 20 Jun 2018 22:32:49 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:07 +0200

sched/numa: Remove unused task_capacity from 'struct numa_stats'

The task_capacity field in 'struct numa_stats' is redundant.
Also move nr_running for better packing within the struct.

No functional changes.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25308.6     25377.3     0.271
1     72964       72287       -0.92

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1529514181-9842-9-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e5f39e8dfe53..4ac60b296d96 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1450,14 +1450,12 @@ static unsigned long capacity_of(int cpu);
 
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
-	unsigned long nr_running;
 	unsigned long load;
 
 	/* Total compute capacity of CPUs on a node */
 	unsigned long compute_capacity;
 
-	/* Approximate capacity in terms of runnable tasks on a node */
-	unsigned long task_capacity;
+	unsigned int nr_running;
 	int has_free_capacity;
 };
 
@@ -1495,9 +1493,9 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 	smt = DIV_ROUND_UP(SCHED_CAPACITY_SCALE * cpus, ns->compute_capacity);
 	capacity = cpus / smt; /* cores */
 
-	ns->task_capacity = min_t(unsigned, capacity,
+	capacity = min_t(unsigned, capacity,
 		DIV_ROUND_CLOSEST(ns->compute_capacity, SCHED_CAPACITY_SCALE));
-	ns->has_free_capacity = (ns->nr_running < ns->task_capacity);
+	ns->has_free_capacity = (ns->nr_running < capacity);
 }
 
 struct task_numa_env {
