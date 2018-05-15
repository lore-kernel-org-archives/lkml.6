Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752471AbeEOGZq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:25:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44607 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752186AbeEOGZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:25:44 -0400
Date: Mon, 14 May 2018 23:25:21 -0700
From: tip-bot for SeongJae Park <tipbot@zytor.com>
Message-ID: <tip-173af2613efdc29547718848a0a2928a26b1398f@git.kernel.org>
Cc: akpm@linux-foundation.org, hpa@zytor.com, will.deacon@arm.com,
        sj38.park@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
        torvalds@linux-foundation.org
Reply-To: mingo@kernel.org, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, hpa@zytor.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, sj38.park@gmail.com
In-Reply-To: <1526338533-6044-8-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526338533-6044-8-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/Documentation: Use `warning` RST
 directive
Git-Commit-ID: 173af2613efdc29547718848a0a2928a26b1398f
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

Commit-ID:  173af2613efdc29547718848a0a2928a26b1398f
Gitweb:     https://git.kernel.org/tip/173af2613efdc29547718848a0a2928a26b1398f
Author:     SeongJae Park <sj38.park@gmail.com>
AuthorDate: Mon, 14 May 2018 15:55:33 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:15 +0200

locking/Documentation: Use `warning` RST directive

Use the proper RST directive, pointed out by a build warning.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
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
Cc: stern@rowland.harvard.edu
Link: http://lkml.kernel.org/r/1526338533-6044-8-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/core-api/atomic_ops.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
index 4ea4af71e68a..2e7165f86f55 100644
--- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -466,10 +466,12 @@ Like the above, except that these routines return a boolean which
 indicates whether the changed bit was set _BEFORE_ the atomic bit
 operation.
 
-WARNING! It is incredibly important that the value be a boolean,
-ie. "0" or "1".  Do not try to be fancy and save a few instructions by
-declaring the above to return "long" and just returning something like
-"old_val & mask" because that will not work.
+
+.. warning::
+        It is incredibly important that the value be a boolean, ie. "0" or "1".
+        Do not try to be fancy and save a few instructions by declaring the
+        above to return "long" and just returning something like "old_val &
+        mask" because that will not work.
 
 For one thing, this return value gets truncated to int in many code
 paths using these interfaces, so on 64-bit if the bit is set in the
