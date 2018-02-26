Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387443-1519633772-2-4607913499968154066
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519633772; b=cr2B9xXD+QUEOJZvtGVt9uIHbZvUeQlipzf36lnHnwA1a3c
    miAM3D8z+9TVx7JzhWUjAFDHJjzlk2t3RoD38bTCmj9G2myU7i3eczTI/tUoQTqr
    dDsARr70PwRiGnI+IElRERQICEvfs8y8zJXE/nmqLhgPN10Z2dcBgnfh1Sc8VhRA
    zv7UrReW1pSZr3q1Tug2DAbj0O6Y5MDk1qP1tu+pjmUY882YZFrnlR1lxIyaKn2K
    6QNfaB13E78eE04aHVLz8AEObQzrNCG6kBbzPhbM08KOXJwd/5+LGWLpa9DBKgwp
    53hPpUPC8U5CmWRzccoqUQRH4smjU0kfXXnp9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633772;
    bh=GbyVFSuKqlJlOZQir9uMnmIFVEqzFtVXTBGR5PiLN7c=; b=um8u+yyS9x9U
    LyRoPiMslxYfhZ8nws8TbLdcpYS0g0U1oEULBUQi4WsCzNyH43jWBAdkMsw3QDSu
    sBVzs7U6ONArVtwW2e+Rmg/DduvV318K/DW4tSSfU3PSDzEnMD/eXm4G3M6L0V55
    8+wmdzP8gnTq7qskO6jsvAep41zNxKJYB8Ow9FA197foBj4Yjh2QbvL7rEewJJRm
    JPhwlmGl0Z7AsuKuo/7Fx3DB/NfgDy7e0VuxlWY6jnn7JANlcqelkUxjWEz7GuSo
    lSKBWN/yizqhIUhVCyn8SEIdXzFA9/AJT9N2JE7mnv6Vix1pmI4XUcPKaDLrgLNY
    98LhnD1Jmw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Ghh1zawi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GBmt7wVK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Ghh1zawi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GBmt7wVK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeBZI3O (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:29:14 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43276 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbeBZI1I (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:27:08 -0500
X-Google-Smtp-Source: AH8x224g2UDfRT5xRQQ4DxvZjjwwTnsNHCxoT3B4f8HjaMDwTvSf7mwA7WEigEqdTqdxwnvDMMAogg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 46/52] arm: Add BTB invalidation on switch_mm for Cortex-A9, A12 and A17
Date: Mon, 26 Feb 2018 16:20:20 +0800
Message-Id: <1519633227-29832-47-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

** Not yet queued for inclusion in mainline **

In order to avoid aliasing attacks against the branch predictor,
some implementations require to invalidate the BTB when switching
from one user context to another.

For this, we reuse the existing implementation for Cortex-A8, and
apply it to A9, A12 and A17.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/mm/Kconfig          | 17 +++++++++++++++++
 arch/arm/mm/proc-v7-2level.S |  4 ++--
 arch/arm/mm/proc-v7-3level.S |  5 +++++
 arch/arm/mm/proc-v7.S        | 30 ++++++++++++++++++++++++++++--
 4 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c1799dd..1a5acee 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -1068,3 +1068,20 @@ config DEBUG_ALIGN_RODATA
 	  additional section-aligned split of rodata from kernel text so it
 	  can be made explicitly non-executable. This padding may waste memory
 	  space to gain the additional protection.
+
+config HARDEN_BRANCH_PREDICTOR
+	bool "Harden the branch predictor against aliasing attacks" if EXPERT
+	default y
+	help
+	  Speculation attacks against some high-performance processors rely on
+	  being able to manipulate the branch predictor for a victim context by
+	  executing aliasing branches in the attacker context.  Such attacks
+	  can be partially mitigated against by clearing internal branch
+	  predictor state and limiting the prediction logic in some situations.
+
+	  This config option will take CPU-specific actions to harden the
+	  branch predictor against aliasing attacks and may rely on specific
+	  instruction sequences or control bits being set by the system
+	  firmware.
+
+	  If unsure, say Y.
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index c6141a5..0422e58b 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -41,7 +41,7 @@
  *	even on Cortex-A8 revisions not affected by 430973.
  *	If IBE is not set, the flush BTAC/BTB won't do anything.
  */
-ENTRY(cpu_ca8_switch_mm)
+ENTRY(cpu_v7_btbinv_switch_mm)
 #ifdef CONFIG_MMU
 	mov	r2, #0
 	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
@@ -66,7 +66,7 @@ ENTRY(cpu_v7_switch_mm)
 #endif
 	bx	lr
 ENDPROC(cpu_v7_switch_mm)
-ENDPROC(cpu_ca8_switch_mm)
+ENDPROC(cpu_v7_btbinv_switch_mm)
 
 /*
  *	cpu_v7_set_pte_ext(ptep, pte)
diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index 5e5720e..a25450b 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -54,6 +54,10 @@
  * Set the translation table base pointer to be pgd_phys (physical address of
  * the new TTB).
  */
+ENTRY(cpu_v7_btbinv_switch_mm)
+#ifdef CONFIG_MMU
+	mcr	p15, 0, r0, c7, c5, 6			@ flush BTAC/BTB
+#endif
 ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_MMU
 	mmid	r2, r2
@@ -64,6 +68,7 @@ ENTRY(cpu_v7_switch_mm)
 #endif
 	ret	lr
 ENDPROC(cpu_v7_switch_mm)
+ENDPROC(cpu_v7_btbinv_switch_mm)
 
 #ifdef __ARMEB__
 #define rl r3
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index d00d52c..ff7018a 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -163,6 +163,7 @@ ENDPROC(cpu_v7_do_resume)
 	globl_equ	cpu_ca8_dcache_clean_area, cpu_v7_dcache_clean_area
 	globl_equ	cpu_ca8_set_pte_ext,	cpu_v7_set_pte_ext
 	globl_equ	cpu_ca8_suspend_size,	cpu_v7_suspend_size
+	globl_equ	cpu_ca8_switch_mm,	cpu_v7_btbinv_switch_mm
 #ifdef CONFIG_ARM_CPU_SUSPEND
 	globl_equ	cpu_ca8_do_suspend,	cpu_v7_do_suspend
 	globl_equ	cpu_ca8_do_resume,	cpu_v7_do_resume
@@ -176,7 +177,11 @@ ENDPROC(cpu_v7_do_resume)
 	globl_equ	cpu_ca9mp_reset,	cpu_v7_reset
 	globl_equ	cpu_ca9mp_do_idle,	cpu_v7_do_idle
 	globl_equ	cpu_ca9mp_dcache_clean_area, cpu_v7_dcache_clean_area
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	globl_equ	cpu_ca9mp_switch_mm,	cpu_v7_btbinv_switch_mm
+#else
 	globl_equ	cpu_ca9mp_switch_mm,	cpu_v7_switch_mm
+#endif
 	globl_equ	cpu_ca9mp_set_pte_ext,	cpu_v7_set_pte_ext
 .globl	cpu_ca9mp_suspend_size
 .equ	cpu_ca9mp_suspend_size, cpu_v7_suspend_size + 4 * 2
@@ -202,6 +207,26 @@ ENTRY(cpu_ca9mp_do_resume)
 ENDPROC(cpu_ca9mp_do_resume)
 #endif
 
+/*
+ * Cortex-A12/A17
+ */
+	globl_equ	cpu_ca17_proc_init,	cpu_v7_proc_init
+	globl_equ	cpu_ca17_proc_fin,	cpu_v7_proc_fin
+	globl_equ	cpu_ca17_reset,		cpu_v7_reset
+	globl_equ	cpu_ca17_do_idle,	cpu_v7_do_idle
+	globl_equ	cpu_ca17_dcache_clean_area, cpu_v7_dcache_clean_area
+	globl_equ	cpu_ca17_set_pte_ext,	cpu_v7_set_pte_ext
+	globl_equ	cpu_ca17_suspend_size,	cpu_v7_suspend_size
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	globl_equ	cpu_ca17_switch_mm,	cpu_v7_btbinv_switch_mm
+#else
+	globl_equ	cpu_ca17_switch_mm,	cpu_v7_switch_mm
+#endif
+#ifdef CONFIG_ARM_CPU_SUSPEND
+	globl_equ	cpu_ca17_do_suspend,	cpu_v7_do_suspend
+	globl_equ	cpu_ca17_do_resume,	cpu_v7_do_resume
+#endif
+
 #ifdef CONFIG_CPU_PJ4B
 	globl_equ	cpu_pj4b_switch_mm,     cpu_v7_switch_mm
 	globl_equ	cpu_pj4b_set_pte_ext,	cpu_v7_set_pte_ext
@@ -543,6 +568,7 @@ __v7_setup_stack:
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions v7, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
+	define_processor_functions ca17, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 #ifndef CONFIG_ARM_LPAE
 	define_processor_functions ca8, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 	define_processor_functions ca9mp, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
@@ -653,7 +679,7 @@ __v7_ca7mp_proc_info:
 __v7_ca12mp_proc_info:
 	.long	0x410fc0d0
 	.long	0xff0ffff0
-	__v7_proc __v7_ca12mp_proc_info, __v7_ca12mp_setup
+	__v7_proc __v7_ca12mp_proc_info, __v7_ca12mp_setup, proc_fns = ca17_processor_functions
 	.size	__v7_ca12mp_proc_info, . - __v7_ca12mp_proc_info
 
 	/*
@@ -683,7 +709,7 @@ __v7_b15mp_proc_info:
 __v7_ca17mp_proc_info:
 	.long	0x410fc0e0
 	.long	0xff0ffff0
-	__v7_proc __v7_ca17mp_proc_info, __v7_ca17mp_setup
+	__v7_proc __v7_ca17mp_proc_info, __v7_ca17mp_setup, proc_fns = ca17_processor_functions
 	.size	__v7_ca17mp_proc_info, . - __v7_ca17mp_proc_info
 
 	/*
-- 
2.7.4
