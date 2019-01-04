Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B6BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D762D21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jHoldeje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbfADFOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:14:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34372 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfADFOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:14:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id u89-v6so31590770lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 21:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7Sw/6st9Ubj4bJ8/oI1WtNzIPwHrAFtrBY9Nswqq3M4=;
        b=jHoldejeKMrLXhf2iCaNC9Am8eCfUOnK68ejf3aqUy0Vdgve6XTLD++96ml5qgLbIG
         RIXpdcLbe/uUZajWARYdLyvVhSlU9V13/eO2fDVObFUwon+MWwyn5Qyou5KL8BGhYsHj
         AIMH1LZvfAv5fdtuuTrUE6uDzK0GI11s85Ho4On8rbtGzIYidA6b488evysVINB3nYqR
         w8I+pxHsabGqpS4psgB2SE262h6T3aUhJhuXdIx+uJBS2tsWBb92GgTrl6Ri5qp8gaq9
         tqst/LhMY7tEMhTfsZABKmeqKDEa/L+pZdeK7dllQqsb3S8IyneInnQXcyX3x6gR1UU9
         38eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7Sw/6st9Ubj4bJ8/oI1WtNzIPwHrAFtrBY9Nswqq3M4=;
        b=t12Happ3g3ojK+Rd0lwQkmgsg1TYecJAJ3L4UWyg+X7T3MXlyBP9pvZ38pBLDRyWqo
         /E4oJrBE8QUX3gdNOk79zSG/MH0s3YBOmviFztjq0MRL15zYVPptLsNkLo1ZkPQGs8HW
         QdTuzYbUywZHp/O2corPBvoXC86wSO118z5rN3XPPfVodORsK9pgucJEzXRDTLXP6Qa4
         lhHxZa0UeXvgiVHEeedFADa+/Xuq1tn81yw4Ph3rPcaWMR3wHA6M2FqNb3crl5+x8VIm
         0zDictSZ9yoPdbzPBBIe51Ycp6JdQFHt9oBLfLHkg8E2nwMW2XwZYzMizaE4Zy0D8lcr
         1KRg==
X-Gm-Message-State: AJcUukfA9uZ9nl7rV12TCsaW84xmk79txvGJIVhT8P6xeEV6OnsyDsZR
        W9SNLrQ/8TxLMocg9rl7t/TTFN8PcjspLbcTC3BzzQ==
X-Google-Smtp-Source: ALg8bN5oHdJ9ApZivM4N7SicYO8l+XGzQ0h9Ig6pjkmZjb6vxsV2LSS6MAK/wbPbbA9Y/C36WPZJN35l897wiNQ1ngE=
X-Received: by 2002:a2e:4746:: with SMTP id u67-v6mr7199091lja.142.1546578886941;
 Thu, 03 Jan 2019 21:14:46 -0800 (PST)
MIME-Version: 1.0
References: <1544768442-12530-1-git-send-email-yash.shah@sifive.com>
 <1544768442-12530-3-git-send-email-yash.shah@sifive.com> <20181217221151.h63swo4xpi2zj3q5@pengutronix.de>
In-Reply-To: <20181217221151.h63swo4xpi2zj3q5@pengutronix.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Fri, 4 Jan 2019 10:44:10 +0530
Message-ID: <CAJ2_jOF7DxOo8_v2_218TCev057-jX65eTfB22u-rQ+wpXMUFQ@mail.gmail.com>
Subject: Re: [RFC v2 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
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

On Tue, Dec 18, 2018 at 3:42 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Fri, Dec 14, 2018 at 11:50:42AM +0530, Yash Shah wrote:
> > Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC=
.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Various fixes and code cleanup]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  drivers/pwm/Kconfig      |  10 +++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-sifive.c | 229 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 240 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-sifive.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 27e5dd4..da85557 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -378,6 +378,16 @@ config PWM_SAMSUNG
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-samsung.
> >
> > +config PWM_SIFIVE
> > +     tristate "SiFive PWM support"
> > +     depends on OF
> > +     depends on COMMON_CLK
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
> > index 0000000..26913b6
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -0,0 +1,229 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2017-2018 SiFive
>
> If there is a publically available reference manual, please add a link
> to it here.

Ok will add the link to the reference manual.

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
> > +#define REG_PWMCFG           0x0
> > +#define REG_PWMCOUNT         0x8
> > +#define REG_PWMS             0x10
> > +#define REG_PWMCMP0          0x20
> > +
> > +/* PWMCFG fields */
> > +#define BIT_PWM_SCALE                0
> > +#define BIT_PWM_STICKY               8
> > +#define BIT_PWM_ZERO_ZMP     9
> > +#define BIT_PWM_DEGLITCH     10
> > +#define BIT_PWM_EN_ALWAYS    12
> > +#define BIT_PWM_EN_ONCE              13
> > +#define BIT_PWM0_CENTER              16
> > +#define BIT_PWM0_GANG                24
> > +#define BIT_PWM0_IP          28
> > +
> > +#define SIZE_PWMCMP          4
> > +#define MASK_PWM_SCALE               0xf
> > +
> > +struct sifive_pwm_device {
> > +     struct pwm_chip chip;
> > +     struct notifier_block notifier;
> > +     struct clk *clk;
> > +     void __iomem *regs;
> > +     unsigned int approx_period;
> > +     unsigned int real_period;
> > +};
> > +
> > +static inline struct sifive_pwm_device *to_sifive_pwm_chip(struct pwm_=
chip *c)
> > +{
> > +     return container_of(c, struct sifive_pwm_device, chip);
> > +}
> > +
> > +static int sifive_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
dev,
> > +                         struct pwm_state *state)
> > +{
> > +     struct sifive_pwm_device *pwm =3D to_sifive_pwm_chip(chip);
> > +     unsigned int duty_cycle;
> > +     u32 frac;
> > +
> > +     duty_cycle =3D state->duty_cycle;
> > +     if (!state->enabled)
> > +             duty_cycle =3D 0;
>
> @Thierry: You see, this driver is cheating in the same way that I
> suggested to implement for imx.
>
> > +
> > +     frac =3D ((u64)duty_cycle << 16) / state->period;
>
> You must not use / to divide an u64 (unless you're on a 64 bit arch).

Will use div_u64().

>
> > +     frac =3D min(frac, 0xFFFFU);
>
> Also if real_period is for example 10 ms and the consumer requests
> duty=3D12 ms + period=3D100 ms, the hardware is configured for duty=3D1.2=
 ms +
> period=3D10 ms, right?

Right.

>
> You should also check polarity (and fail if it's !=3D
> PWM_POLARITY_INVERSED?).

Will add the check for polarity.

>
> If state->duty_cycle =3D=3D state->period, we end up with frac =3D 0xffff=
.
> Does that mean the chip cannot output 100%?

No, it does not mean that. The chip can output 100%

>
> > +     writel(frac, pwm->regs + REG_PWMCMP0 + dev->hwpwm * SIZE_PWMCMP);
> > +
> > +     if (state->enabled) {
> > +             state->period =3D pwm->real_period;
> > +             state->duty_cycle =3D ((u64)frac * pwm->real_period) >> 1=
6;
> > +     }
>
> Is this the expected behaviour of .apply to update *state? (I think it's
> a good idea, but I think it misses official blessing.)

Ok, will update the *state by calling get_state() from .apply

>
> > +     return 0;
> > +}
>
> How does a period start with this PWM hardware. The expected behaviour
> would be to start with low level for duty_cycle and then high for the
> rest of the period (given that the polarity is always inversed). Is this
> what the hardware actually does?

Yes, Correct.

>
> If the duty cycle changes, is the currently running period completed
> before the new setting gets active? If yes, .apply is supposed to block
> until the new setting is active.

No, it is not the case.

>
> > +static void sifive_pwm_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *dev,
> > +                              struct pwm_state *state)
> > +{
> > +     struct sifive_pwm_device *pwm =3D to_sifive_pwm_chip(chip);
> > +     u32 duty;
> > +
> > +     duty =3D readl(pwm->regs + REG_PWMCMP0 + dev->hwpwm * SIZE_PWMCMP=
);
> > +
> > +     state->period =3D pwm->real_period;
> > +     state->duty_cycle =3D ((u64)duty * pwm->real_period) >> 16;
> > +     state->polarity =3D PWM_POLARITY_INVERSED;
> > +     state->enabled =3D duty > 0;
> > +}
> > +
> > +static const struct pwm_ops sifive_pwm_ops =3D {
> > +     .get_state =3D sifive_pwm_get_state,
> > +     .apply =3D sifive_pwm_apply,
> > +     .owner =3D THIS_MODULE,
> > +};
> > +
> > +static struct pwm_device *sifive_pwm_xlate(struct pwm_chip *chip,
> > +                                        const struct of_phandle_args *=
args)
> > +{
> > +     struct sifive_pwm_device *pwm =3D to_sifive_pwm_chip(chip);
> > +     struct pwm_device *dev;
> > +
> > +     if (args->args[0] >=3D chip->npwm)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     dev =3D pwm_request_from_chip(chip, args->args[0], NULL);
> > +     if (IS_ERR(dev))
> > +             return dev;
> > +
> > +     /* The period cannot be changed on a per-PWM basis */
> > +     dev->args.period   =3D pwm->real_period;
>
> A single space before the =3D please.

Sure.

>
> > +     dev->args.polarity =3D PWM_POLARITY_NORMAL;
> > +     if (args->args[1] & PWM_POLARITY_INVERSED)
> > +             dev->args.polarity =3D PWM_POLARITY_INVERSED;
> > +
> > +     return dev;
> > +}
> > +
> > +static void sifive_pwm_update_clock(struct sifive_pwm_device *pwm,
> > +                                 unsigned long rate)
> > +{
> > +     /* (1 << (16+scale)) * 10^9/rate =3D real_period */
> > +     unsigned long scale_pow =3D (pwm->approx_period * (u64)rate) / 10=
00000000;
> > +     int scale =3D clamp(ilog2(scale_pow) - 16, 0, 0xf);
> > +
> > +     writel((1 << BIT_PWM_EN_ALWAYS) | (scale << BIT_PWM_SCALE),
> > +            pwm->regs + REG_PWMCFG);
>
> What happens with the output if you don't set the BIT_PWM_EN_ALWAYS bit?

If BIT_PWM_EN_ALWAYS is set, the PWM counter increments continuously.
If not set, PWM counter will be disabled. There won't be PWM output unless
BIT_PWM_EN_ONCE is set. In that case it will generate single PWM cycle and =
stop.

>
> > +     pwm->real_period =3D (1000000000ULL << (16 + scale)) / rate;
>
> I suggest commenting this assignment with something like: "As scale <=3D
> 15 the shift operation cannot overflow." You must use div64_ul for
> dividing an unsigned long long variable. Can it happen that the result
> is too big to be hold by read_period (which is an unsigned int only)?

Ok. Will add that comment and also use div64_ul for division.
Regarding the result, I don't think so it will be big enough to
overflow read_period.

>
> Maybe add a dev_dbg with the new real_period here.

Sure, will add it.

>
> > +}
> > +
> > +static int sifive_pwm_clock_notifier(struct notifier_block *nb,
> > +                                  unsigned long event, void *data)
> > +{
> > +     struct clk_notifier_data *ndata =3D data;
> > +     struct sifive_pwm_device *pwm =3D
> > +             container_of(nb, struct sifive_pwm_device, notifier);
> > +
> > +     if (event =3D=3D POST_RATE_CHANGE)
> > +             sifive_pwm_update_clock(pwm, ndata->new_rate);
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static int sifive_pwm_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct device_node *node =3D pdev->dev.of_node;
> > +     struct sifive_pwm_device *pwm;
> > +     struct pwm_chip *chip;
> > +     struct resource *res;
> > +     int ret;
> > +
> > +     pwm =3D devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> > +     if (!pwm)
> > +             return -ENOMEM;
> > +
> > +     chip =3D &pwm->chip;
> > +     chip->dev =3D dev;
> > +     chip->ops =3D &sifive_pwm_ops;
> > +     chip->of_xlate =3D sifive_pwm_xlate;
> > +     chip->of_pwm_n_cells =3D 2;
> > +     chip->base =3D -1;
> > +     chip->npwm =3D 4;
> > +
> > +     ret =3D of_property_read_u32(node, "sifive,approx-period",
> > +                                &pwm->approx_period);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Unable to read sifive,approx-period from DT=
S\n");
> > +             return ret;
> > +     }
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
> > +             dev_err(dev, "Unable to find controller clock\n");
>
> Please don't emit an error message if PTR_ERR(pwm->clk) is
> -EPROBE_DEFER.

Will add an "if" check.

>
> > +             return PTR_ERR(pwm->clk);
> > +     }
> > +
> > +     /* Watch for changes to underlying clock frequency */
> > +     pwm->notifier.notifier_call =3D sifive_pwm_clock_notifier;
> > +     ret =3D clk_notifier_register(pwm->clk, &pwm->notifier);
> > +     if (ret) {
> > +             dev_err(dev, "failed to register clock notifier: %d\n", r=
et);
> > +             return ret;
> > +     }
> > +
> > +     /* Initialize PWM config */
> > +     sifive_pwm_update_clock(pwm, clk_get_rate(pwm->clk));
>
> You're supposed to call clk_get_rate only after you enabled the clk.

Will fix this.

>
> > +     ret =3D pwmchip_add(chip);
> > +     if (ret < 0) {
> > +             dev_err(dev, "cannot register PWM: %d\n", ret);
> > +             clk_notifier_unregister(pwm->clk, &pwm->notifier);
> > +             return ret;
> > +     }
> > +
> > +     platform_set_drvdata(pdev, pwm);
> > +     dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sifive_pwm_remove(struct platform_device *dev)
> > +{
> > +     struct sifive_pwm_device *pwm =3D platform_get_drvdata(dev);
> > +
> > +     clk_notifier_unregister(pwm->clk, &pwm->notifier);
> > +     return pwmchip_remove(&pwm->chip);
>
> In probe you setup the clk notifier before calling pwmchip_add. So it's
> a good habit to do it the other way round in .remove.

Will change the sequence.

>
> > +}
>
> You're not using the irq that according to the dt binding is required?!

Yes, currently there is no use.

>
> Best regards
> Uwe

Thanks for the comments!

>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
