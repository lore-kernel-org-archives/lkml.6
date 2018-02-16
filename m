Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-268172-1518790777-2-8688600769540667670
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518790776; b=UsORVrdc71OXOzV8bFiS6Ln0iluC4DZdpvbACADccJdlQXs
    k1nQNiZIB5XkM9uysqwT+hMjvxIDv6JFj4casKQY1xwrvQuSSA1fZJEmtUx8fXse
    leXbKQQwx3ya38iAWUS30Kz4JE3U/mZSBIG7qHMJUHRK6hpLDhiTJUN0b8WaWxwM
    XPmGrztdnZcawhLSP+tvzWBx8Z1qGUh62ptUvpsioqF+eV04QWXzRisCCihRyX7m
    WWhkLxy7+lJtUMVSEbUO3yrNR/HPu1azvSR0x2sXDE97vYrqNUVauhQBP3XWNo9V
    jGtCpRCfqVGwI0iz6HOO8L9zbbym3QlNohprHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518790776; bh=AwahgsFMRVIabsovV/brCn95qId8mqkLxauoPRRmWGc=; b=O
    CtiUpSEVGBAPnkU9rpxxHtIUv5G1qHQsNzJSX25r6OUSBVf6J7/1pUJ0EPiTGgjg
    yKNZbjROfemG8iC4XjF7mABvqeuFaNj+SkNsCOKzNZrclCmV3vMgR6PzUEbfiXS6
    1l9YjMmfHJtkULFQmjnKn8mCiFY+A6txXu9xMDmXhgzC3RF8CwAjP8Ri0nL7VRja
    Ci0gRY8jqII5EZK52YUdIutBUEjJhU/ITuwTXS38ks1iejaxhow2OcyBnOFNCfe8
    qR56v7PlyAfH/lKzWa4WUKdkZoIrp+WSBWbAvGTpY4htEcgb7UoIJtlyjQgJCqMJ
    KTh2MJAC4XtjxrlsSfvKA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Bqy5gokf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MNBXOvS9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Bqy5gokf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MNBXOvS9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034069AbeBPOSp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 09:18:45 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35797 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033893AbeBPOSj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 09:18:39 -0500
X-Google-Smtp-Source: AH8x2252Fq6+AYcyzHMe8iTgzQUR2ReRxK6KOPNZVIy0m7VpuvbQw5QrZ1/UiGzDge1zNrzne4ZdyQ==
Subject: Re: [PATCH 7/9] KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
To: David Woodhouse <dwmw@amazon.co.uk>,
        Jim Mattson <jmattson@google.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
 <1517938181-15317-8-git-send-email-dwmw@amazon.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4be4e462-61be-53a9-b0e1-3508466d1645@redhat.com>
Date: Fri, 16 Feb 2018 15:18:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517938181-15317-8-git-send-email-dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06/02/2018 18:29, David Woodhouse wrote:
> From: KarimAllah Ahmed <karahmed@amazon.de>
> 
> Intel processors use MSR_IA32_ARCH_CAPABILITIES MSR to indicate RDCL_NO
> (bit 0) and IBRS_ALL (bit 1). This is a read-only MSR. By default the
> contents will come directly from the hardware, but user-space can still
> override it.

Uhm, taking contents from the hardware is wrong (guess why---live
migration).  I'll send a revert of those two lines.

Paolo

> [dwmw2: The bit in kvm_cpuid_7_0_edx_x86_features can be unconditional]
> 
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jun Nakajima <jun.nakajima@intel.com>
> Cc: kvm@vger.kernel.org
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Asit Mallick <asit.k.mallick@intel.com>
> Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Link: https://lkml.kernel.org/r/1517522386-18410-4-git-send-email-karahmed@amazon.de
> 
> (cherry picked from commit 28c1c9fabf48d6ad596273a11c46e0d0da3e14cd)
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kvm/cpuid.c |  8 +++++++-
>  arch/x86/kvm/cpuid.h |  8 ++++++++
>  arch/x86/kvm/vmx.c   | 15 +++++++++++++++
>  arch/x86/kvm/x86.c   |  1 +
>  4 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 6f24483..9c6493f 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -380,6 +380,10 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  	/* cpuid 7.0.ecx*/
>  	const u32 kvm_cpuid_7_0_ecx_x86_features = F(PKU) | 0 /*OSPKE*/;
>  
> +	/* cpuid 7.0.edx*/
> +	const u32 kvm_cpuid_7_0_edx_x86_features =
> +		F(ARCH_CAPABILITIES);
> +
>  	/* all calls to cpuid_count() should be made on the same cpu */
>  	get_cpu();
>  
> @@ -462,12 +466,14 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  			/* PKU is not yet implemented for shadow paging. */
>  			if (!tdp_enabled || !boot_cpu_has(X86_FEATURE_OSPKE))
>  				entry->ecx &= ~F(PKU);
> +			entry->edx &= kvm_cpuid_7_0_edx_x86_features;
> +			cpuid_mask(&entry->edx, CPUID_7_EDX);
>  		} else {
>  			entry->ebx = 0;
>  			entry->ecx = 0;
> +			entry->edx = 0;
>  		}
>  		entry->eax = 0;
> -		entry->edx = 0;
>  		break;
>  	}
>  	case 9:
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index ec4f9dc..8719997 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -171,6 +171,14 @@ static inline bool guest_cpuid_has_ibpb(struct kvm_vcpu *vcpu)
>  	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
>  }
>  
> +static inline bool guest_cpuid_has_arch_capabilities(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_cpuid_entry2 *best;
> +
> +	best = kvm_find_cpuid_entry(vcpu, 7, 0);
> +	return best && (best->edx & bit(X86_FEATURE_ARCH_CAPABILITIES));
> +}
> +
>  
>  /*
>   * NRIPS is provided through cpuidfn 0x8000000a.edx bit 3
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index dd6c831..92bf61f 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -551,6 +551,8 @@ struct vcpu_vmx {
>  	u64 		      msr_guest_kernel_gs_base;
>  #endif
>  
> +	u64 		      arch_capabilities;
> +
>  	u32 vm_entry_controls_shadow;
>  	u32 vm_exit_controls_shadow;
>  	/*
> @@ -2979,6 +2981,12 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_IA32_TSC:
>  		msr_info->data = guest_read_tsc(vcpu);
>  		break;
> +	case MSR_IA32_ARCH_CAPABILITIES:
> +		if (!msr_info->host_initiated &&
> +		    !guest_cpuid_has_arch_capabilities(vcpu))
> +			return 1;
> +		msr_info->data = to_vmx(vcpu)->arch_capabilities;
> +		break;
>  	case MSR_IA32_SYSENTER_CS:
>  		msr_info->data = vmcs_read32(GUEST_SYSENTER_CS);
>  		break;
> @@ -3110,6 +3118,11 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap, MSR_IA32_PRED_CMD,
>  					      MSR_TYPE_W);
>  		break;
> +	case MSR_IA32_ARCH_CAPABILITIES:
> +		if (!msr_info->host_initiated)
> +			return 1;
> +		vmx->arch_capabilities = data;
> +		break;
>  	case MSR_IA32_CR_PAT:
>  		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
>  			if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
> @@ -5200,6 +5213,8 @@ static int vmx_vcpu_setup(struct vcpu_vmx *vmx)
>  		++vmx->nmsrs;
>  	}
>  
> +	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
> +		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, vmx->arch_capabilities);
>  
>  	vm_exit_controls_init(vmx, vmcs_config.vmexit_ctrl);
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e023ef9..94d1573 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -975,6 +975,7 @@ static u32 msrs_to_save[] = {
>  #endif
>  	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
>  	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
> +	MSR_IA32_ARCH_CAPABILITIES
>  };
>  
>  static unsigned num_msrs_to_save;
> 
