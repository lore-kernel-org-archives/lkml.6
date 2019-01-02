Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673FCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C99218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ntjaD1bY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfABTNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:13:00 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50813 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfABTNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:13:00 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so42311050iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 11:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DxiKtlIHAhkgNNg05/mUflt9Sx4jQ1d5b+1aFFOaVuY=;
        b=ntjaD1bYNE645HP+pBJIDDGvgIUI0vFDX51I1M4LaixKUQ3NpSAKDT/meFxgR0tH1f
         cbIF2cESSDiM629j8W33ZjqbdVTndZptZcyrxTCensqJJzpxK0j+tobxwplXnbZE7STo
         HG6/pGEwCchCA27w1Xy++FImmIChLC5a2bwx18LxxRdFW6w/aicsKTYm3WYbalhXcVrv
         /RGQAt3rTmoUiTgPdS8pdj3sHUKyy+6Mdh6AGPXjEiy1Fw9uskI11mTBftq7pQGaQb35
         BwHjY9lQkbATGe1U72PQw12W/tu3m5rWYLavadnmPlHwO4s7VJZgJjUpBP9C6iyItvve
         5/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxiKtlIHAhkgNNg05/mUflt9Sx4jQ1d5b+1aFFOaVuY=;
        b=QLzs0FjVrBYpH8Td9Dh7S4U4dF9rz1fXxRpOXCYauDarkPDmDr/Ps+jJFisA9tJQ4U
         0xoh49PNjgnddxuLekiGZLj0GuXOKjAonrSyf9y2CyeYqUXL9TjrYdpYtMnaplbo36Qr
         4f7zbdVXwsI96bSzuk1NXkeA1jE+pozXTwvGlxQI3h6+H089SfuxAWjOFudpBmkk+KB5
         hj8cXavZnsGACoc5QGDliSJqBAHhPQLe4tMX7lvBzd32CNrB5pgDs5R0Ehi85692bHmX
         ju3WayryByJDEv2exYNq8BK1twkUrDQZ0ZoiDT8DEZlqwDNOPJGBLz7tBC2O0yFF9ING
         6fgQ==
X-Gm-Message-State: AA+aEWb+DsG3Dwp6Kto4wnOft9zyomziSQivyRUQDRl/d6UdpBltwzUb
        03AJy4hlEGC/eiUvm73N+LrRXakvYAvG+GhDw0eGog==
X-Google-Smtp-Source: AFSGD/XbTyqqdciq/uxjBX6W2+rnrNdFBHJXagl1M0UgT5P+YW9JqNpAGcUPG7Q01aThVyLw2mpn8XwjV6COvOTrm2Q=
X-Received: by 2002:a24:4a95:: with SMTP id k143mr28237775itb.77.1546456378478;
 Wed, 02 Jan 2019 11:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20181226081532.30698-1-weijiang.yang@intel.com> <20181226081532.30698-5-weijiang.yang@intel.com>
In-Reply-To: <20181226081532.30698-5-weijiang.yang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 2 Jan 2019 11:12:47 -0800
Message-ID: <CALMp9eTNG5eWL2WkaF0nkTbfGgE8YjrEfQoFSZ9x64d9kGdWbw@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] kvm:vmx Pass through host CET related MSRs to Guest.
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, yu-cheng.yu@intel.com,
        yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 12:13 AM Yang Weijiang <weijiang.yang@intel.com> wrote:
>
> During Guest OS execution, it accesses these MSRs to
> configure CET runtime settings.
>
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 25fa6bd2fb95..fa2db6248404 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -11550,6 +11550,13 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
>         vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_CS, MSR_TYPE_RW);
>         vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_ESP, MSR_TYPE_RW);
>         vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_EIP, MSR_TYPE_RW);
> +
> +       vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_U_CET, MSR_TYPE_RW);
> +       vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_S_CET, MSR_TYPE_RW);
> +       vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_INT_SSP_TAB, MSR_TYPE_RW);
> +       vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_PL0_SSP, MSR_TYPE_RW);
> +       vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_PL3_SSP, MSR_TYPE_RW);
> +

Shouldn't this be conditional on the guest having CET support
enumerated in CPUID?

>         vmx->msr_bitmap_mode = 0;
>
>         vmx->loaded_vmcs = &vmx->vmcs01;
> --
> 2.17.1
>
