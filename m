Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842A1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF7820842
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fnNSuK1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfBZKY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:24:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34762 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZKY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:24:59 -0500
Received: by mail-lj1-f195.google.com with SMTP id l5so10277738lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 02:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BlnXGxqK5MhwjZpw/qMw8m77B2Fs+iNJ9vxMV/XLcZk=;
        b=fnNSuK1jRK0dY0Wtd1sJvoUmA32QAgSuktHAnyKR4CSTRc1eiol6ge8a6ADmO2ggk3
         sXoqRCf1BqyAs5ILZEp3X4nKvbXmYmqUa/fuxB7GhlobwG0Spv4Sj9DFHbSvhuqHof+G
         51oW+y2u12+wUE1Lx1pNLHcOWmWKBNuVRvhIE5a4ipQ0Z/5lxAFeojFhahKlK1VkHQMe
         Inw6gMFLwhjo0VJ2PVToxrhd+lC6tCjFQANUlkqQ7WdzXtm6EfinQtWLJhkrk7WJ2Ch7
         joRVlRHXrQZtNnBVAEk5ydQBRVSpN5aWartz3eyPE/Bn6nxEoLUEVIpOilS9qURQn89w
         ZF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BlnXGxqK5MhwjZpw/qMw8m77B2Fs+iNJ9vxMV/XLcZk=;
        b=lGWqn+Y3fK8GOrt+k0Sukjt3ryJW97zx+exQFvmVw0TuRdiq7/2QqY0ME6Q2YWq9c9
         P0ObQZU/j4eHVLqqIcBgP74F3sduBN2iMorRhaTdfdRhIrUAT7TLRhHRpvVQO3tE2Y7F
         /7q9cY+tO2fE9EWdQyNXo7tRrqc7Qkf42rszAxVC7KTjMK6KyXEc+9vEW70ftAau2ADg
         zqfOwZLuxSe5ZD8MRss+gFIqWIozfaEBNPJfcaK1UoPK+yJ3tr+thXEuXydsGVnT/APh
         noEy9t+3ScBZnFZAW+w0RMEr8kNwzdV+uAzRHjW8jC+bh4gatarpGNu2MwcgKIzXlp1T
         uxFg==
X-Gm-Message-State: AHQUAuYLIAxDVY4fhMs6E435t4zOp4bI3r8mHKUmkz71q3UAWsTR1tR4
        iQHXrvvWMNSxolsWzypuNBx4a6mSadOWUyaGToDNDA==
X-Google-Smtp-Source: AHgI3IaUd5fSEYrav4T/9i4UGBinjp3QAKilJONnDA8j+dGGwIYoAy4CSzQjKrKdZfjc2P1tqE97mlS3VSeeM8jcV4E=
X-Received: by 2002:a2e:9916:: with SMTP id v22mr12448206lji.68.1551176695826;
 Tue, 26 Feb 2019 02:24:55 -0800 (PST)
MIME-Version: 1.0
References: <1550740301-10097-1-git-send-email-yash.shah@sifive.com>
 <1550740301-10097-3-git-send-email-yash.shah@sifive.com> <20190221211603.4um523z5lpozrcua@pengutronix.de>
In-Reply-To: <20190221211603.4um523z5lpozrcua@pengutronix.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 26 Feb 2019 15:54:16 +0530
Message-ID: <CAJ2_jOFZyZDMv3QBsDVg_O5iL5VRhXYZQrGZES2dnELFsX9-JQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
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

On Fri, Feb 22, 2019 at 2:46 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Feb 21, 2019 at 02:41:41PM +0530, Yash Shah wrote:
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
> >  drivers/pwm/pwm-sifive.c | 346 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 358 insertions(+)
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
> > index 0000000..8f29283d
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -0,0 +1,346 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2017-2018 SiFive
> > + * For SiFive's PWM IP block documentation please refer Chapter 14 of
> > + * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pd=
f
> > + *
> > + * Limitations:
> > + * - When changing both duty cycle and period, we cannot prevent in
> > + *   software that the output might produce a period with mixed
> > + *   settings (new period length and old duty cycle).
> > + * - The hardware cannot generate a 100% duty cycle.
> > + * - The hardware generaets only inverted output.
>
> s/generaets/generates/

Will fix the typo.

>
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
> > +#define PWM_SIFIVE_PWMCFG_EN_ALWAYS  BIT(12)
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
> > +     struct mutex lock; /* lock to protect user_count and active_user =
*/
> > +     struct notifier_block notifier;
> > +     struct clk *clk;
> > +     void __iomem *regs;
> > +     unsigned int real_period;
> > +     int user_count;
> > +     int active_user;
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
> > +     mutex_lock(&pwm->lock);
> > +     pwm->user_count++;
> > +     mutex_unlock(&pwm->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static void pwm_sifive_free(struct pwm_chip *chip, struct pwm_device *=
dev)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +
> > +     mutex_lock(&pwm->lock);
> > +     pwm->user_count--;
> > +     mutex_unlock(&pwm->lock);
> > +}
> > +
> > +static void pwm_sifive_update_clock(struct pwm_sifive_ddata *pwm,
> > +                                 unsigned long rate)
> > +{
> > +     u32 val;
> > +     unsigned long num;
> > +     /* (1 << (PWM_SIFIVE_CMPWIDTH+scale)) * 10^9/rate =3D real_period=
 */
> > +     unsigned long scale_pow =3D
> > +                     div64_ul(pwm->real_period * (u64)rate, NSEC_PER_S=
EC);
> > +     int scale =3D clamp(ilog2(scale_pow) - PWM_SIFIVE_CMPWIDTH, 0, 0x=
f);
> > +
> > +     val =3D PWM_SIFIVE_PWMCFG_EN_ALWAYS | (scale << PWM_SIFIVE_PWMCFG=
_SCALE);
> > +     writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > +
> > +     /* As scale <=3D 15 the shift operation cannot overflow. */
> > +     num =3D 1000000000ULL << (PWM_SIFIVE_CMPWIDTH + scale);
>
> Huh, num is only an unsigned long, so you're loosing some bits here.
>
> > +     pwm->real_period =3D div64_ul(num, rate);
> > +     dev_dbg(pwm->chip.dev, "New real_period =3D %u ns\n", pwm->real_p=
eriod);
> > +}
> > +
> > +static void pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *dev,
> > +                              struct pwm_state *state)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +     u32 duty, val;
> > +     unsigned long num;
>
> This should also be unsigned long long.

I will change both the above num to long long

>
> > +     duty =3D readl(pwm->regs + PWM_SIFIVE_PWMCMP0 +
> > +                  dev->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
> > +
> > +     val =3D readl(pwm->regs + PWM_SIFIVE_PWMCFG);
> > +     state->enabled =3D duty > 0;
> > +
> > +     val &=3D 0x0F;
> > +     num =3D 1000000000ULL << (PWM_SIFIVE_CMPWIDTH + val);
> > +     pwm->real_period =3D div64_ul(num, clk_get_rate(pwm->clk));
>
> clk_get_rate must only be called if the clock is enabled.

Ok. Will remove the above lines and directly assign pwm->real_period
to state->period.
The pwm->real_period gets calculated in pwm_sifive_update_clock().
Also, will call pwm_sifive_update_clock() in probe func with default
period value so that pwm->real_period will have a default value.

>
> > +     state->period =3D pwm->real_period;
> > +     state->duty_cycle =3D
> > +             (u64)duty * pwm->real_period >> PWM_SIFIVE_CMPWIDTH;
> > +     state->polarity =3D PWM_POLARITY_INVERSED;
> > +}
> > +
> > +static int pwm_sifive_enable(struct pwm_chip *chip, bool enable)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +     int val, ret;
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
> > +             val |=3D PWM_SIFIVE_PWMCFG_EN_ALWAYS;
> > +     else
> > +             val &=3D ~PWM_SIFIVE_PWMCFG_EN_ALWAYS;
> > +
> > +     writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > +
> > +     if (!enable)
> > +             clk_disable(pwm->clk);
>
> This might come too early as after clearing PWM_SIFIVE_PWMCFG_EN_ALWAYS
> the period has to finish first.

Since now I won't be clearing PWM_SIFIVE_PWMCFG_EN_ALWAYS, this won't
be an issue.

>
> > +     return 0;
> > +}
> > +
> > +static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *=
dev,
> > +                         struct pwm_state *state)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +     unsigned int duty_cycle, x;
> > +     u32 frac;
> > +     struct pwm_state cur_state;
> > +     bool enabled;
> > +     int ret;
> > +     unsigned long num;
> > +
> > +     pwm_get_state(dev, &cur_state);
> > +     enabled =3D cur_state.enabled;
> > +
> > +     if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > +             return -EINVAL;
> > +
> > +     if (state->period !=3D cur_state.period) {
> > +             mutex_lock(&pwm->lock);
>
> This lock is too late. You need to protect pwm_get_state() already.

Ok, will move this lock before pwm_get_state() call

>
> > +             if (pwm->user_count !=3D 1) {
> > +                     mutex_unlock(&pwm->lock);
> > +                     return -EINVAL;
> > +             }
> > +             pwm->real_period =3D state->period;
> > +             pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
> > +             mutex_unlock(&pwm->lock);
>
> This is also wrong.

I will unlock the mutex just before returning from .apply

> > +     }
> > +
> > +     duty_cycle =3D state->duty_cycle;
> > +     if (!state->enabled)
> > +             duty_cycle =3D 0;
> > +
> > +     x =3D 1U << PWM_SIFIVE_CMPWIDTH;
> > +     num =3D (u64)duty_cycle * x + x / 2;
> > +     frac =3D div_u64(num, state->period);
> > +     /* The hardware cannot generate a 100% duty cycle */
> > +     frac =3D min(frac, x - 1);
> > +
> > +     writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 +
> > +            dev->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
> > +
> > +     if (!state->enabled && enabled) {
> > +             mutex_lock(&pwm->lock);
> > +             if (pwm->active_user =3D=3D 1) {
>
> You count in .active_user something that clk_enable/clk_disable could
> already do for you. (Just keep PWM_SIFIVE_PWMCFG_EN_ALWAYS set, the
> generated wave forms are identical apart from the first enable taking
> more time without tracking active_user)

Ok, I will remove .active_user and won't be clearing
PWM_SIFIVE_PWMCFG_EN_ALWAYS when pwm is disabled.

>
> > +                     ret =3D pwm_sifive_enable(chip, false);
> > +                     if (ret) {
> > +                             mutex_unlock(&pwm->lock);
> > +                             return ret;
> > +                     }
> > +             }
> > +             pwm->active_user--;
> > +             mutex_unlock(&pwm->lock);
> > +             enabled =3D false;
> > +     }
> > +
> > +     if (state->enabled !=3D enabled) {
>
> I think using
>
>         if (state->enabled && !enabled) {
>
> is equivalent but clearer.

Sure, will change it.

>
> > +             mutex_lock(&pwm->lock);
> > +             if (pwm->active_user =3D=3D 0) {
> > +                     ret =3D pwm_sifive_enable(chip, state->enabled);
> > +                     if (ret) {
> > +                             mutex_unlock(&pwm->lock);
> > +                             return ret;
> > +                     }
> > +             }
> > +             pwm->active_user++;
> > +             mutex_unlock(&pwm->lock);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct pwm_ops pwm_sifive_ops =3D {
> > +     .request =3D pwm_sifive_request,
> > +     .free =3D pwm_sifive_free,
> > +     .get_state =3D pwm_sifive_get_state,
> > +     .apply =3D pwm_sifive_apply,
> > +     .owner =3D THIS_MODULE,
> > +};
> > +
> > +static int pwm_sifive_clock_notifier(struct notifier_block *nb,
> > +                                  unsigned long event, void *data)
> > +{
> > +     struct clk_notifier_data *ndata =3D data;
> > +     struct pwm_sifive_ddata *pwm =3D
> > +             container_of(nb, struct pwm_sifive_ddata, notifier);
> > +
> > +     if (event =3D=3D POST_RATE_CHANGE)
> > +             pwm_sifive_update_clock(pwm, ndata->new_rate);
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static int pwm_sifive_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct pwm_sifive_ddata *pwm;
> > +     struct pwm_chip *chip;
> > +     struct resource *res;
> > +     int ret;
> > +
> > +     pwm =3D devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> > +     if (!pwm)
> > +             return -ENOMEM;
> > +
> > +     mutex_init(&pwm->lock);
> > +     chip =3D &pwm->chip;
> > +     chip->dev =3D dev;
> > +     chip->ops =3D &pwm_sifive_ops;
> > +     chip->of_pwm_n_cells =3D 3;
> > +     chip->base =3D -1;
> > +     chip->npwm =3D 4;
> > +
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     pwm->regs =3D devm_ioremap_resource(dev, res);
> > +     if (IS_ERR(pwm->regs)) {
> > +             dev_err(dev, "Unable to map IO resources\n");
> > +             return PTR_ERR(pwm->regs);
> > +     }
> > +
> > +     pwm->clk =3D devm_clk_get(dev, NULL);
> > +     if (IS_ERR(pwm->clk)) {
> > +             if (PTR_ERR(pwm->clk) !=3D -EPROBE_DEFER)
> > +                     dev_err(dev, "Unable to find controller clock\n")=
;
> > +             return PTR_ERR(pwm->clk);
> > +     }
> > +
> > +     ret =3D clk_prepare_enable(pwm->clk);
> > +     if (ret) {
> > +             dev_err(dev, "failed to enable clock for pwm: %d\n", ret)=
;
> > +             return ret;
> > +     }
> > +
> > +     /* Watch for changes to underlying clock frequency */
> > +     pwm->notifier.notifier_call =3D pwm_sifive_clock_notifier;
> > +     ret =3D clk_notifier_register(pwm->clk, &pwm->notifier);
> > +     if (ret) {
> > +             dev_err(dev, "failed to register clock notifier: %d\n", r=
et);
> > +             goto disable_clk;
> > +     }
> > +
> > +     ret =3D pwmchip_add(chip);
> > +     if (ret < 0) {
> > +             dev_err(dev, "cannot register PWM: %d\n", ret);
> > +             goto unregister_clk;
> > +     }
> > +
> > +     /* Enable PWM */
> > +     ret =3D pwm_sifive_enable(chip, true);
> > +     if (ret)
> > +             dev_warn(dev, "cannot Enable PWM: %d\n", ret);
>
> s/E/e/

Sure.

>
> > +
> > +     if (!pwm_is_enabled(pwm->chip.pwms))
> > +             clk_disable(pwm->clk);
>
> You check only the first pwm here, while you must not disable the clock
> if any pwm is running, right?

Good catch. I will fix this.

>
> > +
> > +     platform_set_drvdata(pdev, pwm);
> > +     dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
> > +
> > +     return 0;
> > +
> > +unregister_clk:
> > +     clk_notifier_unregister(pwm->clk, &pwm->notifier);
> > +disable_clk:
> > +     clk_disable_unprepare(pwm->clk);
> > +
> > +     return ret;
> > +}
> > +
> > +static int pwm_sifive_remove(struct platform_device *dev)
> > +{
> > +     struct pwm_sifive_ddata *pwm =3D platform_get_drvdata(dev);
> > +     int ret;
> > +
> > +     ret =3D pwmchip_remove(&pwm->chip);
> > +     clk_notifier_unregister(pwm->clk, &pwm->notifier);
> > +     if (!pwm_is_enabled(pwm->chip.pwms))
> > +             clk_disable(pwm->clk);
>
> I think this must be:
>
>         if (any pwm is enabled)
>                 clk_disable(pwm->clk);

Yes, will change it to something like below:

for (ch =3D 0; ch < pwm->chip.npwm; ch++) {
        if (pwm_is_enabled(pwm->chip.pwms[ch])) {
                is_enabled =3D true;
                break;
        }
}
if (is_enabled)
        clk_disable(pwm->clk);

>
> > +     clk_unprepare(pwm->clk);
> > +     return ret;
> > +}
>
> Best regards
> Uwe

Thanks for your comments.

>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
