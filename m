Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2060698-1517565867-2-9484487673262174747
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517565867; b=i/oeWsrcmnZ8vxDKC9ETHvDrbPbC7D/KqzobihVBvfCylAE
    I1JnK+TfDv2biA4Gy8XYzR+Q32vO22kWhTh75VVwbekSKFnJf4PdiqwsqfNlgy5f
    bw6tYJsXnz3V7w81P+JEC7/hVJYKOIH9tHqMYyiSfZANEk4IhhEdUuRZd85ea7SY
    H0BekEal6RTWDcs5a0mEUu+mJdIo3CGKxi7qG4E9EJr1d1BESlejfbEwn9zHbZUW
    O14oskb1M1ToKDMDlI08uE2VN3ucvAtf83c9AKogGkm4TFiiqEEoTUPix6MCbd+F
    YbXjGQan6rgRGWPWpYLZTI6Fq5A3wNbXDkUe4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517565867; bh=P12gzHc1Ss2iz431FQMo23T++aFwSfoNSMkuRcx4KkI=; b=F
    FULJ6xm/5NBj53lH4+zBhG+ldLMgHx4E/KYZ531Dvtodhl9aabjAf7+8SqVT7VeC
    xf+ADFpUjAMyGewyrSVvOe8Wc2PtdIdF8r7lvPnS4HhvSn6nuo2FHYU6OP16n9Gv
    oKO4ezLb8Kc08LsoN+iLZqkYNBvmTiMYwfxv5AIBsNOTXafIEw6YAPOInZPr4P6L
    bMq0mgne/JOQW4bQKqd1leZaOS8AFlqytDXBK8ejXgw9E3B8/u/YoW47WquuIA6a
    Hni6NK9wYNWP8amtLtwdwjr1BSyHiO/Oyc0aXMS/W27p2vB1JK9BNPfGwMpwtxZ7
    a9dvZy+xlKHlrvsBsEcYQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeBBKEJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 05:04:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbeBBKEI (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Feb 2018 05:04:08 -0500
Subject: Re: [PATCH v2] KVM: x86: fix backward migration with async_PF
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, stable@vger.kernel.org
References: <20180201211621.27371-1-rkrcmar@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <956a28c7-bafa-bd57-5566-23ab34cd1e65@redhat.com>
Date: Fri, 2 Feb 2018 11:04:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
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

On 01.02.2018 22:16, Radim Krčmář wrote:
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

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
