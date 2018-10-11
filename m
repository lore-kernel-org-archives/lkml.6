Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6FEC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8632064A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlz0IgR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8632064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeJKUIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:08:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43814 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeJKUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:08:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id p24-v6so4355551pff.10;
        Thu, 11 Oct 2018 05:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mCWKvxQA4AJ14W7qbT9TVTTMmqQdSidyQPvphhaD1HQ=;
        b=Tlz0IgR5n5TtXf4E8Sgox6qmJwy0mF1RRXjBIk6n2ImEgHJz9rigZdxKKXZubNbUlS
         N6Xw27kQgx3k0Fd7yHOkB9iMFyi6b9XwX4vUdSFU/cQONwd7YZBLgtl1Yiiscbet8fg6
         TQ2ndz+Yeuvp8uHDXbrJI369645YFkj2AaIgaxvhCg+Wys5abn22maqqOLUpDlV0/fRF
         YU+ZxImjtFrMpuHP7CyPzkbPeu8lIW5cG7sV2/ZP40VB1J5s9lukPGFLSZOXCRB4P57k
         8D9xf0UtuxSmIAsoHyJSxwnKxu1UX+mK6EysWUrlS5ggYFjjPBA7snX056kNQwVvOTEB
         WPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mCWKvxQA4AJ14W7qbT9TVTTMmqQdSidyQPvphhaD1HQ=;
        b=nVl1soyrJI7fyqTnCAb6yKuR+A3dqiegsEWSZ/cvhVPXZPZq6ZdE/6aUUrVmq9aZnL
         vLLrvetEm9zFi7qg5wmZBQz7oYZyhWsujuDHiyXLphDea0Bsx+ZiAnpjmE63OAcvvFQ1
         hG+ZSrDptO0jaLbLvVTDJ6v2dmKb4zAGc0paqScYtUpo4EN0kmZmuJcLVeU9wORQP/+/
         kgk17OHqcEXxwzw8AsXUdQcIGJvG7TcJIeNFPsF0LQiXuWCmzUOfo+v+fBpeSPgvvE1y
         8EPZxVmmf8Jz5c8cq+H9vpXPQnkZ7lT4Q82eGBWbe7NKbt7K3K539TjIaPSWMfclJVzv
         Jm/w==
X-Gm-Message-State: ABuFfoghS10Fl5FXYxjJaZAwqTnbzCPNfS7OQ2C7iKCpRvmXJsM9Wl6f
        XrUSyfU7zdk6SwMkJmOi3g5/OSJPOeK61mINLTPAawezViw=
X-Google-Smtp-Source: ACcGV61KoiV9IxI6bHozv9o7rZhS8QbrReGbQ3k+2/ywa2bhbx+OKqLqxa+q1Wqi1h+MSyAcQmsWmFW9BMkSgtMMRjY=
X-Received: by 2002:aa7:8281:: with SMTP id s1-v6mr1401776pfm.63.1539261695191;
 Thu, 11 Oct 2018 05:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181011100312.4083-1-vkuznets@redhat.com> <CAOLK0pzTzubAcgv3nd_G6pSbB48Xw-ANbCn7+wX0NE1ssDW2Vg@mail.gmail.com>
 <87zhvkpth0.fsf@vitty.brq.redhat.com>
In-Reply-To: <87zhvkpth0.fsf@vitty.brq.redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Thu, 11 Oct 2018 20:41:23 +0800
Message-ID: <CAOLK0pzL5qvUksKwieoVgsqM9e6Bibu1kKR1kvr96jMMz_RxdQ@mail.gmail.com>
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

On Thu, Oct 11, 2018 at 8:18 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Tianyu Lan <lantianyu1986@gmail.com> writes:
>
> > On Thu, Oct 11, 2018 at 6:32 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
> >> I'm observing random crashes in multi-vCPU L2 guests running on KVM on
> >> Hyper-V. I bisected the issue to the commit 877ad952be3d ("KVM: vmx: Add
> >> tlb_remote_flush callback support"). Hyper-V TLFS states:
> >>
> >> "AddressSpace specifies an address space ID (an EPT PML4 table pointer)"
> >>
> >> So apparently, Hyper-V doesn't expect us to pass naked EPTP, only PML4
> >> pointer should be used. Strip off EPT configuration information before
> >> calling into vmx_hv_remote_flush_tlb().
> >
> > Hi Vitaly:
> > :               Thanks to fix this. Sorry, I didn't meet the issue..
> > I think we may just store EPT PML4 table pointer without EPT
> > configuration information
> > in the ept_pointer field for this case.
> >
> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > index 619307b3e6bb..e316058b41a6 100644
> > --- a/arch/x86/kvm/vmx.c
> > +++ b/arch/x86/kvm/vmx.c
> > @@ -5379,7 +5379,7 @@ static void vmx_set_cr3(struct kvm_vcpu *vcpu,
> > unsigned long cr3)
> >
> >                 if (kvm_x86_ops->tlb_remote_flush) {
> >                         spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
> > -                       to_vmx(vcpu)->ept_pointer = eptp;
> > +                       to_vmx(vcpu)->ept_pointer = cr3;
>
> True, we can do that (and I even had a version of my patch doing so)
> but 'ept_pointer' will likely need to be renamed as it's not obvious
> why vcpu->ept_pointer != eptp.
>

Yes. that need to rename ept_pointer.

> Alternatively, we can filter lower 12 bits out in
> hyperv_flush_guest_mapping() but I would rename 'as' parameter to eptp
> then.

OK. I got it. Thanks.
-- 
Best regards
Tianyu Lan
