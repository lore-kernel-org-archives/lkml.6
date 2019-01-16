Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DCDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE10620657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DzmD7b0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389676AbfAPLLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:11:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33234 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389626AbfAPLLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:11:22 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so4593029lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 03:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8xQUdo1GwF1PIhMykfW6uVMxaCwSHcQHQnFh8SgzU6Q=;
        b=DzmD7b0H3+XOl49d4jrmFCR93+moC3C1wAc7HaSHpKLlMzwNI2gjIXuApnxnXYTO4v
         Wag2+VYGJf8L6HFUai6jPpVKKFSmbhJ4v6w2Z+RXXR91eiP9ZikLibF10cPsxU3fFT1J
         DsEd8jmPEWaANG7dQ4ENpxQD5KaZNV8degQ5pJVh/9BEs1Am3yciTSqWBsOVIYji3CUg
         q4wpPc2ZRjY1ACCVluZRxnta0HiD0c9al92dQCf/ByTUn3dVIopaS3lT9+eKOzVNtfSn
         dsJsQl8WPl+XmUQE+BeDj0IY5DIhoTAbv0G5+GESTc0stAG5P8sJaagJTfFLi1ngcpoK
         HcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8xQUdo1GwF1PIhMykfW6uVMxaCwSHcQHQnFh8SgzU6Q=;
        b=gPL2AVREK2RJWNgsPlcVaI9yQM9omPeonDU7KQtxptlMYy3wnVwK4lAPRcYCmhNmUs
         31KO71wvNzyMUde6GwnGnYxgXBDEiguhDnvOcr6pu8YznvID6A1abGmuHhlQglgThWLC
         wo7Jf21P7aVZJ5ey2KpFqttShvH93Q+O+pfnDVysEWWN3F55xwjyxh+oGCzTbVDEiEyF
         xDO8grEc1Ehp4j4fL/KdapxlIzYu1J00g16jertmPdH7yN7kddJNhdDPBdZ66/7dgR6e
         f50w/cqhCANwWhoDCvketVN8vRoIeZx2WHLh3lhnqtcU0Q73jfXRuuZf2HD/CLxaWsNA
         g6Yg==
X-Gm-Message-State: AJcUukeNB1sv9hzwaz/LwmM291h3doz/8oSl29DZALJAoU8eY9gZFvm+
        joPegM1QH4VEPxg8zB5K1yqx0Y31DU7rpmgZfPP4xA==
X-Google-Smtp-Source: ALg8bN7kUBWt7roMnbHJLkybNbOMZYmtEKgmFTFX0jCAgJUs3372xXMWc73CNaYoAg3Q6R/KdACL3K6BHMhTP3bcnUo=
X-Received: by 2002:a19:5402:: with SMTP id i2mr6428836lfb.128.1547637079175;
 Wed, 16 Jan 2019 03:11:19 -0800 (PST)
MIME-Version: 1.0
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com> <20190115220046.etgbno6ymsux75dk@pengutronix.de>
In-Reply-To: <20190115220046.etgbno6ymsux75dk@pengutronix.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Wed, 16 Jan 2019 16:40:42 +0530
Message-ID: <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
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

On Wed, Jan 16, 2019 at 3:30 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC=
.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Various fixes and code cleanup]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  drivers/pwm/Kconfig      |  10 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-sifive.c | 246 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 257 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-sifive.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index a8f47df..3bcaf6a 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-samsung.
> >
> > +config PWM_SIFIVE
> > +     tristate "SiFive PWM support"
> > +     depends on OF
> > +     depends on COMMON_CLK
>
> I'd say add:
>
>         depends on MACH_SIFIVE || COMPILE_TEST
>
> (I guess "MACH_SIFIVE" is wrong, but I assume you get what I mean.)

As of now, MACH_SIFIVE/ARCH_SIFIVE isn't available.
@Paul, Do you have any comments on this?

>
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
> > index 0000000..7fee809
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -0,0 +1,246 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2017-2018 SiFive
> > + * For SiFive's PWM IP block documentation please refer Chapter 14 of
> > + * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pd=
f
>
> I wonder if such an instance should be only a single PWM instead of
> four. Then you were more flexible with the period lengths (using
> pwmcfg.pwmzerocmp) and could do stuff like inverted and uninverted mode.
>
> I didn't understand how the deglitch logic works yet. Currently it is
> not used which might result in four edges in a single period (which is
> bad).

I can enable deglitch logic by just setting a bit (BIT_PWM_DEGLITCH) in
REG_PWMCFG. Will do that.

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
>
> I suggest a common prefix for these defines. Something like
> PWM_SIFIVE_

Sure.

>
> > +
> > +/* PWMCFG fields */
> > +#define BIT_PWM_SCALE                0
> > +#define BIT_PWM_STICKY               8
> > +#define BIT_PWM_ZERO_ZMP     9
>
> the manual calls this "pwmzerocmp".

Will fix this.

>
> > +#define BIT_PWM_DEGLITCH     10
> > +#define BIT_PWM_EN_ALWAYS    12
> > +#define BIT_PWM_EN_ONCE              13
> > +#define BIT_PWM0_CENTER              16
> > +#define BIT_PWM0_GANG                24
> > +#define BIT_PWM0_IP          28
>
> Also a common prefix please. Something like PWM_SIFIVE_PWMCFG_ seems
> sensible.

Sure.

>
> > +#define SIZE_PWMCMP          4
>
> Please describe what this constant means. I think this is "ncmp" in the
> reference manual. If so, using PWM_SIFIVE_NCMP as name instead seems
> adequate.

No, it is not ncmp. It is used to calculate the offset for pwmcmp registers=
.
I will add the description for the above constant.

>
> > +#define MASK_PWM_SCALE               0xf
>
> MASK_PWM_SCALE is unused, please drop it.

Sure.

>
> > +struct sifive_pwm_device {
> > +     struct pwm_chip chip;
> > +     struct notifier_block notifier;
> > +     struct clk *clk;
> > +     void __iomem *regs;
> > +     unsigned int approx_period;
> > +     unsigned int real_period;
> > +};
>
> I'd call this pwm_sifive_ddata. The prefix because the driver is called
> pwm-sifive and ddata because this is driver data and not a device.

Will be done.

>
> > +static inline struct sifive_pwm_device *to_sifive_pwm_chip(struct pwm_=
chip *c)
> > +{
> > +     return container_of(c, struct sifive_pwm_device, chip);
> > +}
> > +
> > +static void sifive_pwm_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *dev,
> > +                              struct pwm_state *state)
>
> given that the driver is called pwm-sifive, please use pwm_sifive as
> function prefix.

Sure. Will change it for all functions.

>
> > +{
> > +     struct sifive_pwm_device *pwm =3D to_sifive_pwm_chip(chip);
> > +     u32 duty;
> > +
> > +     duty =3D readl(pwm->regs + REG_PWMCMP0 + dev->hwpwm * SIZE_PWMCMP=
);
> > +
> > +     state->period =3D pwm->real_period;
> > +     state->duty_cycle =3D ((u64)duty * pwm->real_period) >> 16;
>
> In the reference manual this 16 is called "cmpwidth" I think. If I
> understand correctly this might in theory be different from 16, so it
> would be great if this would be at least a cpp symbol for now.

I assume you meant to add a macro for cmpwidth and use it here.
Will be done.

>
> > +     state->polarity =3D PWM_POLARITY_INVERSED;
> > +     state->enabled =3D duty > 0;
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
> > +     if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > +             return -EINVAL;
> > +
> > +     duty_cycle =3D state->duty_cycle;
> > +     if (!state->enabled)
> > +             duty_cycle =3D 0;
> > +
> > +     frac =3D div_u64((u64)duty_cycle << 16, state->period);
> > +     frac =3D min(frac, 0xFFFFU);
>
> In the previous review round I asked here:
>
> | Also if real_period is for example 10 ms and the consumer requests
> | duty=3D12 ms + period=3D100 ms, the hardware is configured for duty=3D1=
.2 ms +
> | period=3D10 ms, right?
>
> which you confirmed. IMHO this is not acceptable. If the period is
> fixed, you should return -EINVAL (I think) if a different period is
> requested.

Will return -EINVAL on state->period !=3D pwm->real_period

>
> > +     writel(frac, pwm->regs + REG_PWMCMP0 + dev->hwpwm * SIZE_PWMCMP);
>
> If you get a constant inactive output with frac=3D0 and a constant active
> output with frac=3D0xffff the calculation above seems wrong to me.
> (A value i written to the pwmcmpX register means a duty cycle of
> (i * period / 0xffff). Your calculation assumes a divisor of 0x10000
> however.)

Not sure if I get you completely. But, if divisor of 0xffff is your concern=
 then
does the below look ok?

frac =3D div_u64(((u64)duty_cycle << 16) - duty_cycle, state->period);

>
> > +
> > +     if (state->enabled)
> > +             sifive_pwm_get_state(chip, dev, state);
>
> @Thierry: Should we bless this correction of state?
>
> > +
> > +     return 0;
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
> > +     dev->args.period =3D pwm->real_period;
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
>
> NSEC_PER_SEC instead of 1000000000

Will be done.

>
> > +     int scale =3D clamp(ilog2(scale_pow) - 16, 0, 0xf);
> > +
> > +     writel((1 << BIT_PWM_EN_ALWAYS) | (scale << BIT_PWM_SCALE),
> > +            pwm->regs + REG_PWMCFG);
> > +
> > +     /* As scale <=3D 15 the shift operation cannot overflow. */
> > +     pwm->real_period =3D div64_ul(1000000000ULL << (16 + scale), rate=
);
> > +     dev_dbg(pwm->chip.dev, "New real_period =3D %u ns\n", pwm->real_p=
eriod);
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
>
> Does this need locking? (Maybe not with the current state.)

No. We can add it when required.

>
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
> > +     ret =3D of_property_read_u32(node, "sifive,approx-period-ns",
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
> > +     pwm->notifier.notifier_call =3D sifive_pwm_clock_notifier;
> > +     ret =3D clk_notifier_register(pwm->clk, &pwm->notifier);
> > +     if (ret) {
> > +             dev_err(dev, "failed to register clock notifier: %d\n", r=
et);
> > +             clk_disable_unprepare(pwm->clk);
> > +             return ret;
> > +     }
> > +
> > +     /* Initialize PWM config */
> > +     sifive_pwm_update_clock(pwm, clk_get_rate(pwm->clk));
> > +
> > +     ret =3D pwmchip_add(chip);
> > +     if (ret < 0) {
> > +             dev_err(dev, "cannot register PWM: %d\n", ret);
> > +             clk_notifier_unregister(pwm->clk, &pwm->notifier);
> > +             clk_disable_unprepare(pwm->clk);
> > +             return ret;
> > +     }
>
> Can you please use a common error path using goto?

Sure.

>
> > +     platform_set_drvdata(pdev, pwm);
> > +     dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sifive_pwm_remove(struct platform_device *dev)
> > +{
> > +     struct sifive_pwm_device *pwm =3D platform_get_drvdata(dev);
> > +     int ret;
> > +
> > +     ret =3D pwmchip_remove(&pwm->chip);
> > +     clk_notifier_unregister(pwm->clk, &pwm->notifier);
> > +     clk_disable_unprepare(pwm->clk);
> > +     return ret;
> > +}
> > +
> > +static const struct of_device_id sifive_pwm_of_match[] =3D {
> > +     { .compatible =3D "sifive,pwm0" },
> > +     { .compatible =3D "sifive,fu540-c000-pwm" },
>
> Do you really need both compatible strings here?

I believe I can remove the second compatible string.
@Paul, Correct me if I am wrong.

>
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, sifive_pwm_of_match);
> > +
> > +static struct platform_driver sifive_pwm_driver =3D {
> > +     .probe =3D sifive_pwm_probe,
> > +     .remove =3D sifive_pwm_remove,
> > +     .driver =3D {
> > +             .name =3D "pwm-sifive",
> > +             .of_match_table =3D sifive_pwm_of_match,
> > +     },
> > +};
> > +module_platform_driver(sifive_pwm_driver);
> > +
> > +MODULE_DESCRIPTION("SiFive PWM driver");
> > +MODULE_LICENSE("GPL v2");
>
> Best regards
> Uwe

Thanks for the comments.

>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
