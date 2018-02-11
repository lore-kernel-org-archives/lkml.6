Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932582AbeBLCXE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 21:23:04 -0500
Received: from [198.137.202.136] ([198.137.202.136]:59005 "EHLO
        terminus.zytor.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbeBLCXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 21:23:03 -0500
Date: Sun, 11 Feb 2018 04:13:03 -0800
From: tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-ac65ddad4a23d46529f921fdf8f7b7b6d14a15d8@git.kernel.org>
Cc: peterz@infradead.org, corbet@lwn.net, mathieu.desnoyers@efficios.com,
        boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        benh@kernel.crashing.org, mingo@kernel.org, ahh@google.com,
        sehr@google.com, luto@kernel.org, hpa@zytor.com, davejwatson@fb.com,
        ghackmann@google.com, linux-kernel@vger.kernel.org,
        maged.michael@gmail.com, avi@scylladb.com, parri.andrea@gmail.com,
        torvalds@linux-foundation.org, paulus@samba.org, mpe@ellerman.id.au,
        will.deacon@arm.com, linux@armlinux.org.uk, tglx@linutronix.de
Reply-To: davejwatson@fb.com, ghackmann@google.com, parri.andrea@gmail.com,
        maged.michael@gmail.com, linux-kernel@vger.kernel.org,
        avi@scylladb.com, mpe@ellerman.id.au, torvalds@linux-foundation.org,
        paulus@samba.org, will.deacon@arm.com, linux@armlinux.org.uk,
        tglx@linutronix.de, corbet@lwn.net, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, boqun.feng@gmail.com,
        benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, sehr@google.com,
        ahh@google.com, mingo@kernel.org, hpa@zytor.com, luto@kernel.org
In-Reply-To: <1518208256-22034-1-git-send-email-mathieu.desnoyers@efficios.com>
References: <1518208256-22034-1-git-send-email-mathieu.desnoyers@efficios.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/core] Documentation/features, membarriers: Document
 membarrier-sync-core architecture support
Git-Commit-ID: ac65ddad4a23d46529f921fdf8f7b7b6d14a15d8
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

Commit-ID:  ac65ddad4a23d46529f921fdf8f7b7b6d14a15d8
Gitweb:     https://git.kernel.org/tip/ac65ddad4a23d46529f921fdf8f7b7b6d14a15d8
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Fri, 9 Feb 2018 15:30:56 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 12:19:03 +0100

Documentation/features, membarriers: Document membarrier-sync-core architecture support

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
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maged Michael <maged.michael@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-doc@vger.kernel.org
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
