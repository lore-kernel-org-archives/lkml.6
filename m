Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE7BC6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 13:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1C720652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 13:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4QK1ccb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1C720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeJNVCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 17:02:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34698 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeJNVCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 17:02:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id f18-v6so8004919plr.1;
        Sun, 14 Oct 2018 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3p7rOh3EHCcs5xJhBdJ9os0FBYpeHAf7F1aAnqF/f30=;
        b=M4QK1ccb/idnXeaKqj+Ewbkhcgm7CdlXT/yTIpkXgaATox26SQJltMaTvHPGPG79xb
         8FdicVlinm6TH9QQZywahbCsqU2Qo2cEeNF/BnNBRbcLzSuKYDeFaDlRsj9PNMtQl5/u
         ZX4AYSOkwd0qBIZSPiNXtPkByaFmv+vy/1D1182c0mcu5ApITPdk/hdFU1kMcAg5ZMkg
         VsR+cVaH4ChJ8jYBsBoXC7i04fwmIuiOlMYd8Hl4YZnQbq7dclEzhNcqcApiQBoSECiM
         GrKvFRQUSNqIOucytr38BPo65LejZNhIRfZwDzWlLHOw8Mlxuq6P6JkUPEi+BT/bzRTj
         FQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3p7rOh3EHCcs5xJhBdJ9os0FBYpeHAf7F1aAnqF/f30=;
        b=jHXvbbnZnZpS1f6ZgpisjJ9mfYXH1tDZrV/sWMb1ShpmR2v/vxO+oc9DKH6eiUnQy/
         xLhgY9FeI3WhruBpPfX5wsMBx/PDF/cLvy58IZEJ0Nv/AehefFKgjCC00JN6KCPXZB2x
         Q0med2EbGJpRACBJ4SZ23HB6xUyFtx+bCQ3YM/9rqj1hQDEebXUoMGcEcgzPtWz8ZJT0
         pPGSd32fqmUbYH4sA1pqtFXr5A6sy/mCBVhWld4PhUC2zwiHB9YNdzXOoURTV0vIv4fn
         FFzr7+YEKYHs8JVo3KLdEBE3pwQGATsO0B9YKonkTOeFtbkMqT2p0YkybrlcbF+Wbawg
         tG7Q==
X-Gm-Message-State: ABuFfoiDMXBlhHGuS1BfXpsVTGpt20fAT2TraNNmlCnN4S6ludI9bsmW
        c7GX0nDwgXjJ+1aVtTy7TE5ydsbS6WtotCkN5R6q0EBsGax6Tw==
X-Google-Smtp-Source: ACcGV60Bsdv+2lbefbGLxTexZhfM8a9SDOpaKx+exqAsk4LqnWktEAF8KcHNub/RKj7H2PyE8ha/L2lfpnhhtHYxQ0w=
X-Received: by 2002:a17:902:da4:: with SMTP id 33-v6mr12916512plv.172.1539523294880;
 Sun, 14 Oct 2018 06:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com> <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
 <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
 <20181014092734.GV30658@n2100.armlinux.org.uk> <20181014093541.GW30658@n2100.armlinux.org.uk>
In-Reply-To: <20181014093541.GW30658@n2100.armlinux.org.uk>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Sun, 14 Oct 2018 21:21:23 +0800
Message-ID: <CAOLK0pzHAc1ipDbd3Trg2W_Gb_DxdEKM2ML5Fk09u0-O8y6UAg@mail.gmail.com>
Subject: Re: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
To:     linux@armlinux.org.uk
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org,
        linux@armlinux.org, kvm <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, benh@kernel.crashing.org,
        will.deacon@arm.com, christoffer.dall@arm.com, paulus@ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
        kvmarm@lists.cs.columbia.edu, sthemmin@microsoft.com,
        mpe@ellerman.id.au, "the arch/x86 maintainers" <x86@kernel.org>,
        michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>,
        catalin.marinas@arm.com, jhogan@kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
        haiyangz@microsoft.com, kvm-ppc@vger.kernel.org,
        liran.alon@oracle.com, Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        ralf@linux-mips.org, paul.burton@mips.com,
        devel@linuxdriverproject.org, vkuznets@redhat.com,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell:
              Thanks for your review.

On Sun, Oct 14, 2018 at 5:36 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Sun, Oct 14, 2018 at 10:27:34AM +0100, Russell King - ARM Linux wrote:
> > On Sun, Oct 14, 2018 at 10:16:56AM +0200, Thomas Gleixner wrote:
> > > On Sun, 14 Oct 2018, Liran Alon wrote:
> > > > > On 13 Oct 2018, at 17:53, lantianyu1986@gmail.com wrote:
> > > > >
> > > > > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > > > >
> > > > > This patch is to add wrapper functions for tlb_remote_flush_with_=
range
> > > > > callback.
> > > > >
> > > > > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > > > > ---
> > > > > Change sicne V3:
> > > > >       Remove code of updating "tlbs_dirty"
> > > > > Change since V2:
> > > > >       Fix comment in the kvm_flush_remote_tlbs_with_range()
> > > > > ---
> > > > > arch/x86/kvm/mmu.c | 40 ++++++++++++++++++++++++++++++++++++++++
> > > > > 1 file changed, 40 insertions(+)
> > > > >
> > > > > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > > > > index c73d9f650de7..ff656d85903a 100644
> > > > > --- a/arch/x86/kvm/mmu.c
> > > > > +++ b/arch/x86/kvm/mmu.c
> > > > > @@ -264,6 +264,46 @@ static void mmu_spte_set(u64 *sptep, u64 spt=
e);
> > > > > static union kvm_mmu_page_role
> > > > > kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
> > > > >
> > > > > +
> > > > > +static inline bool kvm_available_flush_tlb_with_range(void)
> > > > > +{
> > > > > +       return kvm_x86_ops->tlb_remote_flush_with_range;
> > > > > +}
> > > >
> > > > Seems that kvm_available_flush_tlb_with_range() is not used in this=
 patch=E2=80=A6
> > >
> > > What's wrong with that?
> > >
> > > It provides the implementation and later patches make use of it. It's=
 a
> > > sensible way to split patches into small, self contained entities.
> >
> > From what I can see of the patches that follow _this_ patch in the
> > series, this function remains unused.  So, not only is it not used
> > in this patch, it's not used in this series.
>
> Note - I seem to have only received patches 1 through 4, so this is
> based on the patches I've received.
>

Sorry to confuse your. I get from CCers from get_maintainer.pl script.
The next patch "[PATCH V4 3/15]KVM: Replace old tlb flush function with
new one to flush a specified range" calls new function.
https://lkml.org/lkml/2018/10/13/254

The patch "[PATCH V4 4/15] KVM: Make kvm_set_spte_hva() return int"
changes under ARM directory. Please have a look. Thanks.
--=20
Best regards
Tianyu Lan
