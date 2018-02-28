Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790668-2-11551798571266914110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790667; b=rDHS4AnFxljBTPg9Q2YP3/oVjmByc8ebWsTKo7rDULEPWAA
    rmABR+kONTMRIAkoPjARQ1zqveDHPW+yZaBlHfWKP09Ns6NxZj9nFDEg2OE+h3Yr
    jY+c7G/MuDVK0QIO/iW28Yzw+XnqfMGNGovHQ2TiW7l8/i2oRhJZkbCLshyCL9dM
    DiEjVL40rdMgfF2eKjOMIRbkUfWmTlmuvQI/u04lNlsHGevQPDwUZudSn7pWmkGp
    Hay3p7JSSSzoJ5fnmaGtvFav+eo5KVDY2Os6zbmDcc1GUNrmOd66/4f8sv3HTwGZ
    77hnXv9S/S0YlhOIUIbqrMHDXbkeLGnHUFG4dKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790667;
    bh=A0pfV/DwY+7OHAPDaT2NCm9JaxY5uj5pHP+9/1OoPcU=; b=LyJduUcLoDAA
    hcNxznlxuU1CVLG1ArpWWTW66EAtqXx8raOhglECPPn7VwjueKvJehC5wSudbvwg
    LGvq4qQSoc8xtB4SxmhkwH6E/Ry/QsBs0shHdcKQKKgpQdE5ZymoeD1VTFkiz0fR
    2PTNsyIWPNnvhBEPQXxsWmgWmQIxqZ5sHVvWHWgxlha2ZRWM393i9yPn1NM4YuJ0
    9N2n5RoF8EDEb0vAOBMVJetK9YO0caFYEU90Z3DK38x+yaU7+eBHe2mvccspDXVb
    WT4d5cAGmkYCLy6Bsm+W/9h31XHAwp9/eHBSitNxpntqFJKMmOKap7AJfZ+oK+fy
    zQ5zrTdaiw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=LtDf4XA4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oD6cyfIU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=LtDf4XA4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oD6cyfIU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeB1D60 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:58:26 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:32909 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeB1D6Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:58:25 -0500
X-Google-Smtp-Source: AH8x2253Dee0sEUZbnVLt41TwB06xx80AOnvSMHFm8pkOzE/dVsswcGfqdo0km+mGM5xh9aGvAMNjQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Xie XiuQi <xiexiuqi@huawei.com>,
        Wang Xiongfeng <wangxiongfengi2@huawei.com>,
        James Morse <james.morse@arm.com>,
        Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 07/29] arm64: entry.S: move SError handling into a C function for future expansion
Date: Wed, 28 Feb 2018 11:56:29 +0800
Message-Id: <1519790211-16582-8-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xie XiuQi <xiexiuqi@huawei.com>

commit a92d4d1454ab upstream.

Today SError is taken using the inv_entry macro that ends up in
bad_mode.

SError can be used by the RAS Extensions to notify either the OS or
firmware of CPU problems, some of which may have been corrected.

To allow this handling to be added, add a do_serror() C function
that just panic()s. Add the entry.S boiler plate to save/restore the
CPU registers and unmask debug exceptions. Future patches may change
do_serror() to return if the SError Interrupt was notification of a
corrected error.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
Signed-off-by: Wang Xiongfeng <wangxiongfengi2@huawei.com>
[Split out of a bigger patch, added compat path, renamed, enabled debug
 exceptions]
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>

Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	no vmap_stack in arch/arm64/kernel/traps.c
	using old enable_dbg_and_irq instead of enable_daif in
		arch/arm64/kernel/entry.S
---
 arch/arm64/kernel/entry.S | 36 +++++++++++++++++++++++++++++-------
 arch/arm64/kernel/traps.c | 14 ++++++++++++++
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f5aa8f0..60b202a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -270,18 +270,18 @@ ENTRY(vectors)
 	kernel_ventry	el1_sync			// Synchronous EL1h
 	kernel_ventry	el1_irq				// IRQ EL1h
 	kernel_ventry	el1_fiq_invalid			// FIQ EL1h
-	kernel_ventry	el1_error_invalid		// Error EL1h
+	kernel_ventry	el1_error			// Error EL1h
 
 	kernel_ventry	el0_sync			// Synchronous 64-bit EL0
 	kernel_ventry	el0_irq				// IRQ 64-bit EL0
 	kernel_ventry	el0_fiq_invalid			// FIQ 64-bit EL0
-	kernel_ventry	el0_error_invalid		// Error 64-bit EL0
+	kernel_ventry	el0_error			// Error 64-bit EL0
 
 #ifdef CONFIG_COMPAT
 	kernel_ventry	el0_sync_compat			// Synchronous 32-bit EL0
 	kernel_ventry	el0_irq_compat			// IRQ 32-bit EL0
 	kernel_ventry	el0_fiq_invalid_compat		// FIQ 32-bit EL0
-	kernel_ventry	el0_error_invalid_compat	// Error 32-bit EL0
+	kernel_ventry	el0_error_compat		// Error 32-bit EL0
 #else
 	kernel_ventry	el0_sync_invalid		// Synchronous 32-bit EL0
 	kernel_ventry	el0_irq_invalid			// IRQ 32-bit EL0
@@ -321,10 +321,6 @@ ENDPROC(el0_error_invalid)
 el0_fiq_invalid_compat:
 	inv_entry 0, BAD_FIQ, 32
 ENDPROC(el0_fiq_invalid_compat)
-
-el0_error_invalid_compat:
-	inv_entry 0, BAD_ERROR, 32
-ENDPROC(el0_error_invalid_compat)
 #endif
 
 el1_sync_invalid:
@@ -532,6 +528,10 @@ el0_svc_compat:
 el0_irq_compat:
 	kernel_entry 0, 32
 	b	el0_irq_naked
+
+el0_error_compat:
+	kernel_entry 0, 32
+	b	el0_error_naked
 #endif
 
 el0_da:
@@ -653,6 +653,28 @@ el0_irq_naked:
 	b	ret_to_user
 ENDPROC(el0_irq)
 
+el1_error:
+	kernel_entry 1
+	mrs	x1, esr_el1
+	enable_dbg
+	mov	x0, sp
+	bl	do_serror
+	kernel_exit 1
+ENDPROC(el1_error)
+
+el0_error:
+	kernel_entry 0
+el0_error_naked:
+	mrs	x1, esr_el1
+	enable_dbg
+	mov	x0, sp
+	bl	do_serror
+	enable_dbg_and_irq
+	ct_user_exit
+	b	ret_to_user
+ENDPROC(el0_error)
+
+
 /*
  * Register switch for AArch64. The callee-saved registers need to be saved
  * and restored. On entry:
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c743d1f..2ef7e33 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -637,6 +637,20 @@ asmlinkage void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr)
 	force_sig_info(info.si_signo, &info, current);
 }
 
+
+asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
+{
+	nmi_enter();
+
+	console_verbose();
+
+	pr_crit("SError Interrupt on CPU%d, code 0x%08x -- %s\n",
+		smp_processor_id(), esr, esr_get_class_string(esr));
+	__show_regs(regs);
+
+	panic("Asynchronous SError Interrupt");
+}
+
 void __pte_error(const char *file, int line, unsigned long val)
 {
 	pr_err("%s:%d: bad pte %016lx.\n", file, line, val);
-- 
2.7.4
