Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D93C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BAF2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvtyBYCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BAF2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeJKUji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:39:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33079 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeJKUjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:39:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id 78-v6so2024435pfq.0;
        Thu, 11 Oct 2018 06:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARQ1kyEkV52b+OHA2QE2Y8kVu4z8LaZILeKKfpaxozE=;
        b=XvtyBYCEvEZA1V6NmOG2/cZZwPU6eZopSs9xzyHEZuOt+mrz4nVLCTpg4RStj6I+aw
         tAvzJekE52AZyo9eszihTjea9QVaP1pVRVsPJtYj2EYb5u3l1uevl88FlNh/ocAa5uyG
         KHU8rJR5J1txiRsoLjyd8ibEF9czCCzUFTOyu7MvU64BEPKgEk2n0z1/Q7Zz/1xVXqAH
         SohCAUA2HI+Cz5qXra3sY6BiZCBh4IDsNEuNFT/86BcA+Z/ifXhSpGvqz0242Ix78Xxs
         AgzFow9ZZSEjavlFu9oFBZ0+hzmjpJIqnF7ICNMj3v+I/5w53jqd3sZWOJgzdsC1Mu2m
         2Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARQ1kyEkV52b+OHA2QE2Y8kVu4z8LaZILeKKfpaxozE=;
        b=su10Ui1gq69utQndf2T75xP58rW64Nx9fdR5wxS7YgOcdzroZOAPoxsIySXGxdrSXV
         OQ433/lh8UVX/yyd5qXxl/Iu7nb3SzyByQ8YPkl3jLzijAWtaLLjNBbVk921/KNVky1s
         7D6deyh7zuPy2r4f0z1U1wS+66jBikKOkCkOqjYk4j0o1b7HQBDU5zvf/sx+oxOr9pRi
         ZzJqm2gdLdJ/QYpn/BgjJI+tldfaMGJ6Zr5Unc41lWsQAn5anogroYPJZNQOzOi8o6/l
         DqPM2oybk8Zbd/KsYHOkR4WewA/ZnG2Bsk7b9lrHyYh7T1uVOboGr/QNz57aJXCHGT8A
         22Qg==
X-Gm-Message-State: ABuFfog9uYVbmTYdH6sTZ0Yey5MsFt99dw0DzZ+3Z1tiMy6F49GEqm5V
        UEhaqABuAoUy0b5pUQzDoxLnYlB2+3BGMlni9lI=
X-Google-Smtp-Source: ACcGV62s/xeAoK5RACknP0khyWi8xHim8MhbkVInwnRI6hOgHDt1dkr/TpxDscR0RzxEBsKdOgB+RYidgyx1qeqZeBo=
X-Received: by 2002:a63:6bc2:: with SMTP id g185-v6mr1423824pgc.25.1539263548660;
 Thu, 11 Oct 2018 06:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181011100312.4083-1-vkuznets@redhat.com> <CAOLK0pzTzubAcgv3nd_G6pSbB48Xw-ANbCn7+wX0NE1ssDW2Vg@mail.gmail.com>
 <87zhvkpth0.fsf@vitty.brq.redhat.com> <CAOLK0pzL5qvUksKwieoVgsqM9e6Bibu1kKR1kvr96jMMz_RxdQ@mail.gmail.com>
 <87woqopri8.fsf@vitty.brq.redhat.com>
In-Reply-To: <87woqopri8.fsf@vitty.brq.redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Thu, 11 Oct 2018 21:12:17 +0800
Message-ID: <CAOLK0pw+BCZWqR2TC2-6ZY_O4Y2e+=6RjP9D8yRiACfcVL0K7A@mail.gmail.com>
Subject: Re: [PATCH] KVM: vmx: hyper-v: don't pass EPT configuration info to vmx_hv_remote_flush_tlb()
To:     vkuznets@redhat.com
Cc:     kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 9:00 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Tianyu Lan <lantianyu1986@gmail.com> writes:
>
> > On Thu, Oct 11, 2018 at 8:18 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
> >> Tianyu Lan <lantianyu1986@gmail.com> writes:
> >>
> >> > On Thu, Oct 11, 2018 at 6:32 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >> >>
> >> >> I'm observing random crashes in multi-vCPU L2 guests running on KVM on
> >> >> Hyper-V. I bisected the issue to the commit 877ad952be3d ("KVM: vmx: Add
> >> >> tlb_remote_flush callback support"). Hyper-V TLFS states:
> >> >>
> >> >> "AddressSpace specifies an address space ID (an EPT PML4 table pointer)"
> >> >>
> >> >> So apparently, Hyper-V doesn't expect us to pass naked EPTP, only PML4
> >> >> pointer should be used. Strip off EPT configuration information before
> >> >> calling into vmx_hv_remote_flush_tlb().
> >> >
> >> > Hi Vitaly:
> >> > :               Thanks to fix this. Sorry, I didn't meet the issue..
> >> > I think we may just store EPT PML4 table pointer without EPT
> >> > configuration information
> >> > in the ept_pointer field for this case.
> >> >
> >> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> >> > index 619307b3e6bb..e316058b41a6 100644
> >> > --- a/arch/x86/kvm/vmx.c
> >> > +++ b/arch/x86/kvm/vmx.c
> >> > @@ -5379,7 +5379,7 @@ static void vmx_set_cr3(struct kvm_vcpu *vcpu,
> >> > unsigned long cr3)
> >> >
> >> >                 if (kvm_x86_ops->tlb_remote_flush) {
> >> >                         spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
> >> > -                       to_vmx(vcpu)->ept_pointer = eptp;
> >> > +                       to_vmx(vcpu)->ept_pointer = cr3;
> >>
> >> True, we can do that (and I even had a version of my patch doing so)
> >> but 'ept_pointer' will likely need to be renamed as it's not obvious
> >> why vcpu->ept_pointer != eptp.
> >>
> >
> > Yes. that need to rename ept_pointer.
> >
>
> Honestly, I would prefer to keep more information cached, e.g. if
> someone needs EPT configuration data later he can easily get it from
> ept_pointer and by putting raw cr3 there we'll just keep less.
>
Yes, that makes sense.
-- 
Best regards
Tianyu Lan
