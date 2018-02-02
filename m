Return-Path: <darren.kenny@oracle.com>
X-Google-Smtp-Source: AH8x226nJ76SlxSn0sC//2hXb8axWUFj0XOjPD4Sn1yk2f0tvIHd2s1HOhNwyWRqkwtTo3moTnDf
ARC-Seal: i=1; a=rsa-sha256; t=1517569420; cv=none;
        d=google.com; s=arc-20160816;
        b=znZEkBk8WlFsTR7ZUcY3rY49SJvAgzWFebdHYIj5riOby2KopatrlZTVoSVN1BUTxX
         XtWI7ryI4yp3JIt/tYwEAOdKl4gCwJDGK1nxHDl92WHD9tlYtkzTVC5gBMgalMsMSgVm
         uWksPSnjMsjsUPmzIm8DZkAya6xBWrlsGDXbT9gPA8R74ns8tpw5WgkgX9lLGrDSB21X
         qXUxNUDNDzIEaVPpj4jAzKqAaz4V6dhJ/A7Z8/DtuL3+BkjYSQIRFpRA0FZbZKD47ZI5
         nlJ/o8yzAMsBflGAOkD18jWHdg3njg6uUOuzIwiDWgCmeZ2UB5gLE8SqeY40kNiMcNmm
         r7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=+EwcOHR6YUtTj6rVaFEKBHG8zoG2xryzMF82GsygzmE=;
        b=ZFp7ebmOctVwdhG47bIDM3axxyn5UhhQex+JVMU8RKCxqDDGR2WDiRzDtHQCssNocQ
         NU8NfT3u8wehwrG0bOEdbkSFJPauv01GEzIfZU2RH32VLTbtg8N8XD7gDVQ2SA7wbfd/
         CsMiuaX60/l8UufJU9uvOGFFfCrklkdfbH8Zr7JJkqepCP6OtE8KhrnB6c+6VJo0Z5oB
         Bf5ie8iN3vOKzqsR46t66otn9MIAv69OaTwMh/ALpW0K4dJ5S7iiLuF/lRt52AsAZnw7
         2sbkGrNCiGuQH+zKG6MuvdPCJsOQ46Qeuu0UcBEYLWewg5qwaDk3+3Gz4kCFUUsFbltE
         qoWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=OAuW4C8u;
       spf=pass (google.com: domain of darren.kenny@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=darren.kenny@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=OAuW4C8u;
       spf=pass (google.com: domain of darren.kenny@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=darren.kenny@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 2 Feb 2018 11:03:18 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v6 4/5] KVM: VMX: Allow direct access to
 MSR_IA32_SPEC_CTRL
Message-ID: <20180202110318.mxacgr52zya2dqk5@starbug-vm.ie.oracle.com>
Mail-Followup-To: KarimAllah Ahmed <karahmed@amazon.de>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Greg KH <gregkh@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>, Ashok Raj <ashok.raj@intel.com>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-5-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1517522386-18410-5-git-send-email-karahmed@amazon.de>
User-Agent: NeoMutt/20171215
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020136
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237580461918240?=
X-GMAIL-MSGID: =?utf-8?q?1591286872168103477?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 10:59:45PM +0100, KarimAllah Ahmed wrote:
>[ Based on a patch from Ashok Raj <ashok.raj@intel.com> ]
>
>Add direct access to MSR_IA32_SPEC_CTRL for guests. This is needed for
>guests that will only mitigate Spectre V2 through IBRS+IBPB and will not
>be using a retpoline+IBPB based approach.
>
>To avoid the overhead of saving and restoring the MSR_IA32_SPEC_CTRL for
>guests that do not actually use the MSR, only start saving and restoring
>when a non-zero is written to it.
>
>No attempt is made to handle STIBP here, intentionally. Filtering STIBP
>may be added in a future patch, which may require trapping all writes
>if we don't want to pass it through directly to the guest.
>
>[dwmw2: Clean up CPUID bits, save/restore manually, handle reset]
>
>Cc: Asit Mallick <asit.k.mallick@intel.com>
>Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
>Cc: Dave Hansen <dave.hansen@intel.com>
>Cc: Andi Kleen <ak@linux.intel.com>
>Cc: Andrea Arcangeli <aarcange@redhat.com>
>Cc: Linus Torvalds <torvalds@linux-foundation.org>
>Cc: Tim Chen <tim.c.chen@linux.intel.com>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Jun Nakajima <jun.nakajima@intel.com>
>Cc: Paolo Bonzini <pbonzini@redhat.com>
>Cc: David Woodhouse <dwmw@amazon.co.uk>
>Cc: Greg KH <gregkh@linuxfoundation.org>
>Cc: Andy Lutomirski <luto@kernel.org>
>Cc: Ashok Raj <ashok.raj@intel.com>
>Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
>Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
>v6:
>- got rid of save_spec_ctrl_on_exit
>- introduce msr_write_intercepted
>v5:
>- Also check for X86_FEATURE_SPEC_CTRL for the msr reads/writes
>v4:
>- Add IBRS to kvm_cpuid_8000_0008_ebx_x86_features
>- Handling nested guests
>v3:
>- Save/restore manually
>- Fix CPUID handling
>- Fix a copy & paste error in the name of SPEC_CTRL MSR in
>  disable_intercept.
>- support !cpu_has_vmx_msr_bitmap()
>v2:
>- remove 'host_spec_ctrl' in favor of only a comment (dwmw@).
>- special case writing '0' in SPEC_CTRL to avoid confusing live-migration
>  when the instance never used the MSR (dwmw@).
>- depend on X86_FEATURE_IBRS instead of X86_FEATURE_SPEC_CTRL (dwmw@).
>- add MSR_IA32_SPEC_CTRL to the list of MSRs to save (dropped it by accident).
>---
> arch/x86/kvm/cpuid.c |   9 +++--
> arch/x86/kvm/vmx.c   | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> arch/x86/kvm/x86.c   |   2 +-
> 3 files changed, 110 insertions(+), 6 deletions(-)
>
>diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>index 1909635..13f5d42 100644
>--- a/arch/x86/kvm/cpuid.c
>+++ b/arch/x86/kvm/cpuid.c
>@@ -367,7 +367,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>
> 	/* cpuid 0x80000008.ebx */
> 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
>-		F(IBPB);
>+		F(IBPB) | F(IBRS);
>
> 	/* cpuid 0xC0000001.edx */
> 	const u32 kvm_cpuid_C000_0001_edx_x86_features =
>@@ -394,7 +394,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>
> 	/* cpuid 7.0.edx*/
> 	const u32 kvm_cpuid_7_0_edx_x86_features =
>-		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(ARCH_CAPABILITIES);
>+		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
>+		F(ARCH_CAPABILITIES);
>
> 	/* all calls to cpuid_count() should be made on the same cpu */
> 	get_cpu();
>@@ -630,9 +631,11 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
> 			g_phys_as = phys_as;
> 		entry->eax = g_phys_as | (virt_as << 8);
> 		entry->edx = 0;
>-		/* IBPB isn't necessarily present in hardware cpuid */
>+		/* IBRS and IBPB aren't necessarily present in hardware cpuid */
> 		if (boot_cpu_has(X86_FEATURE_IBPB))
> 			entry->ebx |= F(IBPB);
>+		if (boot_cpu_has(X86_FEATURE_IBRS))
>+			entry->ebx |= F(IBRS);
> 		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
> 		cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
> 		break;
>diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>index b13314a..5d8a6a91 100644
>--- a/arch/x86/kvm/vmx.c
>+++ b/arch/x86/kvm/vmx.c
>@@ -594,6 +594,7 @@ struct vcpu_vmx {
> #endif
>
> 	u64 		      arch_capabilities;
>+	u64 		      spec_ctrl;
>
> 	u32 vm_entry_controls_shadow;
> 	u32 vm_exit_controls_shadow;
>@@ -1913,6 +1914,29 @@ static void update_exception_bitmap(struct kvm_vcpu *vcpu)
> }
>
> /*
>+ * Check if MSR is intercepted for currently loaded MSR bitmap.
>+ */
>+static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
>+{
>+	unsigned long *msr_bitmap;
>+	int f = sizeof(unsigned long);
>+
>+	if (!cpu_has_vmx_msr_bitmap())
>+		return true;
>+
>+	msr_bitmap = to_vmx(vcpu)->loaded_vmcs->msr_bitmap;
>+
>+	if (msr <= 0x1fff) {
>+		return !!test_bit(msr, msr_bitmap + 0x800 / f);
>+	} else if ((msr >= 0xc0000000) && (msr <= 0xc0001fff)) {
>+		msr &= 0x1fff;
>+		return !!test_bit(msr, msr_bitmap + 0xc00 / f);
>+	}
>+
>+	return true;
>+}
>+
>+/*
>  * Check if MSR is intercepted for L01 MSR bitmap.
>  */
> static bool msr_write_intercepted_l01(struct kvm_vcpu *vcpu, u32 msr)
>@@ -3264,6 +3288,14 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> 	case MSR_IA32_TSC:
> 		msr_info->data = guest_read_tsc(vcpu);
> 		break;
>+	case MSR_IA32_SPEC_CTRL:
>+		if (!msr_info->host_initiated &&
>+		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
>+		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
>+			return 1;
>+
>+		msr_info->data = to_vmx(vcpu)->spec_ctrl;
>+		break;
> 	case MSR_IA32_ARCH_CAPABILITIES:
> 		if (!msr_info->host_initiated &&
> 		    !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
>@@ -3377,6 +3409,37 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> 	case MSR_IA32_TSC:
> 		kvm_write_tsc(vcpu, msr_info);
> 		break;
>+	case MSR_IA32_SPEC_CTRL:
>+		if (!msr_info->host_initiated &&
>+		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
>+		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
>+			return 1;
>+
>+		/* The STIBP bit doesn't fault even if it's not advertised */
>+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
>+			return 1;
>+
>+		vmx->spec_ctrl = data;
>+
>+		if (!data)
>+			break;
>+
>+		/*
>+		 * For non-nested:
>+		 * When it's written (to non-zero) for the first time, pass
>+		 * it through.
>+		 *
>+		 * For nested:
>+		 * The handling of the MSR bitmap for L2 guests is done in
>+		 * nested_vmx_merge_msr_bitmap. We should not touch the
>+		 * vmcs02.msr_bitmap here since it gets completely overwritten
>+		 * in the merging. We update the vmcs01 here for L1 as well
>+		 * since it will end up touching the MSR anyway now.
>+		 */
>+		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap,
>+					      MSR_IA32_SPEC_CTRL,
>+					      MSR_TYPE_RW);
>+		break;
> 	case MSR_IA32_PRED_CMD:
> 		if (!msr_info->host_initiated &&
> 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBPB) &&
>@@ -5702,6 +5765,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> 	u64 cr0;
>
> 	vmx->rmode.vm86_active = 0;
>+	vmx->spec_ctrl = 0;
>
> 	vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
> 	kvm_set_cr8(vcpu, 0);
>@@ -9373,6 +9437,15 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>
> 	vmx_arm_hv_timer(vcpu);
>
>+	/*
>+	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
>+	 * it's non-zero. Since vmentry is serialising on affected CPUs, there
>+	 * is no need to worry about the conditional branch over the wrmsr
>+	 * being speculatively taken.
>+	 */
>+	if (vmx->spec_ctrl)
>+		wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
>+
> 	vmx->__launched = vmx->loaded_vmcs->launched;
> 	asm(
> 		/* Store host registers */
>@@ -9491,6 +9564,27 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
> #endif
> 	      );
>
>+	/*
>+	 * We do not use IBRS in the kernel. If this vCPU has used the
>+	 * SPEC_CTRL MSR it may have left it on; save the value and
>+	 * turn it off. This is much more efficient than blindly adding
>+	 * it to the atomic save/restore list. Especially as the former
>+	 * (Saving guest MSRs on vmexit) doesn't even exist in KVM.
>+	 *
>+	 * For non-nested case:
>+	 * If the L01 MSR bitmap does not intercept the MSR, then we need to
>+	 * save it.
>+	 *
>+	 * For nested case:
>+	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
>+	 * save it.
>+	 */
>+	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
>+		rdmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
>+
>+	if (vmx->spec_ctrl)
>+		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
>+
> 	/* Eliminate branch target predictions from guest mode */
> 	vmexit_fill_RSB();
>
>@@ -10115,7 +10209,7 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
> 	unsigned long *msr_bitmap_l1;
> 	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
> 	/*
>-	 * pred_cmd is trying to verify two things:
>+	 * pred_cmd & spec_ctrl are trying to verify two things:
> 	 *
> 	 * 1. L0 gave a permission to L1 to actually passthrough the MSR. This
> 	 *    ensures that we do not accidentally generate an L02 MSR bitmap
>@@ -10128,9 +10222,10 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
> 	 *    the MSR.
> 	 */
> 	bool pred_cmd = msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
>+	bool spec_ctrl = msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
>
> 	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
>-	    !pred_cmd)
>+	    !pred_cmd && !spec_ctrl)
> 		return false;
>
> 	page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->msr_bitmap);
>@@ -10164,6 +10259,12 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
> 		}
> 	}
>
>+	if (spec_ctrl)
>+		nested_vmx_disable_intercept_for_msr(
>+					msr_bitmap_l1, msr_bitmap_l0,
>+					MSR_IA32_SPEC_CTRL,
>+					MSR_TYPE_R | MSR_TYPE_W);
>+
> 	if (pred_cmd)
> 		nested_vmx_disable_intercept_for_msr(
> 					msr_bitmap_l1, msr_bitmap_l0,
>diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>index 4ec142e..ac38143 100644
>--- a/arch/x86/kvm/x86.c
>+++ b/arch/x86/kvm/x86.c
>@@ -1009,7 +1009,7 @@ static u32 msrs_to_save[] = {
> #endif
> 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
> 	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
>-	MSR_IA32_ARCH_CAPABILITIES
>+	MSR_IA32_SPEC_CTRL, MSR_IA32_ARCH_CAPABILITIES
> };
>
> static unsigned num_msrs_to_save;
>-- 
>2.7.4
>
