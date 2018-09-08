Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DBAC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E65120844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E65120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeIHOUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:20:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46997 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbeIHOUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:20:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w889Xt9v1040028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 8 Sep 2018 02:33:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w889XsTu1040025;
        Sat, 8 Sep 2018 02:33:54 -0700
Date:   Sat, 8 Sep 2018 02:33:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-bd7b1f7cbf9cb35dab8e1b99145d07afc5b7a132@git.kernel.org>
Cc:     ak@linux.intel.com, luto@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, torvalds@linux-foundation.org,
        adrian.hunter@intel.com, jolsa@redhat.com, joro@8bytes.org,
        alexander.shishkin@linux.intel.com, jpoimboe@redhat.com,
        bp@alien8.de, acme@kernel.org, hpa@zytor.com, bp@suse.de,
        peterz@infradead.org
Reply-To: bp@alien8.de, acme@kernel.org, jpoimboe@redhat.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          bp@suse.de, hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, luto@kernel.org,
          ak@linux.intel.com, jolsa@redhat.com, joro@8bytes.org,
          adrian.hunter@intel.com, dave.hansen@linux.intel.com,
          torvalds@linux-foundation.org
In-Reply-To: <6e56c3ad94879e41afe345750bc28ccc0e820ea8.1536015544.git.luto@kernel.org>
References: <6e56c3ad94879e41afe345750bc28ccc0e820ea8.1536015544.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Document idtentry
Git-Commit-ID: bd7b1f7cbf9cb35dab8e1b99145d07afc5b7a132
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

Commit-ID:  bd7b1f7cbf9cb35dab8e1b99145d07afc5b7a132
Gitweb:     https://git.kernel.org/tip/bd7b1f7cbf9cb35dab8e1b99145d07afc5b7a132
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 3 Sep 2018 15:59:42 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 8 Sep 2018 11:20:11 +0200

x86/entry/64: Document idtentry

The idtentry macro is complicated and magical.  Document what it
does to help future readers and to allow future patches to adjust
the code and docs at the same time.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/6e56c3ad94879e41afe345750bc28ccc0e820ea8.1536015544.git.luto@kernel.org

---
 arch/x86/entry/entry_64.S | 36 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c   |  4 ++++
 2 files changed, 40 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 957dfb693ecc..ce6af4460e9c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -900,6 +900,42 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + ((x) - 1) * 8)
 
+/**
+ * idtentry - Generate an IDT entry stub
+ * @sym:		Name of the generated entry point
+ * @do_sym: 		C function to be called
+ * @has_error_code: 	True if this IDT vector has an error code on the stack
+ * @paranoid: 		non-zero means that this vector may be invoked from
+ *			kernel mode with user GSBASE and/or user CR3.
+ *			2 is special -- see below.
+ * @shift_ist:		Set to an IST index if entries from kernel mode should
+ *             		decrement the IST stack so that nested entries get a
+ *			fresh stack.  (This is for #DB, which has a nasty habit
+ *             		of recursing.)
+ *
+ * idtentry generates an IDT stub that sets up a usable kernel context,
+ * creates struct pt_regs, and calls @do_sym.  The stub has the following
+ * special behaviors:
+ *
+ * On an entry from user mode, the stub switches from the trampoline or
+ * IST stack to the normal thread stack.  On an exit to user mode, the
+ * normal exit-to-usermode path is invoked.
+ *
+ * On an exit to kernel mode, if @paranoid == 0, we check for preemption,
+ * whereas we omit the preemption check if @paranoid != 0.  This is purely
+ * because the implementation is simpler this way.  The kernel only needs
+ * to check for asynchronous kernel preemption when IRQ handlers return.
+ *
+ * If @paranoid == 0, then the stub will handle IRET faults by pretending
+ * that the fault came from user mode.  It will handle gs_change faults by
+ * pretending that the fault happened with kernel GSBASE.  Since this handling
+ * is omitted for @paranoid != 0, the #GP, #SS, and #NP stubs must have
+ * @paranoid == 0.  This special handling will do the wrong thing for
+ * espfix-induced #DF on IRET, so #DF must not use @paranoid == 0.
+ *
+ * @paranoid == 2 is special: the stub will never switch stacks.  This is for
+ * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
+ */
 .macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e6db475164ed..1a90821c0b74 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -383,6 +383,10 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code)
 		 * we won't enable interupts or schedule before we invoke
 		 * general_protection, so nothing will clobber the stack
 		 * frame we just set up.
+		 *
+		 * We will enter general_protection with kernel GSBASE,
+		 * which is what the stub expects, given that the faulting
+		 * RIP will be the IRET instruction.
 		 */
 		regs->ip = (unsigned long)general_protection;
 		regs->sp = (unsigned long)&gpregs->orig_ax;
