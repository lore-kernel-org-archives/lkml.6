Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC2BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E984020831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E984020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437963AbeKWChM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:37:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33307 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732326AbeKWChM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:37:12 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 73AFD2072F; Thu, 22 Nov 2018 16:57:13 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4A2DF20712;
        Thu, 22 Nov 2018 16:57:03 +0100 (CET)
Date:   Thu, 22 Nov 2018 16:57:03 +0100
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
Subject: Re: [RFC PATCH v3 01/17] ARM: add CONFIG_ARCH_SUNXI_V7 for
 differentiate ARMv5/v7 Allwinner SoCs
Message-ID: <20181122155703.wsziwzybqwcmn25w@flea>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <267ffcf3b91930a82f20d93e1fad1fceaf8b9b0e.1542824904.git.mesihkilinc@gmail.com>
 <20181122082635.br5n33owxxpenv62@flea>
 <20181122150751.n26pvywmvnuglly5@ThinkPad>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="flmo5uucax4cgdii"
Content-Disposition: inline
In-Reply-To: <20181122150751.n26pvywmvnuglly5@ThinkPad>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--flmo5uucax4cgdii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 06:07:51PM +0300, Mesih Kilinc wrote:
> On 18/11/22 09:26, Maxime Ripard wrote:
> > On Wed, Nov 21, 2018 at 09:30:34PM +0300, Mesih Kilinc wrote:
> > > Allwinner also has some ARMv5 SoCs.
> > >=20
> > > In order to add support for them, add a CONFIG_ARCH_SUNXI_V7 bool con=
fig
> > > which is selected when a ARMv7 soc is selected, and make CONFIG_ARCH_=
SUNXI
> > > a common option which is selected by both V7 and V5 sunxi option.
> > >=20
> > > Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> > > ---
> > >  arch/arm/mach-sunxi/Kconfig | 23 ++++++++++++++++-------
> > >  1 file changed, 16 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > > index d9c8ecf..7e5f173 100644
> > > --- a/arch/arm/mach-sunxi/Kconfig
> > > +++ b/arch/arm/mach-sunxi/Kconfig
> > > @@ -6,31 +6,38 @@ menuconfig ARCH_SUNXI
> > >  	select GENERIC_IRQ_CHIP
> > >  	select GPIOLIB
> > >  	select PINCTRL
> > > -	select PM_OPP
> > >  	select SUN4I_TIMER
> > >  	select RESET_CONTROLLER
> > > +	help
> > > +	  Support for Allwinner ARM-based family of processors
> > > =20
> > >  if ARCH_SUNXI
> > > =20
> > > +if ARCH_MULTI_V7
> > > +
> > > +config ARCH_SUNXI_V7
> > > +	bool
> > > +	select PM_OPP
> > > +
> >=20
> > Actually, thinking more about this, I don't see why the PM_OPP config
> > option should be made specific to the ARMv7 sunxi SoCs, you will have
> > things cpufreq enabled at some point as well on the armv5 support.
> >=20
> OK. I was basing this code to the first patch series.=20
> So there will be no need for ARCH_SUNXI_VX configs. Should I drop them
> and differantiate IC's by only ARCH_MULTI_VX?

Yeah, that's probably enough for now, and we can always merge some
patch along those lines if we ever need it later.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--flmo5uucax4cgdii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/bRzwAKCRDj7w1vZxhR
xQIQAQDIbdeo2bMJcBp7aRe7q+1h7ETMBDGYXYKr+sBSJygGWQD/Y329IDLTYSzP
jCyMWo01jtQefNDk69lMkGXlZuuOOAQ=
=FveE
-----END PGP SIGNATURE-----

--flmo5uucax4cgdii--
