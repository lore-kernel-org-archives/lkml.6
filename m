Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FA9ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3211720852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3211720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbeGQKAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:00:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34763 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbeGQKAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:00:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9Rr0F1462235
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:27:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9RroR1462232;
        Tue, 17 Jul 2018 02:27:53 -0700
Date:   Tue, 17 Jul 2018 02:27:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-5bde06b63af2af8c2326270aae041067eef89245@git.kernel.org>
Cc:     luc.maranget@inria.fr, will.deacon@arm.com, boqun.feng@gmail.com,
        mark.rutland@arm.com, tglx@linutronix.de, j.alglave@ucl.ac.uk,
        stern@rowland.harvard.edu, dhowells@redhat.com,
        paulmck@linux.vnet.ibm.com, hpa@zytor.com, akiyks@gmail.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        andrea.parri@amarulasolutions.com, npiggin@gmail.com,
        peterz@infradead.org, mingo@kernel.org
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com,
          dhowells@redhat.com, paulmck@linux.vnet.ibm.com,
          akiyks@gmail.com, j.alglave@ucl.ac.uk, stern@rowland.harvard.edu,
          mark.rutland@arm.com, tglx@linutronix.de, boqun.feng@gmail.com,
          luc.maranget@inria.fr, will.deacon@arm.com, mingo@kernel.org,
          peterz@infradead.org, npiggin@gmail.com,
          andrea.parri@amarulasolutions.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180716180605.16115-5-paulmck@linux.vnet.ibm.com>
References: <20180716180605.16115-5-paulmck@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Remove ACCESS_ONCE() from
 recipes
Git-Commit-ID: 5bde06b63af2af8c2326270aae041067eef89245
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5bde06b63af2af8c2326270aae041067eef89245
Gitweb:     https://git.kernel.org/tip/5bde06b63af2af8c2326270aae041067eef89245
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Mon, 16 Jul 2018 11:05:56 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:29:34 +0200

tools/memory-model: Remove ACCESS_ONCE() from recipes

Since commit:

  b899a850431e2dd0 ("compiler.h: Remove ACCESS_ONCE()")

... there has been no definition of ACCESS_ONCE() in the kernel tree,
and it has been necessary to use READ_ONCE() or WRITE_ONCE() instead.

Let's update the exmaples in recipes.txt likewise for consistency, using
READ_ONCE() for reads.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: parri.andrea@gmail.com
Link: http://lkml.kernel.org/r/20180716180605.16115-5-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/Documentation/recipes.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index ee4309a87fc4..1fea8ef2b184 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -322,9 +322,9 @@ the following write-side code fragment:
 And the xlog_valid_lsn() function in fs/xfs/xfs_log_priv.h contains
 the corresponding read-side code fragment:
 
-	cur_cycle = ACCESS_ONCE(log->l_curr_cycle);
+	cur_cycle = READ_ONCE(log->l_curr_cycle);
 	smp_rmb();
-	cur_block = ACCESS_ONCE(log->l_curr_block);
+	cur_block = READ_ONCE(log->l_curr_block);
 
 Alternatively, consider the following comment in function
 perf_output_put_handle() in kernel/events/ring_buffer.c:
