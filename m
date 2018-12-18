Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA945C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33EE217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSNgGK/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbeLRIgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:36:17 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33527 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeLRIgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:36:16 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so17303789qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7oGO02NfXnOUS1mE9pnrgbEYKMKIhHruFOd1QdgfDaM=;
        b=NSNgGK/C/Ggq+r3M51s89bHkI0u/cuppvBzSqGDH/3gxTm4VfmBOKr2tu1MwGSnlqI
         dqmAtGg0cMzOPRGXTme9WArbcaBQpB/aGLbo7YonBKHaLn+qCuAc+/O6GInl1Cc7WoXu
         KTr1a6y1FxjCUd6cizqIWBPM4y8Abkb2fxK3CBsCos6R8bZFt1WlAKGa473TwkWJIxqX
         XN01kGVA+g7uOsaafigRKu9YGbvn8PWjp/rdOU0nVY1P41xLOaGUeX2q63TXOAfJAgBA
         TqyC22OU1szq6x2L+SSX8rg1KdIsw3VYFDS83EsT/62aBWc7WUEKkz+lbb0E3nlBFPSk
         5HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7oGO02NfXnOUS1mE9pnrgbEYKMKIhHruFOd1QdgfDaM=;
        b=RDSJ1TkIzebZZIibAAqkmj/4AqjqbVagUlzUIWKd+Gu0WJaLeh8u5gMMmOhtnaSkw+
         kC+lkIsVSATktCYx/7f7gr+bzXbf8hy8lJoundmOrp59wqObpNxCpIdbMs37RsJuFx3q
         PNypMB8n+MzbBv57PmeO4KjGS49n3eHaWQKHNwGi5wiLttVwzwHLTDp/B25nf08Rt+CO
         a9kg33QSBS7sZNy6+XcM+V3cjvchIhuuiuBzIxYuXyGW26Uevbf5HZ9XeW+JsEdYFqXB
         /0E3eWBrd802meyARUUqLCcJr9MAaMXRpghv9yHldY8MgzI2jqHD3C6x3ik3HrvH8Eiy
         oQ0Q==
X-Gm-Message-State: AA+aEWaNDBN2OUvAaiC6X0V10bwjkP6VqesUJl/wqIEc/RxxAi6ROMPa
        AgKcEnLo7ARXBBw6IPM6gFN2CrPCeSqes8gonyw=
X-Google-Smtp-Source: AFSGD/VMjleKU65Vsl8+ibMX+Xrcg+yzmWxkgGKFN48rA9HApIfCa96GpiC53/tu9zn0zkUK6m2tU3bd1ISpMRmQJSA=
X-Received: by 2002:ac8:1308:: with SMTP id e8mr16828130qtj.201.1545122175482;
 Tue, 18 Dec 2018 00:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20181216144715.7486-1-lecopzer@gmail.com> <e69be9ad-fcda-fa8d-1844-ad0decffb876@arm.com>
In-Reply-To: <e69be9ad-fcda-fa8d-1844-ad0decffb876@arm.com>
From:   Jian-Lin Chen <lecopzer@gmail.com>
Date:   Tue, 18 Dec 2018 16:36:04 +0800
Message-ID: <CANr2M18RppcS2o0cSb7Ze7tVGSCWq-rPSDQFoVfp_zgrT1HD_Q@mail.gmail.com>
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Jian-Lin Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Julien,

Thanks a lot for your reply, since I'm working on this patch in ARM
(32 bits), so I have to dig into the details.

Julien Thierry <julien.thierry@arm.com> =E6=96=BC 2018=E5=B9=B412=E6=9C=881=
7=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:26=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Jian-Lin,
>
> Thanks for looking at this.
>
> On 16/12/2018 14:47, Jian-Lin Chen wrote:
> > From: Jian-Lin Chen <lecopzer.chen@mediatek.com>
> >
> >
> > On Wed, 12 Dec 2018 at 17:48, Julien Thierry <julien.thierry@arm.com> w=
rote:
> >>  static inline void arch_local_irq_enable(void)
> >>  {
> >> -       asm volatile(
> >> -               "msr    daifclr, #2             // arch_local_irq_enab=
le"
> >> -               :
> >> +       unsigned long unmasked =3D GIC_PRIO_IRQON;
> >> +
> >
> > Should we need a WARN_ON() to check if the daif_I bit is masked, or
> > explicitly unmasked I bit here?
> >
>
> While I would agree, adding the WARN_ON() will add some non-negligible
> overhead, especially if we need to read the daif flags to check it.
>
> Since these functions are called often in the whole system and using PMR
> already makes things a bit slower, I'd prefer to avoid checks in here.

Ok, so we have to find a better place to check it.
I have no idea so far...


>
> > If I bit was masked and someone calls arch_local_irq_enable(), they sti=
ll
> > couldn't recieve any interrupt.
> >
> >
> >> +       asm volatile(ALTERNATIVE(
> >> +               "msr    daifclr, #2             // arch_local_irq_enab=
le\n"
> >> +               "nop",
> >> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> >> +               "dsb    sy",
> >> +               ARM64_HAS_IRQ_PRIO_MASKING)
> >>                 :
> >> +               : "r" (unmasked)
> >>                 : "memory");
> >>  }
> >>
> >>  static inline void arch_local_irq_disable(void)
> >>  {
> >> -       asm volatile(
> >> -               "msr    daifset, #2             // arch_local_irq_disa=
ble"
> >> -               :
> >> +       unsigned long masked =3D GIC_PRIO_IRQOFF;
> >> +
> >> +       asm volatile(ALTERNATIVE(
> >> +               "msr    daifset, #2             // arch_local_irq_disa=
ble",
> >> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
> >
> > May be a "dsb sy" here?
>
> So, we need a "dsb sy" when unmasking interrupts because this ensures
> the redistributor sees the latest PMR value and starts forwarding lower
> priority interrupts again.
>
> When we disable interrupts however, the GIC CPU interface guarantees
> that no interrupts of lower priority than the current value of PMR will
> be taken. So we don't really need the redistributor to immediately see
> the new value of PMR as the logic in the GIC CPU interface is good
> enough for our goal.
>

Got it, thanks for the detail!



> Thanks,
>
> --
> Julien Thierry
