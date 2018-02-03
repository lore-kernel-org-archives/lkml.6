Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x227d+q4gzZDTsmWzfwvxUIPl2DMFmxikFhvsvnNH8Yle6uRBzVm+ADkW+q4jw+exnWPGNwxe
ARC-Seal: i=1; a=rsa-sha256; t=1517698498; cv=none;
        d=google.com; s=arc-20160816;
        b=xSx6wgr7QKpZ5IAKEE9F9bnOJG02pvUU3GUa6UJdelImNylziSeSDcBVBVAN78YNhp
         SVVvumunR1NH9PdQaeG5Yn2bfc4gmlqmDA9hW6VOKShqD6Rdd+roBAWIeiO8Slbk5Dem
         We6RX6YDyiq0CmOHlEpbXIXYNDZIHWQqpWyQn/9FELEvBraTn5rd3BgFP2tr1xRIwuCr
         eX0DP0GMP6M8EG8gycvXZouZGpqPgS6+o4i9aBnTh9Ua22hy9pgsvuau1YIZiYdziJLZ
         vfClF0PRMNO94eGfCRU8ySOgTDY/OoxKf9vOcRRpB9YQG9rsOPvIBbZaW1I61sVA5IIT
         S8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=SzJc+NY3CpiRnhK9mXIsdLNK35xHGtDR4zzpxMoISx4=;
        b=OwRNOj7w6MMZuwxtOdUurhAf0ia94WbFJ4WUBgbhVLljs0fY4kiShPjCo+fY3gz+vZ
         MEGOhThpqEvSYWvbbQKJufjqxNkl9jHh7+jBkpNC0A6JWtW+Us0e+wQ1BeUGWE268lcU
         Wul5S+1CLSH3w4GkmykLnKxL4XPClc2agDyBuAXxqNrStFn7HHE6ihQe1pjbXN0pj5Mn
         rKtsHgz5WF9DhLCdjOHq1hDM5ojWC4XO0s8u90xVg8xI03vlWIPaGxlNlA/u78ggzJOw
         FqRD+ShmAGhqquG7Q6HsJTCmzbu0dw1X8v7kTuCMpNLa0xVCaGdt4GsN1Gdac/OaDaCo
         pXEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 65.50.211.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 65.50.211.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sat, 3 Feb 2018 14:51:47 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for KarimAllah Ahmed <tipbot@zytor.com>
Message-ID: <tip-d28b387fb74da95d69d2615732f50cceb38e9a4d@git.kernel.org>
Cc: dave.hansen@intel.com, ak@linux.intel.com, ashok.raj@intel.com,
        darren.kenny@oracle.com, pbonzini@redhat.com,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        dwmw@amazon.co.uk, jun.nakajima@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        arjan.van.de.ven@intel.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, jmattson@google.com, karahmed@amazon.de,
        luto@kernel.org, asit.k.mallick@intel.com, hpa@zytor.com,
        aarcange@redhat.com, tim.c.chen@linux.intel.com
Reply-To: tim.c.chen@linux.intel.com, aarcange@redhat.com, jmattson@google.com,
        luto@kernel.org, karahmed@amazon.de, asit.k.mallick@intel.com,
        hpa@zytor.com, arjan.van.de.ven@intel.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        jun.nakajima@intel.com, dwmw@amazon.co.uk, ak@linux.intel.com,
        ashok.raj@intel.com, darren.kenny@oracle.com, pbonzini@redhat.com,
        dave.hansen@intel.com
In-Reply-To: <1517522386-18410-5-git-send-email-karahmed@amazon.de>
References: <1517522386-18410-5-git-send-email-karahmed@amazon.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL
Git-Commit-ID: d28b387fb74da95d69d2615732f50cceb38e9a4d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591422220389385539?=
X-GMAIL-MSGID: =?utf-8?q?1591422220389385539?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  d28b387fb74da95d69d2615732f50cceb38e9a4d
Gitweb:     https://git.kernel.org/tip/d28b387fb74da95d69d2615732f50cceb38e9a4d
Author:     KarimAllah Ahmed <karahmed@amazon.de>
AuthorDate: Thu, 1 Feb 2018 22:59:45 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 3 Feb 2018 23:06:52 +0100

KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL

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

---
 arch/x86/kvm/cpuid.c |   9 +++--
 arch/x86/kvm/vmx.c   | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c   |   2 +-
 3 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 1909635..13f5d42 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -367,7 +367,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(IBPB);
+		F(IBPB) | F(IBRS);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_cpuid_C000_0001_edx_x86_features =
@@ -394,7 +394,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(ARCH_CAPABILITIES);
+		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
+		F(ARCH_CAPABILITIES);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
@@ -630,9 +631,11 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
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
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index e5f75eb..bee4c49 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -595,6 +595,7 @@ struct vcpu_vmx {
 #endif
 
 	u64 		      arch_capabilities;
+	u64 		      spec_ctrl;
 
 	u32 vm_entry_controls_shadow;
 	u32 vm_exit_controls_shadow;
@@ -1911,6 +1912,29 @@ static void update_exception_bitmap(struct kvm_vcpu *vcpu)
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
@@ -3262,6 +3286,14 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_TSC:
 		msr_info->data = guest_read_tsc(vcpu);
 		break;
+	case MSR_IA32_SPEC_CTRL:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
+			return 1;
+
+		msr_info->data = to_vmx(vcpu)->spec_ctrl;
+		break;
 	case MSR_IA32_ARCH_CAPABILITIES:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
@@ -3375,6 +3407,37 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, msr_info);
 		break;
+	case MSR_IA32_SPEC_CTRL:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
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
 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBPB) &&
@@ -5700,6 +5763,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	u64 cr0;
 
 	vmx->rmode.vm86_active = 0;
+	vmx->spec_ctrl = 0;
 
 	vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
 	kvm_set_cr8(vcpu, 0);
@@ -9371,6 +9435,15 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 
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
@@ -9489,6 +9562,27 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
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
 
@@ -10113,7 +10207,7 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
 	/*
-	 * pred_cmd is trying to verify two things:
+	 * pred_cmd & spec_ctrl are trying to verify two things:
 	 *
 	 * 1. L0 gave a permission to L1 to actually passthrough the MSR. This
 	 *    ensures that we do not accidentally generate an L02 MSR bitmap
@@ -10126,9 +10220,10 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
 	 *    the MSR.
 	 */
 	bool pred_cmd = msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
+	bool spec_ctrl = msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
 
 	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
-	    !pred_cmd)
+	    !pred_cmd && !spec_ctrl)
 		return false;
 
 	page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->msr_bitmap);
@@ -10162,6 +10257,12 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
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
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4ec142e..ac38143 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1009,7 +1009,7 @@ static u32 msrs_to_save[] = {
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
-	MSR_IA32_ARCH_CAPABILITIES
+	MSR_IA32_SPEC_CTRL, MSR_IA32_ARCH_CAPABILITIES
 };
 
 static unsigned num_msrs_to_save;
