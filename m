Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2495636-1519249342-2-11368297206926831355
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519249342; b=YblYHapOUMfZwMlgYBOvkHRp5AobFzDCC+ZbZgg8Kc1SRB5
    M/A6jwHFPrKgAZr3nO1UKtRYs1tH6gqc0bhJ5eqZj4NoO1JDhWYpeMB/14b0G0F4
    cVOG8KrZCPnB6/ZTrYBX+ueyld5CbE516jUcv2IvcwtBFDEJGvCwM73rNM70JbqZ
    oVOJIKk6h7wDWe+yZgn8rV4wxY5pWsWxSkEkVTOjX66ADj/XK1o8YiI+G/1P09Ei
    t+hAdByZToPqYRuqODfEDpR/4o+B9FTqFcqTc2CqTcEmTM0R/LKJFHdk/5E51Tiu
    OmmkiSl97KPeiIlOwwB9kLTyQe1gZeIlWxPZr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519249342; bh=rB3/BoHzkW3FyPo4r06A/oZBN8bcCbpXphlnntmyFFA=; b=Z
    pvdA+TnuaHAJApmmYl/lVrMA5feRE+92VOqgYOHHaS+hMr7vsQ+3YAs8EISTRRD7
    lwYqz+8YUvBWIWEMyp1TB0kClWeVjXJuHpyZIAVK1MkTTZ6iNZnkbD87ngPQvH6Z
    LBNIPXuzoRghwxCe45oi0fCi93BZNaxZrZfJyvK0pIvA4LeidbcS3ATWTYL2N70a
    aP76Z3QPlJOpgUJfHr9D8dKCKiP6l9O8P3hsbRjRIPHcjj0bLmDkrt/MZ13P4a/e
    g6WzbpkoctCMCi0ERlQ6hy477akxb8GdJpdcaAAnABOZI25QffOoHFDVIiKl5++0
    6aUDbKxMTD9WZWuuv4ZwA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JPaLJ5od x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AOQSlEBW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JPaLJ5od x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AOQSlEBW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeBUVly (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 16:41:54 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33354 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBUVls (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 16:41:48 -0500
X-Google-Smtp-Source: AH8x2249sw7mPnAlcPXgCOLCh08B6rmeeWkaTskULglnX3g6FU3F76t8IgTviXfF7Ux2hgupXNimQA==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: x86@kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 3/3] KVM: VMX: mark RDMSR path as unlikely
Date: Wed, 21 Feb 2018 22:41:37 +0100
Message-Id: <1519249297-73718-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519249297-73718-1-git-send-email-pbonzini@redhat.com>
References: <1519249297-73718-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

vmx_vcpu_run and svm_vcpu_run are large functions, and this can actually
make a substantial cycle difference by keeping the fast path contiguous
in memory.  Without it, the retpoline guest/retpoline host case is about
50 cycles slower.

Cc: x86@kernel.org
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Jim Mattson <jmattson@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm.c | 2 +-
 arch/x86/kvm/vmx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 1598beeda11c..24c9521ebc24 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5465,7 +5465,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (svm->spec_ctrl)
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index af89d377681d..e13fd2a833c4 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9589,7 +9589,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (vmx->spec_ctrl)
-- 
1.8.3.1
