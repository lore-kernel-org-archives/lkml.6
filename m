Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeCJJ3J (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 04:29:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37235 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeCJJ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 04:29:07 -0500
Date: Sat, 10 Mar 2018 01:28:44 -0800
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-ff1fe5e079730f138c98b268ce2e8482a1d954b4@git.kernel.org>
Cc: stern@rowland.harvard.edu, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, torvalds@linux-foundation.org,
        peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com
In-Reply-To: <1520443660-16858-3-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1520443660-16858-3-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Add documentation of new
 litmus test
Git-Commit-ID: ff1fe5e079730f138c98b268ce2e8482a1d954b4
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

Commit-ID:  ff1fe5e079730f138c98b268ce2e8482a1d954b4
Gitweb:     https://git.kernel.org/tip/ff1fe5e079730f138c98b268ce2e8482a1d954b4
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Wed, 7 Mar 2018 09:27:39 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 10 Mar 2018 10:22:23 +0100

tools/memory-model: Add documentation of new litmus test

The litmus-tests/README file lacks any mention of the new litmus test
ISA2+pooncelock+pooncelock+pombonce.litmus.  This commit therefore
adds a description of this test.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
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
Link: http://lkml.kernel.org/r/1520443660-16858-3-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/litmus-tests/README | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index dca7d823ad57..04096fb8b8d9 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -32,6 +32,12 @@ IRIW+poonceonces+OnceOnce.litmus
 	order of a pair of writes, where each write is to a different
 	variable by a different process?
 
+ISA2+pooncelock+pooncelock+pombonce.litmus
+	Tests whether the ordering provided by a lock-protected S
+	litmus test is visible to an external process whose accesses are
+	separated by smp_mb().	This addition of an external process to
+	S is otherwise known as ISA2.
+
 ISA2+poonceonces.litmus
 	As below, but with store-release replaced with WRITE_ONCE()
 	and load-acquire replaced with READ_ONCE().
