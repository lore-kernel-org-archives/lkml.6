Return-Path: <prvs=56348445f=karahmed@amazon.de>
X-Google-Smtp-Source: AH8x227jGjSXOONhCJdC5KOg93KwQga1R2KgD15GBYbl+nH24cxdqxEjGGiy6rSbXx7/KOJUK91t
ARC-Seal: i=1; a=rsa-sha256; t=1517444938; cv=none;
        d=google.com; s=arc-20160816;
        b=NMLj+ngH+p2I10qjVKPQlUKOw2rthQBn5yjV0wNlrv+utgss9YcKt2kFAXAPe547CK
         O3ISCiLHGNDsk9R9KKimdxqwaQ/QbRB3+PmNbCrz/YDZP+1/wDy+NYKvKMYunv1UQzcZ
         ckDLw5yJwG8msms1SNTw6RW0vy/Jk/ndih1K7eqRuziFGDjDe6xzVM6v68P+3TZUw23D
         HpgxvcJsawVcAF1x292us5fzZL5P2CjfSIntBlRKiMuZStJCBB//0jmJYmvwfzH2XsTo
         nGUCL/YyXGmp39QHu20PizWvKzBnYJf2iKurItK+KsjZgqPhGGUMDMEQSOuLF63zm/HS
         sGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=V6Bih04q3Ys/4pTsGq0oZhoDiNvpyBDMHczjRqJczcE=;
        b=AJZbnVTQwfk3VwypdML1ODLoftmQtrgRIB9+UjEEuF9ImBIPGFym/qa6zpPx5+ZuY0
         0i5bfFaGqfYXzvkIz0tNLKXDNCeR/uDbSsLDI3ZA1jDaQDutwe+N7HjyCpwlhTHA7sGc
         3eReBLCmnjj6efMOczmjV+AsO6pV9u1IWUvDWzUL0la7N0NQBrRiZaWqr0/9lEMeaaNm
         o/1YI/Ld2PhQ8UNo/3XIurTD+WfDnnkRVI5bvZu4WNQ8uUMY1KVvEsOx+P7pBJ+Tvqc3
         YrfUeGoI+IJzPfqfWvn06Sx+UHvIGy8CaPvdTJxcwuAgB/qt7HzTFmuhKsIoTgMjfn6S
         ZUkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amazon.com header.s=amazon201209 header.b=bwBArsnN;
       spf=pass (google.com: domain of prvs=56348445f=karahmed@amazon.de designates 207.171.190.10 as permitted sender) smtp.mailfrom=prvs=56348445f=karahmed@amazon.de;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amazon.com header.s=amazon201209 header.b=bwBArsnN;
       spf=pass (google.com: domain of prvs=56348445f=karahmed@amazon.de designates 207.171.190.10 as permitted sender) smtp.mailfrom=prvs=56348445f=karahmed@amazon.de;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.com
X-Amazon-filename: 0002-KVM-x86-Add-IBPB-support.patch
X-IronPort-AV: E=Sophos;i="5.46,442,1511827200";
   d="scan'208,223";a="717716919"
Subject: Re: [PATCH v5 2/5] KVM: x86: Add IBPB support
To: Jim Mattson <jmattson@google.com>, David Woodhouse <dwmw2@infradead.org>
CC: KarimAllah Ahmed <karahmed@amazon.de>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers
	<x86@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Asit Mallick
	<asit.k.mallick@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Arjan Van
 De Ven" <arjan.van.de.ven@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli
	<aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nakajima
	<jun.nakajima@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH
	<gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Peter
 Zijlstra" <peterz@infradead.org>
References: <1517427467-28567-1-git-send-email-karahmed@amazon.de>
 <1517427467-28567-3-git-send-email-karahmed@amazon.de>
 <CALMp9eTNyjrQLViYkopsHp57saQwjNRnMTJt_pZVsaFvaUS9tQ@mail.gmail.com>
 <1517428398.18619.197.camel@infradead.org>
 <CALMp9eS25UwLM_ScfyuJ0BsUeLhM_cyfSQfFgJEQSdqFjVj-XQ@mail.gmail.com>
From: KarimAllah Ahmed <karahmed@amazon.com>
Message-ID: <c8e0975d-a7f6-8130-a970-c49eedb25773@amazon.com>
Date: Thu, 1 Feb 2018 01:27:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eS25UwLM_ScfyuJ0BsUeLhM_cyfSQfFgJEQSdqFjVj-XQ@mail.gmail.com>
Content-Type: multipart/mixed;
	boundary="------------D41975B490A2E466640D6590"
Content-Language: en-US
X-Originating-IP: [10.43.160.193]
X-ClientProxiedBy: EX13D06UWA001.ant.amazon.com (10.43.160.220) To
 EX13D01EUB003.ant.amazon.com (10.43.166.248)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591138068251830751?=
X-GMAIL-MSGID: =?utf-8?q?1591156343415170608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--------------D41975B490A2E466640D6590
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMDEvMzEvMjAxOCAwODo1NSBQTSwgSmltIE1hdHRzb24gd3JvdGU6Cj4gT24gV2VkLCBKYW4g
MzEsIDIwMTggYXQgMTE6NTMgQU0sIERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9y
Zz4gd3JvdGU6Cj4+IFJhdGhlciB0aGFuIGRvaW5nIHRoZSBleHBlbnNpdmUgZ3Vlc3RfY3B1X2hh
cygpIGV2ZXJ5IHRpbWUgKHdoaWNoIGlzCj4+IHdvcnNlIG5vdyBhcyB3ZSByZWFsaXNlZCB3ZSBu
ZWVkIHR3byBvZiB0aGVtKSBwZXJoYXBzIHdlIHNob3VsZAo+PiBpbnRyb2R1Y2UgYSBsb2NhbCBm
bGFnIGZvciB0aGF0IHRvbz8KPiAKPiBUaGF0IHNvdW5kcyBnb29kIHRvIG1lLgo+IAoKRG9uZS4K
QW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKQmVybGluIC0gRHJlc2RlbiAt
IEFhY2hlbgptYWluIG9mZmljZTogS3JhdXNlbnN0ci4gMzgsIDEwMTE3IEJlcmxpbgpHZXNjaGFl
ZnRzZnVlaHJlcjogRHIuIFJhbGYgSGVyYnJpY2gsIENocmlzdGlhbiBTY2hsYWVnZXIKVXN0LUlE
OiBERTI4OTIzNzg3OQpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyBI
UkIgMTQ5MTczIEIK

--------------D41975B490A2E466640D6590
Content-Type: text/x-patch; name="0002-KVM-x86-Add-IBPB-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-KVM-x86-Add-IBPB-support.patch"

>From d51391ae3667f85cd1d6160e83c1d6c28b47b7d8 Mon Sep 17 00:00:00 2001
From: Ashok Raj <ashok.raj@intel.com>
Date: Thu, 11 Jan 2018 17:32:19 -0800
Subject: [PATCH] KVM: x86: Add IBPB support

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

Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1515720739-43819-6-git-send-email-ashok.raj@intel.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v6:
- introduce pred_cmd_used

v5:
- Use MSR_TYPE_W instead of MSR_TYPE_R for the MSR.
- Always merge the bitmaps unconditionally.
- Add PRED_CMD to direct_access_msrs.
- Also check for X86_FEATURE_SPEC_CTRL for the msr reads/writes
- rewrite the commit message (from ashok.raj@)
---
 arch/x86/kvm/cpuid.c | 11 ++++++++++-
 arch/x86/kvm/svm.c   | 28 ++++++++++++++++++++++++++++
 arch/x86/kvm/vmx.c   | 42 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index c0eb337..033004d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -365,6 +365,10 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 		F(3DNOWPREFETCH) | F(OSVW) | 0 /* IBS */ | F(XOP) |
 		0 /* SKINIT, WDT, LWP */ | F(FMA4) | F(TBM);
 
+	/* cpuid 0x80000008.ebx */
+	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
+		F(IBPB);
+
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_cpuid_C000_0001_edx_x86_features =
 		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
@@ -625,7 +629,12 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
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
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f40d0da..bfbb7b9 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -250,6 +250,7 @@ static const struct svm_direct_access_msrs {
 	{ .index = MSR_SYSCALL_MASK,			.always = true  },
 #endif
 	{ .index = MSR_IA32_LASTBRANCHFROMIP,		.always = false },
+	{ .index = MSR_IA32_PRED_CMD,			.always = false },
 	{ .index = MSR_IA32_LASTBRANCHTOIP,		.always = false },
 	{ .index = MSR_IA32_LASTINTFROMIP,		.always = false },
 	{ .index = MSR_IA32_LASTINTTOIP,		.always = false },
@@ -529,6 +530,7 @@ struct svm_cpu_data {
 	struct kvm_ldttss_desc *tss_desc;
 
 	struct page *save_area;
+	struct vmcb *current_vmcb;
 };
 
 static DEFINE_PER_CPU(struct svm_cpu_data *, svm_data);
@@ -1703,11 +1705,17 @@ static void svm_free_vcpu(struct kvm_vcpu *vcpu)
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
@@ -1736,6 +1744,10 @@ static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (static_cpu_has(X86_FEATURE_RDTSCP))
 		wrmsrl(MSR_TSC_AUX, svm->tsc_aux);
 
+	if (sd->current_vmcb != svm->vmcb) {
+		sd->current_vmcb = svm->vmcb;
+		indirect_branch_prediction_barrier();
+	}
 	avic_vcpu_load(vcpu, cpu);
 }
 
@@ -3684,6 +3696,22 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, msr);
 		break;
+	case MSR_IA32_PRED_CMD:
+		if (!msr->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_IBPB))
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
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index d46a61b..c057a0a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -592,6 +592,14 @@ struct vcpu_vmx {
 	u64 		      msr_host_kernel_gs_base;
 	u64 		      msr_guest_kernel_gs_base;
 #endif
+
+	/*
+	 * This indicates that:
+	 * 1) guest_cpuid_has(X86_FEATURE_IBPB) = true &&
+	 * 2) The guest has initiated a write against the MSR.
+	 */
+	bool pred_cmd_used;
+
 	u32 vm_entry_controls_shadow;
 	u32 vm_exit_controls_shadow;
 	u32 secondary_exec_control;
@@ -2285,6 +2293,7 @@ static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (per_cpu(current_vmcs, cpu) != vmx->loaded_vmcs->vmcs) {
 		per_cpu(current_vmcs, cpu) = vmx->loaded_vmcs->vmcs;
 		vmcs_load(vmx->loaded_vmcs->vmcs);
+		indirect_branch_prediction_barrier();
 	}
 
 	if (!already_loaded) {
@@ -3342,6 +3351,28 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, msr_info);
 		break;
+	case MSR_IA32_PRED_CMD:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_IBPB) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
+			return 1;
+
+		vmx->pred_cmd_used = true;
+
+		if (data & ~PRED_CMD_IBPB)
+			return 1;
+
+		if (!data)
+			break;
+
+		wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
+
+		if (is_guest_mode(vcpu))
+			break;
+
+		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap, MSR_IA32_PRED_CMD,
+					      MSR_TYPE_W);
+		break;
 	case MSR_IA32_CR_PAT:
 		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
 			if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
@@ -10045,8 +10076,8 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
 
-	/* This shortcut is ok because we support only x2APIC MSRs so far. */
-	if (!nested_cpu_has_virt_x2apic_mode(vmcs12))
+	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
+	    !to_vmx(vcpu)->pred_cmd_used)
 		return false;
 
 	page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->msr_bitmap);
@@ -10079,6 +10110,13 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
 				MSR_TYPE_W);
 		}
 	}
+
+	if (to_vmx(vcpu)->pred_cmd_used)
+		nested_vmx_disable_intercept_for_msr(
+					msr_bitmap_l1, msr_bitmap_l0,
+					MSR_IA32_PRED_CMD,
+					MSR_TYPE_W);
+
 	kunmap(page);
 	kvm_release_page_clean(page);
 
-- 
2.7.4


--------------D41975B490A2E466640D6590--
