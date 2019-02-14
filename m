Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250B1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE67C222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ddHtzlq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406141AbfBNH4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:56:08 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46649 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731244AbfBNH4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:56:08 -0500
Received: by mail-lf1-f68.google.com with SMTP id f5so3789199lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 23:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SkWcdFHz4m+88BhQlZtAY3s2XwmOuJZjrimaiuFanjY=;
        b=ddHtzlq94xAJb27g/EoGFGYPjPquEKEJTgO70aNhT4brmjl0XpEXE3eWc3Khx3sRzQ
         oJz7bGbr6ZynMTVRRq4w3NeEQD9TC3csDIZei7aYrqhqUc6gfb7oq9T6b+TVbZMkUKco
         f6MD7wk1bZ+XKXGttuqiDbzyx55ZEU/WCdkcdNvQzaQEhSKYudUXlOPVAv2gZD8kZVdN
         yoF/btbqAZbEyuE0cBdnt+S5DPiSFcBEDLm8omewF3UKtZa/cYDyHjWH7uyWBZaUaX5x
         IFEyNd4afNYmcH7knDif3fpCBwcjwbtxAjBzHZPFvpy4x66sD0aWck9fP7sRl3gXw+2k
         QwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SkWcdFHz4m+88BhQlZtAY3s2XwmOuJZjrimaiuFanjY=;
        b=JjxtrK/wrkuPRe73uooASYG4O3XYNRR3s+fw422WmE6XdOJynpjpqdM/dXy1NAVpPE
         zR28W8DM2L9gCAZlQ7/vqtw3L7gKAw0iwGRz9ukkScTrxOf1DOynPSyMSRaeBULfVp4Y
         J74RWGu4DC4m1vKnHa8Xip265bqCJ5RPx696qtNtM8sgE2mXXlTb3Fp+r92covIfMo2C
         G8VVS8QIer8nmg2V7y1EMeNnkMclUGvjUa2m9EWwWYgK0CMJIQvJQjtCb70FwsJ145vM
         H/h/FnFsazDFuPDRO70bggx0CEvl2eY8i0pVN2jbHn+Gqm+VflePJhyiJsT82Q/V7T/i
         q+cQ==
X-Gm-Message-State: AHQUAuY7hyMsGF5rTyxvwTB3jY+soKV1dZIKH2bFNwH46SM9Z5KhCoG0
        08XKWqTgRlMGVBw7Dro9QD1CQ5nmEfadi0w4nNq0fA==
X-Google-Smtp-Source: AHgI3IbtTy7/L+1ByqfW8gWuelFMEnoQG7hYVMa1kutewuoODk1QK7ZYhJXviuAU3mEq7CV3zZKyoz26oIl2wv8sekw=
X-Received: by 2002:a19:16:: with SMTP id 22mr1408546lfa.160.1550130965034;
 Wed, 13 Feb 2019 23:56:05 -0800 (PST)
MIME-Version: 1.0
References: <1550049978-20705-1-git-send-email-yash.shah@sifive.com>
 <1550049978-20705-3-git-send-email-yash.shah@sifive.com> <20190213103459.t5bvemxrb2x6iagm@pengutronix.de>
In-Reply-To: <20190213103459.t5bvemxrb2x6iagm@pengutronix.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Thu, 14 Feb 2019 13:25:27 +0530
Message-ID: <CAJ2_jOH7WaceLVY6KhMmSbwjo3-5tgbiSZYtbRmUxS-4Rf2WLA@mail.gmail.com>
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

On Wed, Feb 13, 2019 at 4:05 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Wed, Feb 13, 2019 at 02:56:18PM +0530, Yash Shah wrote:
> > Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC=
.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Various fixes and code cleanup]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  drivers/pwm/Kconfig      |  11 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-sifive.c | 311 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 323 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-sifive.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index a8f47df..4a61d1a 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -380,6 +380,17 @@ config PWM_SAMSUNG
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-samsung.
> >
> > +config PWM_SIFIVE
> > +     tristate "SiFive PWM support"
> > +     depends on OF
> > +     depends on COMMON_CLK
> > +     depends on RISCV || COMPILE_TEST
> > +     help
> > +       Generic PWM framework driver for SiFive SoCs.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called pwm-sifive.
> > +
> >  config PWM_SPEAR
> >       tristate "STMicroelectronics SPEAr PWM support"
> >       depends on PLAT_SPEAR
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 9c676a0..30089ca 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_RCAR)              +=3D pwm-rcar.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)        +=3D pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)   +=3D pwm-rockchip.o
> >  obj-$(CONFIG_PWM_SAMSUNG)    +=3D pwm-samsung.o
> > +obj-$(CONFIG_PWM_SIFIVE)     +=3D pwm-sifive.o
> >  obj-$(CONFIG_PWM_SPEAR)              +=3D pwm-spear.o
> >  obj-$(CONFIG_PWM_STI)                +=3D pwm-sti.o
> >  obj-$(CONFIG_PWM_STM32)              +=3D pwm-stm32.o
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > new file mode 100644
> > index 0000000..c0eb90e
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -0,0 +1,311 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2017-2018 SiFive
> > + * For SiFive's PWM IP block documentation please refer Chapter 14 of
> > + * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pd=
f
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/slab.h>
> > +
> > +/* Register offsets */
> > +#define PWM_SIFIVE_PWMCFG            0x0
> > +#define PWM_SIFIVE_PWMCOUNT          0x8
> > +#define PWM_SIFIVE_PWMS                      0x10
> > +#define PWM_SIFIVE_PWMCMP0           0x20
> > +
> > +/* PWMCFG fields */
> > +#define PWM_SIFIVE_PWMCFG_SCALE              0
> > +#define PWM_SIFIVE_PWMCFG_STICKY     8
> > +#define PWM_SIFIVE_PWMCFG_ZERO_CMP   9
> > +#define PWM_SIFIVE_PWMCFG_DEGLITCH   10
> > +#define PWM_SIFIVE_PWMCFG_EN_ALWAYS  12
>
> PWM_SIFIVE_PWMCFG_EN_ALWAYS is always used as
>
>         BIT(PWM_SIFIVE_PWMCFG_EN_ALWAYS)
>
> so defining this as BIT(12) directly makes some expressions below easier
> to read.

Sure, will do that.

>
> > +#define PWM_SIFIVE_PWMCFG_EN_ONCE    13
> > +#define PWM_SIFIVE_PWMCFG_CENTER     16
> > +#define PWM_SIFIVE_PWMCFG_GANG               24
> > +#define PWM_SIFIVE_PWMCFG_IP         28
> > +
> > +/* PWM_SIFIVE_SIZE_PWMCMP is used to calculate offset for pwmcmpX regi=
sters */
> > +#define PWM_SIFIVE_SIZE_PWMCMP               4
> > +#define PWM_SIFIVE_CMPWIDTH          16
> > +
> > +struct pwm_sifive_ddata {
> > +     struct pwm_chip chip;
> > +     struct notifier_block notifier;
> > +     struct clk *clk;
> > +     void __iomem *regs;
> > +     unsigned int real_period;
> > +     int user_count;
> > +};
> > +
> > +static inline
> > +struct pwm_sifive_ddata *pwm_sifive_chip_to_ddata(struct pwm_chip *c)
> > +{
> > +     return container_of(c, struct pwm_sifive_ddata, chip);
> > +}
> > +
> > +static int pwm_sifive_request(struct pwm_chip *chip, struct pwm_device=
 *dev)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +
> > +     pwm->user_count++;
> > +
> > +     return 0;
> > +}
> > +
> > +static void pwm_sifive_free(struct pwm_chip *chip, struct pwm_device *=
dev)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +
> > +     pwm->user_count--;
> > +}
> > +
> > +static void pwm_sifive_update_clock(struct pwm_sifive_ddata *pwm,
> > +                                 unsigned long rate)
> > +{
> > +     /* (1 << (16+scale)) * 10^9/rate =3D real_period */
>
> Maybe you want to mention here the relation between 16 and
> PWM_SIFIVE_CMPWIDTH.

Sure, will change it to
/* (1 << (PWM_SIFIVE_CMPWIDTH+scale)) * 10^9/rate =3D real_period */

>
> > +     unsigned long scale_pow =3D
> > +                     div64_ul(pwm->real_period * (u64)rate, NSEC_PER_S=
EC);
> > +     int scale =3D clamp(ilog2(scale_pow) - PWM_SIFIVE_CMPWIDTH, 0, 0x=
f);
> > +
> > +     writel((1 << PWM_SIFIVE_PWMCFG_EN_ALWAYS) | (scale <<
> > +            PWM_SIFIVE_PWMCFG_SCALE), pwm->regs + PWM_SIFIVE_PWMCFG);
>
> I think this would be better readable with the newline after the |. With
> my editor's configuration when broken like this, the 2nd line would be
> intended with the opening ( after the |.
>
> > +
> > +     /* As scale <=3D 15 the shift operation cannot overflow. */
> > +     pwm->real_period =3D div64_ul(1000000000ULL << (PWM_SIFIVE_CMPWID=
TH +
> > +                                 scale), rate);
>
> ditto. Maybe break after the =3D?
>
> > +     dev_dbg(pwm->chip.dev, "New real_period =3D %u ns\n", pwm->real_p=
eriod);
> > +}
> > +
> > +static void pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *dev,
> > +                              struct pwm_state *state)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +     u32 duty;
> > +     int val;
> > +
> > +     duty =3D readl(pwm->regs + PWM_SIFIVE_PWMCMP0 + dev->hwpwm *
> > +                  PWM_SIFIVE_SIZE_PWMCMP);
> > +
> > +     val =3D readl(pwm->regs + PWM_SIFIVE_PWMCFG);
> > +     state->enabled =3D (val & BIT(PWM_SIFIVE_PWMCFG_EN_ALWAYS)) > 0;
> > +
> > +     val &=3D 0x0F;
> > +     pwm->real_period =3D div64_ul(1000000000ULL << (PWM_SIFIVE_CMPWID=
TH +
> > +                                 val), clk_get_rate(pwm->clk));
>
> Another bad line break.

Will add temp variable to split the above expressions.

>
> > +
> > +     state->period =3D pwm->real_period;
> > +     state->duty_cycle =3D ((u64)duty * pwm->real_period) >>
> > +                         PWM_SIFIVE_CMPWIDTH;
> > +     state->polarity =3D PWM_POLARITY_INVERSED;
> > +}
> > +
> > +static int pwm_sifive_enable(struct pwm_chip *chip, struct pwm_device =
*dev,
> > +                          bool enable)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +     u32 val;
> > +     int ret;
> > +
> > +     if (enable) {
> > +             ret =3D clk_enable(pwm->clk);
> > +             if (ret) {
> > +                     dev_err(pwm->chip.dev, "Enable clk failed:%d\n", =
ret);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     val =3D readl(pwm->regs + PWM_SIFIVE_PWMCFG);
> > +
> > +     if (enable)
> > +             val |=3D BIT(PWM_SIFIVE_PWMCFG_EN_ALWAYS);
> > +     else
> > +             val &=3D ~BIT(PWM_SIFIVE_PWMCFG_EN_ALWAYS);
> > +
> > +     writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > +
> > +     if (!enable)
> > +             clk_disable(pwm->clk);
>
> A disabled PWM is supposed to output an inactive signal. If the PWM runs
> at (near) 100% and you disable it, does it reliably give that inactive
> signal after completing the currently running period?

Yes, you are right, it just freezes at that state (100%).
What if I set duty cycle =3D 0 if (!state->enabled) before disabling the PW=
M?

>
> > +
> > +     return 0;
> > +}
> > +
> > +static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *=
dev,
> > +                         struct pwm_state *state)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +     unsigned int duty_cycle;
> > +     u32 frac, val;
> > +     struct pwm_state cur_state;
> > +     bool enabled;
> > +     int ret;
> > +
> > +     pwm_get_state(dev, &cur_state);
> > +     enabled =3D cur_state.enabled;
> > +
> > +     if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > +             return -EINVAL;
> > +
> > +     if (state->period !=3D cur_state.period) {
> > +             if (pwm->user_count !=3D 1)
> > +                     return -EINVAL;
>
> I think we need locking here. Consider two pwm users on two CPUs:
>
>         CPU1                                    CPU2
>         pwm_sifive_apply(pwm0, period=3DA, ...)
>          check user_count=3D=3D1 -> good
>          ...                                    pwm1 =3D pwm_get(...)
>          ...                                    pwm_sifive_apply(pwm1, pe=
riod=3DB...)
>          ...                                      configure based on B
>          pwm_sifive_update_clock()

mutex_lock();
  if (pwm->user_count !=3D 1)
                  return -EINVAL;
mutex_unlock();
Something like this?

>
> Also I wonder if we should change the period if the user requested
> enabled=3Dfalse.

You want me to NOT update period if enabled=3Dfalse, right?

>
> > +             pwm->real_period =3D state->period;
> > +             pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
>
> If you change from
>
>         .period =3D A
>         .duty_cycle =3D B
>
> to
>
>         .period =3D C
>         .duty_cycle =3D D
>
> the output pin might see a period with
>
>         .period =3D C
>         .duty_cycle =3D B
>
> right? I think this is not fixable, but this needs a prominent comment.

Good point. Is the below comment good enough?
/* When changing both duty cycle and period, the old duty cycle might
be active with new the period settings for a period */

>
> > +     }
> > +
> > +     if (!state->enabled && enabled) {
> > +             ret =3D pwm_sifive_enable(chip, dev, false);
> > +             if (ret)
> > +                     return ret;
> > +             enabled =3D false;
> > +     }
> > +
> > +     duty_cycle =3D state->duty_cycle;
> > +     frac =3D div_u64((u64)duty_cycle * (1 << PWM_SIFIVE_CMPWIDTH) +
> > +                    (1 << PWM_SIFIVE_CMPWIDTH) / 2, state->period);
> > +     /* The hardware cannot generate a 100% duty cycle */
>
> @Thierry: Do you consider this bad enough that pwm_apply_state should
> fail if 100% is requested?
>
> > +     frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > +
> > +     val =3D readl(pwm->regs + PWM_SIFIVE_PWMCFG);
> > +     val |=3D BIT(PWM_SIFIVE_PWMCFG_DEGLITCH);
> > +     writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > +
> > +     writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 + dev->hwpwm *
> > +            PWM_SIFIVE_SIZE_PWMCMP);
> > +
> > +     val &=3D ~BIT(PWM_SIFIVE_PWMCFG_DEGLITCH);
>
> Doesn't that come too early? I thought the right thing was to keep it
> set all the time. With this code I think you might see a duty cycle of
> 50 when going from 60 to 40.

We cannot set it all the time.
Setting it all the time makes every alternate period to remain high
(latched state).
As per the manual, it needs to be set when reprogramming and must be
cleared afterwards.

>
> > +     writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > +
> > +     if (state->enabled !=3D enabled) {
> > +             ret =3D pwm_sifive_enable(chip, dev, state->enabled);
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> FTR: This doesn't block until the newly configured state is active.
>
> > +
> > +     return 0;
> > +}
>
> Best regards
> Uwe

Thanks for your comments

>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
