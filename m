Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbeDPQNY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:13:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753089AbeDPQLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:11:49 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 17/17] tools/memory-model: Fix coding style in 'linux-kernel.def'
Date: Mon, 16 Apr 2018 09:12:45 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041616-0044-0000-0000-00000404B80C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008863; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018801; UDB=6.00519703; IPR=6.00798043;
 MB=3.00020599; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-16 16:11:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041616-0045-0000-0000-00000836BB71
Message-Id: <1523895165-17576-17-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

This commit fixes white spaces around semicolons.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/linux-kernel.def | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index acf86f6f360a..6bd3bc431b3d 100644
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
2.5.2
