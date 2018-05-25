Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965281AbeEYJFw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:05:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965197AbeEYJFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:05:44 -0400
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, bigeasy@linutronix.de, paulmck@linux.vnet.ibm.com,
        ebiederm@xmission.com, Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH v2 1/2] rcu: Update documentation of rcu_read_unlock()
Date: Fri, 25 May 2018 11:05:06 +0200
Message-Id: <20180525090507.22248-2-anna-maria@linutronix.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180525090507.22248-1-anna-maria@linutronix.de>
References: <20180525090507.22248-1-anna-maria@linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b4abf91047cf ("rtmutex: Make wait_lock irq safe") the
explanation in rcu_read_unlock() documentation about irq unsafe rtmutex
wait_lock is no longer valid.

Remove it to prevent kernel developers reading the documentation to rely on
it.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 include/linux/rcupdate.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 36360d07f25b..64644fda3b22 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -653,9 +653,7 @@ static inline void rcu_read_lock(void)
  * Unfortunately, this function acquires the scheduler's runqueue and
  * priority-inheritance spinlocks.  This means that deadlock could result
  * if the caller of rcu_read_unlock() already holds one of these locks or
- * any lock that is ever acquired while holding them; or any lock which
- * can be taken from interrupt context because rcu_boost()->rt_mutex_lock()
- * does not disable irqs while taking ->wait_lock.
+ * any lock that is ever acquired while holding them.
  *
  * That said, RCU readers are never priority boosted unless they were
  * preempted.  Therefore, one way to avoid deadlock is to make sure
-- 
2.15.1
