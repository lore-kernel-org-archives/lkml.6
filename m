Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeEOGZY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:25:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51549 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752160AbeEOGZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:25:23 -0400
Date: Mon, 14 May 2018 23:24:52 -0700
From: tip-bot for SeongJae Park <tipbot@zytor.com>
Message-ID: <tip-fc7bdc90249b216051d06496577c306327f2e3f5@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, stern@rowland.harvard.edu,
        sj38.park@gmail.com, will.deacon@arm.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com
Reply-To: paulmck@linux.vnet.ibm.com, mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        will.deacon@arm.com, akpm@linux-foundation.org, tglx@linutronix.de,
        hpa@zytor.com, stern@rowland.harvard.edu, sj38.park@gmail.com
In-Reply-To: <1526338533-6044-7-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526338533-6044-7-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/Documentation: Fix incorrect example
 code
Git-Commit-ID: fc7bdc90249b216051d06496577c306327f2e3f5
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

Commit-ID:  fc7bdc90249b216051d06496577c306327f2e3f5
Gitweb:     https://git.kernel.org/tip/fc7bdc90249b216051d06496577c306327f2e3f5
Author:     SeongJae Park <sj38.park@gmail.com>
AuthorDate: Mon, 14 May 2018 15:55:32 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:14 +0200

locking/Documentation: Fix incorrect example code

 - Remove a stale line of code
 - Fix the condition of the READ_ONCE() example

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Link: http://lkml.kernel.org/r/1526338533-6044-7-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/core-api/atomic_ops.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
index fce929144ccd..4ea4af71e68a 100644
--- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -111,7 +111,6 @@ If the compiler can prove that do_something() does not store to the
 variable a, then the compiler is within its rights transforming this to
 the following::
 
-	tmp = a;
 	if (a > 0)
 		for (;;)
 			do_something();
@@ -119,7 +118,7 @@ the following::
 If you don't want the compiler to do this (and you probably don't), then
 you should use something like the following::
 
-	while (READ_ONCE(a) < 0)
+	while (READ_ONCE(a) > 0)
 		do_something();
 
 Alternatively, you could place a barrier() call in the loop.
