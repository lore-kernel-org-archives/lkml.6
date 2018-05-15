Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbeEOGas (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:30:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47651 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeEOGar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:30:47 -0400
Date: Mon, 14 May 2018 23:30:12 -0700
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-bf8c6d963d16d40fbe70e94b61d9bf18c455fc6b@git.kernel.org>
Cc: pbonzini@redhat.com, torvalds@linux-foundation.org, tglx@linutronix.de,
        paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org,
        will.deacon@arm.com, stern@rowland.harvard.edu, hpa@zytor.com,
        linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com,
        peterz@infradead.org, mingo@kernel.org
Reply-To: hpa@zytor.com, stern@rowland.harvard.edu, pbonzini@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        paulmck@linux.vnet.ibm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, andrea.parri@amarulasolutions.com,
        mingo@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <1526340837-12222-7-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526340837-12222-7-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Model 'smp_store_mb()'
Git-Commit-ID: bf8c6d963d16d40fbe70e94b61d9bf18c455fc6b
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

Commit-ID:  bf8c6d963d16d40fbe70e94b61d9bf18c455fc6b
Gitweb:     https://git.kernel.org/tip/bf8c6d963d16d40fbe70e94b61d9bf18c455fc6b
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Mon, 14 May 2018 16:33:45 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:16 +0200

tools/memory-model: Model 'smp_store_mb()'

This commit models 'smp_store_mb(x, val);' to be semantically equivalent
to 'WRITE_ONCE(x, val); smp_mb();'.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
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
Link: http://lkml.kernel.org/r/1526340837-12222-7-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/linux-kernel.def | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 397e4e67e8c8..acf86f6f360a 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -14,6 +14,7 @@ smp_store_release(X,V) { __store{release}(*X,V); }
 smp_load_acquire(X) __load{acquire}(*X)
 rcu_assign_pointer(X,V) { __store{release}(X,V); }
 rcu_dereference(X) __load{once}(X)
+smp_store_mb(X,V) { __store{once}(X,V); __fence{mb}; }
 
 // Fences
 smp_mb() { __fence{mb} ; }
