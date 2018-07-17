Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3CEECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3082086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3082086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeGQJ5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:57:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbeGQJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:57:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9PSRr1461887
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:25:28 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9PRlt1461884;
        Tue, 17 Jul 2018 02:25:27 -0700
Date:   Tue, 17 Jul 2018 02:25:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-b464818978d45cd4d78c8f13207891142c68bea9@git.kernel.org>
Cc:     torvalds@linux-foundation.org, stern@rowland.harvard.edu,
        mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, andrea.parri@amarulasolutions.com
Reply-To: hpa@zytor.com, paulmck@linux.vnet.ibm.com,
          stern@rowland.harvard.edu, mingo@kernel.org,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          andrea.parri@amarulasolutions.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180716180605.16115-1-paulmck@linux.vnet.ibm.com>
References: <20180716180605.16115-1-paulmck@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Add litmus test for full
 multicopy atomicity
Git-Commit-ID: b464818978d45cd4d78c8f13207891142c68bea9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b464818978d45cd4d78c8f13207891142c68bea9
Gitweb:     https://git.kernel.org/tip/b464818978d45cd4d78c8f13207891142c68bea9
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Mon, 16 Jul 2018 11:05:52 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:29:29 +0200

tools/memory-model: Add litmus test for full multicopy atomicity

This commit adds a litmus test suggested by Alan Stern that is forbidden
on fully multicopy atomic systems, but allowed on other-multicopy and
on non-multicopy atomic systems.  For reference, s390 is fully multicopy
atomic, x86 and ARMv8 are other-multicopy atomic, and ARMv7 and powerpc
are non-multicopy atomic.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/20180716180605.16115-1-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/litmus-tests/README             |  9 ++++++
 .../litmus-tests/SB+rfionceonce-poonceonces.litmus | 32 ++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 17eb9a8c222d..00140aaf58b7 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -111,6 +111,15 @@ SB+mbonceonces.litmus
 SB+poonceonces.litmus
 	As above, but without the smp_mb() invocations.
 
+SB+rfionceonce-poonceonces.litmus
+	This litmus test demonstrates that LKMM is not fully multicopy
+	atomic.  (Neither is it other multicopy atomic.)  This litmus test
+	also demonstrates the "locations" debugging aid, which designates
+	additional registers and locations to be printed out in the dump
+	of final states in the herd7 output.  Without the "locations"
+	statement, only those registers and locations mentioned in the
+	"exists" clause will be printed.
+
 S+poonceonces.litmus
 	As below, but without the smp_wmb() and acquire load.
 
diff --git a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
new file mode 100644
index 000000000000..04a16603660b
--- /dev/null
+++ b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
@@ -0,0 +1,32 @@
+C SB+rfionceonce-poonceonces
+
+(*
+ * Result: Sometimes
+ *
+ * This litmus test demonstrates that LKMM is not fully multicopy atomic.
+ *)
+
+{}
+
+P0(int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	WRITE_ONCE(*x, 1);
+	r1 = READ_ONCE(*x);
+	r2 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y)
+{
+	int r3;
+	int r4;
+
+	WRITE_ONCE(*y, 1);
+	r3 = READ_ONCE(*y);
+	r4 = READ_ONCE(*x);
+}
+
+locations [0:r1; 1:r3; x; y] (* Debug aid: Print things not in "exists". *)
+exists (0:r2=0 /\ 1:r4=0)
