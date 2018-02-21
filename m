Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeBUKhD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:37:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49863 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933054AbeBUKhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:37:01 -0500
Date: Wed, 21 Feb 2018 02:35:21 -0800
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-77a021be383ebdacb17594e280242f7fd116095f@git.kernel.org>
Cc: riel@redhat.com, kernellwp@gmail.com, hpa@zytor.com,
        lcapitulino@redhat.com, cl@linux.com, peterz@infradead.org,
        cmetcalf@mellanox.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, efault@gmx.de
Reply-To: paulmck@linux.vnet.ibm.com, cmetcalf@mellanox.com,
        frederic@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org,
        efault@gmx.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        lcapitulino@redhat.com, kernellwp@gmail.com, riel@redhat.com,
        hpa@zytor.com, peterz@infradead.org, cl@linux.com
In-Reply-To: <1519186649-3242-2-git-send-email-frederic@kernel.org>
References: <1519186649-3242-2-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Rename init_rq_hrtick() to
 hrtick_rq_init()
Git-Commit-ID: 77a021be383ebdacb17594e280242f7fd116095f
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

Commit-ID:  77a021be383ebdacb17594e280242f7fd116095f
Gitweb:     https://git.kernel.org/tip/77a021be383ebdacb17594e280242f7fd116095f
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Wed, 21 Feb 2018 05:17:23 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:49:07 +0100

sched/core: Rename init_rq_hrtick() to hrtick_rq_init()

Do that rename in order to normalize the hrtick namespace.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>
Link: http://lkml.kernel.org/r/1519186649-3242-2-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7c535e..e72ca3c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -333,7 +333,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 }
 #endif /* CONFIG_SMP */
 
-static void init_rq_hrtick(struct rq *rq)
+static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
 	rq->hrtick_csd_pending = 0;
@@ -351,7 +351,7 @@ static inline void hrtick_clear(struct rq *rq)
 {
 }
 
-static inline void init_rq_hrtick(struct rq *rq)
+static inline void hrtick_rq_init(struct rq *rq)
 {
 }
 #endif	/* CONFIG_SCHED_HRTICK */
@@ -6028,7 +6028,7 @@ void __init sched_init(void)
 		rq->last_sched_tick = 0;
 #endif
 #endif /* CONFIG_SMP */
-		init_rq_hrtick(rq);
+		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 	}
 
