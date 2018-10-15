Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86215C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433012089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXFm5w1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433012089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJPAzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:55:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35924 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeJPAzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:55:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so20356544wmf.1;
        Mon, 15 Oct 2018 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UaeSn5o7MU44vYPB0/mPq0TGml9+BOlwsrBznXi9V20=;
        b=mXFm5w1p+AQdj7yfSY2y9WjwePAux/Rk4xqO7sS7qEagAcCJbEVjiCP0mBwJZHkCvs
         4nxaQ+iJxt165hhS0fVWUOQOFTz3dwc5guzc6VRRIpLr01JaKH1IvR8Oiodsd9YBNg1E
         BOPS03yEmD3UifMbSOMQVNIWZp24yVjssPkqa6J0CYFAM5+Fo9ylgYNdznqv5Tbcx8dg
         j47Fa2Iza8ean3VeeKhVnhCW1e4aaGRu6sfgWFR+5jDzScnSNBb6RBSITrQQzbkJkmpt
         TL0IYMxOFzKOAlIaqcqZY/5mgZgfCFkyvB3nShS7+VBIYg6fWkNNIc9Q0xxzcVsY/6bn
         9aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UaeSn5o7MU44vYPB0/mPq0TGml9+BOlwsrBznXi9V20=;
        b=BhMUmjnyG4jEr0AYFijHNTwwpl45qTj9rEsYk6D1Ebb9L0Hlz6b56vn1Q9Z6VP5gZF
         CwemlfKvnQksPG7I0X8tvQPF1w5o25fy1OKP/WiUHg+gpE1j9KVeGrJS0nryVnnlw7Z/
         L9f+ifIk6+qQZ3imLFyZz9vUBdBgThhGAE6vQZLYDiVwun8xzzvl+x69ncnD56hf/+QN
         yHIvZHbiwWUm7XgFKDs5vNTutcfJK0SL56MFgVDU1rC42KcxtmwPqOpc+F8+Ts81PDiq
         oW06Wigxtu1M37P+x09G7WYD351OMOOZ27Ox8mC67sfQ0J3osTqGf07wYHQfMqeN9u5G
         IAoA==
X-Gm-Message-State: ABuFfohbgNMyh/nXcOOIW+L0b9WOqm123MDW+Abg2cu8+NOO13b1YRn6
        rERcfnnIh5Wd6wSZplKI8Dq6f5Hq
X-Google-Smtp-Source: ACcGV61/yC2LgFywZN/PUfPUQEA71OPkJ15T+mKUY07n8PoK7Y9Ujjx2NGTH1IZ4aA0AHdG6UNZKbA==
X-Received: by 2002:a1c:b9cf:: with SMTP id j198-v6mr13435274wmf.57.1539623378985;
        Mon, 15 Oct 2018 10:09:38 -0700 (PDT)
Received: from [192.168.10.150] (dynamic-adsl-78-12-228-118.clienti.tiscali.it. [78.12.228.118])
        by smtp.googlemail.com with ESMTPSA id a5-v6sm8794602wmh.8.2018.10.15.10.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 10:09:38 -0700 (PDT)
Subject: Re: [PATCH v5 09/12] x86/kvm/nVMX: allow bare VMXON state migration
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20180913170522.24876-1-vkuznets@redhat.com>
 <20180913170522.24876-10-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <8d6b85c4-16c6-cbde-22ec-ee61df0c49fd@redhat.com>
Date:   Mon, 15 Oct 2018 19:09:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180913170522.24876-10-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2018 19:05, Vitaly Kuznetsov wrote:
> It is perfectly valid for a guest to do VMXON and not do VMPTRLD. This
> state needs to be preserved on migration.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Please cover this in state-test.c too.

Paolo

> ---
>  arch/x86/kvm/vmx.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index d3297fadf7ed..25a25fff8dd9 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -14482,13 +14482,6 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>  	if (!page_address_valid(vcpu, kvm_state->vmx.vmxon_pa))
>  		return -EINVAL;
>  
> -	if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
> -		return -EINVAL;
> -
> -	if (kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
> -	    !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
> -		return -EINVAL;
> -
>  	if ((kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_GUEST_MODE) &&
>  	    (kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
>  		return -EINVAL;
> @@ -14510,6 +14503,14 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>  	if (ret)
>  		return ret;
>  
> +	/* Empty 'VMXON' state is permitted */
> +	if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
> +		return 0;
> +
> +	if (kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
> +	    !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
> +		return -EINVAL;
> +
>  	set_current_vmptr(vmx, kvm_state->vmx.vmcs_pa);
>  
>  	if (kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON) {
> 

