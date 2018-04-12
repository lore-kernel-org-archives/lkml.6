Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeDLMX7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 08:23:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42110 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbeDLMX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 08:23:56 -0400
X-Google-Smtp-Source: AIpwx49Gc5hNp1zjnV/NXSUB0/5SuppdhlqWT0x+ySKdwQ0WuXMK4KBQpSAk8vxQb6DO3by0qB0zzg==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH 2/2] tools/memory-model: Fix coding style in 'linux-kernel.def'
Date: Thu, 12 Apr 2018 14:22:50 +0200
Message-Id: <1523535770-10781-3-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523535770-10781-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1523535770-10781-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes white spaces around semicolons.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/memory-model/linux-kernel.def | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index acf86f6f360a7..6bd3bc431b3da 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -17,12 +17,12 @@ rcu_dereference(X) __load{once}(X)
 smp_store_mb(X,V) { __store{once}(X,V); __fence{mb}; }
 
 // Fences
-smp_mb() { __fence{mb} ; }
-smp_rmb() { __fence{rmb} ; }
-smp_wmb() { __fence{wmb} ; }
-smp_mb__before_atomic() { __fence{before-atomic} ; }
-smp_mb__after_atomic() { __fence{after-atomic} ; }
-smp_mb__after_spinlock() { __fence{after-spinlock} ; }
+smp_mb() { __fence{mb}; }
+smp_rmb() { __fence{rmb}; }
+smp_wmb() { __fence{wmb}; }
+smp_mb__before_atomic() { __fence{before-atomic}; }
+smp_mb__after_atomic() { __fence{after-atomic}; }
+smp_mb__after_spinlock() { __fence{after-spinlock}; }
 
 // Exchange
 xchg(X,V)  __xchg{mb}(X,V)
@@ -35,26 +35,26 @@ cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)
 cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
 
 // Spinlocks
-spin_lock(X) { __lock(X) ; }
-spin_unlock(X) { __unlock(X) ; }
+spin_lock(X) { __lock(X); }
+spin_unlock(X) { __unlock(X); }
 spin_trylock(X) __trylock(X)
 
 // RCU
 rcu_read_lock() { __fence{rcu-lock}; }
-rcu_read_unlock() { __fence{rcu-unlock};}
+rcu_read_unlock() { __fence{rcu-unlock}; }
 synchronize_rcu() { __fence{sync-rcu}; }
 synchronize_rcu_expedited() { __fence{sync-rcu}; }
 
 // Atomic
 atomic_read(X) READ_ONCE(*X)
-atomic_set(X,V) { WRITE_ONCE(*X,V) ; }
+atomic_set(X,V) { WRITE_ONCE(*X,V); }
 atomic_read_acquire(X) smp_load_acquire(X)
 atomic_set_release(X,V) { smp_store_release(X,V); }
 
-atomic_add(V,X) { __atomic_op(X,+,V) ; }
-atomic_sub(V,X) { __atomic_op(X,-,V) ; }
-atomic_inc(X)   { __atomic_op(X,+,1) ; }
-atomic_dec(X)   { __atomic_op(X,-,1) ; }
+atomic_add(V,X) { __atomic_op(X,+,V); }
+atomic_sub(V,X) { __atomic_op(X,-,V); }
+atomic_inc(X)   { __atomic_op(X,+,1); }
+atomic_dec(X)   { __atomic_op(X,-,1); }
 
 atomic_add_return(V,X) __atomic_op_return{mb}(X,+,V)
 atomic_add_return_relaxed(V,X) __atomic_op_return{once}(X,+,V)
-- 
2.7.4
