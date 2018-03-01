Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909447-2-18246116395609747199
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
    t=1519909446; b=hhdQmGEblOy+eNcES08tfeJIvj6klDRdWRX4Bg3yNCp753B
    Ox+lELZD8jVvHLvGRTzQsrcDKf0T1apDgu6rzHOA4Naigo82Ew+g2+PXBHdn9trB
    MD/b8y+5vYfCdwlQyqoOKYCgAgSHxRYpVhT1IqwAnEdeV7wK3k8RTn7Y+AHZYfGO
    lsvADXVPV7RgNROY5LCC9QcmkS1kSApuSTpZ9w0fKSEeLH4lwkzJG97HxrjYdfwf
    eVjoIS8A21fibR1J87YTtp9I7NEmgjFq6u/s8Rw6bsGBt09gvZr8jj+ww1gAHmJv
    E3SQf+0VL4QgUEcDAHJ8ksqQe95cn7TlBurWz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909446;
    bh=/nksGLZqHQjfpQbfH68HEgt65Nc6WZIfEk50r4t0UeE=; b=iRfjJ4fpn/Z+
    1jHkM+dOH7sn433B4PojvWaj8UB2+IWqqe6CwXy+GR8KPh7O0BfrM9kpjbbv1tMv
    dJK9UGuAcuz1yw+htwiSp3yA0kBPi1r4ST/ULpvdBsP9xP9FuEkS89BThkY0wlsB
    i4o+0Ux53ACm5IyhCX8dS1A/Hu+KSdg9DZZgwi0/rGMXAora0Eo7Pr7yECrGtffR
    qDVCCl8WTyRK7y+y1DghBTao5yaHO2pNj3Ylq34ULEtSfEayTGqQCLIek10Dgzxl
    1AgUncsJnzHcNo2KwKRqz+sWxsRONhP9J7VYPkH2IcJk8bHJ78LkU+FP3BqfG4ue
    sArHI04Rmw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=KX26itFa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=avXaoGou;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=KX26itFa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=avXaoGou;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030726AbeCAM7e (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:59:34 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39893 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031000AbeCAM72 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:59:28 -0500
X-Google-Smtp-Source: AG47ELtD/baaMEgHc/wvhiwz4X0UBIZz2P2IRUFr9lAdDcIq1pdr5XeqYlJlK9TbxfXFiquPRg2LEA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 30/45] arm64: KVM: Increment PC after handling an SMC trap
Date: Thu,  1 Mar 2018 20:54:07 +0800
Message-Id: <1519908862-11425-31-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
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
