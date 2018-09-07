Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378A8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FFC2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FFC2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbeIGSMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:12:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42744 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbeIGSMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:12:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DE0A3207AD; Fri,  7 Sep 2018 15:31:36 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id ACEC120379;
        Fri,  7 Sep 2018 15:31:26 +0200 (CEST)
Date:   Fri, 7 Sep 2018 15:31:26 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH v4 1/4] clk: sunxi-ng: Enable DE2_CCU
 for SUN8I and SUN50I
Message-ID: <20180907133125.ghks5cgk5u6vrhd6@flea>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
 <20180905070335.dclhpxjld4vdkdu4@flea>
 <2955967.qdhifWMYUT@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4nzkw2nv5o3dfnhg"
Content-Disposition: inline
In-Reply-To: <2955967.qdhifWMYUT@jernej-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4nzkw2nv5o3dfnhg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2018 at 07:10:06AM +0200, Jernej =C5=A0krabec wrote:
> Dne sreda, 05. september 2018 ob 09:03:35 CEST je Maxime Ripard napisal(a=
):
> > On Tue, Sep 04, 2018 at 10:06:06PM +0530, Jagan Teki wrote:
> > > Allwinner SoC like SUN8I and SUN50I has DE2 CCU so enable them
> > > as default.
> > >=20
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v4, v3:
> > > - none
> > > Changes for v2:
> > > - Enable for MACH_SUN8I
> > >=20
> > >  drivers/clk/sunxi-ng/Kconfig | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kcon=
fig
> > > index 826674d090fd..e20182aa9748 100644
> > > --- a/drivers/clk/sunxi-ng/Kconfig
> > > +++ b/drivers/clk/sunxi-ng/Kconfig
> > > @@ -63,6 +63,8 @@ config SUN8I_V3S_CCU
> > >=20
> > >  config SUN8I_DE2_CCU
> > > =20
> > >  	bool "Support for the Allwinner SoCs DE2 CCU"
> > >=20
> > > +	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
> > > +	depends on DRM_SUN4I && (MACH_SUN8I || (ARM64 && ARCH_SUNXI))
> >=20
> > I don't see why there's a dependency on the DRM driver. I'm pretty
> > sure this would even break simplefb.
>=20
> I think best approach would be that SUN8I_MIXER selects (or depends on?) =
this=20
> symbol, since it can't work if there is no DE2 CCU clock present.

This is a runtime dependency, not a build time one. We're not doing it
for any other similar driver, so there's no reason to do it in this
particular case.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4nzkw2nv5o3dfnhg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluSfa0ACgkQ0rTAlCFN
r3SkZBAAmUPFSM0fZN7/iHasr4dZei6lHt0x+qegvqVbl8dm9QCIEeBHIqgheV/k
7uiiY67CaeHNXOUDVGnlxa/G2FxDSAN0SoDWqd/ERJjux6hD8G+RtYhpn+cpreph
yIGDBLjsbZdDdx4J+BRD7gAXFDW+gm922MRzPPN8yRY/qlD8XxsBznHC9v5KzJsJ
Uqhy5MWFDtMrt06F94OFnMmcmQvR6UA0wNkDcjEMhMEKsV2NRbOOYsdvIzfSaCYL
wBeYpuuvK6pG5B83n6NRBm4x17Ky17VqR7s1qhe+rWqfX/qdySDY9HYXwp00Qcjv
Ew2IBnYtkawtQC/dX85gnWJLRpWerD4tu0lpcn5Z8oI3ZvLBH0wC/pTjY4RAk5jD
oyHQIAdSjcOHciN+BDqp2TYS2q5auKUMIGTCYYh3LwLvw/NSw3Y7fXfydnPob57E
GtZinGViN0ANegiR451TkS6Dzj7zc9h241NgRmGvYlG2U/JBgPrH4iph1dvVsfEG
H98ziz13+pdvjdAsnZ/6FBiTqnTl/6z5Lb36eYpQPG9riiklFA6F/ESgi/RbEdoB
YW0a1qQrk0qnRBlc9kZwAz380e7JNZGN2NnFdbGFnFdE9wI+29p+IJH1Nb6RzNcI
656FO7rLhkstUmdJmyYiRVclPJBL+0Dd+upCsjI5W+YMgOdoUKU=
=Nbx1
-----END PGP SIGNATURE-----

--4nzkw2nv5o3dfnhg--
