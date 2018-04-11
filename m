Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753719AbeDKNsQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:48:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35128 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbeDKNsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:48:13 -0400
X-Google-Smtp-Source: AIpwx4+a69pMwgPRT/FlcYGLuXLI88hDsJ/Urs8xV5Y5M/vV+XDGg+n38j5t3JNi6gCo5SsQoteDhw==
X-ME-Sender: <xms:GRLOWmnnFf1Y31uuxo1Yvu-SgGVTth-PHkpa-y6XgQjq_j1PlSguKg>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 17/20] Revert "locking/lockdep/selftests: Fix mixed read-write ABBA tests"
Date: Wed, 11 Apr 2018 21:51:07 +0800
Message-Id: <20180411135110.9217-18-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d82fed75294229abc9d757f08a4817febae6c4f4.

Since we now could handle mixed read-write deadlock detection well, the
self tests could be detected as expected, no need to use this
work-around.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 6b7a28d84fc4..79270288fa28 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2266,14 +2266,6 @@ void locking_selftest(void)
 	print_testname("mixed read-lock/lock-write ABBA");
 	pr_cont("             |");
 	dotest(rlock_ABBA1, FAILURE, LOCKTYPE_RWLOCK);
-#ifdef CONFIG_PROVE_LOCKING
-	/*
-	 * Lockdep does indeed fail here, but there's nothing we can do about
-	 * that now.  Don't kill lockdep for it.
-	 */
-	unexpected_testcase_failures--;
-#endif
-
 	pr_cont("             |");
 	dotest(rwsem_ABBA1, FAILURE, LOCKTYPE_RWSEM);
 
-- 
2.16.2
