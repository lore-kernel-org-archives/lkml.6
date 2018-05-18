Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeERHhb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:37:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39975 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbeERHh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:37:29 -0400
Date: Fri, 18 May 2018 00:36:50 -0700
From: tip-bot for Mathieu Malaterre <tipbot@zytor.com>
Message-ID: <tip-f6a3463063f42d9fb2c78f386437a822e0ad1792@git.kernel.org>
Cc: mingo@kernel.org, srikar@linux.vnet.ibm.com,
        torvalds@linux-foundation.org, tglx@linutronix.de, malat@debian.org,
        peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, malat@debian.org,
        peterz@infradead.org, mingo@kernel.org, srikar@linux.vnet.ibm.com
In-Reply-To: <20180516195348.30426-1-malat@debian.org>
References: <20180516195348.30426-1-malat@debian.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/debug: Move the print_rt_rq() and
 print_dl_rq() declarations to kernel/sched/sched.h
Git-Commit-ID: f6a3463063f42d9fb2c78f386437a822e0ad1792
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

Commit-ID:  f6a3463063f42d9fb2c78f386437a822e0ad1792
Gitweb:     https://git.kernel.org/tip/f6a3463063f42d9fb2c78f386437a822e0ad1792
Author:     Mathieu Malaterre <malat@debian.org>
AuthorDate: Wed, 16 May 2018 21:53:47 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 18 May 2018 09:05:14 +0200

sched/debug: Move the print_rt_rq() and print_dl_rq() declarations to kernel/sched/sched.h

In the following commit:

  6b55c9654fcc ("sched/debug: Move print_cfs_rq() declaration to kernel/sched/sched.h")

the print_cfs_rq() prototype was added to <kernel/sched/sched.h>,
right next to the prototypes for print_cfs_stats(), print_rt_stats()
and print_dl_stats().

Finish this previous commit and also move related prototypes for
print_rt_rq() and print_dl_rq().

Remove existing extern declarations now that they not needed anymore.

Silences the following GCC warning, triggered by W=1:

  kernel/sched/debug.c:573:6: warning: no previous prototype for ‘print_rt_rq’ [-Wmissing-prototypes]
  kernel/sched/debug.c:603:6: warning: no previous prototype for ‘print_dl_rq’ [-Wmissing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180516195348.30426-1-malat@debian.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/deadline.c | 2 --
 kernel/sched/rt.c       | 2 --
 kernel/sched/sched.h    | 5 +++--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e7b3008b85bb..d6196bc6cbb5 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2731,8 +2731,6 @@ bool dl_cpu_busy(unsigned int cpu)
 #endif
 
 #ifdef CONFIG_SCHED_DEBUG
-extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
-
 void print_dl_stats(struct seq_file *m, int cpu)
 {
 	print_dl_rq(m, cpu, &cpu_rq(cpu)->dl);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7aef6b4e885a..ef3c4e6f5345 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2701,8 +2701,6 @@ int sched_rr_handler(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_SCHED_DEBUG
-extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
-
 void print_rt_stats(struct seq_file *m, int cpu)
 {
 	rt_rq_iter_t iter;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 15750c222ca2..1f0a4bc6a39d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2025,8 +2025,9 @@ extern bool sched_debug_enabled;
 extern void print_cfs_stats(struct seq_file *m, int cpu);
 extern void print_rt_stats(struct seq_file *m, int cpu);
 extern void print_dl_stats(struct seq_file *m, int cpu);
-extern void
-print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq);
+extern void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq);
+extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
+extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
 #ifdef CONFIG_NUMA_BALANCING
 extern void
 show_numa_stats(struct task_struct *p, struct seq_file *m);
