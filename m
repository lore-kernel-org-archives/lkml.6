Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753596AbeBUKoz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:44:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36655 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbeBUKox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:44:53 -0500
Date: Wed, 21 Feb 2018 02:44:32 -0800
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-cac79a39f200ef73ae7fc8a429ce2859ebb118d9@git.kernel.org>
Cc: hpa@zytor.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de
In-Reply-To: <1519169112-20593-11-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1519169112-20593-11-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Convert underscores to
 hyphens
Git-Commit-ID: cac79a39f200ef73ae7fc8a429ce2859ebb118d9
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

Commit-ID:  cac79a39f200ef73ae7fc8a429ce2859ebb118d9
Gitweb:     https://git.kernel.org/tip/cac79a39f200ef73ae7fc8a429ce2859ebb118d9
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Tue, 20 Feb 2018 15:25:11 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:58:15 +0100

tools/memory-model: Convert underscores to hyphens

Typical cat-language code uses hyphens for word separators in
identifiers, but several LKMM identifiers use underscores instead.
This commit therefore converts underscores to hyphens in the .bell-
and .cat-file identifiers corresponding to smp_mb__before_atomic(),
smp_mb__after_atomic(), and smp_mb__after_spinlock().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: nborisov@suse.com
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/1519169112-20593-11-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/linux-kernel.bell | 6 +++---
 tools/memory-model/linux-kernel.cat  | 6 +++---
 tools/memory-model/linux-kernel.def  | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index b984bbd..18885ad 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -28,9 +28,9 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 		'rcu-lock (*rcu_read_lock*)  ||
 		'rcu-unlock (*rcu_read_unlock*) ||
 		'sync-rcu (*synchronize_rcu*) ||
-		'before_atomic (*smp_mb__before_atomic*) ||
-		'after_atomic (*smp_mb__after_atomic*) ||
-		'after_spinlock (*smp_mb__after_spinlock*)
+		'before-atomic (*smp_mb__before_atomic*) ||
+		'after-atomic (*smp_mb__after_atomic*) ||
+		'after-spinlock (*smp_mb__after_spinlock*)
 instructions F[Barriers]
 
 (* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index babe2b3..f0d27f8 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -29,9 +29,9 @@ let rb-dep = [R] ; fencerel(Rb_dep) ; [R]
 let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
 let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
-	([M] ; fencerel(Before_atomic) ; [RMW] ; po? ; [M]) |
-	([M] ; po? ; [RMW] ; fencerel(After_atomic) ; [M]) |
-	([M] ; po? ; [LKW] ; fencerel(After_spinlock) ; [M])
+	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
+	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
+	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
 let gp = po ; [Sync-rcu] ; po?
 
 let strong-fence = mb | gp
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index a397387..f5a1eb0 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -21,9 +21,9 @@ smp_mb() { __fence{mb} ; }
 smp_rmb() { __fence{rmb} ; }
 smp_wmb() { __fence{wmb} ; }
 smp_read_barrier_depends() { __fence{rb_dep}; }
-smp_mb__before_atomic() { __fence{before_atomic} ; }
-smp_mb__after_atomic() { __fence{after_atomic} ; }
-smp_mb__after_spinlock() { __fence{after_spinlock} ; }
+smp_mb__before_atomic() { __fence{before-atomic} ; }
+smp_mb__after_atomic() { __fence{after-atomic} ; }
+smp_mb__after_spinlock() { __fence{after-spinlock} ; }
 
 // Exchange
 xchg(X,V)  __xchg{mb}(X,V)
