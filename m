Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E155C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EA92148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6H2XO3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfA1PJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:09:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39758 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1PJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:09:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so18429489wra.6;
        Mon, 28 Jan 2019 07:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jLRLeJJ4vXgRYRkUNOKN95IL2dl3P67YmfBbj4Dgqi0=;
        b=g6H2XO3ay5npAXtszIVyDrbEzXJvLcxNvM/nNT7uko/Uu3ekJr56zehiwhL6dgah94
         CFyaxMbkzIhnf6SeZlF8/GbNdo0DRVAYNBFp89/xzTtB1iBor81DMBgyJn6I721AY6Kl
         2o5Afov430OIP6HhbUiFDz3IOyEDnYPkRQ85caV2E+nXx6jG0/4KX/RtT+0KY6Ev85AS
         Q+fvSQ2gW5hJ6ckWuLbGh32YKgT75v4EWb4SZ6C5iEnDIP9/Qg16TCD/CZ9ajb9pTicI
         O9Hj1DKkyr/fqK959Q9arR1wcLaNjCRxkQCoVcCsrQLQiNNruWwRp1Aql6E5eYiaabmT
         7ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jLRLeJJ4vXgRYRkUNOKN95IL2dl3P67YmfBbj4Dgqi0=;
        b=ipvRxSYk0vhSQ82MaVXYVISW6ek0t+LlmZpQMCehHj9wL7B20VL/bfsSeyExuKcauC
         IMDIZ+EMdKXz5mLgkEmBK4X4bm4h1EAnJOZTSPY737DfeC7O3kuBpri9d0lm/NrDHoWY
         TgXjkxikuw6dRh6dQN4cH7m16CuOgOaRndMjBXxDJgL0gQNQqsFqNTNSoAIYz+9ko+Vi
         4e7igNwCdNnECq/AbOuG6MOHxY0mFxopHwX6KkBION+i5rPgJOqRWJSGZDiUTvz9ft2k
         hRCoJmAAY2pkdNd1vJRBAM5bs85EtQDF1TdcE5Ua21RzNRZTdh5lS1Mj37/oCDwMn+5l
         ZUqw==
X-Gm-Message-State: AJcUukfjionEzuyxVQOpQisc1z7/K84TzhW4NIWy0H5eigNgNOko9OUV
        0rhlZhmpIY3k4YyH94oQxGEbwMYyL1k=
X-Google-Smtp-Source: ALg8bN5EvbpcKs5FyQwh+cGZrxdR3rDt9NdbsYU1dxIpgBf7jqAayLIDea4IoyeIZfwCxyQ9ABu6kw==
X-Received: by 2002:adf:fc09:: with SMTP id i9mr21306085wrr.299.1548688151119;
        Mon, 28 Jan 2019 07:09:11 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id f3sm8023821wmd.22.2019.01.28.07.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 07:09:10 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:09:08 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joseph Lo <josephl@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/6] clocksource: tegra: add Tegra210 timer driver
Message-ID: <20190128150908.GB31317@ulmo>
References: <20190128091815.7040-1-josephl@nvidia.com>
 <20190128091815.7040-3-josephl@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <20190128091815.7040-3-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 05:18:11PM +0800, Joseph Lo wrote:
> Add support for the Tegra210 timer that runs at oscillator clock
> (TMR10-TMR13). We need these timers to work as clock event device and to
> replace the ARMv8 architected timer due to it can't survive across the
> power cycle of the CPU core or CPUPORESET signal. So it can't be a wake-up
> source when CPU suspends in power down state.
>=20
> Based on the work of Antti P Miettinen <amiettinen@nvidia.com>
>=20
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> v2:
>  * add error clean-up code
> ---
>  drivers/clocksource/Kconfig          |   3 +
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/timer-tegra210.c | 268 +++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h           |   1 +
>  4 files changed, 273 insertions(+)
>  create mode 100644 drivers/clocksource/timer-tegra210.c
>=20
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a9e26f6a81a1..e6e3e64b6320 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -135,6 +135,9 @@ config TEGRA_TIMER
>  	help
>  	  Enables support for the Tegra driver.
> =20
> +config TEGRA210_TIMER
> +	def_bool ARCH_TEGRA_210_SOC
> +
>  config VT8500_TIMER
>  	bool "VT8500 timer driver" if COMPILE_TEST
>  	depends on HAS_IOMEM
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index cdd210ff89ea..95de59c8a47b 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_SUN4I_TIMER)	+=3D timer-sun4i.o
>  obj-$(CONFIG_SUN5I_HSTIMER)	+=3D timer-sun5i.o
>  obj-$(CONFIG_MESON6_TIMER)	+=3D timer-meson6.o
>  obj-$(CONFIG_TEGRA_TIMER)	+=3D timer-tegra20.o
> +obj-$(CONFIG_TEGRA210_TIMER)	+=3D timer-tegra210.o
>  obj-$(CONFIG_VT8500_TIMER)	+=3D timer-vt8500.o
>  obj-$(CONFIG_NSPIRE_TIMER)	+=3D timer-zevio.o
>  obj-$(CONFIG_BCM_KONA_TIMER)	+=3D bcm_kona_timer.o
> diff --git a/drivers/clocksource/timer-tegra210.c b/drivers/clocksource/t=
imer-tegra210.c
> new file mode 100644
> index 000000000000..477b164e540b
> --- /dev/null
> +++ b/drivers/clocksource/timer-tegra210.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2019, NVIDIA CORPORATION.  All rights reserved.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/percpu.h>
> +#include <linux/syscore_ops.h>
> +
> +static u32 tegra210_timer_freq;
> +static void __iomem *tegra210_timer_reg_base;
> +static u32 usec_config;
> +
> +#define TIMER_PTV		0x0
> +#define TIMER_PTV_EN		BIT(31)
> +#define TIMER_PTV_PER		BIT(30)
> +#define TIMER_PCR		0x4
> +#define TIMER_PCR_INTR_CLR	BIT(30)
> +#define TIMERUS_CNTR_1US	0x10
> +#define TIMERUS_USEC_CFG	0x14
> +
> +#define TIMER10_OFFSET		0x90
> +#define TIMER10_IRQ_IDX		10
> +
> +#define TIMER_FOR_CPU(cpu) (TIMER10_OFFSET + (cpu) * 8)
> +#define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)
> +
> +struct tegra210_clockevent {
> +	struct clock_event_device evt;
> +	char name[20];
> +	void __iomem *reg_base;
> +};
> +#define to_tegra_cevt(p) (container_of(p, struct tegra210_clockevent, ev=
t))
> +
> +static struct tegra210_clockevent __percpu *tegra210_evt;
> +
> +static int tegra210_timer_set_next_event(unsigned long cycles,
> +					 struct clock_event_device *evt)
> +{
> +	struct tegra210_clockevent *tevt;
> +
> +	tevt =3D to_tegra_cevt(evt);
> +	writel(TIMER_PTV_EN |
> +	       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
> +	       tevt->reg_base + TIMER_PTV);
> +
> +	return 0;
> +}
> +
> +static inline void timer_shutdown(struct tegra210_clockevent *tevt)
> +{
> +	writel(0, tevt->reg_base + TIMER_PTV);
> +}
> +
> +static int tegra210_timer_shutdown(struct clock_event_device *evt)
> +{
> +	struct tegra210_clockevent *tevt;
> +
> +	tevt =3D to_tegra_cevt(evt);
> +	timer_shutdown(tevt);
> +
> +	return 0;
> +}
> +
> +static int tegra210_timer_set_periodic(struct clock_event_device *evt)
> +{
> +	struct tegra210_clockevent *tevt;
> +
> +	tevt =3D to_tegra_cevt(evt);
> +	writel(TIMER_PTV_EN | TIMER_PTV_PER | ((tegra210_timer_freq / HZ) - 1),
> +	       tevt->reg_base + TIMER_PTV);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t tegra210_timer_isr(int irq, void *dev_id)
> +{
> +	struct tegra210_clockevent *tevt;
> +
> +	tevt =3D dev_id;
> +	writel(TIMER_PCR_INTR_CLR, tevt->reg_base + TIMER_PCR);
> +	tevt->evt.event_handler(&tevt->evt);
> +
> +	return IRQ_HANDLED;
> +}

Up to here this is a duplicate of timer-tegra20.c. And a lot of
tegra210_timer_init() is the same as tegra20_timer_init() as well. Can't
we unify the two drivers instead?

The power cycle restrictions of the architected timer, do they not apply
to chips earlier than Tegra210 either? So don't we need all of these
additional features on the timer-tegra20.c driver as well? If so that
would increase the code duplication even more. I think we should avoid
that, unless there are any strong arguments that would justify it.

Thierry

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPGxIACgkQ3SOs138+
s6GwFg/8DJCWHrWuFSOY6LIcYSKi2FK7juvR23Bw/fRwCJg+CWYhGmBi6+ib3sll
xgWA6cvQ6OOv5/fXXswPNKSDXWFPlGS7ujVz24EYqzup6bh832as/XcjXkXfPgsN
pVlhq6CImaxlLEIZscP7N/8FBboIrr6pgXtvw+WjRk+Q5IQ/8IVbFmGtDn6UnA+h
F1CxEA9XbFkpY+UAWlKW0vwi9l5wjAoAuzSfYBBDTGhbYIjj7z9Yza/1hOy2f7eO
2kR35GJDzBGPA13G/aQWqoO8xzF/qv6CZryQT3GJXaTCetGgbPGpEY5IvGDA68fZ
4wvOxOgYAjyrBi4eU43Vq6142hxL2+VQltYpKmwo6VO5FTZoaBT1sLJVlgkglU58
a5nX9JfzI7//oT8xXGYfJYv7ox6MnLIh89y578sEb5zvuhkby+3O0qDR6XiklzRI
asTENLzfgJIbKwalzAAqWpgGvU515uLnbbZ2UbCBBZNlGMDxtFDwuH1u+5IRzkkF
NaY7s8edXJ269UPYiEESP/3cBzhz3zFNJAkK9Por9t4LHceE7C2hnxLaaatdbsUx
wvpH8rbNDjhmv9tL0yyr1U47cadBpjGMF3jBC1/S8NB7p8F5KI+kzz0uNZzeN7r9
HZ7oOEDPQIy8as1LsFFDUZnBuXuN20OkJ71gry/gpkYCr8Nq8u4=
=CZGE
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
