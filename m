Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933284AbeBUKh2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:37:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53429 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932790AbeBUKh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:37:27 -0500
Date: Wed, 21 Feb 2018 02:35:50 -0800
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-a364298359e74a414857bbbf3b725564feb22d09@git.kernel.org>
Cc: riel@redhat.com, mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, cl@linux.com, lcapitulino@redhat.com,
        paulmck@linux.vnet.ibm.com, cmetcalf@mellanox.com, tglx@linutronix.de,
        efault@gmx.de, frederic@kernel.org, torvalds@linux-foundation.org,
        kernellwp@gmail.com
Reply-To: peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, cl@linux.com, lcapitulino@redhat.com,
        riel@redhat.com, torvalds@linux-foundation.org, kernellwp@gmail.com,
        paulmck@linux.vnet.ibm.com, cmetcalf@mellanox.com, tglx@linutronix.de,
        frederic@kernel.org, efault@gmx.de
In-Reply-To: <1519186649-3242-3-git-send-email-frederic@kernel.org>
References: <1519186649-3242-3-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] nohz: Convert tick_nohz_tick_stopped() to bool
Git-Commit-ID: a364298359e74a414857bbbf3b725564feb22d09
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

Commit-ID:  a364298359e74a414857bbbf3b725564feb22d09
Gitweb:     https://git.kernel.org/tip/a364298359e74a414857bbbf3b725564feb22d09
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Wed, 21 Feb 2018 05:17:24 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:49:08 +0100

nohz: Convert tick_nohz_tick_stopped() to bool

It makes this function more self-explanatory about what it does and how
to use it.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
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
Link: http://lkml.kernel.org/r/1519186649-3242-3-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/tick.h     | 2 +-
 kernel/time/tick-sched.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 7cc3592..86576d9 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -113,7 +113,7 @@ enum tick_dep_bits {
 
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
-extern int tick_nohz_tick_stopped(void);
+extern bool tick_nohz_tick_stopped(void);
 extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 29a5733..0aba041 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -481,7 +481,7 @@ static int __init setup_tick_nohz(char *str)
 
 __setup("nohz=", setup_tick_nohz);
 
-int tick_nohz_tick_stopped(void)
+bool tick_nohz_tick_stopped(void)
 {
 	return __this_cpu_read(tick_cpu_sched.tick_stopped);
 }
