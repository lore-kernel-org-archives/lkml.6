Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324422-2-8302719621279889289
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324421; b=bEoxkVvVUuFcsFYJXkWGYev2hX/cVTvSHdDipkwgo40Uz8n
    19J1LDTo5040zfUiAhvfz6fb82M3WVhVLB6rtx/ye50GAhX80SSNC0jaBf3L0dJz
    RjgaE8Zht1PMClz8C8UlseRtdXubC9nHtbhE8jxaRLBtztm/h588alZZgXH9UAkW
    5OJrUg+MNa1xIEntFgfrVBcd0bAPg6Bz4U9Qc5oFA9FxHOPJMy6Wdep5YkdmmdYo
    q2hvfbbm4eMeh8MKFXvdVkR0lKV4mo4kRNyMXCSh5UrN6cqVElW8hPrmM4ScDo7W
    MUFijlHO7Yrf14/ueZzeApY9QY30yWnELVGXy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324421; bh=6nas6re4RmgfYA/2UPF
    ubntoHKGQovGg/kt89hcGNnw=; b=vxOQ1RLfLSc1tsoUvPOtcrle4ritarKtepy
    6yRV1Z5xzZZLSn5KOfXo3tr9rtCkAP7PmhHLXbz22+oFgkIwnBmqhkAavssTBrIG
    BqjpmIscxiVCCc4u7KP/UBz/jnbK8KuK9DGecBCt+1uNeCsAnthClZh7v+vzqIdv
    193PAK+6igLF29q9dBE/f7fCYpedAEFAmnroCMAdSYTsuw7CFZejPWp1/zIHN1Zq
    CpvsRRHKMaf2pQSH3gJnjDFhgzAsgvMumaYO+aJjWMrNPJKSkI0cE/EIKZtZX3mA
    JxSvYlpxr+Q+EDEsTyWZlm7HWYd8rfc/U97xxT4VjhXbzMl7mWg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753128AbeBKEpQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:45:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41841 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752853AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Nadav Amit" <namit@cs.technion.ac.il>,
        "Paolo Bonzini" <pbonzini@redhat.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.905380071@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 088/136] KVM: vmx: Inject #GP on invalid PAT CR
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nadav Amit <namit@cs.technion.ac.il>

commit 4566654bb9be9e8864df417bb72ceee5136b6a6a upstream.

Guest which sets the PAT CR to invalid value should get a #GP.  Currently, if
vmx supports loading PAT CR during entry, then the value is not checked.  This
patch makes the required check in that case.

Signed-off-by: Nadav Amit <namit@cs.technion.ac.il>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/vmx.c | 2 ++
 arch/x86/kvm/x86.c | 5 +++--
 arch/x86/kvm/x86.h | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2599,6 +2599,8 @@ static int vmx_set_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_CR_PAT:
 		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
+			if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
+				return 1;
 			vmcs_write64(GUEST_IA32_PAT, data);
 			vcpu->arch.pat = data;
 			break;
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1742,7 +1742,7 @@ static bool valid_mtrr_type(unsigned t)
 	return t < 8 && (1 << t) & 0x73; /* 0, 1, 4, 5, 6 */
 }
 
-static bool mtrr_valid(struct kvm_vcpu *vcpu, u32 msr, u64 data)
+bool kvm_mtrr_valid(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
 	int i;
 
@@ -1768,12 +1768,13 @@ static bool mtrr_valid(struct kvm_vcpu *
 	/* variable MTRRs */
 	return valid_mtrr_type(data & 0xff);
 }
+EXPORT_SYMBOL_GPL(kvm_mtrr_valid);
 
 static int set_msr_mtrr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
 	u64 *p = (u64 *)&vcpu->arch.mtrr_state.fixed_ranges;
 
-	if (!mtrr_valid(vcpu, msr, data))
+	if (!kvm_mtrr_valid(vcpu, msr, data))
 		return 1;
 
 	if (msr == MSR_MTRRdefType) {
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -132,6 +132,8 @@ int kvm_write_guest_virt_system(struct x
 	gva_t addr, void *val, unsigned int bytes,
 	struct x86_exception *exception);
 
+bool kvm_mtrr_valid(struct kvm_vcpu *vcpu, u32 msr, u64 data);
+
 #define KVM_SUPPORTED_XCR0     (XSTATE_FP | XSTATE_SSE | XSTATE_YMM \
 				| XSTATE_BNDREGS | XSTATE_BNDCSR)
 extern u64 host_xcr0;
