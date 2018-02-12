Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2169032-1518465370-2-6985035251652125638
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
    t=1518465369; b=vzU+ltyZhhpv/ONq8q5VxP/GAf7DAtAkjHGjToNiiJ7mvbP
    KnfbjuJwkmVGV5aNrUWbZ3KfhrK3SAhafZzv49Zo7CP93kqDPeyJdW6eaZPKxPoW
    cLTz4js1JnL+EXSjb6mBbPNcbfNUZ0VWQjoO+Ko5/Lo+DvzBVAJa89f+4vD+X6h1
    70pahWstVuy/6qqq5uolg74wBepBkN2NIn9N0JLoRtsgxZBxqTCSJq1LcAHkG2J3
    sFjn/A/Y7Y4XoeVLp1Aq1rg3B/CwBeY+832EWRr1IvTJsD/Dc6Hxwya0gw4eUUxu
    LiiwHlUFNDtvzms63V7VVH0W591Xw2b5I5jBc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518465369; bh=qXBtjC/dWj0RdsLg6wbjhfoao9
    mLo1xoCVf2uu8HPpc=; b=Miik51wj2h10eZLQgjFCovSqzEHcVHQq1a2AkZT0Jb
    WeG+wWNJDtPu3roNaOkMg0AmFQVUUld5Oniuwod1KAokuRMF3evLdKKyxt3zuiOh
    VLVtlygfeBZCG3LL8t5nL5ghJUPl3uOKpt8YnRdHaHfHMF6oK8cSPAtIC/2JGm7A
    bgYGzGxjyTUA9jnqahKxd4id/rtFnv1w7/wITT5NLflVLyAjG1AOI2hAQaLNxQHd
    xHtOdnR7fbi9xy5DZjiClUBUt0Q97nddL4H+xQqN5gzvvYSzhKCgrYHxGdq55gk3
    Wrt6p2fkfa3BIfuuE99sZXqNMj/9goXHqzWCD7sXHrCQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeBLT4H (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 14:56:07 -0500
Received: from mail.efficios.com ([167.114.142.141]:60928 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbeBLT4F (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Feb 2018 14:56:05 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        Maged Michael <maged.michael@gmail.com>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Watson <davejwatson@fb.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Hackmann <ghackmann@google.com>,
        Will Deacon <will.deacon@arm.com>,
        David Sehr <sehr@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH manpages] membarrier.2: New membarrier commands introduced in 4.16
Date: Mon, 12 Feb 2018 14:55:49 -0500
Message-Id: <20180212195549.11485-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Document the following membarrier commands introduced in 4.16:
- MEMBARRIER_CMD_GLOBAL_EXPEDITED (the old enum label
  MEMBARRIER_CMD_SHARED is now an alias to preserve header backward
  compatibility),
- MEMBARRIER_CMD_GLOBAL_EXPEDITED,
- MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,
- MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE,
- MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>
---
 man2/membarrier.2 | 73 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 11 deletions(-)

diff --git a/man2/membarrier.2 b/man2/membarrier.2
index c47bc875a..e878301ca 100644
--- a/man2/membarrier.2
+++ b/man2/membarrier.2
@@ -80,7 +80,7 @@ This command is always supported (on kernels where
 .BR membarrier ()
 is provided).
 .TP
-.B MEMBARRIER_CMD_SHARED
+.B MEMBARRIER_CMD_GLOBAL " (since Linux 4.16)"
 Ensure that all threads from all processes on the system pass through a
 state where all memory accesses to user-space addresses match program
 order between entry to and return from the
@@ -88,7 +88,30 @@ order between entry to and return from the
 system call.
 All threads on the system are targeted by this command.
 .TP
-.BR MEMBARRIER_CMD_PRIVATE_EXPEDITED " (since Linux 4.14)"
+.B MEMBARRIER_CMD_GLOBAL_EXPEDITED " (since Linux 4.16)"
+Execute a memory barrier on all running threads of all processes which
+previously registered with
+.BR MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED .
+Upon return from system call, the caller thread is ensured that all
+running threads have passed through a state where all memory accesses to
+user-space addresses match program order between entry to and return
+from the system call (non-running threads are de facto in such a state).
+This only covers threads from processes which registered with
+.BR MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED .
+Given that registration is about the intent to receive the barriers, it
+is valid to invoke
+.BR MEMBARRIER_CMD_GLOBAL_EXPEDITED
+from a non-registered process.
+.IP
+The "expedited" commands complete faster than the non-expedited ones;
+they never block, but have the downside of causing extra overhead.
+.TP
+.B MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED " (since Linux 4.16)"
+Register the process intent to receive
+.BR MEMBARRIER_CMD_GLOBAL_EXPEDITED
+memory barriers.
+.TP
+.B MEMBARRIER_CMD_PRIVATE_EXPEDITED " (since Linux 4.14)"
 Execute a memory barrier on each running thread belonging to the same
 process as the current thread.
 Upon return from system call, the calling
@@ -103,9 +126,29 @@ they never block, but have the downside of causing extra overhead.
 A process needs to register its intent to use the private
 expedited command prior to using it.
 .TP
-.BR MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED " (since Linux 4.14)"
+.B MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED " (since Linux 4.14)"
 Register the process's intent to use
-.BR MEMBARRIER_CMD_PRIVATE_EXPEDITED .
+.B MEMBARRIER_CMD_PRIVATE_EXPEDITED .
+.TP
+.B MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE " (since Linux 4.16)"
+In addition to provide memory ordering guarantees described in
+.BR MEMBARRIER_CMD_PRIVATE_EXPEDITED ,
+ensure the caller thread, upon return from system call, that all its
+running threads siblings have executed a core serializing instruction.
+This only covers threads from the same process as the caller thread.
+The "expedited" commands complete faster than the non-expedited ones,
+they never block, but have the downside of causing extra overhead. A
+process needs to register its intent to use the private expedited sync
+core command prior to using it.
+.TP
+.B MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE " (since Linux 4.16)"
+Register the process intent to use
+.BR MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE .
+.TP
+.B MEMBARRIER_CMD_SHARED
+ Alias to
+.BR MEMBARRIER_CMD_GLOBAL .
+Provided for header backward compatibility.
 .PP
 The
 .I flags
@@ -137,10 +180,14 @@ The pair ordering is detailed as (O: ordered, X: not ordered):
 On success, the
 .B MEMBARRIER_CMD_QUERY
 operation returns a bit mask of supported commands, and the
-.B MEMBARRIER_CMD_SHARED ,
+.B MEMBARRIER_CMD_GLOBAL ,
+.B MEMBARRIER_CMD_GLOBAL_EXPEDITED ,
+.B MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED ,
 .B MEMBARRIER_CMD_PRIVATE_EXPEDITED ,
-and
 .B MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED ,
+.B MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE ,
+and
+.B MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE
 operations return zero.
 On error, \-1 is returned,
 and
@@ -163,10 +210,14 @@ set to 0, error handling is required only for the first call to
 is invalid, or
 .I flags
 is nonzero, or the
-.BR MEMBARRIER_CMD_SHARED
+.BR MEMBARRIER_CMD_GLOBAL
 command is disabled because the
 .I nohz_full
-CPU parameter has been set.
+CPU parameter has been set, or the
+.BR MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE
+and
+.BR MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE
+commands are not implemented by the architecture.
 .TP
 .B ENOSYS
 The
@@ -294,9 +345,9 @@ init_membarrier(void)
         return \-1;
     }
 
-    if (!(ret & MEMBARRIER_CMD_SHARED)) {
+    if (!(ret & MEMBARRIER_CMD_GLOBAL)) {
         fprintf(stderr,
-            "membarrier does not support MEMBARRIER_CMD_SHARED\\n");
+            "membarrier does not support MEMBARRIER_CMD_GLOBAL\\n");
         return \-1;
     }
 
@@ -315,7 +366,7 @@ static void
 slow_path(int *read_a)
 {
     b = 1;
-    membarrier(MEMBARRIER_CMD_SHARED, 0);
+    membarrier(MEMBARRIER_CMD_GLOBAL, 0);
     *read_a = a;
 }
 
-- 
2.11.0

