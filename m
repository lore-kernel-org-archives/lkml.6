Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387526-1519633662-2-9195571609449676887
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES encaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519633661; b=Cl2lmYIOaOrrdJP0B0hbGlWd9W5Gn602njuHBWLfc38R6K2
    qRYY4AVt8AOUaHlslIiqwshpfwXp9T5CaJ5SsNz4bn6OE8NWRpcomczE+9tMotnw
    iUXo4sED77hHhSl6sYqUK4mJsVtlu8Oyx6RawspTOwJ5d4aPOjki4/C9U0Y11X/p
    Nqu7TaHhLefAw6z571KO8cLnmE6RmRITFxh3vYJNrb5Qut1dNYZ7NX1LD2JhZQuA
    xW/P2yLx99Dx6XLS8XAiPT6boBJTQgDpWpcfIlzuHDCC+rjD8MpZ7YYtchwc9WBB
    YBnW0QPpQQe2summP9Zzsq4vU8Lsf5LXHYedvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633661;
    bh=EGJE0Nu47ttv68Cv7IDoZdvRv6F03kpbdP4X9eVpyD0=; b=AQquzQnBILbY
    cpR3XBUZHmmHQDFVCQ4duPqwgO3GHfoCZiTHpZU4M8F/tpS1d2JSqm3yIx4EKklC
    1tMwKgTd0Q9ESCUX+xVLSFzm2v3cF52zXplGVtqo92QtsocCnO9KDYw96h/9HaGJ
    mxj6mUr8koZfXqleE8cCcpgL8+iVYAjLNgj3f8Y3Zep/d4nLzpIuFOmKLz+QO31T
    AD+6zV9kN+yJNQbojDTA1kX/wvR3gVP6DsjEXj6QfaqveSmCsEQmPioyznIUYJ94
    cPsoyBqUO3Mg+W+qpXhCBjCaa17UfVQzTt+548AL36TdCQLKHaWv1eghAr/PIdeb
    tgqt14yAEQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=db7VIA95 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Zu2T9Ebh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=db7VIA95 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Zu2T9Ebh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbeBZI1h (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:27:37 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46002 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752865AbeBZI1e (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:27:34 -0500
X-Google-Smtp-Source: AH8x226FXXBAN6jeZg6J+9NAKHiCuOuf6xBe3ZftMOGkbk1yKnD2bdz6Y2XvKbmopSBNNwyAq1EetA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 49/52] arm: Add icache invalidation on switch_mm for Cortex-A15
Date: Mon, 26 Feb 2018 16:20:23 +0800
Message-Id: <1519633227-29832-50-git-send-email-alex.shi@linaro.org>
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
Cortex-A15 require to invalidate the BTB when switching
from one user context to another. The only way to do so on this
CPU is to perform an ICIALLU, having set ACTLR[0] to 1 from secure
mode.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/mm/proc-v7-2level.S | 10 ++++++++++
 arch/arm/mm/proc-v7-3level.S | 10 ++++++++++
 arch/arm/mm/proc-v7.S        | 23 ++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index 0422e58b..6d81ed7 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -40,7 +40,16 @@
  *	Note that we always need to flush BTAC/BTB if IBE is set
  *	even on Cortex-A8 revisions not affected by 430973.
  *	If IBE is not set, the flush BTAC/BTB won't do anything.
+ *
+ *	Cortex-A15 requires ACTLR[0] to be set from secure in order
+ *	for the icache invalidation to also invalidate the BTB.
  */
+ENTRY(cpu_v7_icinv_switch_mm)
+#ifdef CONFIG_MMU
+	mcr	p15, 0, r0, c7, c5, 0		@ ICIALLU
+	/* Fall through to switch_mm... */
+#endif
+
 ENTRY(cpu_v7_btbinv_switch_mm)
 #ifdef CONFIG_MMU
 	mov	r2, #0
@@ -67,6 +76,7 @@ ENTRY(cpu_v7_switch_mm)
 	bx	lr
 ENDPROC(cpu_v7_switch_mm)
 ENDPROC(cpu_v7_btbinv_switch_mm)
+ENDPROC(cpu_v7_icinv_switch_mm)
 
 /*
  *	cpu_v7_set_pte_ext(ptep, pte)
diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index a25450b..af6d7b1 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -54,6 +54,15 @@
  * Set the translation table base pointer to be pgd_phys (physical address of
  * the new TTB).
  */
+ENTRY(cpu_v7_icinv_switch_mm)
+#ifdef CONFIG_MMU
+	/*
+	 * Cortex-A15 requires ACTLR[0] to be set from secure in order
+	 * for the icache invalidation to also invalidate the BTB.
+	 */
+	mcr	p15, 0, r0, c7, c5, 0		@ ICIALLU
+	/* Fall through to switch_mm... */
+#endif
 ENTRY(cpu_v7_btbinv_switch_mm)
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r0, c7, c5, 6			@ flush BTAC/BTB
@@ -69,6 +78,7 @@ ENTRY(cpu_v7_switch_mm)
 	ret	lr
 ENDPROC(cpu_v7_switch_mm)
 ENDPROC(cpu_v7_btbinv_switch_mm)
+ENDPROC(cpu_v7_icinv_switch_mm)
 
 #ifdef __ARMEB__
 #define rl r3
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index ff7018a..f385933 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -227,6 +227,26 @@ ENDPROC(cpu_ca9mp_do_resume)
 	globl_equ	cpu_ca17_do_resume,	cpu_v7_do_resume
 #endif
 
+/*
+ * Cortex-A15
+ */
+	globl_equ	cpu_ca15_proc_init,	cpu_v7_proc_init
+	globl_equ	cpu_ca15_proc_fin,	cpu_v7_proc_fin
+	globl_equ	cpu_ca15_reset,		cpu_v7_reset
+	globl_equ	cpu_ca15_do_idle,	cpu_v7_do_idle
+	globl_equ	cpu_ca15_dcache_clean_area, cpu_v7_dcache_clean_area
+	globl_equ	cpu_ca15_set_pte_ext,	cpu_v7_set_pte_ext
+	globl_equ	cpu_ca15_suspend_size,	cpu_v7_suspend_size
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	globl_equ	cpu_ca15_switch_mm,	cpu_v7_icinv_switch_mm
+#else
+	globl_equ	cpu_ca15_switch_mm,	cpu_v7_switch_mm
+#endif
+#ifdef CONFIG_ARM_CPU_SUSPEND
+	globl_equ	cpu_ca15_do_suspend,	cpu_v7_do_suspend
+	globl_equ	cpu_ca15_do_resume,	cpu_v7_do_resume
+#endif
+
 #ifdef CONFIG_CPU_PJ4B
 	globl_equ	cpu_pj4b_switch_mm,     cpu_v7_switch_mm
 	globl_equ	cpu_pj4b_set_pte_ext,	cpu_v7_set_pte_ext
@@ -568,6 +588,7 @@ __v7_setup_stack:
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions v7, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
+	define_processor_functions ca15, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 	define_processor_functions ca17, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 #ifndef CONFIG_ARM_LPAE
 	define_processor_functions ca8, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
@@ -689,7 +710,7 @@ __v7_ca12mp_proc_info:
 __v7_ca15mp_proc_info:
 	.long	0x410fc0f0
 	.long	0xff0ffff0
-	__v7_proc __v7_ca15mp_proc_info, __v7_ca15mp_setup
+	__v7_proc __v7_ca15mp_proc_info, __v7_ca15mp_setup, proc_fns = ca15_processor_functions
 	.size	__v7_ca15mp_proc_info, . - __v7_ca15mp_proc_info
 
 	/*
-- 
2.7.4
