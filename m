Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbeE3OjY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:39:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeE3OhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:37:18 -0400
Message-Id: <20180530143106.344490819@infradead.org>
User-Agent: quilt/0.63-1
Date: Wed, 30 May 2018 16:22:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        umgwanakikbuti@gmail.com, matt@codeblueprint.co.uk, riel@surriel.com,
        peterz@infradead.org
Subject: [RFC 09/11] sched/fair: Remove SIS_AVG_PROP
References: <20180530142236.667774973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-sis-again-9.patch
X-Bad-Reply: References but no 'Re:' in Subject.
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hasn't been used in forever and doesn't give nice numbers anyway.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |    3 ---
 kernel/sched/features.h |    1 -
 2 files changed, 4 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6465,9 +6465,6 @@ static int select_idle_cpu(struct task_s
 	}
 	avg_cost = this_sd->avg_scan_cost + 1;
 
-	if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
-		return -1;
-
 	if (sched_feat(SIS_PROP)) {
 		u64 span_avg = sd->span_weight * avg_idle;
 		if (span_avg > sis_min_cores * avg_cost)
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -55,7 +55,6 @@ SCHED_FEAT(TTWU_QUEUE, true)
 /*
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
  */
-SCHED_FEAT(SIS_AVG_CPU, false)
 SCHED_FEAT(SIS_PROP, true)
 
 SCHED_FEAT(SIS_AGE, true)
