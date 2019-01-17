Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894F6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA7620657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jXmfboBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfAQGqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:46:18 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44387 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfAQGqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:46:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so7556847lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 22:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NxoRT2Ol19EK1HMAFEdy4XkQkzKkEOo4TrYDIsKJ16k=;
        b=jXmfboBoK6xjenebEmj9iey52h2s500qABifhDxqK+OF5EdXVZhY9aFAyM1QFlyn9v
         dIAegw5wQSsYjAxcyFE9Ya9T5TKDsZrKQFktee4YdtlzXFpNJfNrQGgR5R75SotSiypR
         MslAT5USWx7rU/IeQydxm0RB6CtFD5BG/6HHoyFsfOi6s8XOgQ4nscr2LY2N6EXWnsjV
         Xmzsuh2K+Ut0svyDMJQn1pwjyzSht1y98vnddhMPtpc4kjbeD0eBX2tl8oLYYoWbIPOg
         meKsqWslX7hNuoer4kHcTGwoqEeN//ZrI+bZ0V5NP2yrsFYKh7s0GWbFScPfPIBVxXNP
         VEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NxoRT2Ol19EK1HMAFEdy4XkQkzKkEOo4TrYDIsKJ16k=;
        b=gE/drBG1bN6G0ZWMk64JJxd6q+4ZlBdvxEOV24FozGR2mrp8Wx+w5rBiT19kvQjS6r
         RZ92G2pPi0uSz+QhLI44ZW2wsV6QhZim6lumxzGmISllyWRXEu9fLORZYtpXb2d0IJAQ
         zzcst3em41fVbMClhgY2dZ6+gMXYmDpCzdgW9cvWByAVlGzgxxag0ESOlPr8YV+pq1D2
         6r8uuCFbw1bgOBlUuDaVXZC79owll2dfm0yz6dAFyE3IxZDuxrBsqIAlMebgQdOqA4Aq
         4qTNHiF3MLYF9vHHpaYJvs5TWiaCUYSwZKZhwsQU6KTbxU2735+jIPa0FuS4pLkHAmil
         MP+w==
X-Gm-Message-State: AJcUukezN2nyKAELT+3Ejo3bNXX3+Z6Kfz1X6KUNqSgD3tQPj5bXbk5Q
        3jTsdtvXCClRCLvRdJPdeUE9GdyIrESjd7RtHz1PXg==
X-Google-Smtp-Source: ALg8bN5o/x7JmSy8U/cUP7f6/KOxQ7/EQdSX/cXm89FRRs4FIyIj2odzpOYkmINP2uoSI96BZznz0qBlgZda+BRgg5w=
X-Received: by 2002:a2e:1603:: with SMTP id w3-v6mr8892390ljd.33.1547707574678;
 Wed, 16 Jan 2019 22:46:14 -0800 (PST)
MIME-Version: 1.0
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com> <20190115220046.etgbno6ymsux75dk@pengutronix.de>
 <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com> <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de>
In-Reply-To: <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Thu, 17 Jan 2019 12:15:38 +0530
Message-ID: <CAJ2_jOEuE1Y8G3xnYqa+aA9GSRGmN8xN7fh4nBs0_Yb68Br9bg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:16 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Wed, Jan 16, 2019 at 04:40:42PM +0530, Yash Shah wrote:
> > On Wed, Jan 16, 2019 at 3:30 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > > > Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed=
 SoC.
> > > >
> > > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > > [Atish: Various fixes and code cleanup]
> > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > > ---
> > > >  drivers/pwm/Kconfig      |  10 ++
> > > >  drivers/pwm/Makefile     |   1 +
> > > >  drivers/pwm/pwm-sifive.c | 246 +++++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  3 files changed, 257 insertions(+)
> > > >  create mode 100644 drivers/pwm/pwm-sifive.c
> > > >
> > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > index a8f47df..3bcaf6a 100644
> > > > --- a/drivers/pwm/Kconfig
> > > > +++ b/drivers/pwm/Kconfig
> > > > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> > > >         To compile this driver as a module, choose M here: the modu=
le
> > > >         will be called pwm-samsung.
> > > >
> > > > +config PWM_SIFIVE
> > > > +     tristate "SiFive PWM support"
> > > > +     depends on OF
> > > > +     depends on COMMON_CLK
> > >
> > > I'd say add:
> > >
> > >         depends on MACH_SIFIVE || COMPILE_TEST
> > >
> > > (I guess "MACH_SIFIVE" is wrong, but I assume you get what I mean.)
> >
> > As of now, MACH_SIFIVE/ARCH_SIFIVE isn't available.
> > @Paul, Do you have any comments on this?
>
> If this is not going to be available at least protect it by
>
>         depends RISCV || COMPILE_TEST
>
> > > I wonder if such an instance should be only a single PWM instead of
> > > four. Then you were more flexible with the period lengths (using
> > > pwmcfg.pwmzerocmp) and could do stuff like inverted and uninverted mo=
de.
> > >
> > > I didn't understand how the deglitch logic works yet. Currently it is
> > > not used which might result in four edges in a single period (which i=
s
> > > bad).
> >
> > I can enable deglitch logic by just setting a bit (BIT_PWM_DEGLITCH) in
> > REG_PWMCFG. Will do that.
>
> This only works for the first pwm output though.
>
> > > > +struct sifive_pwm_device {
> > > > +     struct pwm_chip chip;
> > > > +     struct notifier_block notifier;
> > > > +     struct clk *clk;
> > > > +     void __iomem *regs;
> > > > +     unsigned int approx_period;
>
> When thinking about this a bit more, I think the better approach would
> be to let the consumer change the period iff there is only one consumer.
> Then you can drop that approx-period stuff and the result is more
> flexible. (Having said that I still prefer making the driver provide
> only a single PWM with the ability to have periods other than powers of
> two.)
>

I am not confident about the implementation of the way you are suggesting.
As of now, I am going to stick with the current implementation.

> > > > +     writel(frac, pwm->regs + REG_PWMCMP0 + dev->hwpwm * SIZE_PWMC=
MP);
> > >
> > > If you get a constant inactive output with frac=3D0 and a constant ac=
tive
> > > output with frac=3D0xffff the calculation above seems wrong to me.
> > > (A value i written to the pwmcmpX register means a duty cycle of
> > > (i * period / 0xffff). Your calculation assumes a divisor of 0x10000
> > > however.)
> >
> > Not sure if I get you completely. But, if divisor of 0xffff is your con=
cern then
> > does the below look ok?
> >
> > frac =3D div_u64(((u64)duty_cycle << 16) - duty_cycle, state->period);
>
> This works (I think, didn't redo the maths), but I would prefer
>
>         frac =3D div_u64((u64)duty_cycle * 0xffff, state->period);
>
> for better readability. (Maybe the compiler is even clever enough to see
> this can be calculated as you suggested.)

Sure, will multiply it with 0xffff for better readability.

>
> > > > +static int sifive_pwm_clock_notifier(struct notifier_block *nb,
> > > > +                                  unsigned long event, void *data)
> > > > +{
> > > > +     struct clk_notifier_data *ndata =3D data;
> > > > +     struct sifive_pwm_device *pwm =3D
> > > > +             container_of(nb, struct sifive_pwm_device, notifier);
> > > > +
> > > > +     if (event =3D=3D POST_RATE_CHANGE)
> > > > +             sifive_pwm_update_clock(pwm, ndata->new_rate);
> > >
> > > Does this need locking? (Maybe not with the current state.)
> >
> > No. We can add it when required.
>
> My thought was, that the clk freq might change while .apply is active.
> But given that you only configure the relative duty cycle this is
> independent of the actual clk freq.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
