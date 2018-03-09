Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeCIIbs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:31:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48291 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbeCIIbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:31:46 -0500
Date: Fri, 9 Mar 2018 00:31:05 -0800
From: tip-bot for Mario Leinweber <tipbot@zytor.com>
Message-ID: <tip-c2e513821d5df5e772287f6d0c23fd17b7c2bb1a@git.kernel.org>
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        marioleinweber@web.de, hpa@zytor.com, efault@gmx.de,
        torvalds@linux-foundation.org, tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        efault@gmx.de, hpa@zytor.com, marioleinweber@web.de
In-Reply-To: <20180302182007.28691-1-marioleinweber@web.de>
References: <20180302182007.28691-1-marioleinweber@web.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/deadline: Clean up various coding style
 details
Git-Commit-ID: c2e513821d5df5e772287f6d0c23fd17b7c2bb1a
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

Commit-ID:  c2e513821d5df5e772287f6d0c23fd17b7c2bb1a
Gitweb:     https://git.kernel.org/tip/c2e513821d5df5e772287f6d0c23fd17b7c2bb1a
Author:     Mario Leinweber <marioleinweber@web.de>
AuthorDate: Fri, 2 Mar 2018 13:20:07 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 3 Mar 2018 15:50:20 +0100

sched/deadline: Clean up various coding style details

- Fixed style error: Missing space before the open parenthesis
- Fixed style warnings: 2x Missing blank line after declaration

One warning left: else after return
 (I don't feel comfortable fixing that without side effects)

Signed-off-by: Mario Leinweber <marioleinweber@web.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180302182007.28691-1-marioleinweber@web.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpudeadline.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 8d9562d890d3..6a9defebbb54 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -42,8 +42,9 @@ static void cpudl_heapify_down(struct cpudl *cp, int idx)
 		return;
 
 	/* adapted from lib/prio_heap.c */
-	while(1) {
+	while (1) {
 		u64 largest_dl;
+
 		l = left_child(idx);
 		r = right_child(idx);
 		largest = idx;
@@ -131,6 +132,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 		return 1;
 	} else {
 		int best_cpu = cpudl_maximum(cp);
+
 		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
 
 		if (cpumask_test_cpu(best_cpu, &p->cpus_allowed) &&
@@ -205,6 +207,7 @@ void cpudl_set(struct cpudl *cp, int cpu, u64 dl)
 	old_idx = cp->elements[cpu].idx;
 	if (old_idx == IDX_INVALID) {
 		int new_idx = cp->size++;
+
 		cp->elements[new_idx].dl = dl;
 		cp->elements[new_idx].cpu = cpu;
 		cp->elements[cpu].idx = new_idx;
