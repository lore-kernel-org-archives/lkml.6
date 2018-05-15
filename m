Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbeEOGaJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:30:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47623 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeEOGaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:30:07 -0400
Date: Mon, 14 May 2018 23:29:43 -0700
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-bfd403bb3617e17a272e1189e5c76253052c22b8@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        stern@rowland.harvard.edu, will.deacon@arm.com, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, will.deacon@arm.com, torvalds@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, stern@rowland.harvard.edu, tglx@linutronix.de
In-Reply-To: <1526340837-12222-6-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526340837-12222-6-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-order: Update the cheat-sheet to
 show that smp_mb__after_atomic() orders later RMW operations
Git-Commit-ID: bfd403bb3617e17a272e1189e5c76253052c22b8
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

Commit-ID:  bfd403bb3617e17a272e1189e5c76253052c22b8
Gitweb:     https://git.kernel.org/tip/bfd403bb3617e17a272e1189e5c76253052c22b8
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Mon, 14 May 2018 16:33:44 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:16 +0200

tools/memory-order: Update the cheat-sheet to show that smp_mb__after_atomic() orders later RMW operations

The current cheat sheet does not claim that smp_mb__after_atomic()
orders later RMW atomic operations, which it must, at least against
earlier RMW atomic operations and whatever precedes them.

This commit therefore adds the needed "Y".

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
Link: http://lkml.kernel.org/r/1526340837-12222-6-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/Documentation/cheatsheet.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index 46fe79afc737..33ba98d72b16 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -14,7 +14,7 @@ smp_wmb()                                  Y    W           Y       Y    W
 smp_mb() & synchronize_rcu()  CP        Y  Y    Y        Y  Y   Y   Y    Y
 Successful full non-void RMW  CP     Y  Y  Y    Y     Y  Y  Y   Y   Y    Y   Y
 smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
-smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y
+smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
 
 
 Key:	C:	Ordering is cumulative
