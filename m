Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4006443-1519425993-2-13544343763355969440
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519425993; b=W/hgf8fAUu6GgtGZSN3wqW5PiVwJge/UJ9H0dmjWBdqfiDy
    NP7i7bS6v2OM/oYH58i3glh0YWIsCf2xbrPyM9dtZ1lFzwN7aC9586lx51iLyCbO
    UAqw7r/OnbEDuoUob+V8Yg9FpJ+79+EDk1BtR37cuDZmSGG8wzmTif3A85QiUTNo
    eQZCydJQHcpD5JM3LMsdvg6clHxWAOSiflQW7Z+qOyOHoF6L5vhsz4N4WwfZY544
    CO6QUcsiBuevfEqGrL9Ng9/x3EIKnXTaxepNNK6bGUfSQcKFMytZdhxhfhGaCGWx
    LImZtGcr0ejEPmIB21G69Mp/YZ00eFlno0YV9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519425993; bh=yG0yUT76ywOFBB2i76D5D3FauSfcupTMYnfp6I0qadY=; b=i
    qPNgNf5iWNabKw5mylV+gNN3tVHk+IqMeTYo7nSJNR5EJjmBuaA4RNMMtRCLnBcP
    sl16TXZ40RrXCdYGnDVgH6hH4UYUM4SdEHk2LonhF3qGGy2mG061syHZZPAns4iA
    wn5ES+/2V8f/zUHyLoDvqymvp/T0Fsd3ykhwnaPVuPKP2Xof6HfLR4Vj1UxQWz2J
    wdNOziNE/KAj8UONpYJEPNLWq22nGf69wrau8LafYHdRw5hTQzGs+Mc7lyuTgIFe
    FFNrTsQXc/5Sf9twHOPmE8qEMRNzeoKDowRAAxoNp0gMrl6bjWqfIfOcrJi/lYIg
    ED/B+BRHrjZduJInqsRNA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeBWWp5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 17:45:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751907AbeBWWp4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 17:45:56 -0500
Subject: Re: [PATCH v2] KVM: x86: fix backward migration with async_PF
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Wanpeng Li <wanpeng.li@hotmail.com>, stable@vger.kernel.org
References: <20180201211621.27371-1-rkrcmar@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <64ee2d55-8a56-bd12-1f4b-9787ab01a93e@redhat.com>
Date: Fri, 23 Feb 2018 23:45:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180201211621.27371-1-rkrcmar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/02/2018 22:16, Radim Krčmář wrote:
> Guests on new hypersiors might set KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT
> bit when enabling async_PF, but this bit is reserved on old hypervisors,
> which results in a failure upon migration.
> 
> To avoid breaking different cases, we are checking for CPUID feature bit
> before enabling the feature and nothing else.
> 
> Fixes: 52a5c155cf79 ("KVM: async_pf: Let guest support delivery of async_pf from guest mode")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> ---
> v2:
> * added documentation [Paolo]
> * retained compatibility recent kernels [Paolo]
> ---
>  Documentation/virtual/kvm/cpuid.txt  | 4 ++++
>  Documentation/virtual/kvm/msr.txt    | 3 ++-
>  arch/x86/include/uapi/asm/kvm_para.h | 1 +
>  arch/x86/kernel/kvm.c                | 8 ++++----
>  arch/x86/kvm/cpuid.c                 | 3 ++-
>  5 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
> index dcab6dc11e3b..87a7506f31c2 100644
> --- a/Documentation/virtual/kvm/cpuid.txt
> +++ b/Documentation/virtual/kvm/cpuid.txt
> @@ -58,6 +58,10 @@ KVM_FEATURE_PV_TLB_FLUSH           ||     9 || guest checks this feature bit
>                                     ||       || before enabling paravirtualized
>                                     ||       || tlb flush.
>  ------------------------------------------------------------------------------
> +KVM_FEATURE_ASYNC_PF_VMEXIT        ||    10 || paravirtualized async PF VM exit
> +                                   ||       || can be enabled by setting bit 2
> +                                   ||       || when writing to msr 0x4b564d02
> +------------------------------------------------------------------------------
>  KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
>                                     ||       || per-cpu warps are expected in
>                                     ||       || kvmclock.
> diff --git a/Documentation/virtual/kvm/msr.txt b/Documentation/virtual/kvm/msr.txt
> index 1ebecc115dc6..f3f0d57ced8e 100644
> --- a/Documentation/virtual/kvm/msr.txt
> +++ b/Documentation/virtual/kvm/msr.txt
> @@ -170,7 +170,8 @@ MSR_KVM_ASYNC_PF_EN: 0x4b564d02
>  	when asynchronous page faults are enabled on the vcpu 0 when
>  	disabled. Bit 1 is 1 if asynchronous page faults can be injected
>  	when vcpu is in cpl == 0. Bit 2 is 1 if asynchronous page faults
> -	are delivered to L1 as #PF vmexits.
> +	are delivered to L1 as #PF vmexits.  Bit 2 can be set only if
> +	KVM_FEATURE_ASYNC_PF_VMEXIT is present in CPUID.
>  
>  	First 4 byte of 64 byte memory location will be written to by
>  	the hypervisor at the time of asynchronous page fault (APF)
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> index 7a2ade4aa235..6cfa9c8cb7d6 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -26,6 +26,7 @@
>  #define KVM_FEATURE_PV_EOI		6
>  #define KVM_FEATURE_PV_UNHALT		7
>  #define KVM_FEATURE_PV_TLB_FLUSH	9
> +#define KVM_FEATURE_ASYNC_PF_VMEXIT	10
>  
>  /* The last 8 bits are used to indicate how to interpret the flags field
>   * in pvclock structure. If no bits are set, all flags are ignored.
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 4e37d1a851a6..971babe964d2 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -341,10 +341,10 @@ static void kvm_guest_cpu_init(void)
>  #endif
>  		pa |= KVM_ASYNC_PF_ENABLED;
>  
> -		/* Async page fault support for L1 hypervisor is optional */
> -		if (wrmsr_safe(MSR_KVM_ASYNC_PF_EN,
> -			(pa | KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT) & 0xffffffff, pa >> 32) < 0)
> -			wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
> +		if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_VMEXIT))
> +			pa |= KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
> +
> +		wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
>  		__this_cpu_write(apf_reason.enabled, 1);
>  		printk(KERN_INFO"KVM setup async PF for cpu %d\n",
>  		       smp_processor_id());
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 20e491b94f44..7fc04a176c57 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -604,7 +604,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  			     (1 << KVM_FEATURE_PV_EOI) |
>  			     (1 << KVM_FEATURE_CLOCKSOURCE_STABLE_BIT) |
>  			     (1 << KVM_FEATURE_PV_UNHALT) |
> -			     (1 << KVM_FEATURE_PV_TLB_FLUSH);
> +			     (1 << KVM_FEATURE_PV_TLB_FLUSH) |
> +			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT);
>  
>  		if (sched_info_on())
>  			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
> 

Queued, thanks.

Paolo
