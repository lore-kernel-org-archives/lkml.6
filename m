Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EC4C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230C320851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230C320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeKTTKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:10:55 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50013 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKTTKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:10:54 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A5EE72074F; Tue, 20 Nov 2018 09:42:55 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 735D62037D;
        Tue, 20 Nov 2018 09:42:45 +0100 (CET)
Date:   Tue, 20 Nov 2018 09:42:45 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH v2 03/14] ARM: sunxi: add Allwinner ARMv5 SoCs
Message-ID: <20181120084245.bnjdaf647e6tdlku@flea>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
 <8f07fac854eaaea63e199fe0e80cf20004dffbdf.1542546735.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f4q6buea7vbu6n7w"
Content-Disposition: inline
In-Reply-To: <8f07fac854eaaea63e199fe0e80cf20004dffbdf.1542546735.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f4q6buea7vbu6n7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 18, 2018 at 05:17:02PM +0300, Mesih Kilinc wrote:
> Add option for Allwinner ARMv5 SoCs and SoC F1C100s (which has a die
> used for many new F-series products, including F1C100A, F1C100s, F1C200s,
> F1C500, F1C600).
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  arch/arm/mach-sunxi/Kconfig    | 14 +++++++++++++-
>  arch/arm/mach-sunxi/Makefile   |  1 +
>  arch/arm/mach-sunxi/sunxi_v5.c | 22 ++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-sunxi/sunxi_v5.c
>=20
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 5db17ec..066644c 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -1,6 +1,6 @@
>  menuconfig ARCH_SUNXI
>  	bool "Allwinner SoCs"
> -	depends on ARCH_MULTI_V7
> +	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select CLKSRC_MMIO
>  	select GENERIC_IRQ_CHIP
> @@ -64,4 +64,16 @@ config ARCH_SUNXI_MC_SMP
> =20
>  endif
> =20
> +if ARCH_MULTI_V5
> +
> +config ARCH_SUNXI_V5
> +	bool
> +	select SUN4I_TIMER

If SUN4I_TIMER is needed both by the armv5 and armv7 cores, why did we
need to move it out of ARCH_SUNXI?

> +config MACH_SUNIV
> +	bool "Allwinner new F-series (suniv) SoCs support"

I would drop the "new" here.

> +++ b/arch/arm/mach-sunxi/sunxi_v5.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree support for Allwinner F series SoCs
> + *
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> + * Copyright (C) 2018 Mesih Kilinc <mesihkilinc@gmail.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <asm/mach/arch.h>
> +
> +static const char * const suniv_board_dt_compat[] =3D {
> +	"allwinner,suniv-f1c100s",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(SUNXI_DT, "Allwinner suniv Family")
> +	.dt_compat	=3D suniv_board_dt_compat,
> +MACHINE_END

Do we really need a separate file for that?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--f4q6buea7vbu6n7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/PJBQAKCRDj7w1vZxhR
xYLpAP9rCPbc1QsZM0YP5XXJlABPGK4Zg27MF0Ul2TZafIW9FwEArf/W5NzApR+d
G/uBrwKajJEKBB5Jh2P4rZBA1CZ0gA0=
=HggK
-----END PGP SIGNATURE-----

--f4q6buea7vbu6n7w--
