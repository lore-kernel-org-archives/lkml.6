Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A29C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13B220663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVJ9IxM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfAULap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:30:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33786 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbfAULao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:30:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so22952563wrr.0;
        Mon, 21 Jan 2019 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mnTU2JyyziVhsFT/PUFFS0Dhiz+5OeVNk8iNBBaCWsA=;
        b=TVJ9IxM4egmGw/+ghHvZRmEQkAy1gS+CSuu5W0S1gEewV4DeIIKOMmI/ydOFiC4Ngj
         dOehenZMmJpym4OlGmSGiFJrYt/9BK82Xkb/Wdp2oPvOruQ1ujnmQYES/0Y+bBeTnTtg
         2sTACTaW2VtYDZDoBOI+Uw16VBRL85rkdNg/0qU/XQ97bORw9NH82pfuum4aL13oKWL5
         87/FsnEdnBwL2QNdcwj1rv1VvBCiNhanpyrpoXwkImlFKvDZDPLKm1FLWY4LF7GiVlgQ
         obLWUjO1BL70rjB9Pvs1EbB7JYVG0hEdl45c46FWN3tuwAtRL6SsjiHj1HTgM7eMu5qn
         9X1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mnTU2JyyziVhsFT/PUFFS0Dhiz+5OeVNk8iNBBaCWsA=;
        b=NG55meH6iSAGAJSDw3CKTCpaLaPjY4/4vXg8hRT8oKNtIZrPf+6NE67UFEzZFj48yv
         CHynXD54ue53hJAAhYvpxC2emmO4ZhYWHc2V7jy+3t8mCWEtN2nXG3S042wlXrIT4B8h
         x7p8xZ/Fjr8VnBppAQesrlJPt5XUIvQGmiaL8lSHzzeMr1HmL53N0AAfMMK8P5BrBHOb
         zfyQFiXk2HBtx9torZji/pmQnNRUistoA5n02c6DBDNHMf7jhDPNa1Gcm1UeVfuGXkxY
         w3JkLx936X9325cxyvhmW6xgampdP5nVQbpzr+/9Zlry8NxsYQfaQlDEso0xGb6l1q0C
         tEcA==
X-Gm-Message-State: AJcUukcheAXn+FSPzggQrlZq7g+DlmU+FhbERkSb5UyvxztMh1x9myB3
        Fzh61zoKH2g3mymb0Yz/S4M=
X-Google-Smtp-Source: ALg8bN7qlbRepS1CrYVIP8szHJ8UxXlCcXeDjtZpm0H8yhM7shfVRWRKVyVBah27d2nyE9FHibaABQ==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr29201871wrt.241.1548070241927;
        Mon, 21 Jan 2019 03:30:41 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id v133sm40079446wmf.19.2019.01.21.03.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 03:30:41 -0800 (PST)
Date:   Mon, 21 Jan 2019 12:30:39 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Yash Shah <yash.shah@sifive.com>, palmer@sifive.com,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190121113039.GI16756@ulmo>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
 <20190115220046.etgbno6ymsux75dk@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Content-Disposition: inline
In-Reply-To: <20190115220046.etgbno6ymsux75dk@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 11:00:46PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC.
> >=20
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
> >=20
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index a8f47df..3bcaf6a 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-samsung.
> > =20
> > +config PWM_SIFIVE
> > +	tristate "SiFive PWM support"
> > +	depends on OF
> > +	depends on COMMON_CLK
>=20
> I'd say add:
>=20
> 	depends on MACH_SIFIVE || COMPILE_TEST
>=20
> (I guess "MACH_SIFIVE" is wrong, but I assume you get what I mean.)
>=20
> > +	help
> > +	  Generic PWM framework driver for SiFive SoCs.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-sifive.
> > +
> >  config PWM_SPEAR
> >  	tristate "STMicroelectronics SPEAr PWM support"
> >  	depends on PLAT_SPEAR
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 9c676a0..30089ca 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> > +obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> >  obj-$(CONFIG_PWM_SPEAR)		+=3D pwm-spear.o
> >  obj-$(CONFIG_PWM_STI)		+=3D pwm-sti.o
> >  obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
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
> > + * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pdf
>=20
> I wonder if such an instance should be only a single PWM instead of
> four. Then you were more flexible with the period lengths (using
> pwmcfg.pwmzerocmp) and could do stuff like inverted and uninverted mode.

I thought this IP only allowed a single period for all PWM channels in
the IP. If so, splitting this into four different devices is going to
complicate things because you'd have to coordinate between all four as
to which period is currently set.

> > +struct sifive_pwm_device {
> > +	struct pwm_chip	chip;
> > +	struct notifier_block notifier;
> > +	struct clk *clk;
> > +	void __iomem *regs;
> > +	unsigned int approx_period;
> > +	unsigned int real_period;
> > +};
>=20
> I'd call this pwm_sifive_ddata. The prefix because the driver is called
> pwm-sifive and ddata because this is driver data and not a device.

I don't think there's a need to have an extra suffix. Just call this
sifive_pwm or pwm_sifive. There's no ambiguity in that name and it's
short and crisp.

> > +	if (state->enabled)
> > +		sifive_pwm_get_state(chip, dev, state);
>=20
> @Thierry: Should we bless this correction of state?

I'm not sure I understand why this correction is necessary. Is it okay
to request a state to be applied and when we're not able to set that
state we just set anything as close as possible? Sounds a bit risky to
me. What if somebody wants to use this in a case where precision
matters?

Now, if you're saying that there can't be such cases and we should
support this, then why restrict the state correction to when the PWM is
enabled? What's wrong with correcting it in either case?

Thierry

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxFrVwACgkQ3SOs138+
s6GDPhAAqq3K+XU1yZmkcnkI1Zx0WumCOVIx3+P1YxoZRny1aaps0RIVvR3FIoFv
1I0P/4cuDQ1nUHh8ejdmqE/0uT/+bpxxWg3srsjaKkaSM3TutdX4EPk929EP91oJ
QIXFTxGm3FBeKbd5wdgqC5zLhC3hDowCpH+vyOB+YiW9bn2EBOQwnCwkeRpOAIVG
q2Er9KwCuKd1wIT+jCvprKOCnwui7ycZ2ycLbxRiBNMwcRBUfSMy6J6dZ0CJKMdD
uoSS1XWSOmLymi1g5Ibdii+VGxhXssfR9+YKvgdqJ0kkNqUZ8zrbHinNn0zuPSZH
SJSNZ0QCAOkvgPFTwFR/QV0DnBu/i8pgybpPawLkwA10QAIe4D5vheHI9YgvTxE3
9GNuFbUR1r52guNBF00ht3Wvxzu8WaoYwIOMhIDUrQJ4QA8c8eq+1GIJwXhvnzOH
xW93VlukNv+TmgzE60/9a6JgelKFUw0Iu+yYWs7kFq4WAgPiz9E5TiwoitZq4j5/
81HxqupXIT1jqI0W3JI6ZdVFk6gYEKts2CLIJKu9IIll59T3R8bS+dRdzp3Zm+JY
xO3+m7Kt97Nnz+e0SakZ64dnQF50QR+hv+Pd5jNPiLFfeU9sVpULG03tph0vg/0Q
Qn472hhDUD0VP1zBZxBl8DX0H/yOMaqnKHYyzIKN+JwOrJ/HH3A=
=aoyh
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--
