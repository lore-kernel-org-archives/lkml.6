Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32919C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3B820866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3B820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbeIJPNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:13:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44891 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:13:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AAJqnl1808763
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:19:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AAJqlQ1808760;
        Mon, 10 Sep 2018 03:19:52 -0700
Date:   Mon, 10 Sep 2018 03:19:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-d90707ebebe03596e19de3abbf79b766e72a3465@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        mgorman@techsingularity.net, peterz@infradead.org,
        riel@surriel.com, tglx@linutronix.de, srikar@linux.vnet.ibm.com,
        torvalds@linux-foundation.org, vincent.guittot@linaro.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, riel@surriel.com, mingo@kernel.org,
          mgorman@techsingularity.net, srikar@linux.vnet.ibm.com,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          vincent.guittot@linaro.org
In-Reply-To: <1535548752-4434-2-git-send-email-vincent.guittot@linaro.org>
References: <1535548752-4434-2-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Remove unused code from
 update_numa_stats()
Git-Commit-ID: d90707ebebe03596e19de3abbf79b766e72a3465
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

Commit-ID:  d90707ebebe03596e19de3abbf79b766e72a3465
Gitweb:     https://git.kernel.org/tip/d90707ebebe03596e19de3abbf79b766e72a3465
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Wed, 29 Aug 2018 15:19:09 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:55 +0200

sched/numa: Remove unused code from update_numa_stats()

With:

  commit 2d4056fafa19 ("sched/numa: Remove numa_has_capacity()")

the local variables 'smt', 'cpus' and 'capacity' and their results are not used
anymore in numa_has_capacity()

Remove this unused code.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1535548752-4434-2-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 06ff75f4ac7b..b65596fae06b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1463,8 +1463,7 @@ struct numa_stats {
  */
 static void update_numa_stats(struct numa_stats *ns, int nid)
 {
-	int smt, cpu, cpus = 0;
-	unsigned long capacity;
+	int cpu;
 
 	memset(ns, 0, sizeof(*ns));
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
@@ -1473,26 +1472,8 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 		ns->nr_running += rq->nr_running;
 		ns->load += weighted_cpuload(rq);
 		ns->compute_capacity += capacity_of(cpu);
-
-		cpus++;
 	}
 
-	/*
-	 * If we raced with hotplug and there are no CPUs left in our mask
-	 * the @ns structure is NULL'ed and task_numa_compare() will
-	 * not find this node attractive.
-	 *
-	 * We'll detect a huge imbalance and bail there.
-	 */
-	if (!cpus)
-		return;
-
-	/* smt := ceil(cpus / capacity), assumes: 1 < smt_power < 2 */
-	smt = DIV_ROUND_UP(SCHED_CAPACITY_SCALE * cpus, ns->compute_capacity);
-	capacity = cpus / smt; /* cores */
-
-	capacity = min_t(unsigned, capacity,
-		DIV_ROUND_CLOSEST(ns->compute_capacity, SCHED_CAPACITY_SCALE));
 }
 
 struct task_numa_env {
