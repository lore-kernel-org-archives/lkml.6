Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-69599-1517508604-2-4077368449218971558
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
    t=1517508604; b=OiV3eAeUJ4ElUgRAmAMK3/T2WOEfHeqn9cmLZJWJ0X/AEKr
    vu3ivjQNBYyDTzzsgy/I8rYXoNjNB3/RqNBduFOk6UpAPQabQSh2nf0cNAMgrgvH
    cx7WNGJiQzAtQt+o4rGRqRBKVRCCQE7yJ2tiWewuqRuACXZ8zI+QL/feqbqxu+m+
    ZOep7QhBzdEUgE07ywKw3o74CrMFRv6E0F5Qep+AvfklZDC9LNOXBzaH3Y/LZhzW
    xpp1lq1gJSNQJKK2dnb+bIusqF6+ucLHFSPk17RR7Ju7AziCfOp1jw76CAEmyDQX
    MjOIV705bPxBnI8WkWI50ijGVgtdDD+Nc5UgrRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517508604; bh=4X04sxJOsgfyByZSMiHQHi71bF0E+QnBLWvOVXRHjG4=; b=J
    Rm7WKoiUJLLdNmcJ55Wi1zAxIY2g/eroxBclDyRrsPveb8AaTBtcKXkKtlslrXhE
    k4XSVZYyavBkPeIei8Ti2oIaQ6ZUDvfqDUPMTAB36++bFjJdH4jWIy9BMbMTuuT3
    8vhJeFp6TtVr4Equbfp9xJxSbPhQhE4fWzwzFFTSDje1KmpSA3vsDCNMJqCrq2qA
    SVBYELYJzF7wK8FiRMOmHxPczvpB/Vux5Xv2dzND+yFWMbb/EOcP4Bp8W6uOmkwv
    RTSMPi0ys661MmYW2mDv2hBeSQbEc9kCS2w2UlJLbKvs1JT7eiIm/+FCu6jQ3IYG
    NmH4jt9JZVqx8Kgmb62rA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeBASKB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 13:10:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeBASKA (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Feb 2018 13:10:00 -0500
Subject: Re: [PATCH] KVM: x86: fix backward migration with async_PF
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Wanpeng Li <wanpeng.li@hotmail.com>, stable@vger.kernel.org
References: <20180201175022.25011-1-rkrcmar@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4fa9a87-cc4e-73d6-e248-192ab167b2c2@redhat.com>
Date: Thu, 1 Feb 2018 13:09:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180201175022.25011-1-rkrcmar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/02/2018 12:50, Radim Krčmář wrote:
> Guests on new hypersiors might set KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT
> bit when enabling async_PF, but this bit is reserved on old hypervisors,
> which results in a failure upon migration.
> 
> Guests at least expect that KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT might not
> be present when booting, so we allow userspace to handle migration
> compatibility by adding a KVM CPUID flag that determines the presence of
> KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT.
> 
> Fixes: 52a5c155cf79 ("KVM: async_pf: Let guest support delivery of async_pf from guest mode")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>

This has to be documented in Documentation/virtual/kvm/cpuid.txt.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4c3103f449a3..c16740a06f0c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2139,8 +2139,10 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>  {
>  	gpa_t gpa = data & ~0x3f;
>  
> -	/* Bits 3:5 are reserved, Should be zero */
> -	if (data & 0x38)
> +	/* Bits 3:5 are reserved, Should be zero. */
> +	if (data & 0x38 ||
> +	    (data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT &&
> +	     !guest_kvm_cpuid_has(vcpu, KVM_FEATURE_ASYNC_PF_VMEXIT)))
>  		return 1;
>  
>  	vcpu->arch.apf.msr_val = data;
> 

This check will break migration if the source guest and host both have
the recent kernels which support KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT, so
I am not sure about it.  Otherwise, the patch is okay!

Thanks,

Paolo
