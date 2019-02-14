Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FF7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9EC2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BOVFEHvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406615AbfBNKfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:35:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40071 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405096AbfBNKfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:35:18 -0500
Received: by mail-lj1-f193.google.com with SMTP id w6so4534ljd.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 02:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RrEZVrvHhUoz2LvAgQlfnFQuh5a/XR+7hQXCUe0LkQI=;
        b=BOVFEHvihz56a+QAp8AY0H4V9l66Pjce+fs8yKg0pxjU381OWDMecquX1E5jNzYHRB
         rIIKLMMgfjj/sNRkMQiQS6je4Yl83R6y+U0nZ4Rk0xZFw5344nbxO9QcMa5+yveWxAxU
         /rgJ25l+PQ4e6NZ6gb+VpNbeysr8FSV/ecqaAUDIYz5vzlz50ZKk7q+wi6adE01zUwci
         ryKXf4nRhH4dqLCOENu1F1ONFtudCq+F3RsSs+n8O0HvoBkloBiPLQyfohFjcdhZMt6l
         nioO4FagyAkH0hNzpQ+YfYzP+D3SEa3cC43FLCxSUn17B4HZk+YkY/GiTCqDQg1nuwH1
         Bx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RrEZVrvHhUoz2LvAgQlfnFQuh5a/XR+7hQXCUe0LkQI=;
        b=a47Srqwaawad/MJUHm7c47uTds0GXqet1ew+blHJ5L1hVf4Yw5F1+R/cMxJXAGXdqi
         Cd1YPpOhmIuMREXIy3QwSq+6y6LPysjtlndY8R2X6LfyOiIkeK913BsDtYUn6i/Wk1s1
         GlHpHPooFwIQgrPTLWazNW1PxZZgWCoKvnQklVx7v5FL/NB29pCjgMv8Gx8f3frkADOL
         Y3zs+gILTAMwL/Q2Bb+BJ1JRxjvLzE84A0GaOHX+99cnYe7Otn2r17Ig/BO7Ww01qLgv
         NN0v03lQSUhLRSp+tuwjZwHL7SjQoHFMXTUKYTBzNSK8EDyil+BGAV6cDCD5UqO5KkEe
         qAOw==
X-Gm-Message-State: AHQUAuahAAgzEYu6PValqe2HHg/EcMnoNlvgjSEL1K6jkyC6zq8O/b+c
        11zIGWIFHS5Ex+3tJPm8dOf5cSMxTODYP4jcL0vUSQ==
X-Google-Smtp-Source: AHgI3IaHT3i6vNusWvvBglsC1RWmxVSd3bLRnAhnCKvNrxfRck1Ydty0OhbbLWBWaKzqwAogtRqLnrtNSQlpYkB5aAQ=
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr1856067ljd.137.1550140514444;
 Thu, 14 Feb 2019 02:35:14 -0800 (PST)
MIME-Version: 1.0
References: <1550049978-20705-1-git-send-email-yash.shah@sifive.com>
 <1550049978-20705-3-git-send-email-yash.shah@sifive.com> <20190213103459.t5bvemxrb2x6iagm@pengutronix.de>
 <CAJ2_jOH7WaceLVY6KhMmSbwjo3-5tgbiSZYtbRmUxS-4Rf2WLA@mail.gmail.com> <20190214083427.oal3nmcfalqralbk@pengutronix.de>
In-Reply-To: <20190214083427.oal3nmcfalqralbk@pengutronix.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Thu, 14 Feb 2019 16:04:37 +0530
Message-ID: <CAJ2_jOH=4X6Eq8OxZ1va1a5samG4Q++OutaPyO_2YP5++jUp5Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 2:04 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Thu, Feb 14, 2019 at 01:25:27PM +0530, Yash Shah wrote:
> > On Wed, Feb 13, 2019 at 4:05 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Wed, Feb 13, 2019 at 02:56:18PM +0530, Yash Shah wrote:
> > > > +static int pwm_sifive_enable(struct pwm_chip *chip, struct pwm_dev=
ice *dev,
> > > > +                          bool enable)
> > > > +{
> > > > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chi=
p);
> > > > +     u32 val;
> > > > +     int ret;
> > > > +
> > > > +     if (enable) {
> > > > +             ret =3D clk_enable(pwm->clk);
> > > > +             if (ret) {
> > > > +                     dev_err(pwm->chip.dev, "Enable clk failed:%d\=
n", ret);
> > > > +                     return ret;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     val =3D readl(pwm->regs + PWM_SIFIVE_PWMCFG);
> > > > +
> > > > +     if (enable)
> > > > +             val |=3D BIT(PWM_SIFIVE_PWMCFG_EN_ALWAYS);
> > > > +     else
> > > > +             val &=3D ~BIT(PWM_SIFIVE_PWMCFG_EN_ALWAYS);
> > > > +
> > > > +     writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > > > +
> > > > +     if (!enable)
> > > > +             clk_disable(pwm->clk);
> > >
> > > A disabled PWM is supposed to output an inactive signal. If the PWM r=
uns
> > > at (near) 100% and you disable it, does it reliably give that inactiv=
e
> > > signal after completing the currently running period?
> >
> > Yes, you are right, it just freezes at that state (100%).
> > What if I set duty cycle =3D 0 if (!state->enabled) before disabling th=
e PWM?
>
> Then you only need to be sure that the inactive level is already latched
> to the pwmcmpXip output (which should only need one clock cycle if I'm
> not mistaken) before disabling the clock.
>
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_devi=
ce *dev,
> > > > +                         struct pwm_state *state)
> > > > +{
> > > > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chi=
p);
> > > > +     unsigned int duty_cycle;
> > > > +     u32 frac, val;
> > > > +     struct pwm_state cur_state;
> > > > +     bool enabled;
> > > > +     int ret;
> > > > +
> > > > +     pwm_get_state(dev, &cur_state);
> > > > +     enabled =3D cur_state.enabled;
> > > > +
> > > > +     if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > > > +             return -EINVAL;
> > > > +
> > > > +     if (state->period !=3D cur_state.period) {
> > > > +             if (pwm->user_count !=3D 1)
> > > > +                     return -EINVAL;
> > >
> > > I think we need locking here. Consider two pwm users on two CPUs:
> > >
> > >         CPU1                                    CPU2
> > >         pwm_sifive_apply(pwm0, period=3DA, ...)
> > >          check user_count=3D=3D1 -> good
> > >          ...                                    pwm1 =3D pwm_get(...)
> > >          ...                                    pwm_sifive_apply(pwm1=
, period=3DB...)
> > >          ...                                      configure based on =
B
> > >          pwm_sifive_update_clock()
> >
> > mutex_lock();
> >   if (pwm->user_count !=3D 1)
> >                   return -EINVAL;
> > mutex_unlock();
> > Something like this?
>
> No, the lock needs to protect more. You must at least cover increasing
> and decreasing of user_count and you must hold the lock until the period
> update is completed.

Got your point. Will use locks at appropriate places

>
> > > Also I wonder if we should change the period if the user requested
> > > enabled=3Dfalse.
> >
> > You want me to NOT update period if enabled=3Dfalse, right?
>
> I don't know for sure. Given that period is shared for all four PWM
> outputs it might be sensible to change it at least in a shadow variable
> and only do it when actually needed. (But maybe we can postpone that as
> it doesn't matter for correctness of the driver.)
>
> The question here is: In the following snippet:
>
>         pwm0 =3D pwm_get(... the first pwm ...)
>
>         pwm_apply_state(pwm0, { .enabled =3D true, .period =3D 4000 });
>         pwm_apply_state(pwm0, { .enabled =3D false, .period =3D 8000 });
>
>         pwm1 =3D pwm_get(... the second pwm ...)
>         pwm_apply_state(pwm1, { .enabled =3D true, .period =3D 4000 });
>         pwm_apply_state(pwm0, { .enabled =3D true, .period =3D 8000 });
>
> Which of the two last commands should fail?
>
> > > > +             pwm->real_period =3D state->period;
> > > > +             pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
> > >
> > > If you change from
> > >
> > >         .period =3D A
> > >         .duty_cycle =3D B
> > >
> > > to
> > >
> > >         .period =3D C
> > >         .duty_cycle =3D D
> > >
> > > the output pin might see a period with
> > >
> > >         .period =3D C
> > >         .duty_cycle =3D B
> > >
> > > right? I think this is not fixable, but this needs a prominent commen=
t.
> >
> > Good point. Is the below comment good enough?
> > /* When changing both duty cycle and period, the old duty cycle might
> > be active with new the period settings for a period */
>
> I'd add some blame on the hardware. Something like:
>
>         /*
>          * When changing both duty cycle and period, we cannot prevent in
>          * software that the output might produce a period with mixed
>          * settings (new period length and old duty cycle).
>          */
>
> I'd say it makes sense to put this information at the top of the driver
> to have it in a prominent place. Also point out the inability to provide
> 100% duty cycle and that the hardware is limited to inverted output.
> Then all limitations are summarized in a single place.

Sure, will do as you suggested.

>
> Maybe this mismatch could be made less likely by changing the order of
> the register accesses and a delay depending on pwms and old and new
> settings. But I'd say this is too much for now and can be addressed
> later when and if necessary.
>
> > > > +     }
> > > > +
> > > > +     if (!state->enabled && enabled) {
> > > > +             ret =3D pwm_sifive_enable(chip, dev, false);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +             enabled =3D false;
> > > > +     }
> > > > +
> > > > +     duty_cycle =3D state->duty_cycle;
> > > > +     frac =3D div_u64((u64)duty_cycle * (1 << PWM_SIFIVE_CMPWIDTH)=
 +
> > > > +                    (1 << PWM_SIFIVE_CMPWIDTH) / 2, state->period)=
;
> > > > +     /* The hardware cannot generate a 100% duty cycle */
> > >
> > > @Thierry: Do you consider this bad enough that pwm_apply_state should
> > > fail if 100% is requested?
>
> This question is still open.
>
> > > > +     frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > > > +
> > > > +     val =3D readl(pwm->regs + PWM_SIFIVE_PWMCFG);
> > > > +     val |=3D BIT(PWM_SIFIVE_PWMCFG_DEGLITCH);
> > > > +     writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > > > +
> > > > +     writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 + dev->hwpwm *
> > > > +            PWM_SIFIVE_SIZE_PWMCMP);
> > > > +
> > > > +     val &=3D ~BIT(PWM_SIFIVE_PWMCFG_DEGLITCH);
> > >
> > > Doesn't that come too early? I thought the right thing was to keep it
> > > set all the time. With this code I think you might see a duty cycle o=
f
> > > 50 when going from 60 to 40.
> >
> > We cannot set it all the time.
> > Setting it all the time makes every alternate period to remain high
> > (latched state).
> > As per the manual, it needs to be set when reprogramming and must be
> > cleared afterwards.
>
> I didn't find this in the manual. When looking at Figure 6 and the
> description of pwmdeglitch I have the impression that your statement is
> wrong.
>
> Setting pwmdeglitch only prevents the output from getting low during a
> period, it can only go low when pwms overflows (i.e. the start of a
> period). That's exactly what we want. Where is the misunderstanding?
>
> If however you clear pwmdeglitch after an update, consider the following
> series of events:
>
>  - Assume pwmcmpX is 0x4000 and pwms is 0x5000, so pwmcmpXip is high.
>  - You set pwmdeglitch and change pwmcmpX to 0x8000 while pwms advanced
>    only little. Then pwmcmpXip remains high.
>  - Then you clear pwmdeglitch at say pwms =3D 0x5020, this makes pwmcmpXi=
p
>    fall which we should prevent.
>
> Also note that when setting pwmdeglitch while configuring pwm0---if it
> really had the behaviour you pointed out---would interfere with the
> maybe running pwm1.
>
> So I'm convinced keeping pwmdeglitch active always is the right thing to
> do.

I agree that figure 6 suggests that pwmdeglitch should remain active
through out.
But for some strange reason when I set deglitch bit, I am seeing every
alternate pwm cycle to remain high (latched) unless I clear the
deglitch bit.
I am debugging this issue however is it ok if I remove deglitch logic
from driver until this issue has been root caused?

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
