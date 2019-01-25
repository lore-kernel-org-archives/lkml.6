Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B694C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B232184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfAYLni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:43:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39374 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYLnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:43:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so6312059wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lvFku0OL96YmAbhj1sD055gcNlw8rQvCs5uklBfkcFo=;
        b=RhuMW2g0+EAVgJXhkvtlueMjEC3pUfy8oAHiyUgdVffLoFeScw8c18BLnOPw8bsPD1
         t6RjuiyblX8tS5xmXea7GqotLGYViz0IUwGnhS5uj/D4gtFeMpgZzfuvBVlj5NX9sCO9
         Q5i45Phul0exexy8ZZzzPQChVTNxT0RsQ/TXA6Lb7v03cQQpp9KRvQHKhtA5ktgg1PAo
         lpf6bNm1T6W8/r7wRFMx/SX9OvDIyjNGjpc5EI5IjxRSW5pvPgpX0FnQ9le317B9D6HJ
         7CSWaHnIUMJa2nIME9GEuaiZPnAQw7SrbaiCTm6grBJVOny7iT9fiG4cn7qpRTHLUJ2h
         qUDg==
X-Gm-Message-State: AJcUukdQ89mW/QiSJJRZRTpbHBHZg68NBMQqT3WChYtLinXa2Rvwa+Gc
        0DxfKCfZue65yKYfNOnTFaASRGE8xfIwiw==
X-Google-Smtp-Source: ALg8bN6ILADsp9Wp1Z2x8HYAB7dDAYasgddz7NYhPkk4szKvmPUg51mtwr7IZ8+h4pJNYOMYTfOFkA==
X-Received: by 2002:a1c:1902:: with SMTP id 2mr6758735wmz.150.1548416615868;
        Fri, 25 Jan 2019 03:43:35 -0800 (PST)
Received: from vitty.brq.redhat.com ([147.229.117.36])
        by smtp.gmail.com with ESMTPSA id o3sm80990614wrs.30.2019.01.25.03.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:43:35 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/kvm/hyper-v: recommend using eVMCS only when it is enabled
In-Reply-To: <20190125111934.28782-3-vkuznets@redhat.com>
References: <20190125111934.28782-1-vkuznets@redhat.com> <20190125111934.28782-3-vkuznets@redhat.com>
Date:   Fri, 25 Jan 2019 12:43:33 +0100
Message-ID: <87h8dxnesa.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> We shouldn't probably be suggesting using Enlightened VMCS when it's not
> enabled (not supported from guest's point of view). Hyper-V on KVM seems
> to be fine either way but let's be consistent.
>

Fixes: 2bc39970e932 ("x86/kvm/hyper-v: Introduce KVM_GET_SUPPORTED_HV_CPUID")

is missing here. Hope it can be added upon commit.

> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 4840f5b3c88f..4730fcaa70cf 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1850,7 +1850,8 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  			ent->eax |= HV_X64_RELAXED_TIMING_RECOMMENDED;
>  			ent->eax |= HV_X64_CLUSTER_IPI_RECOMMENDED;
>  			ent->eax |= HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED;
> -			ent->eax |= HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
> +			if (evmcs_ver)
> +				ent->eax |= HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
>  
>  			/*
>  			 * Default number of spinlock retry attempts, matches

-- 
Vitaly
