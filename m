Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AF9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C8A20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C8A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393958AbeKVUvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:51:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42787 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbeKVUvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:51:13 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMAB3RA3743779
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 02:11:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMAB3cx3743776;
        Thu, 22 Nov 2018 02:11:03 -0800
Date:   Thu, 22 Nov 2018 02:11:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-d38bc89c72e7235ac889ae64fe7828e2e61a18af@git.kernel.org>
Cc:     tglx@linutronix.de, luto@kernel.org, peterz@infradead.org,
        riel@surriel.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, yu-cheng.yu@intel.com,
        torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de
Reply-To: yu-cheng.yu@intel.com, torvalds@linux-foundation.org,
          mingo@kernel.org, bp@alien8.de, tglx@linutronix.de,
          luto@kernel.org, peterz@infradead.org,
          dave.hansen@linux.intel.com, riel@surriel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <4e36812b6e1e95236a812021d35cbf22746b5af6.1542841400.git.luto@kernel.org>
References: <4e36812b6e1e95236a812021d35cbf22746b5af6.1542841400.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/oops: Show the correct CS value in show_regs()
Git-Commit-ID: d38bc89c72e7235ac889ae64fe7828e2e61a18af
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

Commit-ID:  d38bc89c72e7235ac889ae64fe7828e2e61a18af
Gitweb:     https://git.kernel.org/tip/d38bc89c72e7235ac889ae64fe7828e2e61a18af
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 21 Nov 2018 15:11:24 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 22 Nov 2018 09:23:01 +0100

x86/oops: Show the correct CS value in show_regs()

show_regs() shows the CS in the CPU register instead of the value in
regs.  This means that we'll probably print "CS: 0010" almost all
the time regardless of what was actually in CS when the kernel
malfunctioned.  This gives a particularly confusing result if we
OOPSed due to an implicit supervisor access from user mode.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/4e36812b6e1e95236a812021d35cbf22746b5af6.1542841400.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/process_64.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 0e0b4288a4b2..2b8e6324fa20 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -66,7 +66,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L, fs, gs, shadowgs;
 	unsigned long d0, d1, d2, d3, d6, d7;
 	unsigned int fsindex, gsindex;
-	unsigned int ds, cs, es;
+	unsigned int ds, es;
 
 	show_iret_regs(regs);
 
@@ -98,7 +98,6 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	}
 
 	asm("movl %%ds,%0" : "=r" (ds));
-	asm("movl %%cs,%0" : "=r" (cs));
 	asm("movl %%es,%0" : "=r" (es));
 	asm("movl %%fs,%0" : "=r" (fsindex));
 	asm("movl %%gs,%0" : "=r" (gsindex));
@@ -114,7 +113,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 
 	printk(KERN_DEFAULT "FS:  %016lx(%04x) GS:%016lx(%04x) knlGS:%016lx\n",
 	       fs, fsindex, gs, gsindex, shadowgs);
-	printk(KERN_DEFAULT "CS:  %04x DS: %04x ES: %04x CR0: %016lx\n", cs, ds,
+	printk(KERN_DEFAULT "CS:  %04lx DS: %04x ES: %04x CR0: %016lx\n", regs->cs, ds,
 			es, cr0);
 	printk(KERN_DEFAULT "CR2: %016lx CR3: %016lx CR4: %016lx\n", cr2, cr3,
 			cr4);
