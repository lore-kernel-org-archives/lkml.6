Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1654186-1517938466-2-10048346156362118010
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: to='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517938465; b=cnCBw94vQrZqEXCFvnPVbzg6mzM40TqMaGLoFCrxu2QbJ5y
    FNo6ByuZqJ7YfeFQH6fVFgZyD/Qb66R2igQ/mA98dWvrn9EDTjnZ6A1Xr5iWP1h3
    zElvarnfZHISBXbj8tSbWDIfPtQdTLmBMghPdV0NOYxYNgi3bJAwNYMwvVsFokTX
    qF11W83HWACjHZ7aNNWTgkMNp3ghaCOYMKBaeDqL1TaZqW46f25cOEwKMLFUa0Hb
    aBXp0dWmq/dy+02cFCRiPkVq2FhYuz36NMbMJXZsqTdaRsnV8RnrvClB/gMhmYc7
    eY1NTUNAKPDzf0WrPMwewcaV2NwsEAh441slW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1517938465;
    bh=gdERRKgfLgZCCLZpxZCP/5aYAqGWcaVwv/MEzUgmByg=; b=fnzPbfay0VKP
    pfswQ8GrTgmzjYPu3ZDhrTarqsOCmeVwTYNI+0TL+IPP6/+yEjb/12GXp+7joHVp
    uCUqCqsPNi3iQfppnV+/nLuxcQ3CA+kNiUi/XZULMX9uzdfbw7pyeud4WG39HB4y
    ZQ44nkxuBZWUfCluFLUnn1yNo2bS4MHhKeWsDUfwb97PH499/QiWpYhQCmy5rG9d
    CTAy9lx1cufqC41pZzflOG+z9KtNrEexxx9btMBX6XzOso0W6kcuDSIRhnFmqZ1q
    5mqCxNAJ7/PHndzFbo3VZbAv6tj7IUwuEhs9n///CzXAqkYDX9xh7VNrPb16KmmJ
    Qwxv9SNI1Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.co.uk);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=H06SpKhZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.co.uk);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=H06SpKhZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeBFRbZ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 12:31:25 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:11107 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752912AbeBFRbF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 12:31:05 -0500
X-IronPort-AV: E=Sophos;i="5.46,469,1511827200";
   d="scan'208";a="718429365"
From: David Woodhouse <dwmw@amazon.co.uk>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 1/9] KVM: nVMX: vmx_complete_nested_posted_interrupt() can't fail
Date: Tue,  6 Feb 2018 17:29:33 +0000
Message-Id: <1517938181-15317-2-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

vmx_complete_nested_posted_interrupt() can't fail, let's turn it into
a void function.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

(cherry picked from commit 6342c50ad12e8ce0736e722184a7dbdea4a3477f)
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/vmx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index feadff3..fd890af 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4736,7 +4736,7 @@ static bool vmx_get_enable_apicv(void)
 	return enable_apicv;
 }
 
-static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
+static void vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int max_irr;
@@ -4747,13 +4747,13 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	    vmx->nested.pi_pending) {
 		vmx->nested.pi_pending = false;
 		if (!pi_test_and_clear_on(vmx->nested.pi_desc))
-			return 0;
+			return;
 
 		max_irr = find_last_bit(
 			(unsigned long *)vmx->nested.pi_desc->pir, 256);
 
 		if (max_irr == 256)
-			return 0;
+			return;
 
 		vapic_page = kmap(vmx->nested.virtual_apic_page);
 		if (!vapic_page) {
@@ -4770,7 +4770,6 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 			vmcs_write16(GUEST_INTR_STATUS, status);
 		}
 	}
-	return 0;
 }
 
 static inline bool kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu)
@@ -10491,7 +10490,8 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu, bool external_intr)
 		return 0;
 	}
 
-	return vmx_complete_nested_posted_interrupt(vcpu);
+	vmx_complete_nested_posted_interrupt(vcpu);
+	return 0;
 }
 
 static u32 vmx_get_preemption_timer_value(struct kvm_vcpu *vcpu)
-- 
2.7.4
