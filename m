Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909161-2-2337740054335739783
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909160; b=XO6dL3Q0PZgB3HfIk+e7vNtQ1wWTJiv5+wG0l5jyHHEiBAa
    rxdmd5KZI+BtK5PnNwlNYkM6/HRhSN6Mp6PKCIXAzq5UlnshiQ3h3mNbK/q2Geg9
    B3sHHorTKHQJ47Ckj+Kss7CU02/GHOGwOeb4TV5A9SCarYkQuYscXIF2frbAFcyM
    DdRO5Z6dQVCW6rApwreowqEA+a3Bz7oJj1j4+nIwo7Sk1bQKZej8wKAYk7FeEj2s
    9a6bL8F163hATkYos042I1lyTUaG5pYNU038YOos3dKQk1bwUlVB2zyfZ9UVCcYI
    03qgZqw/KuhmC+lyiFH+zhxa7k6Ucpl9Wy7Z1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909160;
    bh=YaNlfJjXAm7Tj4lsPJi0xUkj7+DnsswK/FzZeoAqgZ8=; b=IDH2RIQtGkWZ
    4M1p3pRR5SFdSDQ9ezdAu9PyIvWDap7ekzkxMRZO4wvzHZA/+oAL2C7sZAAPXalE
    XMiwDv/S8QX6Tfo38tssS4xhw9NHsO5R9tVdzuhh7hlTXy9TaQXcbBkbsPMtkipb
    ya7L5LQKO1PTVRiHYx2ZuCrqFDySp+y9pcrV46jRdoZwPubt+IX9LKzqPLMgKDfN
    d6oYLsjA/CtWzfqa1Q8oF8/YBpTeP1lyZBXGaGqI8JpcIzmptJ7tNFIba/yGdA+8
    dFpPh/pT4S1Jhw/nFXP9vBjFrBUKuhatOtt9Meq8YH0SFjhxrF7ZERGR6KpG3Y7X
    1MWH5rOs7A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=W450VjVU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QsQM42os;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=W450VjVU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QsQM42os;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030967AbeCAM7D (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:59:03 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34416 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030959AbeCAM7A (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:59:00 -0500
X-Google-Smtp-Source: AG47ELufBfLNL9+Jf+2D4t36mo1FgrZrKSQcICQzBdZ5rtW95TndtCUpLu325S11+fUv7s3kpJ5FfA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 26/45] arm64: entry: Apply BP hardening for high-priority synchronous exceptions
Date: Thu,  1 Mar 2018 20:54:03 +0800
Message-Id: <1519908862-11425-27-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
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
