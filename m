Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeBFMAJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:00:09 -0500
Received: from terminus.zytor.com ([65.50.211.136]:59075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbeBFMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:00:01 -0500
Date: Tue, 6 Feb 2018 03:55:35 -0800
From: tip-bot for Mel Gorman <tipbot@zytor.com>
Message-ID: <tip-89a55f56fd1cdbe7e69d4693fc5790af9a6e1501@git.kernel.org>
Cc: tglx@linutronix.de, efault@gmx.de, mingo@kernel.org, hpa@zytor.com,
        matt@codeblueprint.co.uk, torvalds@linux-foundation.org,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Reply-To: matt@codeblueprint.co.uk, tglx@linutronix.de, efault@gmx.de,
        mingo@kernel.org, hpa@zytor.com, mgorman@techsingularity.net,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
In-Reply-To: <20180130104555.4125-2-mgorman@techsingularity.net>
References: <20180130104555.4125-2-mgorman@techsingularity.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/fair: Remove unnecessary parameters from
 wake_affine_idle()
Git-Commit-ID: 89a55f56fd1cdbe7e69d4693fc5790af9a6e1501
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  89a55f56fd1cdbe7e69d4693fc5790af9a6e1501
Gitweb:     https://git.kernel.org/tip/89a55f56fd1cdbe7e69d4693fc5790af9a6e1501
Author:     Mel Gorman <mgorman@techsingularity.net>
AuthorDate: Tue, 30 Jan 2018 10:45:52 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 6 Feb 2018 10:20:35 +0100

sched/fair: Remove unnecessary parameters from wake_affine_idle()

wake_affine_idle() takes parameters it never uses so clean it up.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180130104555.4125-2-mgorman@techsingularity.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a6b8157..0a551dfe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5692,10 +5692,8 @@ static int wake_wide(struct task_struct *p)
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
@@ -5752,8 +5750,8 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	int this_cpu = smp_processor_id();
 	bool affine = false;
 
-	if (sched_feat(WA_IDLE) && !affine)
-		affine = wake_affine_idle(sd, p, this_cpu, prev_cpu, sync);
+	if (sched_feat(WA_IDLE))
+		affine = wake_affine_idle(this_cpu, prev_cpu, sync);
 
 	if (sched_feat(WA_WEIGHT) && !affine)
 		affine = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
