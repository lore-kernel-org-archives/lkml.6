Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753566AbeBUKnS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:43:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38357 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbeBUKnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:43:16 -0500
Date: Wed, 21 Feb 2018 02:42:53 -0800
From: tip-bot for Nikolay Borisov <tipbot@zytor.com>
Message-ID: <tip-51de78892b1294d1521c41226a5ef215a910c25f@git.kernel.org>
Cc: mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org, hpa@zytor.com, nborisov@suse.com,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        nborisov@suse.com, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org
In-Reply-To: <1519169112-20593-8-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1519169112-20593-8-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] memory-barriers: Fix description of data
 dependency barriers
Git-Commit-ID: 51de78892b1294d1521c41226a5ef215a910c25f
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

Commit-ID:  51de78892b1294d1521c41226a5ef215a910c25f
Gitweb:     https://git.kernel.org/tip/51de78892b1294d1521c41226a5ef215a910c25f
Author:     Nikolay Borisov <nborisov@suse.com>
AuthorDate: Tue, 20 Feb 2018 15:25:08 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:58:14 +0100

memory-barriers: Fix description of data dependency barriers

In the description of data dependency barriers the words 'before' is
used erroneously. Since such barrier order dependent loads one after
the other. So substitute 'before' with 'after'.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
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
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/1519169112-20593-8-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/memory-barriers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index a37d3af..da6525b 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -403,7 +403,7 @@ Memory barriers come in four basic varieties:
      where two loads are performed such that the second depends on the result
      of the first (eg: the first load retrieves the address to which the second
      load will be directed), a data dependency barrier would be required to
-     make sure that the target of the second load is updated before the address
+     make sure that the target of the second load is updated after the address
      obtained by the first load is accessed.
 
      A data dependency barrier is a partial ordering on interdependent loads
