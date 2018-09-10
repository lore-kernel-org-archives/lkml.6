Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C50C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AE02087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AE02087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeIJPOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:14:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJPOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:14:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AAKNs91808819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:20:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AAKNJZ1808816;
        Mon, 10 Sep 2018 03:20:23 -0700
Date:   Mon, 10 Sep 2018 03:20:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-7477a3504e619768c9e972dafe2907e6b8ed9823@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, mgorman@techsingularity.net,
        riel@surriel.com, tglx@linutronix.de, vincent.guittot@linaro.org,
        srikar@linux.vnet.ibm.com, torvalds@linux-foundation.org
Reply-To: riel@surriel.com, tglx@linutronix.de,
          mgorman@techsingularity.net, torvalds@linux-foundation.org,
          srikar@linux.vnet.ibm.com, vincent.guittot@linaro.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org, hpa@zytor.com
In-Reply-To: <1535548752-4434-3-git-send-email-vincent.guittot@linaro.org>
References: <1535548752-4434-3-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Remove unused numa_stats::nr_running
 field
Git-Commit-ID: 7477a3504e619768c9e972dafe2907e6b8ed9823
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

Commit-ID:  7477a3504e619768c9e972dafe2907e6b8ed9823
Gitweb:     https://git.kernel.org/tip/7477a3504e619768c9e972dafe2907e6b8ed9823
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Wed, 29 Aug 2018 15:19:10 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:56 +0200

sched/numa: Remove unused numa_stats::nr_running field

nr_running in struct numa_stats is not used anywhere in the code.

Remove it.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1535548752-4434-3-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b65596fae06b..6bd142d19549 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1454,8 +1454,6 @@ struct numa_stats {
 
 	/* Total compute capacity of CPUs on a node */
 	unsigned long compute_capacity;
-
-	unsigned int nr_running;
 };
 
 /*
@@ -1469,7 +1467,6 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
 		struct rq *rq = cpu_rq(cpu);
 
-		ns->nr_running += rq->nr_running;
 		ns->load += weighted_cpuload(rq);
 		ns->compute_capacity += capacity_of(cpu);
 	}
