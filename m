Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932457AbeBLBiF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:38:05 -0500
Received: from [198.137.202.136] ([198.137.202.136]:43981 "EHLO mail.zytor.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S932314AbeBLBiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:38:03 -0500
Date: Sun, 11 Feb 2018 04:08:29 -0800
From: tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-6a546c7e69ff0b69581377cc70d7e8a601b98fce@git.kernel.org>
Cc: parri.andrea@gmail.com, peterz@infradead.org, mingo@kernel.org,
        mathieu.desnoyers@efficios.com, benh@kernel.crashing.org,
        tglx@linutronix.de, davejwatson@fb.com, sehr@google.com,
        ghackmann@google.com, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, ahh@google.com, paulmck@linux.vnet.ibm.com,
        maged.michael@gmail.com, avi@scylladb.com,
        torvalds@linux-foundation.org, linux@armlinux.org.uk, hpa@zytor.com,
        luto@kernel.org, paulus@samba.org, will.deacon@arm.com,
        mpe@ellerman.id.au
Reply-To: ahh@google.com, boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        sehr@google.com, davejwatson@fb.com, ghackmann@google.com,
        maged.michael@gmail.com, paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        parri.andrea@gmail.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, benh@kernel.crashing.org,
        tglx@linutronix.de, hpa@zytor.com, luto@kernel.org, mpe@ellerman.id.au,
        will.deacon@arm.com, paulus@samba.org, avi@scylladb.com,
        torvalds@linux-foundation.org, linux@armlinux.org.uk
In-Reply-To: <1518208256-22034-1-git-send-email-mathieu.desnoyers@efficios.com>
References: <1518208256-22034-1-git-send-email-mathieu.desnoyers@efficios.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] membarrier-sync-core: Document architecture
 support
Git-Commit-ID: 6a546c7e69ff0b69581377cc70d7e8a601b98fce
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

Commit-ID:  6a546c7e69ff0b69581377cc70d7e8a601b98fce
Gitweb:     https://git.kernel.org/tip/6a546c7e69ff0b69581377cc70d7e8a601b98fce
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Fri, 9 Feb 2018 15:30:56 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 10 Feb 2018 12:45:10 +0100

membarrier-sync-core: Document architecture support

Ensure we gather architecture requirements about each architecture
supporting the "sync_core" membarrier command in a single file under
Documentation/features.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Andrew Hunter <ahh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: David Sehr <sehr@google.com>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maged Michael <maged.michael@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/1518208256-22034-1-git-send-email-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 .../sched/membarrier-sync-core/arch-support.txt    | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
new file mode 100644
index 0000000..2c815a7
--- /dev/null
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -0,0 +1,62 @@
+#
+# Feature name:          membarrier-sync-core
+#         Kconfig:       ARCH_HAS_MEMBARRIER_SYNC_CORE
+#         description:   arch supports core serializing membarrier
+#
+# Architecture requirements
+#
+# * arm64
+#
+# Rely on eret context synchronization when returning from IPI handler, and
+# when returning to user-space.
+#
+# * x86
+#
+# x86-32 uses IRET as return from interrupt, which takes care of the IPI.
+# However, it uses both IRET and SYSEXIT to go back to user-space. The IRET
+# instruction is core serializing, but not SYSEXIT.
+#
+# x86-64 uses IRET as return from interrupt, which takes care of the IPI.
+# However, it can return to user-space through either SYSRETL (compat code),
+# SYSRETQ, or IRET.
+#
+# Given that neither SYSRET{L,Q}, nor SYSEXIT, are core serializing, we rely
+# instead on write_cr3() performed by switch_mm() to provide core serialization
+# after changing the current mm, and deal with the special case of kthread ->
+# uthread (temporarily keeping current mm into active_mm) by issuing a
+# sync_core_before_usermode() in that specific case.
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: | TODO |
+    |         arm: | TODO |
+    |       arm64: |  ok  |
+    |    blackfin: | TODO |
+    |         c6x: | TODO |
+    |        cris: | TODO |
+    |         frv: | TODO |
+    |       h8300: | TODO |
+    |     hexagon: | TODO |
+    |        ia64: | TODO |
+    |        m32r: | TODO |
+    |        m68k: | TODO |
+    |       metag: | TODO |
+    |  microblaze: | TODO |
+    |        mips: | TODO |
+    |     mn10300: | TODO |
+    |       nios2: | TODO |
+    |    openrisc: | TODO |
+    |      parisc: | TODO |
+    |     powerpc: | TODO |
+    |        s390: | TODO |
+    |       score: | TODO |
+    |          sh: | TODO |
+    |       sparc: | TODO |
+    |        tile: | TODO |
+    |          um: | TODO |
+    |   unicore32: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: | TODO |
+    -----------------------
