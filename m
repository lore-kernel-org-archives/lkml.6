Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6D2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8A120852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8A120852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbeGQKBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:01:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54237 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbeGQKBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:01:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9SVeW1462366
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:28:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9SVl11462363;
        Tue, 17 Jul 2018 02:28:31 -0700
Date:   Tue, 17 Jul 2018 02:28:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-af41db5ef7c7cf0fee860f65cab59d0d188098d2@git.kernel.org>
Cc:     paulmck@linux.vnet.ibm.com, dhowells@redhat.com,
        andrea.parri@amarulasolutions.com, stern@rowland.harvard.edu,
        mingo@kernel.org, npiggin@gmail.com, akiyks@gmail.com,
        peterz@infradead.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        will.deacon@arm.com, luc.maranget@inria.fr,
        torvalds@linux-foundation.org, j.alglave@ucl.ac.uk,
        boqun.feng@gmail.com
Reply-To: j.alglave@ucl.ac.uk, torvalds@linux-foundation.org,
          boqun.feng@gmail.com, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mark.rutland@arm.com,
          peterz@infradead.org, luc.maranget@inria.fr, will.deacon@arm.com,
          mingo@kernel.org, stern@rowland.harvard.edu, akiyks@gmail.com,
          npiggin@gmail.com, paulmck@linux.vnet.ibm.com,
          andrea.parri@amarulasolutions.com, dhowells@redhat.com
In-Reply-To: <20180716180605.16115-6-paulmck@linux.vnet.ibm.com>
References: <20180716180605.16115-6-paulmck@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Remove ACCESS_ONCE() from
 model
Git-Commit-ID: af41db5ef7c7cf0fee860f65cab59d0d188098d2
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

Commit-ID:  af41db5ef7c7cf0fee860f65cab59d0d188098d2
Gitweb:     https://git.kernel.org/tip/af41db5ef7c7cf0fee860f65cab59d0d188098d2
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Mon, 16 Jul 2018 11:05:57 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:29:35 +0200

tools/memory-model: Remove ACCESS_ONCE() from model

Since commit:

  b899a850431e2dd0 ("compiler.h: Remove ACCESS_ONCE()")

... there has been no definition of ACCESS_ONCE() in the kernel tree,
and it has been necessary to use READ_ONCE() or WRITE_ONCE() instead.

Correspondingly, let's remove ACCESS_ONCE() from the kernel memory
model.

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
Link: http://lkml.kernel.org/r/20180716180605.16115-6-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/linux-kernel.bell | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 64f5740e0e75..b84fb2f67109 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -13,7 +13,7 @@
 
 "Linux-kernel memory consistency model"
 
-enum Accesses = 'once (*READ_ONCE,WRITE_ONCE,ACCESS_ONCE*) ||
+enum Accesses = 'once (*READ_ONCE,WRITE_ONCE*) ||
 		'release (*smp_store_release*) ||
 		'acquire (*smp_load_acquire*) ||
 		'noreturn (* R of non-return RMW *)
