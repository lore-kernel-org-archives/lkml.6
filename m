Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2252317-1519633468-2-16826608225802479513
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
    t=1519633468; b=uU20HyjVmUJc4+z7LCu0KtqtVbpB6dV8AM5sAFSoBG3sPzg
    ynMsPdYjq9FfOZC0K4y4zIc2K0Jf7WbSH+mixKIWisEiWKodH1yfV0ayFXXrtSlS
    QegePuPukVUn9RL1eNnVFF244RI7mqmycnRQ9PSBOC8TDKCTR3kXk0EE0Y2PF79/
    uY1GE4w05td6LwlrQ1R+SqQ6kZoqcCXVdcJh4qrjpPuZCZ9Kva6PWV7nqi14tB+F
    yn4enbNYlCm/AzkAeTNa++nK+pCghUyUMY+kbusZZoIv4wPBQGgR2HTo998ZVgSg
    UZ1QcI2QAL+Wy6SDMolYYMNbhcJTYcbZTREmcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633468;
    bh=aecMAEg4UDkugVp6jZTqZagnCNTuf8l+gwqIgnZ36z0=; b=cPL8jMHLcp8b
    6xJHpJ8B2omjnURPL5ya00V9fhOFlypYvM03npqUtI94pfIUB3Vml+cO+aWt3VU/
    co6VxM6auE+66Bv7250b58lORMLpDpitavLoZWE1mhI1un4nmckGudKu5ng9FojK
    +jfj7/CQ5Eao5JPmCVrrhjyPZjCFYd0UTQghko41475G+IMYByZwvd6+Ae6K9+xg
    FOUtPcEimZADzgutGhJoUpva4mFLRtr0BR4U+HwM3KsfzTFjY84FehOH+4dGvEHM
    Mm7z1YKlduuzGWQrwDbl2Jrnws7gsNT0E0I21mHNShcyOiq0ROYQNAl1FzXdrAq0
    c6XVVc5IXQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=NdY553qP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gV9zKvZ8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=NdY553qP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gV9zKvZ8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeBZIYZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:24:25 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34164 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeBZIYQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:24:16 -0500
X-Google-Smtp-Source: AH8x227h3eng6DMZUXRmk8VQPls883mrSmvrLGJ8gcmzGiodhqcCp7hPAO76cyEjwLgFQXiC9MKobA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 26/52] arm64: entry: Apply BP hardening for high-priority synchronous exceptions
Date: Mon, 26 Feb 2018 16:20:00 +0800
Message-Id: <1519633227-29832-27-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 5dfc6ed27710 upstream.

Software-step and PC alignment fault exceptions have higher priority than
instruction abort exceptions, so apply the BP hardening hooks there too
if the user PC appears to reside in kernel space.

Reported-by: Dan Hettena <dhettena@nvidia.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	expand enable_da_f to 'msr daifclr, #(8 | 4 | 1)'
	in arch/arm64/kernel/entry.S
---
 arch/arm64/kernel/entry.S | 6 ++++--
 arch/arm64/mm/fault.c     | 9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index bdb0139..d50c2fe 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -584,8 +584,10 @@ el0_sp_pc:
 	 * Stack or PC alignment exception handling
 	 */
 	mrs	x26, far_el1
-	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	msr	daifclr, #(8 | 4 | 1)
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
 	ct_user_exit
 	mov	x0, x26
 	mov	x1, x25
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c95b194..6120a14 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -617,6 +617,12 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 	struct siginfo info;
 	struct task_struct *tsk = current;
 
+	if (user_mode(regs)) {
+		if (instruction_pointer(regs) > TASK_SIZE)
+			arm64_apply_bp_hardening();
+		local_irq_enable();
+	}
+
 	if (show_unhandled_signals && unhandled_signal(tsk, SIGBUS))
 		pr_info_ratelimited("%s[%d]: %s exception: pc=%p sp=%p\n",
 				    tsk->comm, task_pid_nr(tsk),
@@ -676,6 +682,9 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 	if (interrupts_enabled(regs))
 		trace_hardirqs_off();
 
+	if (user_mode(regs) && instruction_pointer(regs) > TASK_SIZE)
+		arm64_apply_bp_hardening();
+
 	if (!inf->fn(addr, esr, regs)) {
 		rv = 1;
 	} else {
-- 
2.7.4
