Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20E5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854FC261D5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854FC261D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964774AbeFZK0W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:26:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49467 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934777AbeFZKZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:25:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QAP2m51648034
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:25:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QAP11q1648027;
        Tue, 26 Jun 2018 03:25:01 -0700
Date:   Tue, 26 Jun 2018 03:25:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dmitry Vyukov <tipbot@zytor.com>
Message-ID: <tip-4188f063e3694ccbf2a2044cf17cc325f91e458f@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        sergey.senozhatsky@gmail.com, brgerst@gmail.com,
        peterz@infradead.org, hpa@zytor.com, luto@kernel.org,
        dvyukov@google.com, mingo@kernel.org,
        torvalds@linux-foundation.org, jpoimboe@redhat.com,
        dvlasenk@redhat.com, bp@alien8.de
Reply-To: jpoimboe@redhat.com, bp@alien8.de, dvlasenk@redhat.com,
          mingo@kernel.org, dvyukov@google.com, luto@kernel.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, peterz@infradead.org, brgerst@gmail.com,
          hpa@zytor.com, sergey.senozhatsky@gmail.com
In-Reply-To: <20180625123808.227417-1-dvyukov@gmail.com>
References: <20180625123808.227417-1-dvyukov@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Get rid of KERN_CONT in show_fault_oops()
Git-Commit-ID: 4188f063e3694ccbf2a2044cf17cc325f91e458f
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

Commit-ID:  4188f063e3694ccbf2a2044cf17cc325f91e458f
Gitweb:     https://git.kernel.org/tip/4188f063e3694ccbf2a2044cf17cc325f91e458f
Author:     Dmitry Vyukov <dvyukov@google.com>
AuthorDate: Mon, 25 Jun 2018 14:38:08 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:00:25 +0200

x86/mm: Get rid of KERN_CONT in show_fault_oops()

KERN_CONT leads to split lines in kernel output
and complicates useful changes to printk like
printing context before each line.

Only acceptable use of continuations is basically
boot-time testing.

Get rid of it.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180625123808.227417-1-dvyukov@gmail.com
[ Removed unnecessary parentheses and prettified the printk statement. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9a84a0d08727..ee85766e6329 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -671,13 +671,9 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 			printk(smep_warning, from_kuid(&init_user_ns, current_uid()));
 	}
 
-	printk(KERN_ALERT "BUG: unable to handle kernel ");
-	if (address < PAGE_SIZE)
-		printk(KERN_CONT "NULL pointer dereference");
-	else
-		printk(KERN_CONT "paging request");
-
-	printk(KERN_CONT " at %px\n", (void *) address);
+	pr_alert("BUG: unable to handle kernel %s at %px\n",
+		 address < PAGE_SIZE ? "NULL pointer dereference" : "paging request",
+		 (void *)address);
 
 	dump_pagetable(address);
 }
