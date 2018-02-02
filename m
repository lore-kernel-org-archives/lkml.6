Return-Path: <darren.kenny@oracle.com>
X-Google-Smtp-Source: AH8x227rnBCGuqu2nl7/PjoVFPn85Cgw8RJ28debJ+4Wlb+Zd1ESYqLF4gw/BKThVm36I70BKnml
ARC-Seal: i=1; a=rsa-sha256; t=1517569156; cv=none;
        d=google.com; s=arc-20160816;
        b=Qn+9nCIcEFGSspkBY6w6lHwgkVJPDD5aH/OVpYXRPijftbFeUUCn84dH/SD5EkBtbP
         q+wIRUycK0hvN6C+x8Zl9Px2mMe3RRuGCiNTcekYwKaxbP/FBwJzuDIaHmmtJh82T1v4
         UPjPA/URTci4HemIhcwIMYcPLrZ50pZHVCS7LdwGt7M9JOVDypQ/hJ7+kdGTf1GALtBX
         XZt7r2MHLY0i4yMFs8J/LUnqET4KdSRGB95IL2B0dGSK8GPuScj3uEoJAmiBQZlPwEMp
         Cg+uWYEZcFmoaZ+te5ZN9rpTEqD9TUKhfeXf034T03YboK2VJ/scNS0mnX21+LD8l62N
         RGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=joj3bM1H/58a7sQDLAuwGq9qIicDXHPHAk/DLuUou8o=;
        b=j8DzpBX20Sy1TAJSFoxQ/ZQFWUFB1lM+FiTkWhs9xSgnSooHR/tZ0DCIaPSoJk0Uvd
         BjvMV98I3tCxOoNQMtlPVOHUtpRj+cRwR4QJxat9OLCQlm5C8HQh3tJTcU+R7x0EGz8i
         Jm3P4jJEfuJtsidatMSvTcZZSXksHKeQk9OTgg+PskAx/FmnKnLXYol1MMF/YfFXJUwG
         9wmhzNDwSR05WAqelrvym0aj3WbRrLv1BqFd0H8EGYgo37OPRkbZkg0mOyyKuyYSi3+9
         qHWiJbUUBeOPnsmuXb00KL3c/seEplHF2+MptBJ9tGAAJw/lvetneRZ9mg5JPQzJYagY
         Vjow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=iQEbPoUw;
       spf=pass (google.com: domain of darren.kenny@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=darren.kenny@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=iQEbPoUw;
       spf=pass (google.com: domain of darren.kenny@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=darren.kenny@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 2 Feb 2018 10:53:26 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Asit Mallick <asit.k.mallick@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Ashok Raj <ashok.raj@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v6 3/5] KVM: VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
Message-ID: <20180202105326.v53jv7ry4yd6icm4@starbug-vm.ie.oracle.com>
Mail-Followup-To: KarimAllah Ahmed <karahmed@amazon.de>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ashok Raj <ashok.raj@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-4-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1517522386-18410-4-git-send-email-karahmed@amazon.de>
User-Agent: NeoMutt/20171215
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020135
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582262223506?=
X-GMAIL-MSGID: =?utf-8?q?1591286596258634541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 10:59:44PM +0100, KarimAllah Ahmed wrote:
>Intel processors use MSR_IA32_ARCH_CAPABILITIES MSR to indicate RDCL_NO
>(bit 0) and IBRS_ALL (bit 1). This is a read-only MSR. By default the
>contents will come directly from the hardware, but user-space can still
>override it.
>
>[dwmw2: The bit in kvm_cpuid_7_0_edx_x86_features can be unconditional]
>
>Cc: Asit Mallick <asit.k.mallick@intel.com>
>Cc: Dave Hansen <dave.hansen@intel.com>
>Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
>Cc: Tim Chen <tim.c.chen@linux.intel.com>
>Cc: Linus Torvalds <torvalds@linux-foundation.org>
>Cc: Andrea Arcangeli <aarcange@redhat.com>
>Cc: Andi Kleen <ak@linux.intel.com>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Jun Nakajima <jun.nakajima@intel.com>
>Cc: Andy Lutomirski <luto@kernel.org>
>Cc: Greg KH <gregkh@linuxfoundation.org>
>Cc: Paolo Bonzini <pbonzini@redhat.com>
>Cc: Ashok Raj <ashok.raj@intel.com>
>Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
>Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> arch/x86/kvm/cpuid.c |  2 +-
> arch/x86/kvm/vmx.c   | 15 +++++++++++++++
> arch/x86/kvm/x86.c   |  1 +
> 3 files changed, 17 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>index 033004d..1909635 100644
>--- a/arch/x86/kvm/cpuid.c
>+++ b/arch/x86/kvm/cpuid.c
>@@ -394,7 +394,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>
> 	/* cpuid 7.0.edx*/
> 	const u32 kvm_cpuid_7_0_edx_x86_features =
>-		F(AVX512_4VNNIW) | F(AVX512_4FMAPS);
>+		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(ARCH_CAPABILITIES);
>
> 	/* all calls to cpuid_count() should be made on the same cpu */
> 	get_cpu();
>diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>index 263eb1f..b13314a 100644
>--- a/arch/x86/kvm/vmx.c
>+++ b/arch/x86/kvm/vmx.c
>@@ -593,6 +593,8 @@ struct vcpu_vmx {
> 	u64 		      msr_guest_kernel_gs_base;
> #endif
>
>+	u64 		      arch_capabilities;
>+
> 	u32 vm_entry_controls_shadow;
> 	u32 vm_exit_controls_shadow;
> 	u32 secondary_exec_control;
>@@ -3262,6 +3264,12 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> 	case MSR_IA32_TSC:
> 		msr_info->data = guest_read_tsc(vcpu);
> 		break;
>+	case MSR_IA32_ARCH_CAPABILITIES:
>+		if (!msr_info->host_initiated &&
>+		    !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
>+			return 1;
>+		msr_info->data = to_vmx(vcpu)->arch_capabilities;
>+		break;
> 	case MSR_IA32_SYSENTER_CS:
> 		msr_info->data = vmcs_read32(GUEST_SYSENTER_CS);
> 		break;
>@@ -3397,6 +3405,11 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> 		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap, MSR_IA32_PRED_CMD,
> 					      MSR_TYPE_W);
> 		break;
>+	case MSR_IA32_ARCH_CAPABILITIES:
>+		if (!msr_info->host_initiated)
>+			return 1;
>+		vmx->arch_capabilities = data;
>+		break;
> 	case MSR_IA32_CR_PAT:
> 		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
> 			if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
>@@ -5659,6 +5672,8 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
> 		++vmx->nmsrs;
> 	}
>
>+	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
>+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, vmx->arch_capabilities);
>
> 	vm_exit_controls_init(vmx, vmcs_config.vmexit_ctrl);
>
>diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>index c53298d..4ec142e 100644
>--- a/arch/x86/kvm/x86.c
>+++ b/arch/x86/kvm/x86.c
>@@ -1009,6 +1009,7 @@ static u32 msrs_to_save[] = {
> #endif
> 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
> 	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
>+	MSR_IA32_ARCH_CAPABILITIES
> };
>
> static unsigned num_msrs_to_save;
>-- 
>2.7.4
>
