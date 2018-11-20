Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B97C4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B447420989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B447420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbeKTTIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:08:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49939 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeKTTIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:08:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 94DF2207B0; Tue, 20 Nov 2018 09:40:26 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5F16120745;
        Tue, 20 Nov 2018 09:40:16 +0100 (CET)
Date:   Tue, 20 Nov 2018 09:40:16 +0100
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
Subject: Re: [RFC PATCH v2 01/14] ARM: add CONFIG_ARCH_SUNXI_V7 for
 differentiate ARMv5/v7 Allwinner SoCs
Message-ID: <20181120084016.nrvpylj64ok3d5ch@flea>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
 <abbb75165c8ef41da6963d72f4155ad6ae79140c.1542546735.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7zekhgszpvxaw4mg"
Content-Disposition: inline
In-Reply-To: <abbb75165c8ef41da6963d72f4155ad6ae79140c.1542546735.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7zekhgszpvxaw4mg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 18, 2018 at 05:17:00PM +0300, Mesih Kilinc wrote:
> Allwinner also has some ARMv5 SoCs.
>=20
> In order to add support for them, add a CONFIG_ARCH_SUNXI_V7 bool config
> which is selected when a ARMv7 soc is selected, and make CONFIG_ARCH_SUNXI
> a common option which is selected by both V7 and V5 sunxi option.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

I'm not sure why Icenowy has her SoB here?

> ---
>  arch/arm/mach-sunxi/Kconfig  | 25 +++++++++++++++++--------
>  arch/arm/mach-sunxi/Makefile |  2 +-
>  2 files changed, 18 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index d9c8ecf..5db17ec 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -6,31 +6,38 @@ menuconfig ARCH_SUNXI
>  	select GENERIC_IRQ_CHIP
>  	select GPIOLIB
>  	select PINCTRL
> -	select PM_OPP
> -	select SUN4I_TIMER
>  	select RESET_CONTROLLER
> +	help
> +	  Support for Allwinner ARM-based family of processors
> =20
>  if ARCH_SUNXI
> =20
> +if ARCH_MULTI_V7
> +
> +config ARCH_SUNXI_V7
> +	bool
> +	select PM_OPP
> +	select SUN4I_TIMER
> +
>  config MACH_SUN4I
>  	bool "Allwinner A10 (sun4i) SoCs support"
> -	default ARCH_SUNXI
> +	select ARCH_SUNXI_V7

It changes the behaviour a bit. It used to be enabled by default, it
doesn't anymore.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7zekhgszpvxaw4mg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/PIcAAKCRDj7w1vZxhR
xXGIAPwPGwDSRKZg49st+Az9UNsk2Bi9+r0OXyVH2rkz58+rlAD9HAoYmcO62gbM
qRK7QGlAXoJQzUU1EJIhRprl/An3QgU=
=MIN4
-----END PGP SIGNATURE-----

--7zekhgszpvxaw4mg--
