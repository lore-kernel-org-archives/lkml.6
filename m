Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2252317-1519633493-2-8878218537275492454
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519633492; b=ZKekF/iPs7teDOFpmPE2i/isOeBhGS2sAR1nsV5Iaj5FO0v
    3maLWbhDCwZSXrLUqZAvCp8y5xhPIf4lLLOkwthZ8L7eKc8J+xUJehasjKZFpXge
    icGMqpmyHtBsHuWFCN192/6yQUqW2UTJA4jxNHHwzt/TeIqNvsw7LWeDgfOqs6+6
    hbceyoPeFesSVA47cTkjwxYCaY4iEiYXP9n1U7S6zKERTUyQpXaFKmnuWt89IS1B
    yitlI77NqPScIhQRyQeaizT43t4YR+h1d+8EmR7g335tCvIjqJ9cKl+td3UNY73u
    8kG2KpHl76tcq8hLdV13WVn1Uuj/dsrnVSaj88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633492;
    bh=/nksGLZqHQjfpQbfH68HEgt65Nc6WZIfEk50r4t0UeE=; b=aElS0X7G9DR6
    QKvey172k04WGiUnJLmqwhrZt0X07KgN26RBTwgOwJs3uAWV7ZH1azEqCu8CcCM7
    xSfrydMdBoTB8hTJgDlA4D9Hu6DJbVc166kZDMtc8vSXj3c1o8KVkK8gBcZBzfJ1
    hBm8PVxs4d9g/1VW4PHNTqftQJ4+32c6Idqcjel+4S4htBOWEDDSPyg2hIqAwWTY
    iLb0mAztADszAEioaW0bgs669R2j6UHUURC/yfs9ChPwCc5dLLchOmc5IYy4mpuI
    iybOmcp+Qr2ZZ7IZVmtMc2164YwC+4+REn0z088uDK3NweSbpFRL8hsl+AitCmGY
    v6l+4iYwuA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=aJOtU3Bb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=l34Y42/P;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=aJOtU3Bb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=l34Y42/P;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbeBZIYs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:24:48 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39892 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeBZIYn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:24:43 -0500
X-Google-Smtp-Source: AH8x224sXf07/1UaovxeoGYvKB4N4ak2vjiwygI8UCwWpZ58MGgB9BdV/E0oV8AEgRnphKGvX23Haw==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM)),
        linux-arm-kernel@lists.infradead.org (moderated list:KERNEL VIRTUAL
        MACHINE FOR ARM64 (KVM/arm64)),
        kvmarm@lists.cs.columbia.edu (open list:KERNEL VIRTUAL MACHINE FOR
        ARM64 (KVM/arm64)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 30/52] arm64: KVM: Increment PC after handling an SMC trap
Date: Mon, 26 Feb 2018 16:20:04 +0800
Message-Id: <1519633227-29832-31-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit f5115e8869e1 upstream.

When handling an SMC trap, the "preferred return address" is set
to that of the SMC, and not the next PC (which is a departure from
the behaviour of an SMC that isn't trapped).

Increment PC in the handler, as the guest is otherwise forever
stuck...

Cc: stable@vger.kernel.org
Fixes: acfb3b883f6d ("arm64: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls")
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kvm/handle_exit.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 2e6e9e9..5b56b09 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -53,7 +53,16 @@ static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
+	/*
+	 * "If an SMC instruction executed at Non-secure EL1 is
+	 * trapped to EL2 because HCR_EL2.TSC is 1, the exception is a
+	 * Trap exception, not a Secure Monitor Call exception [...]"
+	 *
+	 * We need to advance the PC after the trap, as it would
+	 * otherwise return to the same address...
+	 */
 	vcpu_set_reg(vcpu, 0, ~0UL);
+	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
 	return 1;
 }
 
-- 
2.7.4
