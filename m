Return-Path: <darren.kenny@oracle.com>
X-Google-Smtp-Source: AH8x227SXcQCr+CChBNMPXUGWPaJrk74Wm/lRjPEN5Bizkr5MEF/1MdShFNtZnHEEYn+SniPFgJn
ARC-Seal: i=1; a=rsa-sha256; t=1517569594; cv=none;
        d=google.com; s=arc-20160816;
        b=uYKb4fgSSmsEe4Ih7mfPecyD9cfkPOQO2QCrleQ64HZbSn9QDBLv0kxs7NPSr7nDGn
         06UNTceEqjAfYhkSdOTngxcboLq4EN26txV2Wp/oEimHGadYeJj9TgZz1cLnRrIwUuFc
         i3U9V3iMz1eiQVB3xTv4iWxgb0jK/pL5cLquZl3Bk8006dgbXgSMBiARViZL8sTXYZ13
         kW9k9v0bQyaEuyBvjfxmTE76PPrV7KcBsRxh/ImKMqrPQM35b7FC7Qx9CcWLDvo81LnE
         8rCuSisipNnko4mf677lXPMKyTzh3eEem4bCPk7sdAJ9XUB+KZr7vZRZ4BvICwbdPuGk
         GXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=GxE78pIs0suezjhJzBGsyYXPvRNQ+2cQIDhPYuTErEg=;
        b=mut3PT7FIbV76UkgI+vlteHPG3mBVsnVuxBpnUYWT/CLcD7CSk8FkYF1xd79NEOru8
         FD4d/YVCLIoSmRLdTLUl24fPDKgC7nsKjpUIvIDg/ZMx0ShmulhlHKOIC9CxpOk/9Mgz
         Pw6lKdTIJNL/D4FFYUiA6c/iO96m5fCEpWVFGvsSNCWl2yzasm4WpKY/tBKwM1+qMZNP
         Q0NDmzJyoIy7REyI5JCRG7blQZWTr5v8xhtQ4bXoRUvtFtryyU/iJA1oiTIzBONRqHTx
         n6Vqm0eB+bXsBobhU6bCQTlRe9muua/jsJm7I9smWMc6Re4NjlcQ/eiGQtgsBH45HB3f
         WGsw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Idz5zZKA;
       spf=pass (google.com: domain of darren.kenny@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=darren.kenny@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Idz5zZKA;
       spf=pass (google.com: domain of darren.kenny@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=darren.kenny@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 2 Feb 2018 11:06:14 +0000
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
Subject: Re: [PATCH v6 5/5] KVM: SVM: Allow direct access to
 MSR_IA32_SPEC_CTRL
Message-ID: <20180202110614.fj5focdsthhxy4m7@starbug-vm.ie.oracle.com>
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
 <1517522386-18410-6-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1517522386-18410-6-git-send-email-karahmed@amazon.de>
User-Agent: NeoMutt/20171215
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020136
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237584685742413?=
X-GMAIL-MSGID: =?utf-8?q?1591287055290406943?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 10:59:46PM +0100, KarimAllah Ahmed wrote:
>[ Based on a patch from Paolo Bonzini <pbonzini@redhat.com> ]
>
>... basically doing exactly what we do for VMX:
>
>- Passthrough SPEC_CTRL to guests (if enabled in guest CPUID)
>- Save and restore SPEC_CTRL around VMExit and VMEntry only if the guest
>  actually used it.
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
>v5:
>- Add SPEC_CTRL to direct_access_msrs.
>---
> arch/x86/kvm/svm.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 59 insertions(+)
>
>diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
>index 254eefb..c6ab343 100644
>--- a/arch/x86/kvm/svm.c
>+++ b/arch/x86/kvm/svm.c
>@@ -184,6 +184,9 @@ struct vcpu_svm {
> 		u64 gs_base;
> 	} host;
>
>+	u64 spec_ctrl;
>+	bool save_spec_ctrl_on_exit;
>+
> 	u32 *msrpm;
>
> 	ulong nmi_iret_rip;
>@@ -249,6 +252,7 @@ static const struct svm_direct_access_msrs {
> 	{ .index = MSR_CSTAR,				.always = true  },
> 	{ .index = MSR_SYSCALL_MASK,			.always = true  },
> #endif
>+	{ .index = MSR_IA32_SPEC_CTRL,			.always = false },
> 	{ .index = MSR_IA32_PRED_CMD,			.always = false },
> 	{ .index = MSR_IA32_LASTBRANCHFROMIP,		.always = false },
> 	{ .index = MSR_IA32_LASTBRANCHTOIP,		.always = false },
>@@ -1584,6 +1588,8 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> 	u32 dummy;
> 	u32 eax = 1;
>
>+	svm->spec_ctrl = 0;
>+
> 	if (!init_event) {
> 		svm->vcpu.arch.apic_base = APIC_DEFAULT_PHYS_BASE |
> 					   MSR_IA32_APICBASE_ENABLE;
>@@ -3605,6 +3611,13 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> 	case MSR_VM_CR:
> 		msr_info->data = svm->nested.vm_cr_msr;
> 		break;
>+	case MSR_IA32_SPEC_CTRL:
>+		if (!msr_info->host_initiated &&
>+		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS))
>+			return 1;
>+
>+		msr_info->data = svm->spec_ctrl;
>+		break;
> 	case MSR_IA32_UCODE_REV:
> 		msr_info->data = 0x01000065;
> 		break;
>@@ -3696,6 +3709,30 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
> 	case MSR_IA32_TSC:
> 		kvm_write_tsc(vcpu, msr);
> 		break;
>+	case MSR_IA32_SPEC_CTRL:
>+		if (!msr->host_initiated &&
>+		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS))
>+			return 1;
>+
>+		/* The STIBP bit doesn't fault even if it's not advertised */
>+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
>+			return 1;
>+
>+		svm->spec_ctrl = data;
>+
>+		/*
>+		 * When it's written (to non-zero) for the first time, pass
>+		 * it through. This means we don't have to take the perf
>+		 * hit of saving it on vmexit for the common case of guests
>+		 * that don't use it.
>+		 */
>+		if (data && !svm->save_spec_ctrl_on_exit) {
>+			svm->save_spec_ctrl_on_exit = true;
>+			if (is_guest_mode(vcpu))
>+				break;
>+			set_msr_interception(svm->msrpm, MSR_IA32_SPEC_CTRL, 1, 1);
>+		}
>+		break;
> 	case MSR_IA32_PRED_CMD:
> 		if (!msr->host_initiated &&
> 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBPB))
>@@ -4964,6 +5001,15 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
>
> 	local_irq_enable();
>
>+	/*
>+	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
>+	 * it's non-zero. Since vmentry is serialising on affected CPUs, there
>+	 * is no need to worry about the conditional branch over the wrmsr
>+	 * being speculatively taken.
>+	 */
>+	if (svm->spec_ctrl)
>+		wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
>+
> 	asm volatile (
> 		"push %%" _ASM_BP "; \n\t"
> 		"mov %c[rbx](%[svm]), %%" _ASM_BX " \n\t"
>@@ -5056,6 +5102,19 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
> #endif
> 		);
>
>+	/*
>+	 * We do not use IBRS in the kernel. If this vCPU has used the
>+	 * SPEC_CTRL MSR it may have left it on; save the value and
>+	 * turn it off. This is much more efficient than blindly adding
>+	 * it to the atomic save/restore list. Especially as the former
>+	 * (Saving guest MSRs on vmexit) doesn't even exist in KVM.
>+	 */
>+	if (svm->save_spec_ctrl_on_exit)
>+		rdmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
>+
>+	if (svm->spec_ctrl)
>+		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
>+
> 	/* Eliminate branch target predictions from guest mode */
> 	vmexit_fill_RSB();
>
>-- 
>2.7.4
>
