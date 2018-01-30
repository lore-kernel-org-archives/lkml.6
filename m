Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeA3KqB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:46:01 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:48283 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751511AbeA3Kp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:45:57 -0500
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/4] sched/fair: Remove unnecessary parameters from wake_affine_idle
Date: Tue, 30 Jan 2018 10:45:52 +0000
Message-Id: <20180130104555.4125-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180130104555.4125-1-mgorman@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wake_affine_idle takes parameters it never uses so clean it up.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5aa629021ceb..9a5d8462c13c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5696,10 +5696,8 @@ static int wake_wide(struct task_struct *p)
  *			  scheduling latency of the CPUs. This seems to work
  *			  for the overloaded case.
  */
-
 static bool
-wake_affine_idle(struct sched_domain *sd, struct task_struct *p,
-		 int this_cpu, int prev_cpu, int sync)
+wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 {
 	/*
 	 * If this_cpu is idle, it implies the wakeup is from interrupt
@@ -5756,8 +5754,8 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	int this_cpu = smp_processor_id();
 	bool affine = false;
 
-	if (sched_feat(WA_IDLE) && !affine)
-		affine = wake_affine_idle(sd, p, this_cpu, prev_cpu, sync);
+	if (sched_feat(WA_IDLE))
+		affine = wake_affine_idle(this_cpu, prev_cpu, sync);
 
 	if (sched_feat(WA_WEIGHT) && !affine)
 		affine = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
-- 
2.15.1
