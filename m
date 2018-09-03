Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB50CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B6120843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B6120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeICTUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:20:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34903 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:20:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83ExMNp3340271
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 07:59:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83ExMVr3340268;
        Mon, 3 Sep 2018 07:59:22 -0700
Date:   Mon, 3 Sep 2018 07:59:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-5def7a4cd5bef80f7c997cf37c09022fa8c9cd76@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          jgross@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180828074026.820-10-jgross@suse.com>
References: <20180828074026.820-10-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Remove unused paravirt bits
Git-Commit-ID: 5def7a4cd5bef80f7c997cf37c09022fa8c9cd76
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

Commit-ID:  5def7a4cd5bef80f7c997cf37c09022fa8c9cd76
Gitweb:     https://git.kernel.org/tip/5def7a4cd5bef80f7c997cf37c09022fa8c9cd76
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Tue, 28 Aug 2018 09:40:20 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 16:50:35 +0200

x86/paravirt: Remove unused paravirt bits

The macros ENABLE_INTERRUPTS_SYSEXIT, GET_CR0_INTO_EAX and
PARAVIRT_ADJUST_EXCEPTION_FRAME are used nowhere.

Remove their definitions.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: akataria@vmware.com
Cc: rusty@rustcorp.com.au
Cc: boris.ostrovsky@oracle.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180828074026.820-10-jgross@suse.com

---
 arch/x86/include/asm/irqflags.h | 4 ----
 arch/x86/include/asm/paravirt.h | 9 +--------
 arch/x86/kernel/asm-offsets.c   | 1 -
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 15450a675031..088b0e751b3e 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -135,8 +135,6 @@ static inline notrace unsigned long arch_local_irq_save(void)
  */
 #define SWAPGS_UNSAFE_STACK	swapgs
 
-#define PARAVIRT_ADJUST_EXCEPTION_FRAME	/*  */
-
 #define INTERRUPT_RETURN	jmp native_iret
 #define USERGS_SYSRET64				\
 	swapgs;					\
@@ -150,8 +148,6 @@ static inline notrace unsigned long arch_local_irq_save(void)
 #endif
 #else
 #define INTERRUPT_RETURN		iret
-#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
-#define GET_CR0_INTO_EAX		movl %cr0, %eax
 #endif
 
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index a9189b81c7dd..2ba23e98c5cd 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -887,14 +887,7 @@ extern void default_banner(void);
 		  call PARA_INDIRECT(pv_ops+PV_IRQ_irq_enable);		\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
-#ifdef CONFIG_X86_32
-#define GET_CR0_INTO_EAX				\
-	push %ecx; push %edx;				\
-	ANNOTATE_RETPOLINE_SAFE;				\
-	call PARA_INDIRECT(pv_ops+PV_CPU_read_cr0);	\
-	pop %edx; pop %ecx
-#else	/* !CONFIG_X86_32 */
-
+#ifdef CONFIG_X86_64
 /*
  * If swapgs is used while the userspace stack is still current,
  * there's no way to call a pvop.  The PV replacement *must* be
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 46d14498e214..37e323f3d8c9 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -69,7 +69,6 @@ void common(void) {
 	OFFSET(PV_IRQ_irq_disable, paravirt_patch_template, irq.irq_disable);
 	OFFSET(PV_IRQ_irq_enable, paravirt_patch_template, irq.irq_enable);
 	OFFSET(PV_CPU_iret, paravirt_patch_template, cpu.iret);
-	OFFSET(PV_CPU_read_cr0, paravirt_patch_template, cpu.read_cr0);
 	OFFSET(PV_MMU_read_cr2, paravirt_patch_template, mmu.read_cr2);
 #endif
 
