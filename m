Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C72AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B4B20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B4B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeICTS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:18:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43319 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbeICTS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:18:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83EwGR23340153
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 07:58:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83EwGBi3340150;
        Mon, 3 Sep 2018 07:58:16 -0700
Date:   Mon, 3 Sep 2018 07:58:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-27876f3882fdd4acb3d3614a0133ecdc777fc292@git.kernel.org>
Cc:     mingo@kernel.org, jgross@suse.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, jgross@suse.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20180828074026.820-8-jgross@suse.com>
References: <20180828074026.820-8-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Remove clobbers from struct
 paravirt_patch_site
Git-Commit-ID: 27876f3882fdd4acb3d3614a0133ecdc777fc292
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

Commit-ID:  27876f3882fdd4acb3d3614a0133ecdc777fc292
Gitweb:     https://git.kernel.org/tip/27876f3882fdd4acb3d3614a0133ecdc777fc292
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Tue, 28 Aug 2018 09:40:18 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 16:50:34 +0200

x86/paravirt: Remove clobbers from struct paravirt_patch_site

There is no need any longer to store the clobbers in struct
paravirt_patch_site. Remove clobbers from the struct and from the
related macros.

While at it fix some lines longer than 80 characters.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: akataria@vmware.com
Cc: rusty@rustcorp.com.au
Cc: boris.ostrovsky@oracle.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180828074026.820-8-jgross@suse.com

---
 arch/x86/include/asm/paravirt.h       | 33 +++++++++++++++------------------
 arch/x86/include/asm/paravirt_types.h |  1 -
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index e375d4266b53..e1364cb40ce5 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -827,7 +827,7 @@ extern void default_banner(void);
 
 #else  /* __ASSEMBLY__ */
 
-#define _PVSITE(ptype, clobbers, ops, word, algn)	\
+#define _PVSITE(ptype, ops, word, algn)		\
 771:;						\
 	ops;					\
 772:;						\
@@ -836,7 +836,6 @@ extern void default_banner(void);
 	 word 771b;				\
 	 .byte ptype;				\
 	 .byte 772b-771b;			\
-	 .short clobbers;			\
 	.popsection
 
 
@@ -869,7 +868,7 @@ extern void default_banner(void);
 	COND_POP(set, CLBR_RAX, rax)
 
 #define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 8)
-#define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .quad, 8)
+#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
 #define PARA_INDIRECT(addr)	*addr(%rip)
 #else
 #define PV_SAVE_REGS(set)			\
@@ -884,26 +883,26 @@ extern void default_banner(void);
 	COND_POP(set, CLBR_EAX, eax)
 
 #define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 4)
-#define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .long, 4)
+#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .long, 4)
 #define PARA_INDIRECT(addr)	*%cs:addr
 #endif
 
 #define INTERRUPT_RETURN						\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_iret), CLBR_NONE,	\
-		  ANNOTATE_RETPOLINE_SAFE;					\
+	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_iret),			\
+		  ANNOTATE_RETPOLINE_SAFE;				\
 		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_iret);)
 
 #define DISABLE_INTERRUPTS(clobbers)					\
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_disable), clobbers, \
+	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_disable),		\
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
-		  ANNOTATE_RETPOLINE_SAFE;					\
+		  ANNOTATE_RETPOLINE_SAFE;				\
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_disable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
 #define ENABLE_INTERRUPTS(clobbers)					\
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_enable), clobbers,	\
+	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_enable),		\
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
-		  ANNOTATE_RETPOLINE_SAFE;					\
+		  ANNOTATE_RETPOLINE_SAFE;				\
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
@@ -921,8 +920,7 @@ extern void default_banner(void);
  * inlined, or the swapgs instruction must be trapped and emulated.
  */
 #define SWAPGS_UNSAFE_STACK						\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  swapgs)
+	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), swapgs)
 
 /*
  * Note: swapgs is very special, and in practise is either going to be
@@ -931,8 +929,8 @@ extern void default_banner(void);
  * it.
  */
 #define SWAPGS								\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  ANNOTATE_RETPOLINE_SAFE;					\
+	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs),		\
+		  ANNOTATE_RETPOLINE_SAFE;				\
 		  call PARA_INDIRECT(pv_cpu_ops+PV_CPU_swapgs);		\
 		 )
 
@@ -942,15 +940,14 @@ extern void default_banner(void);
 
 #define USERGS_SYSRET64							\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_usergs_sysret64),	\
-		  CLBR_NONE,						\
-		  ANNOTATE_RETPOLINE_SAFE;					\
+		  ANNOTATE_RETPOLINE_SAFE;				\
 		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64);)
 
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_save_fl), clobbers, \
+	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_save_fl),	    \
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);        \
-		  ANNOTATE_RETPOLINE_SAFE;				    \
+		  ANNOTATE_RETPOLINE_SAFE;			    \
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_save_fl);    \
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 #endif
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 225d871373ed..b2220536a7d4 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -681,7 +681,6 @@ struct paravirt_patch_site {
 	u8 *instr; 		/* original instructions */
 	u8 instrtype;		/* type of this instruction */
 	u8 len;			/* length of original instruction */
-	u16 clobbers;		/* what registers you may clobber */
 };
 
 extern struct paravirt_patch_site __parainstructions[],
