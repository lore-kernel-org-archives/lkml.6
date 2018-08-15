Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30DDC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B83F21527
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B83F21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeHOShC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:37:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:37459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729249AbeHOShB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:37:01 -0400
Received: from homer.simpson.net ([185.191.216.245]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MY3Ho-1fL9Py1dvE-00UqGB; Wed, 15
 Aug 2018 17:44:06 +0200
Message-ID: <1534347845.21000.0.camel@gmx.de>
Subject: [PATCH] rcu: Convert rcu_state.ofl_lock to raw_spinlock_t
From:   Mike Galbraith <efault@gmx.de>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 15 Aug 2018 17:44:05 +0200
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:A3x8xkbBuNcEez8LEvsHFzOo204U9RbxgM8dpbOK0vAaAtZRMUu
 EHIULXFuvW5xktqr0QWROx9ECuvzDnIG51+dP319bniVWPZKAFyOUIhSJ+8nOI+58R+gv8j
 A+kIkn5AV+Wns6KsnFFhSpYb/BJ4MWXN5U/LMp79eQe3LbTuIQ8ABTdCHeoZbplFf5WZUqT
 gj9IM97nxRZbKvhAnxGNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9t7z+tNicgI=:5HBvzyfDWnPcrDl9MLeubh
 oRXbqpn6Ia0/Zmscvq+cAGSRCRalVee6m9I2pMIjCqjWP++G2TPkgY2UhJlR9wT+oQgzTDp5t
 f1WbBm1cuWB4jkZfwUU6igusewN5DG5IE26NqmafjlaKwuybhfbvnYrazps9KiZCqopfXJxv2
 w8Vj3VEFfz1JqJVWGJQoJugmeM6xDzNHgwYLbWK9kyDm/VCasOw6f0hkE/tFWMtq1IA1uNJpu
 5uN/rk5MfuciZNsURlIIBJgFuO/4sJ6eDQUWGN1pWHDBW9x0pZnNp+rD6yMtMfZINVpKsqxzc
 kkhqwfu7+8UXskTqzmeLcBlPHIrFGzL3hifLCZlY2RwxYCb4VyUTpxrVdCSytjDJt91f0UOyS
 uGtnZdX9guysKDUA4rn3Kimvu3X2UzMZLRloufbSL1EKRPi00v1lz4dxX3Pi5tpwjd7dJCo/l
 SQENlFmEfps/qeH/JV8QfnlWx3JGOsx1aOpNhpMF9RdTF5X7OIGjI7+14lUhljLRNG42ZHbx+
 ozL10RwTuUCdrZJKXyioevO2T3FOG2/wO7w5046dnf5+c+fRMHoy9Gwzp9tLelL6/Zojlw4ho
 PauWpbqKwppoKI3yg+U6QNY302MwtjjwDXf4AXUoyr3zxJ2o3RKbEqlK1YKNzY0bxEDxSP/IM
 7oOPReRa+nS5rK2nVUFGbB7uxDq9UvkQpdwcGtrVq7lc9eHcqcCDt+fs32AntUuUkM99pSRb8
 l66oe530Y8ZUmLFCs91Iz3RON3KLMy8fmN08Jie2GJ4CiGvHytyg52DJTJxBl+CGWc4DgEU7i
 Isdl+Gi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1e64b15a4b10 ("rcu: Fix grace-period hangs due to race with CPU offline")
added spinlock_t ofl_lock to the rcu_state structure, then takes it with
preemption disabled during CPU offline, giving RT sleeping lock heartburn.

Convert it to raw_spinlock_t.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 kernel/rcu/tree.c |   12 ++++++------
 kernel/rcu/tree.h |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -111,7 +111,7 @@ struct rcu_state sname##_state = { \
 	.abbr = sabbr, \
 	.exp_mutex = __MUTEX_INITIALIZER(sname##_state.exp_mutex), \
 	.exp_wake_mutex = __MUTEX_INITIALIZER(sname##_state.exp_wake_mutex), \
-	.ofl_lock = __SPIN_LOCK_UNLOCKED(sname##_state.ofl_lock), \
+	.ofl_lock = __RAW_SPIN_LOCK_UNLOCKED(sname##_state.ofl_lock), \
 }
 
 RCU_STATE_INITIALIZER(rcu_sched, 's', call_rcu_sched);
@@ -1962,13 +1962,13 @@ static bool rcu_gp_init(struct rcu_state
 	 */
 	rsp->gp_state = RCU_GP_ONOFF;
 	rcu_for_each_leaf_node(rsp, rnp) {
-		spin_lock(&rsp->ofl_lock);
+		raw_spin_lock(&rsp->ofl_lock);
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
 		    !rnp->wait_blkd_tasks) {
 			/* Nothing to do on this leaf rcu_node structure. */
 			raw_spin_unlock_irq_rcu_node(rnp);
-			spin_unlock(&rsp->ofl_lock);
+			raw_spin_unlock(&rsp->ofl_lock);
 			continue;
 		}
 
@@ -2004,7 +2004,7 @@ static bool rcu_gp_init(struct rcu_state
 		}
 
 		raw_spin_unlock_irq_rcu_node(rnp);
-		spin_unlock(&rsp->ofl_lock);
+		raw_spin_unlock(&rsp->ofl_lock);
 	}
 	rcu_gp_slow(rsp, gp_preinit_delay); /* Races with CPU hotplug. */
 
@@ -3892,7 +3892,7 @@ static void rcu_cleanup_dying_idle_cpu(i
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
-	spin_lock(&rsp->ofl_lock);
+	raw_spin_lock(&rsp->ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rsp->gp_seq);
 	rdp->rcu_ofl_gp_flags = READ_ONCE(rsp->gp_flags);
@@ -3903,7 +3903,7 @@ static void rcu_cleanup_dying_idle_cpu(i
 	}
 	rnp->qsmaskinitnext &= ~mask;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	spin_unlock(&rsp->ofl_lock);
+	raw_spin_unlock(&rsp->ofl_lock);
 }
 
 /*
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -368,7 +368,7 @@ struct rcu_state {
 	char abbr;				/* Abbreviated name. */
 	struct list_head flavors;		/* List of RCU flavors. */
 
-	spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
+	raw_spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
 };
