Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2177121-1518208268-2-1344443733319273285
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518208267; b=h1D9vsFRXNahzOjZaEw8JutUSbhk0aGZGGMgS4fTvgmzPR3
    brPrgTG5M68MTYEeeepLxDUMVCEEM9ystHsVHS6eIxBvLA6g8Q3LFHON5bjrhv5z
    jwlrLokz69Kp2UfAF51uh/8SWWRaB8nc3vWpYJmyz9rMjMk3lID6ShjtiRAS6zuK
    qrejy5S68IW5HpTgCoBDAQ8nKGnAnUnIYVDGxvIv8nU5r4qhPvLKD3uDY5bwnNDv
    4AcCdVGVhub6SyOaNuy4kte9MlDqFW4UPGQOyLoGSHHooJvrh8ha0qHDfpKUgPnF
    wPTsBbMghgsvJd562FN7IDBFQwoDy+sIqDEKVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518208267; bh=HN2g1WJRZcfP3A3gnKNGZm9QL5
    hsOcnOUfjGcjXqImA=; b=v5Nq3VAha82ZBE6LKk2evOAS2Q+ZhkQ2cWWm8KYUnw
    u7cYy0TSr8kIs3+JcBJK/VFdIWtC/jLL9leOSc9GC2eEw5ZnJkvaniLQVxCNEYbu
    E2rVPN2ZjGiZj9a6g1TBWVu+YjfUKefRXofekE+dnkyzfhT5Fzxh5gdahGKaXnpg
    P1nzZy6NR98BV8Xa+Kx3R90cIXVgznmnykuUGSSpyZyzNmqRXs0IgqwHzBrOF/tA
    /7c8FcesUvbXXTGW7REyVDh2q6KdwghHNozs+Nia8rBYjoyp421KyhhbeVL369+W
    fT3xa8OIIUej+nmPUNodvPNAXm5hAj5ljs3k20G505OA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeBIUbF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 15:31:05 -0500
Received: from mail.efficios.com ([167.114.142.141]:55070 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeBIUbE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Feb 2018 15:31:04 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, David Sehr <sehr@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Maged Michael <maged.michael@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH for 4.16] membarrier-sync-core: Document architecture support
Date: Fri,  9 Feb 2018 15:30:56 -0500
Message-Id: <1518208256-22034-1-git-send-email-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ensure we gather architecture requirements about each architecture
supporting the "sync_core" membarrier command in a single file under
Documentation/features.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Andrew Hunter <ahh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: David Sehr <sehr@google.com>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maged Michael <maged.michael@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
---
 .../sched/membarrier-sync-core/arch-support.txt    | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/features/sched/membarrier-sync-core/arch-support.txt

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
-- 
1.9.1

