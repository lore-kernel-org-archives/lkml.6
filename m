Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BA8C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEAF21476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="to4RDxfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEAF21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeINAcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:32:06 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39163 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeINAcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:32:05 -0400
Received: by mail-oi0-f68.google.com with SMTP id c190-v6so10539813oig.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QnIRSSWQVZEzs31+v/Ssk5qhkfLojl4KO9Kw45qcCPo=;
        b=to4RDxfcChh07K+hynoDoOkVrQmfrX9CwlgNUAUt79hZxo1qfzvz+U5cncUgP8+9Ik
         ubJ9PB0NGT9mwwzoRNMOU86hzZTdaHlNC1MiCxtb/5Y+y+CS0AXkA2RXH02wbVZIgTTp
         6jFNZ569jT+hbP95uHPMPrEA5ncAHYBLo4vN5ueCCBRRGh+2qomrhXxjYRaAnwfXuKID
         PTxaCwaxAo3BSS/VDUQ7+lQQ1P+GorwJtaO79FyXt+iQlKFbbpcAhhKe+Cg1k6UsME5N
         cgimkiqT/k256/wajKx2VWouk6sEgCZBlMvCGXW1Ngy167lVKb0nmU15qOiX9nrQa9/a
         OeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QnIRSSWQVZEzs31+v/Ssk5qhkfLojl4KO9Kw45qcCPo=;
        b=kYNKmSShzxMZ0kqCab7Zkt5nocugRJFyCVOXVtEeifCdRpP8M499i+h7DX72+wJoby
         cZSNKo9PyF+gAz3aaXaHKEtcEgBhaL/NcJB6KTUIgpQqx4VyTt3xDJahsb91mltSShpP
         QeK2Kco1TblAUjylHRfmov40OjkWi7nugpGNcEJV37dEfbnV+j0Umhg9aK+0n8jld11h
         B3/spOfy+RNsCCXlBfIPU8VWEZJWN1yJ3nU0H+iXl8Y9loQK/P770wzd3hGuobfDdif6
         81P8/pWP4G5LQTik6bEHS/4BgdMr+cZ9E6vfpGUswwuaQMaeCnjDjyMUXCVTE6FYXk0s
         6M6A==
X-Gm-Message-State: APzg51BGqsVxlNiqm17XI56yqnocs4Hm+XTi2z3BwIKNk/MVemzA76rv
        x6jRPfuGtoUZk9CWwa6Eig/nuwaQDBagqg/bPvjeQA==
X-Google-Smtp-Source: ANB0VdZU4aL8C+cj3uE20d3y6S3Ce+2BKGXad08rPT7NZO8f5tkQAnIzBV3sN18sZZCRD+YDslAgQkRHMYO0msPJUUw=
X-Received: by 2002:aca:f105:: with SMTP id p5-v6mr7751947oih.342.1536866473518;
 Thu, 13 Sep 2018 12:21:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2aea:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 12:21:13
 -0700 (PDT)
In-Reply-To: <20180913170522.24876-10-vkuznets@redhat.com>
References: <20180913170522.24876-1-vkuznets@redhat.com> <20180913170522.24876-10-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 13 Sep 2018 12:21:13 -0700
Message-ID: <CALMp9eTTK67npZLjpCYA=6EPpvF8nZZq7fH=e7NQRhDYXZ=UNQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/12] x86/kvm/nVMX: allow bare VMXON state migration
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Liran Alon <liran.alon@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 10:05 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> It is perfectly valid for a guest to do VMXON and not do VMPTRLD. This
> state needs to be preserved on migration.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index d3297fadf7ed..25a25fff8dd9 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -14482,13 +14482,6 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>         if (!page_address_valid(vcpu, kvm_state->vmx.vmxon_pa))
>                 return -EINVAL;
>
> -       if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
> -               return -EINVAL;
> -
> -       if (kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
> -           !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
> -               return -EINVAL;
> -
>         if ((kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_GUEST_MODE) &&
>             (kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
>                 return -EINVAL;
> @@ -14510,6 +14503,14 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>         if (ret)
>                 return ret;
>
> +       /* Empty 'VMXON' state is permitted */
> +       if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
> +               return 0;

In the original version of this code, the early exit is:

if (kvm_state.vmcs_pa == -1ull)
        return 0;
