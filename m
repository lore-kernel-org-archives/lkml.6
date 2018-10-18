Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5711AECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2821A21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2821A21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeJSAP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:15:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60229 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbeJSAP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:15:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9IGDRbO882822
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Oct 2018 09:13:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9IGDR1I882819;
        Thu, 18 Oct 2018 09:13:27 -0700
Date:   Thu, 18 Oct 2018 09:13:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yangtao Li <tipbot@zytor.com>
Message-ID: <tip-e45506ac0af9b56b221863e9649fe122d8bb42ff@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tiny.windzz@gmail.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          tiny.windzz@gmail.com, mingo@kernel.org,
          torvalds@linux-foundation.org, peterz@infradead.org
In-Reply-To: <20181018142133.12341-1-tiny.windzz@gmail.com>
References: <20181018142133.12341-1-tiny.windzz@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq: Fix typo in __do_softirq() comments
Git-Commit-ID: e45506ac0af9b56b221863e9649fe122d8bb42ff
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

Commit-ID:  e45506ac0af9b56b221863e9649fe122d8bb42ff
Gitweb:     https://git.kernel.org/tip/e45506ac0af9b56b221863e9649fe122d8bb42ff
Author:     Yangtao Li <tiny.windzz@gmail.com>
AuthorDate: Thu, 18 Oct 2018 10:21:33 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 18 Oct 2018 18:10:23 +0200

softirq: Fix typo in __do_softirq() comments

s/s/as

[ mingo: Also add a missing 'the', add proper punctuation and clarify what 'swap' means here. ]

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: alexander.levin@verizon.com
Cc: frederic@kernel.org
Cc: joel@joelfernandes.org
Cc: paulmck@linux.vnet.ibm.com
Cc: rostedt@goodmis.org
Link: http://lkml.kernel.org/r/20181018142133.12341-1-tiny.windzz@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/softirq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 6f584861d329..9526895fe4ac 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -257,9 +257,9 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	int softirq_bit;
 
 	/*
-	 * Mask out PF_MEMALLOC s current task context is borrowed for the
-	 * softirq. A softirq handled such as network RX might set PF_MEMALLOC
-	 * again if the socket is related to swap
+	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
+	 * softirq. A softirq handled, such as network RX, might set PF_MEMALLOC
+	 * again if the socket is related to swapping.
 	 */
 	current->flags &= ~PF_MEMALLOC;
 
