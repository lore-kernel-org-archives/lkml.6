Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032445AbeBOAs3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032264AbeBOAs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:48:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2C721782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: [PATCH 1/6] sched: Rename init_rq_hrtick to hrtick_rq_init
Date: Thu, 15 Feb 2018 01:48:09 +0100
Message-Id: <1518655694-8057-2-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518655694-8057-1-git-send-email-frederic@kernel.org>
References: <1518655694-8057-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do that rename in order to normalize the hrtick namespace.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wanpeng Li <kernellwp@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bf724c1..f09ec5c 100644
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
@@ -6023,7 +6023,7 @@ void __init sched_init(void)
 		rq->last_sched_tick = 0;
 #endif
 #endif /* CONFIG_SMP */
-		init_rq_hrtick(rq);
+		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 	}
 
-- 
2.7.4
