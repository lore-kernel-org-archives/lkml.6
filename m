Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ED5C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A1E20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A1E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeLFQkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:40:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFQkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:40:45 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB6GdrRB1769300
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Dec 2018 08:39:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB6GdrRM1769297;
        Thu, 6 Dec 2018 08:39:53 -0800
Date:   Thu, 6 Dec 2018 08:39:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrea Righi <tipbot@zytor.com>
Message-ID: <tip-a50480cb6d61d5c5fc13308479407b628b6bc1c5@git.kernel.org>
Cc:     yhs@fb.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, luto@kernel.org, hpa@zytor.com,
        righi.andrea@gmail.com, torvalds@linux-foundation.org,
        bp@alien8.de, peterz@infradead.org,
        naveen.n.rao@linux.vnet.ibm.com, mingo@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com
Reply-To: torvalds@linux-foundation.org, bp@alien8.de,
          peterz@infradead.org, naveen.n.rao@linux.vnet.ibm.com,
          mingo@kernel.org, davem@davemloft.net,
          anil.s.keshavamurthy@intel.com, tglx@linutronix.de, yhs@fb.com,
          linux-kernel@vger.kernel.org, mhiramat@kernel.org,
          righi.andrea@gmail.com, luto@kernel.org, hpa@zytor.com
In-Reply-To: <20181206095648.GA8249@Dell>
References: <20181206095648.GA8249@Dell>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] kprobes/x86: Blacklist non-attachable interrupt
 functions
Git-Commit-ID: a50480cb6d61d5c5fc13308479407b628b6bc1c5
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

Commit-ID:  a50480cb6d61d5c5fc13308479407b628b6bc1c5
Gitweb:     https://git.kernel.org/tip/a50480cb6d61d5c5fc13308479407b628b6bc1c5
Author:     Andrea Righi <righi.andrea@gmail.com>
AuthorDate: Thu, 6 Dec 2018 10:56:48 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 6 Dec 2018 16:52:03 +0100

kprobes/x86: Blacklist non-attachable interrupt functions

These interrupt functions are already non-attachable by kprobes.
Blacklist them explicitly so that they can show up in
/sys/kernel/debug/kprobes/blacklist and tools like BCC can use this
additional information.

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yonghong Song <yhs@fb.com>
Link: http://lkml.kernel.org/r/20181206095648.GA8249@Dell
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ce25d84023c0..1f0efdb7b629 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -566,6 +566,7 @@ ENTRY(interrupt_entry)
 
 	ret
 END(interrupt_entry)
+_ASM_NOKPROBE(interrupt_entry)
 
 
 /* Interrupt entry/exit. */
@@ -766,6 +767,7 @@ native_irq_return_ldt:
 	jmp	native_irq_return_iret
 #endif
 END(common_interrupt)
+_ASM_NOKPROBE(common_interrupt)
 
 /*
  * APIC interrupts.
@@ -780,6 +782,7 @@ ENTRY(\sym)
 	call	\do_sym	/* rdi points to pt_regs */
 	jmp	ret_from_intr
 END(\sym)
+_ASM_NOKPROBE(\sym)
 .endm
 
 /* Make sure APIC interrupt handlers end up in the irqentry section: */
@@ -960,6 +963,7 @@ ENTRY(\sym)
 
 	jmp	error_exit
 	.endif
+_ASM_NOKPROBE(\sym)
 END(\sym)
 .endm
 
