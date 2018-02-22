Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeBVHGx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:06:53 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55184 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbeBVHGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:06:49 -0500
X-Google-Smtp-Source: AH8x225vBrVCHHo1nDZH6gcoVUjkJjP8mR94CqpuG3ax012rZr81VZb6M/JJBW34LM9pjOzXbzNUJw==
X-ME-Sender: <xms:BmyOWuzeEJW_pkxNFqRcSmXI2Bw8wpawcZh64eX7YUqYheCWcMx2mg>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v5 14/17] Revert "locking/lockdep/selftests: Fix mixed read-write ABBA tests"
Date: Thu, 22 Feb 2018 15:09:01 +0800
Message-Id: <20180222070904.548-15-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222070904.548-1-boqun.feng@gmail.com>
References: <20180222070904.548-1-boqun.feng@gmail.com>
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
2.16.1
