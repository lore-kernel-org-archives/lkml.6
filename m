Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3100591-1519915031-2-17230285816147285278
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519915031; b=gSXgzJbr9btJQHbL2FCMjYFzRnF00DdB4MyvOiBzFOWRzum
    z8PblfMur10+wbuCFgwWkwAFN9OvvfZV08O/V6ADWuckfXatX79VhsNSVkMCY5P6
    q+Z9+wj+I2h2fJvV7Fo/JPX0Q/ctYuHzf66+TiI7/v5TooJMO6id9c21ImXHi70u
    c7kbKddhifR+m6HH3A071IX+AcDqufQvH/398116GXvLk5irLGb+wcjUkzgg8tZg
    Eempq4jl6IX40WWU+RaiFsC9wFVLqPECmCFiwxGn3Bow0jlYs64oGf1PIWtTI3aI
    d+se4VZ9zULrBcyUZI9G0MDTgiWtsmFO58l1Mzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519915031; bh=HGDK6HXiQKPZx0l4TgWW9qlGdRuh5ldtVIro8/Yye/I=; b=v
    xM3onQdBdJCmNJrHPBRXXfhfVWsimd5c1j8wr0N/7zRvOSL1c/wldxv1X0NaJiKu
    PLJIz4F2XH8e9261aBPsoRH/TqHKDmfh/vi6yHIHKwpIG57fLVz5Tv1W88oHlMU+
    W00yJmpzRNBsP7sxeZlfeG/paes5grc9Xx2ZvSmewd4VLqkssfTScXaJirwb7CWi
    0nQfQ2YnnpdOf8YgFobpU/ls1+D6YuJbN9Y6Q8Z/aPgRXhqwC7DuXzGqPQJKcTYc
    lgv1e4rMjDIkykt3cXow4cYYNByClwlne1QTB5DPzNN9Zdw4yRiiX5QbhX0iIFkX
    jwL7kRxw1RHYfpaAK5XZw==
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
        id S1031270AbeCAOhI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 09:37:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031055AbeCAOhI (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 09:37:08 -0500
Subject: Re: [PATCH] KVM: x86: fix vcpu initialization with userspace lapic
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, stable@vger.kernel.org
References: <20180301142425.18550-1-rkrcmar@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <129f5654-9603-f5ef-7fe8-7f98a3c24eff@redhat.com>
Date: Thu, 1 Mar 2018 15:37:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301142425.18550-1-rkrcmar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/03/2018 15:24, Radim Krčmář wrote:
> Moving the code around broke this rare configuration.
> Use this opportunity to finally call lapic reset from vcpu reset.
> 
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Fixes: 0b2e9904c159 ("KVM: x86: move LAPIC initialization after VMCS creation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> ---
>  arch/x86/kvm/lapic.c | 10 ++++------
>  arch/x86/kvm/x86.c   |  3 ++-
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index cc5fe7a50dde..391dda8d43b7 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2002,14 +2002,13 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
>  
>  void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
>  {
> -	struct kvm_lapic *apic;
> +	struct kvm_lapic *apic = vcpu->arch.apic;
>  	int i;
>  
> -	apic_debug("%s\n", __func__);
> +	if (!apic)
> +		return;
>  
> -	ASSERT(vcpu);
> -	apic = vcpu->arch.apic;
> -	ASSERT(apic != NULL);
> +	apic_debug("%s\n", __func__);
>  
>  	/* Stop the timer in case it's a reset to an active apic */
>  	hrtimer_cancel(&apic->lapic_timer.timer);
> @@ -2568,7 +2567,6 @@ void kvm_apic_accept_events(struct kvm_vcpu *vcpu)
>  
>  	pe = xchg(&apic->pending_events, 0);
>  	if (test_bit(KVM_APIC_INIT, &pe)) {
> -		kvm_lapic_reset(vcpu, true);
>  		kvm_vcpu_reset(vcpu, true);
>  		if (kvm_vcpu_is_bsp(apic->vcpu))
>  			vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1a3ed81031f1..3f96b51d0495 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8123,7 +8123,6 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
>  	kvm_vcpu_mtrr_init(vcpu);
>  	vcpu_load(vcpu);
>  	kvm_vcpu_reset(vcpu, false);
> -	kvm_lapic_reset(vcpu, false);
>  	kvm_mmu_setup(vcpu);
>  	vcpu_put(vcpu);
>  	return 0;
> @@ -8166,6 +8165,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  
>  void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  {
> +	kvm_lapic_reset(vcpu, init_event);
> +
>  	vcpu->arch.hflags = 0;
>  
>  	vcpu->arch.smi_pending = 0;
> 

Much better indeed, thanks.

Paolo
