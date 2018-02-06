Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1690823-1517938220-2-3862794467816244410
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: to='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517938219; b=S5BGOZ12BUelgryJmmQgD4zxp4vwu8MdQ1/T4LSSvuX2Ytu
    FzkhE8tSI0Kvyng4u81rk/OKSU6Rikdj2G7Ftl0rOP+eieuPHNL99gv12esHGmXj
    bNi1e3W3L2RFi5WCVOusnkLYbuPFzjsih1p7sdrsEDzrJXPBKGr5DItrFDdjrKhY
    rC2sYeX7Ez9cDhLEF7S3mlBp91TXCb4sJ7Bu4LXfgpkhirzatENjgY/7RaWPimqB
    895G3Uau4r+6iIT8ukeed2dp500BINxi03rhkXFNQmsXfJdHl+Oi2i57mpfCuLsd
    qJt0HCXMHmbm8u0qausTAHM5Kv8SVLuxgzWsxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1517938219;
    bh=+Hzg7DFoYpfWA42oO6osZ5km2Wqrs7a9lqm05HkahQQ=; b=RZQBhxUS7BY8
    KjnhAJ7noIRQnMwPdtSNhYh2neQYsDfcXFabzwl4jGCLMUyaY0nM8CUZnQWNWmcT
    wffD5a+fzW64So/xzX7y2PAZSCA1owyQWuB+lyHU3zb/R2Drn4OgM369BBsQiF9p
    QNH3vKJUN4yQjzftnX7mgvKwMFM6JgJ9JloMztWqOMFeyGhNkK9A6KWDHcG8xTOQ
    0C9+Ash7gCE2lrPIpH+LWvqWm4rW4q8YpFPh9rsOiL2kSzvsRNFHfB6462vOU6eI
    7//KNwuX1kvx8SiiEb3YklwoPc+uqVkXiMk4gcPcEv0c91hDomiKBopy9iEPg5W0
    Tv0DU7/Stw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.co.uk);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=IdxMf35Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.co.uk);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=IdxMf35Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeBFRaQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 12:30:16 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:44336 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbeBFR35 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 12:29:57 -0500
X-IronPort-AV: E=Sophos;i="5.46,469,1511827200";
   d="scan'208";a="330970458"
From: David Woodhouse <dwmw@amazon.co.uk>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 9/9] KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL
Date: Tue,  6 Feb 2018 17:29:41 +0000
Message-Id: <1517938181-15317-10-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: KarimAllah Ahmed <karahmed@amazon.de>

[ Based on a patch from Paolo Bonzini <pbonzini@redhat.com> ]

... basically doing exactly what we do for VMX:

- Passthrough SPEC_CTRL to guests (if enabled in guest CPUID)
- Save and restore SPEC_CTRL around VMExit and VMEntry only if the guest
  actually used it.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: kvm@vger.kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Link: https://lkml.kernel.org/r/1517669783-20732-1-git-send-email-karahmed@amazon.de

(cherry picked from commit b2ac58f90540e39324e7a29a7ad471407ae0bf48)
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/svm.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 6de8d65..be644af 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -183,6 +183,8 @@ struct vcpu_svm {
 		u64 gs_base;
 	} host;
 
+	u64 spec_ctrl;
+
 	u32 *msrpm;
 
 	ulong nmi_iret_rip;
@@ -248,6 +250,7 @@ static const struct svm_direct_access_msrs {
 	{ .index = MSR_CSTAR,				.always = true  },
 	{ .index = MSR_SYSCALL_MASK,			.always = true  },
 #endif
+	{ .index = MSR_IA32_SPEC_CTRL,			.always = false },
 	{ .index = MSR_IA32_PRED_CMD,			.always = false },
 	{ .index = MSR_IA32_LASTBRANCHFROMIP,		.always = false },
 	{ .index = MSR_IA32_LASTBRANCHTOIP,		.always = false },
@@ -863,6 +866,25 @@ static bool valid_msr_intercept(u32 index)
 	return false;
 }
 
+static bool msr_write_intercepted(struct kvm_vcpu *vcpu, unsigned msr)
+{
+	u8 bit_write;
+	unsigned long tmp;
+	u32 offset;
+	u32 *msrpm;
+
+	msrpm = is_guest_mode(vcpu) ? to_svm(vcpu)->nested.msrpm:
+				      to_svm(vcpu)->msrpm;
+
+	offset    = svm_msrpm_offset(msr);
+	bit_write = 2 * (msr & 0x0f) + 1;
+	tmp       = msrpm[offset];
+
+	BUG_ON(offset == MSR_INVALID);
+
+	return !!test_bit(bit_write,  &tmp);
+}
+
 static void set_msr_interception(u32 *msrpm, unsigned msr,
 				 int read, int write)
 {
@@ -1537,6 +1559,8 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	u32 dummy;
 	u32 eax = 1;
 
+	svm->spec_ctrl = 0;
+
 	if (!init_event) {
 		svm->vcpu.arch.apic_base = APIC_DEFAULT_PHYS_BASE |
 					   MSR_IA32_APICBASE_ENABLE;
@@ -3520,6 +3544,13 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_VM_CR:
 		msr_info->data = svm->nested.vm_cr_msr;
 		break;
+	case MSR_IA32_SPEC_CTRL:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has_ibrs(vcpu))
+			return 1;
+
+		msr_info->data = svm->spec_ctrl;
+		break;
 	case MSR_IA32_UCODE_REV:
 		msr_info->data = 0x01000065;
 		break;
@@ -3611,6 +3642,33 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, msr);
 		break;
+	case MSR_IA32_SPEC_CTRL:
+		if (!msr->host_initiated &&
+		    !guest_cpuid_has_ibrs(vcpu))
+			return 1;
+
+		/* The STIBP bit doesn't fault even if it's not advertised */
+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
+			return 1;
+
+		svm->spec_ctrl = data;
+
+		if (!data)
+			break;
+
+		/*
+		 * For non-nested:
+		 * When it's written (to non-zero) for the first time, pass
+		 * it through.
+		 *
+		 * For nested:
+		 * The handling of the MSR bitmap for L2 guests is done in
+		 * nested_svm_vmrun_msrpm.
+		 * We update the L1 MSR bit as well since it will end up
+		 * touching the MSR anyway now.
+		 */
+		set_msr_interception(svm->msrpm, MSR_IA32_SPEC_CTRL, 1, 1);
+		break;
 	case MSR_IA32_PRED_CMD:
 		if (!msr->host_initiated &&
 		    !guest_cpuid_has_ibpb(vcpu))
@@ -4854,6 +4912,15 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	local_irq_enable();
 
+	/*
+	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
+	 * it's non-zero. Since vmentry is serialising on affected CPUs, there
+	 * is no need to worry about the conditional branch over the wrmsr
+	 * being speculatively taken.
+	 */
+	if (svm->spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
 		"mov %c[rbx](%[svm]), %%" _ASM_BX " \n\t"
@@ -4946,6 +5013,27 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 #endif
 		);
 
+	/*
+	 * We do not use IBRS in the kernel. If this vCPU has used the
+	 * SPEC_CTRL MSR it may have left it on; save the value and
+	 * turn it off. This is much more efficient than blindly adding
+	 * it to the atomic save/restore list. Especially as the former
+	 * (Saving guest MSRs on vmexit) doesn't even exist in KVM.
+	 *
+	 * For non-nested case:
+	 * If the L01 MSR bitmap does not intercept the MSR, then we need to
+	 * save it.
+	 *
+	 * For nested case:
+	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
+	 * save it.
+	 */
+	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+		rdmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+
+	if (svm->spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
 
-- 
2.7.4
