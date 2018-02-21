Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2503644-1519249379-2-9712749300005483557
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519249379; b=aBE3Wd4CQ+HbAyuIU6GsInZkWTeubzZICG4kwHlvbUJP/kn
    JPO07l/G0UH+HNrcG42ZpuL/V8v3IJ5RKgz7OcX1tZu8LQxll0qvdOpKu4nRd/ps
    U+vsKHAd9Csaj+DKcn0toJVOh4KNrImHh8KnfEZfk3aT3jmaAvCmLi8ibNZ+MGxg
    +MN8/62qC6vDI3WItkrjKmKKobU6lIBAr+RpaIc2zlAejdUoVhfZdGMmG2FjmIKv
    P/oTqXJDTUMvYhhB/BpxR0TXGQUszUA4aXL700FZDOLJ2gvG83oyo6PJiawt80KX
    uDxCZe375e2CjUU9yY5n0GwevIN32lQgNKfPcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519249379; bh=LcLDfkr9sUSgcF5bZZx3ol5kTYb8HijIsOrppxD2Ch4=; b=d
    OLJwQSMErcxUWl4CvuXPRB7GoaMQEMYhsdA6fgc62JyWW8Fwgin4SIKmuzaSCBKq
    MBzy4VgWDWkJzpYOtdgh5Y55v7o+I+yoS+U/+SO2/yabaDhkoDbyxFNCTauTCv2L
    HC8jQS5pCogiT2KoXWQJl0zKOG1+BIoY4W3Ok57Mi7BTfK42H0WMJ7zz9Wt1j76f
    v3WHWxQZxLGAc0LipI3soZidGFvlMvidGrKHb34KZaW1npUOowIL6+lBbjJY20/9
    cx9vIrcGxKkCmv9GU6zKQTBow5d8R2i8jfaYAl94EYJGYQVWYiWb84iixEf3VrvB
    kJUooBNjq+H0YxTAlNfaA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rZmk7vRS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=d4/crTwy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rZmk7vRS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=d4/crTwy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbeBUVlu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 16:41:50 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50283 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeBUVlr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 16:41:47 -0500
X-Google-Smtp-Source: AH8x224N3W3V+KNUxJkydS4MiLicUcJcuwbzlqbS+seh3Aaos+QPNogHbv85QziC1EzDLBzW34fs6g==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: x86@kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 2/3] KVM: nVMX: fix wrong condition for SPEC_CTRL and PRED_CMD MSRs
Date: Wed, 21 Feb 2018 22:41:36 +0100
Message-Id: <1519249297-73718-3-git-send-email-pbonzini@redhat.com>
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

We need to change the default all-1s bitmap if the MSRs are _not_
intercepted.  However, the code was disabling the intercept when it was
_enabled_ in the VMCS01.  This is not causing bigger trouble,
because vmx_vcpu_run checks the VMCS02's MSR bitmap and would do the
right thing even if fed garbage... but it's obviously a bug and it can
cause extra MSR reads and writes when running nested guests.

Fixes: d28b387fb74da95d69d2615732f50cceb38e9a4d
Fixes: 15d45071523d89b3fb7372e2135fbd72f6af9506
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
 arch/x86/kvm/vmx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 5caeb8dc5bda..af89d377681d 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10235,7 +10235,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 		return false;
 
 	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
-	    !pred_cmd && !spec_ctrl)
+	    pred_cmd && spec_ctrl)
 		return false;
 
 	page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->msr_bitmap);
@@ -10278,13 +10278,13 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 			MSR_TYPE_W);
 	}
 
-	if (spec_ctrl)
+	if (!spec_ctrl)
 		nested_vmx_disable_intercept_for_msr(
 					msr_bitmap_l1, msr_bitmap_l0,
 					MSR_IA32_SPEC_CTRL,
 					MSR_TYPE_R | MSR_TYPE_W);
 
-	if (pred_cmd)
+	if (!pred_cmd)
 		nested_vmx_disable_intercept_for_msr(
 					msr_bitmap_l1, msr_bitmap_l0,
 					MSR_IA32_PRED_CMD,
-- 
1.8.3.1
