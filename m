Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EF5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2CA2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzKkRp3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2CA2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJJVgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:36:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33507 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJJVgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:36:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id y140-v6so13537160wmd.0;
        Wed, 10 Oct 2018 07:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=un0yUwG3NTyMguhX7Ggu2j1+RC+f1cHwhE2aLYBK5+Q=;
        b=FzKkRp3lgrAtKWntMUEUT1ElnB7eCZ1F+ZfbGrknGYnJK/DxMtYvVXL0zBxVdeRNY6
         19SZyY983705bz3KTiGNyvf6iFTCVRNKosu648laweT1cgm9BNsbKFFIpGwNjGvcw5ES
         RrGaMzPotWhWk96mSmb2emBd3I4YtDfrKWCJ2lZVUCGmfry8yXqoqyTAp5/NikxEhJ2t
         lhs0SLhAQ/6cn9j5rwEdwaeJXMd2tfw0vRF57jhMl6Uf0PL2vhG75uih9Xy8XPh6htKQ
         VcCeajR/nZn/L1mwH4WlkbtHoJLclqwEbPWszCpMJFLKgteXSyMWeTjRg0OmFs7YsX5c
         Nu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=un0yUwG3NTyMguhX7Ggu2j1+RC+f1cHwhE2aLYBK5+Q=;
        b=RjU6Cem9PT5u8Nrfh3D3ie7YPjF7L94odoU5tyx7IVn9XJy5PLa7DdlVG61dDD9SXX
         dwWLzck9pgnmVIYjs+SOLqExu5FpHnp5U3qCS7aMctHdj62Zj+w53Ij98G7dm5GrmnLY
         KU8ea/ShmBfJeCEaswZlPZeGtxb2wJaKcHWKBHEIhlqp4FgACc5jklsVgSWkkaHEYgY8
         AlRA06Xbol5xD2CTm+pkMnw61IjQ/a371ZAfgeI5IZB4Ly82gTCHbP0RB5XDXuRz0TXT
         ogkoUNGhGtQjqYtRlDMeo38D0Tdv1c5DnewIOUutm5aXmyDxT7oJCaKpm8kMlKDjt2oP
         mbkw==
X-Gm-Message-State: ABuFfogijwIjp81SrcORH29ZAIujjfrJSF0aXVWYtsa8tWBhNyrbgmJE
        5RfzaUFaoYX4RrZbIid+RBY=
X-Google-Smtp-Source: ACcGV61FrJmRYoHAdnRBgv34w0Ks2zIXujU8tIbitl0/jq58UCeUf+giVgLbPilZFO2NqDH4nfi8Dg==
X-Received: by 2002:a1c:3403:: with SMTP id b3-v6mr1058273wma.108.1539180823472;
        Wed, 10 Oct 2018 07:13:43 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id 199-v6sm14334926wme.39.2018.10.10.07.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 07:13:42 -0700 (PDT)
Date:   Wed, 10 Oct 2018 16:13:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, hch@infradead.org
Subject: Re: [RFC 2/4] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20181010141341.GF21134@ulmo>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-3-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L2Brqb15TUChFOBK"
Content-Disposition: inline
In-Reply-To: <1539111085-25502-3-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 09, 2018 at 11:51:23AM -0700, Atish Patra wrote:
> From: "Wesley W. Terpstra" <wesley@sifive.com>
>=20
> Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC.
>=20
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Various fixes and code cleanup]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  drivers/pwm/Kconfig      |  10 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-sifive.c | 240 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 251 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sifive.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 504d2527..dd12144d 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -378,6 +378,16 @@ config PWM_SAMSUNG
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-samsung.
> =20
> +config PWM_SIFIVE
> +	tristate "SiFive PWM support"
> +	depends on OF
> +	depends on COMMON_CLK
> +	help
> +	  Generic PWM framework driver for SiFive SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sifive.
> +
>  config PWM_SPEAR
>  	tristate "STMicroelectronics SPEAr PWM support"
>  	depends on PLAT_SPEAR
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9c676a0d..30089ca6 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> +obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SPEAR)		+=3D pwm-spear.o
>  obj-$(CONFIG_PWM_STI)		+=3D pwm-sti.o
>  obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> new file mode 100644
> index 00000000..99580025
> --- /dev/null
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017 SiFive
> + */
> +#include <dt-bindings/pwm/pwm.h>

What do you need this for? Your driver should only be dealing with enum
pwm_polarity, not the defines from the above header. This works but only
because PWM_POLARITY_INVERTED and PWM_POLARITY_INVERSED happen to be the
same value.

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>

Keep these in alphabetical order, please.

> +
> +#define MAX_PWM			4
> +
> +/* Register offsets */
> +#define REG_PWMCFG		0x0
> +#define REG_PWMCOUNT		0x8
> +#define REG_PWMS		0x10
> +#define	REG_PWMCMP0		0x20
> +
> +/* PWMCFG fields */
> +#define BIT_PWM_SCALE		0
> +#define BIT_PWM_STICKY		8
> +#define BIT_PWM_ZERO_ZMP	9
> +#define BIT_PWM_DEGLITCH	10
> +#define BIT_PWM_EN_ALWAYS	12
> +#define BIT_PWM_EN_ONCE		13
> +#define BIT_PWM0_CENTER		16
> +#define BIT_PWM0_GANG		24
> +#define BIT_PWM0_IP		28
> +
> +#define SIZE_PWMCMP		4
> +#define MASK_PWM_SCALE		0xf
> +
> +struct sifive_pwm_device {
> +	struct pwm_chip		chip;
> +	struct notifier_block	notifier;
> +	struct clk		*clk;
> +	void __iomem		*regs;
> +	unsigned int		approx_period;
> +	unsigned int		real_period;
> +};

No need to align these. A single space is enough to separate variable
type and name.

> +
> +static inline struct sifive_pwm_device *to_sifive_pwm_chip(struct pwm_ch=
ip *c)
> +{
> +	return container_of(c, struct sifive_pwm_device, chip);
> +}
> +
> +static int sifive_pwm_apply(struct pwm_chip *chip, struct pwm_device *de=
v,
> +			    struct pwm_state *state)
> +{
> +	struct sifive_pwm_device *pwm =3D to_sifive_pwm_chip(chip);
> +	unsigned int duty_cycle;
> +	u32 frac;
> +
> +	duty_cycle =3D state->duty_cycle;
> +	if (!state->enabled)
> +		duty_cycle =3D 0;
> +	if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +		duty_cycle =3D state->period - duty_cycle;

That's not actually polarity inversion. This is "lightweight" inversion
which should be up to the consumer, not the PWM driver, to implement. If
you don't actually have a knob in hardware to switch the polarity, don't
support it.

> +
> +	frac =3D ((u64)duty_cycle << 16) / state->period;
> +	frac =3D min(frac, 0xFFFFU);
> +
> +	iowrite32(frac, pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));

writel()?

> +
> +	if (state->enabled) {
> +		state->period =3D pwm->real_period;
> +		state->duty_cycle =3D ((u64)frac * pwm->real_period) >> 16;
> +		if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +			state->duty_cycle =3D state->period - state->duty_cycle;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sifive_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e *dev,
> +				 struct pwm_state *state)
> +{
> +	struct sifive_pwm_device *pwm =3D to_sifive_pwm_chip(chip);
> +	unsigned long duty;
> +
> +	duty =3D ioread32(pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));

readl()? Maybe also change duty to u32, which is what readl() returns.

> +
> +	state->period     =3D pwm->real_period;
> +	state->duty_cycle =3D ((u64)duty * pwm->real_period) >> 16;
> +	state->polarity   =3D PWM_POLARITY_INVERSED;
> +	state->enabled    =3D duty > 0;
> +}
> +
> +static const struct pwm_ops sifive_pwm_ops =3D {
> +	.get_state	=3D sifive_pwm_get_state,
> +	.apply		=3D sifive_pwm_apply,
> +	.owner		=3D THIS_MODULE,

Again, no need to artificially align these.

> +};
> +
> +static struct pwm_device *sifive_pwm_xlate(struct pwm_chip *chip,
> +					   const struct of_phandle_args *args)
> +{
> +	struct sifive_pwm_device *pwm =3D to_sifive_pwm_chip(chip);
> +	struct pwm_device *dev;
> +
> +	if (args->args[0] >=3D chip->npwm)
> +		return ERR_PTR(-EINVAL);
> +
> +	dev =3D pwm_request_from_chip(chip, args->args[0], NULL);
> +	if (IS_ERR(dev))
> +		return dev;
> +
> +	/* The period cannot be changed on a per-PWM basis */
> +	dev->args.period   =3D pwm->real_period;
> +	dev->args.polarity =3D PWM_POLARITY_NORMAL;
> +	if (args->args[1] & PWM_POLARITY_INVERTED)
> +		dev->args.polarity =3D PWM_POLARITY_INVERSED;
> +
> +	return dev;
> +}
> +
> +static void sifive_pwm_update_clock(struct sifive_pwm_device *pwm,
> +				    unsigned long rate)
> +{
> +	/* (1 << (16+scale)) * 10^9/rate =3D real_period */
> +	unsigned long scalePow =3D (pwm->approx_period * (u64)rate) / 100000000=
0;
> +	int scale =3D ilog2(scalePow) - 16;
> +
> +	scale =3D clamp(scale, 0, 0xf);
> +	iowrite32((1 << BIT_PWM_EN_ALWAYS) | (scale << BIT_PWM_SCALE),
> +		  pwm->regs + REG_PWMCFG);
> +
> +	pwm->real_period =3D (1000000000ULL << (16 + scale)) / rate;
> +}
> +
> +static int sifive_pwm_clock_notifier(struct notifier_block *nb,
> +				     unsigned long event, void *data)
> +{
> +	struct clk_notifier_data *ndata =3D data;
> +	struct sifive_pwm_device *pwm =3D container_of(nb,
> +						     struct sifive_pwm_device,
> +						     notifier);
> +
> +	if (event =3D=3D POST_RATE_CHANGE)
> +		sifive_pwm_update_clock(pwm, ndata->new_rate);
> +
> +	return NOTIFY_OK;
> +}

Does this mean that the PWM source clock can be shared with other IP
blocks? What happens if some other user sets a frequency that we can't
support? Or what if the clock rate change results in a real period that
is out of the limits that are considered valid?

> +static int sifive_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *node =3D pdev->dev.of_node;
> +	struct sifive_pwm_device *pwm;
> +	struct pwm_chip *chip;
> +	struct resource *res;
> +	int ret;
> +
> +	pwm =3D devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	chip =3D &pwm->chip;
> +	chip->dev =3D dev;
> +	chip->ops =3D &sifive_pwm_ops;
> +	chip->of_xlate =3D sifive_pwm_xlate;
> +	chip->of_pwm_n_cells =3D 2;
> +	chip->base =3D -1;
> +
> +	ret =3D of_property_read_u32(node, "sifive,npwm", &chip->npwm);
> +	if (ret < 0 || chip->npwm > MAX_PWM)
> +		chip->npwm =3D MAX_PWM;

This property is not documented. Also, why is it necessary? Do you
expect the number of PWMs to differ depending on the instance of the IP
block? I would argue that the number of PWMs can be derived from the
compatible string, so it's unnecessary here.

I think you can also remove the MAX_PWM macro, since that's only used in
one location and it's meaning is very clear in the context, so the
symbolic name isn't useful.

> +
> +	ret =3D of_property_read_u32(node, "sifive,approx-period",
> +				   &pwm->approx_period);
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to read sifive,approx-period from DTS\n");
> +		return -ENOENT;
> +	}

Maybe propagate ret instead of always returning -ENOENT?

> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwm->regs =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pwm->regs)) {
> +		dev_err(dev, "Unable to map IO resources\n");
> +		return PTR_ERR(pwm->regs);
> +	}
> +
> +	pwm->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(pwm->clk)) {
> +		dev_err(dev, "Unable to find controller clock\n");
> +		return PTR_ERR(pwm->clk);
> +	}
> +
> +	/* Watch for changes to underlying clock frequency */
> +	pwm->notifier.notifier_call =3D sifive_pwm_clock_notifier;
> +	clk_notifier_register(pwm->clk, &pwm->notifier);

Check for errors from this?

> +
> +	/* Initialize PWM config */
> +	sifive_pwm_update_clock(pwm, clk_get_rate(pwm->clk));
> +
> +	/* No interrupt handler needed yet */

That's not a useful comment.

> +
> +	ret =3D pwmchip_add(chip);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot register PWM: %d\n", ret);
> +		clk_notifier_unregister(pwm->clk, &pwm->notifier);

Might be worth introducing a managed version of clk_notifier_register()
so that we can avoid having to unregister it.

> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +	dev_info(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);

Remove this, or at least make it dev_dbg(). This is not noteworthy news,
so no need to bother the user with it.

> +
> +	return 0;
> +}
> +
> +static int sifive_pwm_remove(struct platform_device *dev)
> +{
> +	struct sifive_pwm_device *pwm =3D platform_get_drvdata(dev);
> +	struct pwm_chip *chip =3D &pwm->chip;

Not sure that this intermediate variable is useful, might as well use
&pwm->chip in the one location where you need it.

> +
> +	clk_notifier_unregister(pwm->clk, &pwm->notifier);
> +	return pwmchip_remove(chip);
> +}
> +
> +static const struct of_device_id sifive_pwm_of_match[] =3D {
> +	{ .compatible =3D "sifive,pwm0" },
> +	{ .compatible =3D "sifive,fu540-c000-pwm0" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sifive_pwm_of_match);
> +
> +static struct platform_driver sifive_pwm_driver =3D {
> +	.probe =3D sifive_pwm_probe,
> +	.remove =3D sifive_pwm_remove,
> +	.driver =3D {
> +		.name =3D "pwm-sifivem",

Why does this have the 'm' at the end? I don't see that anywhere else in
the names.

> +		.of_match_table =3D of_match_ptr(sifive_pwm_of_match),

No need for of_match_ptr() here since you depend on OF, so this is
always going to expand to sifive_pwm_of_match.

Thierry

--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu+CRIACgkQ3SOs138+
s6Er3A//b5xfkj8rndHgrpe/FZw3MP3HGcN32nXIinKMtn9hOIQ6RJ57/GgOZ5ai
pfzD0K4srV29jVKiHJ1Arh9lSNYb6bPxcQ3m8o94Vx728FI4R3VuvynnlEGvdMhn
176t4A2HuSRiwBJPLsw/fljVKCfDLnhnhchEWsmATir4bcswm5okh7fnIjPH7UD8
y/44px9i1ZgqUpgEkeuGaqquZYuxjqCe3YNVeQ/vMY+AB0YoGSMEkdKbHR3gMrBm
dH9E7LfTwZAblo+fILZoaYZoHQbejWl5Kx7tgxmwdTem/gt2pPKi0k4yQ7xiP3sW
fD7qXoLeoTCNYFJJnl7eozTCtap9KWvzNLOWFM46daL9aq2SmjZXcQVOXHBSxnFY
+i8A4a9TwWSWTHj34M4eRajYWpn1OwIG1vhYnBrUbfsRXm2ehNSr+YIOasb4zqZ5
sKaFguEtKl2YlIXXXYUWaFY51OlTuBlMgoT0Fd877qjaImYRLkwVt9/8aE76sHrE
6UiY5uumFwJlvPilIyViqxAkPnqPXpGKKY6eOXmNOStSR02xdqn2SXkVKEhTMZw5
vPnbLM0gkCtgKv3t6KrjzVaOZ+3Bye1Rn+ikH0+F5Q6u6i+xu01awtAsERjEM/NB
dAfuqgmHJuxZYTdChE74+Iwttm+JCTReL5xzEaJjcm+HwFZhlfQ=
=pNF+
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--
