Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B1FC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FE120879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FE120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeLNKg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:36:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLNKg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:36:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE764300238C;
        Fri, 14 Dec 2018 10:36:56 +0000 (UTC)
Received: from [10.36.112.72] (ovpn-112-72.ams2.redhat.com [10.36.112.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A98665ED50;
        Fri, 14 Dec 2018 10:36:54 +0000 (UTC)
Subject: Re: [PATCH] x86/hyper-v: Stop caring about EOI for direct stimers
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>
References: <20181205153621.14343-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <60893fd2-5b66-9745-94b7-07a5c272d9f6@redhat.com>
Date:   Fri, 14 Dec 2018 11:36:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181205153621.14343-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 14 Dec 2018 10:36:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/18 16:36, Vitaly Kuznetsov wrote:
> Turns out we over-engineered Direct Mode for stimers a bit: unlike
> traditional stimers where we may want to try to re-inject the message upon
> EOI, Direct Mode stimers just set the irq in APIC and kvm_apic_set_irq()
> fails only when APIC is disabled (see APIC_DM_FIXED case in
> __apic_accept_irq()). Remove the redundant part.
> 
> Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 36 +++---------------------------------
>  1 file changed, 3 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index e6a2a085644a..0a16a77e6ac3 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -56,21 +56,8 @@ static inline int synic_get_sint_vector(u64 sint_value)
>  static bool synic_has_vector_connected(struct kvm_vcpu_hv_synic *synic,
>  				      int vector)
>  {
> -	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
> -	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
> -	struct kvm_vcpu_hv_stimer *stimer;
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++) {
> -		stimer = &hv_vcpu->stimer[i];
> -		if (stimer->config.enable && stimer->config.direct_mode &&
> -		    stimer->config.apic_vector == vector)
> -			return true;
> -	}
> -
> -	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> -		return false;
> -
>  	for (i = 0; i < ARRAY_SIZE(synic->sint); i++) {
>  		if (synic_get_sint_vector(synic_read_sint(synic, i)) == vector)
>  			return true;
> @@ -96,14 +83,14 @@ static bool synic_has_vector_auto_eoi(struct kvm_vcpu_hv_synic *synic,
>  static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
>  				int vector)
>  {
> +	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> +		return;
> +
>  	if (synic_has_vector_connected(synic, vector))
>  		__set_bit(vector, synic->vec_bitmap);
>  	else
>  		__clear_bit(vector, synic->vec_bitmap);
>  
> -	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> -		return;
> -
>  	if (synic_has_vector_auto_eoi(synic, vector))
>  		__set_bit(vector, synic->auto_eoi_bitmap);
>  	else
> @@ -382,9 +369,7 @@ int kvm_hv_synic_set_irq(struct kvm *kvm, u32 vpidx, u32 sint)
>  
>  void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector)
>  {
> -	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
>  	struct kvm_vcpu_hv_synic *synic = vcpu_to_synic(vcpu);
> -	struct kvm_vcpu_hv_stimer *stimer;
>  	int i;
>  
>  	trace_kvm_hv_synic_send_eoi(vcpu->vcpu_id, vector);
> @@ -392,14 +377,6 @@ void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector)
>  	for (i = 0; i < ARRAY_SIZE(synic->sint); i++)
>  		if (synic_get_sint_vector(synic_read_sint(synic, i)) == vector)
>  			kvm_hv_notify_acked_sint(vcpu, i);
> -
> -	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++) {
> -		stimer = &hv_vcpu->stimer[i];
> -		if (stimer->msg_pending && stimer->config.enable &&
> -		    stimer->config.direct_mode &&
> -		    stimer->config.apic_vector == vector)
> -			stimer_mark_pending(stimer, false);
> -	}
>  }
>  
>  static int kvm_hv_set_sint_gsi(struct kvm *kvm, u32 vpidx, u32 sint, int gsi)
> @@ -566,8 +543,6 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *stimer)
>  static int stimer_set_config(struct kvm_vcpu_hv_stimer *stimer, u64 config,
>  			     bool host)
>  {
> -	struct kvm_vcpu *vcpu = stimer_to_vcpu(stimer);
> -	struct kvm_vcpu_hv *hv_vcpu = vcpu_to_hv_vcpu(vcpu);
>  	union hv_stimer_config new_config = {.as_uint64 = config},
>  		old_config = {.as_uint64 = stimer->config.as_uint64};
>  
> @@ -580,11 +555,6 @@ static int stimer_set_config(struct kvm_vcpu_hv_stimer *stimer, u64 config,
>  		new_config.enable = 0;
>  	stimer->config.as_uint64 = new_config.as_uint64;
>  
> -	if (old_config.direct_mode)
> -		synic_update_vector(&hv_vcpu->synic, old_config.apic_vector);
> -	if (new_config.direct_mode)
> -		synic_update_vector(&hv_vcpu->synic, new_config.apic_vector);
> -
>  	stimer_mark_pending(stimer, false);
>  	return 0;
>  }
> 

Queued, thanks.

Paolo
