Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369F0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0512086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0512086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbeGQJ6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:58:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41545 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbeGQJ6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:58:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9Q51k1461931
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:26:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9Q5hC1461928;
        Tue, 17 Jul 2018 02:26:05 -0700
Date:   Tue, 17 Jul 2018 02:26:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-acb6c96c52ac0da6bb464173ad2cf5ada9049ad4@git.kernel.org>
Cc:     torvalds@linux-foundation.org, andrea.parri@amarulasolutions.com,
        hpa@zytor.com, stern@rowland.harvard.edu, mingo@kernel.org,
        tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Reply-To: andrea.parri@amarulasolutions.com, torvalds@linux-foundation.org,
          hpa@zytor.com, stern@rowland.harvard.edu,
          paulmck@linux.vnet.ibm.com, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <20180716180605.16115-2-paulmck@linux.vnet.ibm.com>
References: <20180716180605.16115-2-paulmck@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Fix
 ISA2+pooncelock+pooncelock+pombonce name
Git-Commit-ID: acb6c96c52ac0da6bb464173ad2cf5ada9049ad4
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

Commit-ID:  acb6c96c52ac0da6bb464173ad2cf5ada9049ad4
Gitweb:     https://git.kernel.org/tip/acb6c96c52ac0da6bb464173ad2cf5ada9049ad4
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Mon, 16 Jul 2018 11:05:53 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:29:31 +0200

tools/memory-model: Fix ISA2+pooncelock+pooncelock+pombonce name

The names on the first line of the litmus tests are arbitrary,
but the convention is that they be the filename without the trailing
".litmus".  This commit therefore removes the stray trailing ".litmus"
from ISA2+pooncelock+pooncelock+pombonce.litmus's name.

Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/20180716180605.16115-2-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 .../litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus             | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
index 7a39a0aaa976..0f749e419b34 100644
--- a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
@@ -1,4 +1,4 @@
-C ISA2+pooncelock+pooncelock+pombonce.litmus
+C ISA2+pooncelock+pooncelock+pombonce
 
 (*
  * Result: Sometimes
