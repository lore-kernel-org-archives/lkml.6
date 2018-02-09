Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184817-2-15113341381398659310
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184816; b=QIj67fA3yMZnDWucH8hZ4//MSd/O6u05Eezusvl+0koJLRJ
    cZgpyoQ9RUSbUBrZ86y5xhVN6yGwAdDCosrxne3+ql5kNDvQeFuFhhxKEINi5+eh
    rCU2NxONeelB+D4r/oM9/jbbX5YitiN5gAGLP80tuPYZI17vPjcs0Ys8IKRZyDGV
    K5x1lRPQGnfw00mgwZuByCTVx0lc0q5ZPNFeCSFu1nkDafOBBFI5gw7PMU0hM7Ap
    AqhXl3fghKxxwDlB5EJvr91+/ZisSH8OupmmaHQvkgMz4DGRAjLDYHShCPazTnPN
    JkrSmk8uEqwwL1f9kRx30pmgbCmEIuA1pLAgXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184816; bh=p8f3ED1h3X8ZprQkZlWIQSXmAN
    pyRUTg+RtCaFzioq4=; b=Xn/J9vGdO9LxHm8HJtwmtHV1D/lF0CAurj6g8PzVMs
    fguNXZyPreBBxmHztpfXL1jff7Aa/ayDryD2s0dXfZ1MrZDTYYmjvUXjHEAcYjLy
    fenAMiJG6inI8yyH21UEYLDIbK18QVTuNgXSol/vDplbq4B+eq7YpeSrnUNNrshM
    roAd5FkP4bK/ws3rHHS/8mRNYvN9YX4ccs4twxRmbIhNlMK9MoAsUAw8GJndn/i0
    dZ/+ebMX4v7sm395pxgMNNyETpysu5kUlwlCgOkRLtJFrwQPorrz3XAEXCV+8gQF
    +NrZljSqm20ASbaX9giSnhnNcyoh7lL5gaxnUPQhcwfw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeBINoP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:44:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeBINoM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Kenny <darren.kenny@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 4.9 84/92] KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL
Date: Fri,  9 Feb 2018 14:39:53 +0100
Message-Id: <20180209133937.218820152@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KarimAllah Ahmed <karahmed@amazon.de>


(cherry picked from commit d28b387fb74da95d69d2615732f50cceb38e9a4d)

[ Based on a patch from Ashok Raj <ashok.raj@intel.com> ]

Add direct access to MSR_IA32_SPEC_CTRL for guests. This is needed for
guests that will only mitigate Spectre V2 through IBRS+IBPB and will not
be using a retpoline+IBPB based approach.

To avoid the overhead of saving and restoring the MSR_IA32_SPEC_CTRL for
guests that do not actually use the MSR, only start saving and restoring
when a non-zero is written to it.

No attempt is made to handle STIBP here, intentionally. Filtering STIBP
may be added in a future patch, which may require trapping all writes
if we don't want to pass it through directly to the guest.

[dwmw2: Clean up CPUID bits, save/restore manually, handle reset]

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
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
Link: https://lkml.kernel.org/r/1517522386-18410-5-git-send-email-karahmed@amazon.de
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/cpuid.c |    8 ++-
 arch/x86/kvm/cpuid.h |   11 +++++
 arch/x86/kvm/vmx.c   |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c   |    2 
 4 files changed, 118 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -357,7 +357,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(IBPB);
+		F(IBPB) | F(IBRS);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_cpuid_C000_0001_edx_x86_features =
@@ -382,7 +382,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		F(ARCH_CAPABILITIES);
+		F(SPEC_CTRL) | F(ARCH_CAPABILITIES);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
@@ -618,9 +618,11 @@ static inline int __do_cpuid_ent(struct
 			g_phys_as = phys_as;
 		entry->eax = g_phys_as | (virt_as << 8);
 		entry->edx = 0;
-		/* IBPB isn't necessarily present in hardware cpuid */
+		/* IBRS and IBPB aren't necessarily present in hardware cpuid */
 		if (boot_cpu_has(X86_FEATURE_IBPB))
 			entry->ebx |= F(IBPB);
+		if (boot_cpu_has(X86_FEATURE_IBRS))
+			entry->ebx |= F(IBRS);
 		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
 		cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
 		break;
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -171,6 +171,17 @@ static inline bool guest_cpuid_has_ibpb(
 	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
 }
 
+static inline bool guest_cpuid_has_ibrs(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid_entry2 *best;
+
+	best = kvm_find_cpuid_entry(vcpu, 0x80000008, 0);
+	if (best && (best->ebx & bit(X86_FEATURE_IBRS)))
+		return true;
+	best = kvm_find_cpuid_entry(vcpu, 7, 0);
+	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
+}
+
 static inline bool guest_cpuid_has_arch_capabilities(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best;
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -552,6 +552,7 @@ struct vcpu_vmx {
 #endif
 
 	u64 		      arch_capabilities;
+	u64 		      spec_ctrl;
 
 	u32 vm_entry_controls_shadow;
 	u32 vm_exit_controls_shadow;
@@ -1852,6 +1853,29 @@ static void update_exception_bitmap(stru
 }
 
 /*
+ * Check if MSR is intercepted for currently loaded MSR bitmap.
+ */
+static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
+{
+	unsigned long *msr_bitmap;
+	int f = sizeof(unsigned long);
+
+	if (!cpu_has_vmx_msr_bitmap())
+		return true;
+
+	msr_bitmap = to_vmx(vcpu)->loaded_vmcs->msr_bitmap;
+
+	if (msr <= 0x1fff) {
+		return !!test_bit(msr, msr_bitmap + 0x800 / f);
+	} else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff)) {
+		msr &= 0x1fff;
+		return !!test_bit(msr, msr_bitmap + 0xc00 / f);
+	}
+
+	return true;
+}
+
+/*
  * Check if MSR is intercepted for L01 MSR bitmap.
  */
 static bool msr_write_intercepted_l01(struct kvm_vcpu *vcpu, u32 msr)
@@ -2981,6 +3005,13 @@ static int vmx_get_msr(struct kvm_vcpu *
 	case MSR_IA32_TSC:
 		msr_info->data = guest_read_tsc(vcpu);
 		break;
+	case MSR_IA32_SPEC_CTRL:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has_ibrs(vcpu))
+			return 1;
+
+		msr_info->data = to_vmx(vcpu)->spec_ctrl;
+		break;
 	case MSR_IA32_ARCH_CAPABILITIES:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has_arch_capabilities(vcpu))
@@ -3091,6 +3122,36 @@ static int vmx_set_msr(struct kvm_vcpu *
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, msr_info);
 		break;
+	case MSR_IA32_SPEC_CTRL:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has_ibrs(vcpu))
+			return 1;
+
+		/* The STIBP bit doesn't fault even if it's not advertised */
+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
+			return 1;
+
+		vmx->spec_ctrl = data;
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
+		 * nested_vmx_merge_msr_bitmap. We should not touch the
+		 * vmcs02.msr_bitmap here since it gets completely overwritten
+		 * in the merging. We update the vmcs01 here for L1 as well
+		 * since it will end up touching the MSR anyway now.
+		 */
+		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap,
+					      MSR_IA32_SPEC_CTRL,
+					      MSR_TYPE_RW);
+		break;
 	case MSR_IA32_PRED_CMD:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has_ibpb(vcpu))
@@ -5239,6 +5300,7 @@ static void vmx_vcpu_reset(struct kvm_vc
 	u64 cr0;
 
 	vmx->rmode.vm86_active = 0;
+	vmx->spec_ctrl = 0;
 
 	vmx->soft_vnmi_blocked = 0;
 
@@ -8824,6 +8886,15 @@ static void __noclone vmx_vcpu_run(struc
 
 	vmx_arm_hv_timer(vcpu);
 
+	/*
+	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
+	 * it's non-zero. Since vmentry is serialising on affected CPUs, there
+	 * is no need to worry about the conditional branch over the wrmsr
+	 * being speculatively taken.
+	 */
+	if (vmx->spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
 		/* Store host registers */
@@ -8942,6 +9013,27 @@ static void __noclone vmx_vcpu_run(struc
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
+		rdmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+
+	if (vmx->spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
 
@@ -9501,7 +9593,7 @@ static inline bool nested_vmx_merge_msr_
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
 	/*
-	 * pred_cmd is trying to verify two things:
+	 * pred_cmd & spec_ctrl are trying to verify two things:
 	 *
 	 * 1. L0 gave a permission to L1 to actually passthrough the MSR. This
 	 *    ensures that we do not accidentally generate an L02 MSR bitmap
@@ -9514,9 +9606,10 @@ static inline bool nested_vmx_merge_msr_
 	 *    the MSR.
 	 */
 	bool pred_cmd = msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
+	bool spec_ctrl = msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
 
 	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
-	    !pred_cmd)
+	    !pred_cmd && !spec_ctrl)
 		return false;
 
 	page = nested_get_page(vcpu, vmcs12->msr_bitmap);
@@ -9550,6 +9643,12 @@ static inline bool nested_vmx_merge_msr_
 		}
 	}
 
+	if (spec_ctrl)
+		nested_vmx_disable_intercept_for_msr(
+					msr_bitmap_l1, msr_bitmap_l0,
+					MSR_IA32_SPEC_CTRL,
+					MSR_TYPE_R | MSR_TYPE_W);
+
 	if (pred_cmd)
 		nested_vmx_disable_intercept_for_msr(
 					msr_bitmap_l1, msr_bitmap_l0,
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -975,7 +975,7 @@ static u32 msrs_to_save[] = {
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
-	MSR_IA32_ARCH_CAPABILITIES
+	MSR_IA32_SPEC_CTRL, MSR_IA32_ARCH_CAPABILITIES
 };
 
 static unsigned num_msrs_to_save;
