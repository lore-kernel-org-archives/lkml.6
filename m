Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184851-2-13637495294233586713
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
    t=1518184850; b=iP7H2V17+c7L4rPynmlc3bj8YrGwEpPhoFRpm8UEwj9z6ln
    6S4BdeAr5whM26J5A4Fat14S1UFVyGBs2OxVaZ3At9hzLw4pikKfV3cXjIfUeZib
    OEChpoq/GPtE9rCyz/MqOaAMFEQDzlYIK2jgx7PhmqGgGd87SMmm35A0OlmAj8Oj
    /RwTpybNW63wJ1fWXla94V1e2/ENJ0LMYrOaCTCHpbf2OF3JEKpH7mSbrMh8sXA3
    VfwmEDoDa3/COCUJ3Id6g4AEJmGM46u5G4jnHzx4mcpiPt895d7bYUS+6yPgUvzD
    lQGeZY64K7y95FvjLpezPz3jiGRUClDnpsY3F4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184850; bh=oiwWV9xqJohy57m5UX2gFtYBww
    r+yQSM6AzXlLaRnQA=; b=lN51BcWGVcs81FwOvbvbqzqreIUc3KZzlVxR4JsMe1
    j3+Ecl0TN4SqKXD9s/LZQFmUhpxRwbGFS7n6FFAaGBpNcelv6QJAlnlCLFQIo1H5
    dtaFvjmHktRfBEPDIFdeEeIcqTx8Vy6mMMSXmojVXlciHegIYpL5jJ+wgFH9buMF
    ZmxwTeQ6M48wuag8x7TrJVaK1PZlqJOJ9piqaYxPUMpk1qUQ/8FPJ6ICaoi5p7S3
    8Vi/SwSmKO0n3FTvMLwkamhpyjHrYpsxhx8kaSigoHgBEF/EZsBzQUW3Zri3SX77
    g5lKs9V0NaqGxDfE37J8EJ3VEOQF2XkwjZ1SUV2ZNs2A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753365AbeBINoJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:44:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753372AbeBINoH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, kvm@vger.kernel.org,
        Asit Mallick <asit.k.mallick@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH 4.9 82/92] KVM/x86: Add IBPB support
Date: Fri,  9 Feb 2018 14:39:51 +0100
Message-Id: <20180209133937.063878926@linuxfoundation.org>
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

From: Ashok Raj <ashok.raj@intel.com>


(cherry picked from commit 15d45071523d89b3fb7372e2135fbd72f6af9506)

The Indirect Branch Predictor Barrier (IBPB) is an indirect branch
control mechanism. It keeps earlier branches from influencing
later ones.

Unlike IBRS and STIBP, IBPB does not define a new mode of operation.
It's a command that ensures predicted branch targets aren't used after
the barrier. Although IBRS and IBPB are enumerated by the same CPUID
enumeration, IBPB is very different.

IBPB helps mitigate against three potential attacks:

* Mitigate guests from being attacked by other guests.
  - This is addressed by issing IBPB when we do a guest switch.

* Mitigate attacks from guest/ring3->host/ring3.
  These would require a IBPB during context switch in host, or after
  VMEXIT. The host process has two ways to mitigate
  - Either it can be compiled with retpoline
  - If its going through context switch, and has set !dumpable then
    there is a IBPB in that path.
    (Tim's patch: https://patchwork.kernel.org/patch/10192871)
  - The case where after a VMEXIT you return back to Qemu might make
    Qemu attackable from guest when Qemu isn't compiled with retpoline.
  There are issues reported when doing IBPB on every VMEXIT that resulted
  in some tsc calibration woes in guest.

* Mitigate guest/ring0->host/ring0 attacks.
  When host kernel is using retpoline it is safe against these attacks.
  If host kernel isn't using retpoline we might need to do a IBPB flush on
  every VMEXIT.

Even when using retpoline for indirect calls, in certain conditions 'ret'
can use the BTB on Skylake-era CPUs. There are other mitigations
available like RSB stuffing/clearing.

* IBPB is issued only for SVM during svm_free_vcpu().
  VMX has a vmclear and SVM doesn't.  Follow discussion here:
  https://lkml.org/lkml/2018/1/15/146

Please refer to the following spec for more details on the enumeration
and control.

Refer here to get documentation about mitigations.

https://software.intel.com/en-us/side-channel-security-support

[peterz: rebase and changelog rewrite]
[karahmed: - rebase
           - vmx: expose PRED_CMD if guest has it in CPUID
           - svm: only pass through IBPB if guest has it in CPUID
           - vmx: support !cpu_has_vmx_msr_bitmap()]
           - vmx: support nested]
[dwmw2: Expose CPUID bit too (AMD IBPB only for now as we lack IBRS)
        PRED_CMD is a write-only MSR]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: kvm@vger.kernel.org
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Link: http://lkml.kernel.org/r/1515720739-43819-6-git-send-email-ashok.raj@intel.com
Link: https://lkml.kernel.org/r/1517522386-18410-3-git-send-email-karahmed@amazon.de
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/cpuid.c |   11 ++++++-
 arch/x86/kvm/cpuid.h |   12 +++++++
 arch/x86/kvm/svm.c   |   28 ++++++++++++++++++
 arch/x86/kvm/vmx.c   |   79 +++++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 127 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -355,6 +355,10 @@ static inline int __do_cpuid_ent(struct
 		F(3DNOWPREFETCH) | F(OSVW) | 0 /* IBS */ | F(XOP) |
 		0 /* SKINIT, WDT, LWP */ | F(FMA4) | F(TBM);
 
+	/* cpuid 0x80000008.ebx */
+	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
+		F(IBPB);
+
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_cpuid_C000_0001_edx_x86_features =
 		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
@@ -607,7 +611,12 @@ static inline int __do_cpuid_ent(struct
 		if (!g_phys_as)
 			g_phys_as = phys_as;
 		entry->eax = g_phys_as | (virt_as << 8);
-		entry->ebx = entry->edx = 0;
+		entry->edx = 0;
+		/* IBPB isn't necessarily present in hardware cpuid */
+		if (boot_cpu_has(X86_FEATURE_IBPB))
+			entry->ebx |= F(IBPB);
+		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
+		cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
 		break;
 	}
 	case 0x80000019:
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -160,6 +160,18 @@ static inline bool guest_cpuid_has_rdtsc
 	return best && (best->edx & bit(X86_FEATURE_RDTSCP));
 }
 
+static inline bool guest_cpuid_has_ibpb(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid_entry2 *best;
+
+	best = kvm_find_cpuid_entry(vcpu, 0x80000008, 0);
+	if (best && (best->ebx & bit(X86_FEATURE_IBPB)))
+		return true;
+	best = kvm_find_cpuid_entry(vcpu, 7, 0);
+	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
+}
+
+
 /*
  * NRIPS is provided through cpuidfn 0x8000000a.edx bit 3
  */
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -248,6 +248,7 @@ static const struct svm_direct_access_ms
 	{ .index = MSR_CSTAR,				.always = true  },
 	{ .index = MSR_SYSCALL_MASK,			.always = true  },
 #endif
+	{ .index = MSR_IA32_PRED_CMD,			.always = false },
 	{ .index = MSR_IA32_LASTBRANCHFROMIP,		.always = false },
 	{ .index = MSR_IA32_LASTBRANCHTOIP,		.always = false },
 	{ .index = MSR_IA32_LASTINTFROMIP,		.always = false },
@@ -510,6 +511,7 @@ struct svm_cpu_data {
 	struct kvm_ldttss_desc *tss_desc;
 
 	struct page *save_area;
+	struct vmcb *current_vmcb;
 };
 
 static DEFINE_PER_CPU(struct svm_cpu_data *, svm_data);
@@ -1644,11 +1646,17 @@ static void svm_free_vcpu(struct kvm_vcp
 	__free_pages(virt_to_page(svm->nested.msrpm), MSRPM_ALLOC_ORDER);
 	kvm_vcpu_uninit(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, svm);
+	/*
+	 * The vmcb page can be recycled, causing a false negative in
+	 * svm_vcpu_load(). So do a full IBPB now.
+	 */
+	indirect_branch_prediction_barrier();
 }
 
 static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	struct svm_cpu_data *sd = per_cpu(svm_data, cpu);
 	int i;
 
 	if (unlikely(cpu != vcpu->cpu)) {
@@ -1677,6 +1685,10 @@ static void svm_vcpu_load(struct kvm_vcp
 	if (static_cpu_has(X86_FEATURE_RDTSCP))
 		wrmsrl(MSR_TSC_AUX, svm->tsc_aux);
 
+	if (sd->current_vmcb != svm->vmcb) {
+		sd->current_vmcb = svm->vmcb;
+		indirect_branch_prediction_barrier();
+	}
 	avic_vcpu_load(vcpu, cpu);
 }
 
@@ -3599,6 +3611,22 @@ static int svm_set_msr(struct kvm_vcpu *
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, msr);
 		break;
+	case MSR_IA32_PRED_CMD:
+		if (!msr->host_initiated &&
+		    !guest_cpuid_has_ibpb(vcpu))
+			return 1;
+
+		if (data & ~PRED_CMD_IBPB)
+			return 1;
+
+		if (!data)
+			break;
+
+		wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
+		if (is_guest_mode(vcpu))
+			break;
+		set_msr_interception(svm->msrpm, MSR_IA32_PRED_CMD, 0, 1);
+		break;
 	case MSR_STAR:
 		svm->vmcb->save.star = data;
 		break;
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -550,6 +550,7 @@ struct vcpu_vmx {
 	u64 		      msr_host_kernel_gs_base;
 	u64 		      msr_guest_kernel_gs_base;
 #endif
+
 	u32 vm_entry_controls_shadow;
 	u32 vm_exit_controls_shadow;
 	/*
@@ -911,6 +912,8 @@ static void copy_vmcs12_to_shadow(struct
 static void copy_shadow_to_vmcs12(struct vcpu_vmx *vmx);
 static int alloc_identity_pagetable(struct kvm *kvm);
 static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
+static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
+							  u32 msr, int type);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
@@ -1846,6 +1849,29 @@ static void update_exception_bitmap(stru
 	vmcs_write32(EXCEPTION_BITMAP, eb);
 }
 
+/*
+ * Check if MSR is intercepted for L01 MSR bitmap.
+ */
+static bool msr_write_intercepted_l01(struct kvm_vcpu *vcpu, u32 msr)
+{
+	unsigned long *msr_bitmap;
+	int f = sizeof(unsigned long);
+
+	if (!cpu_has_vmx_msr_bitmap())
+		return true;
+
+	msr_bitmap = to_vmx(vcpu)->vmcs01.msr_bitmap;
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
 static void clear_atomic_switch_msr_special(struct vcpu_vmx *vmx,
 		unsigned long entry, unsigned long exit)
 {
@@ -2255,6 +2281,7 @@ static void vmx_vcpu_load(struct kvm_vcp
 	if (per_cpu(current_vmcs, cpu) != vmx->loaded_vmcs->vmcs) {
 		per_cpu(current_vmcs, cpu) = vmx->loaded_vmcs->vmcs;
 		vmcs_load(vmx->loaded_vmcs->vmcs);
+		indirect_branch_prediction_barrier();
 	}
 
 	if (!already_loaded) {
@@ -3056,6 +3083,33 @@ static int vmx_set_msr(struct kvm_vcpu *
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, msr_info);
 		break;
+	case MSR_IA32_PRED_CMD:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has_ibpb(vcpu))
+			return 1;
+
+		if (data & ~PRED_CMD_IBPB)
+			return 1;
+
+		if (!data)
+			break;
+
+		wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
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
+		 * in the merging.
+		 */
+		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap, MSR_IA32_PRED_CMD,
+					      MSR_TYPE_W);
+		break;
 	case MSR_IA32_CR_PAT:
 		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
 			if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
@@ -9431,9 +9485,23 @@ static inline bool nested_vmx_merge_msr_
 	struct page *page;
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
+	/*
+	 * pred_cmd is trying to verify two things:
+	 *
+	 * 1. L0 gave a permission to L1 to actually passthrough the MSR. This
+	 *    ensures that we do not accidentally generate an L02 MSR bitmap
+	 *    from the L12 MSR bitmap that is too permissive.
+	 * 2. That L1 or L2s have actually used the MSR. This avoids
+	 *    unnecessarily merging of the bitmap if the MSR is unused. This
+	 *    works properly because we only update the L01 MSR bitmap lazily.
+	 *    So even if L0 should pass L1 these MSRs, the L01 bitmap is only
+	 *    updated to reflect this when L1 (or its L2s) actually write to
+	 *    the MSR.
+	 */
+	bool pred_cmd = msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
 
-	/* This shortcut is ok because we support only x2APIC MSRs so far. */
-	if (!nested_cpu_has_virt_x2apic_mode(vmcs12))
+	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
+	    !pred_cmd)
 		return false;
 
 	page = nested_get_page(vcpu, vmcs12->msr_bitmap);
@@ -9466,6 +9534,13 @@ static inline bool nested_vmx_merge_msr_
 				MSR_TYPE_W);
 		}
 	}
+
+	if (pred_cmd)
+		nested_vmx_disable_intercept_for_msr(
+					msr_bitmap_l1, msr_bitmap_l0,
+					MSR_IA32_PRED_CMD,
+					MSR_TYPE_W);
+
 	kunmap(page);
 	nested_release_page_clean(page);
 
