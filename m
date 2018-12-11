Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5874C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B600820851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B600820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeLKQuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:50:54 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60366 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbeLKQuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:50:54 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E47D520C4D; Tue, 11 Dec 2018 17:50:51 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9F43520743;
        Tue, 11 Dec 2018 17:50:41 +0100 (CET)
Date:   Tue, 11 Dec 2018 17:50:41 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@openedev.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [linux-sunxi] Re: [PATCH v5 15/17] clk: sunxi-ng: a64: Add
 minimum rate for PLL_MIPI
Message-ID: <20181211165041.u75t6li6ympzq3mk@flea>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-16-jagan@amarulasolutions.com>
 <20181211163222.hk647c24cjhmwrz4@flea>
 <14061728-2ca3-3342-2cf3-b8588b112f5f@openedev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2q3wpw76o4wgyupz"
Content-Disposition: inline
In-Reply-To: <14061728-2ca3-3342-2cf3-b8588b112f5f@openedev.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2q3wpw76o4wgyupz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 10:05:43PM +0530, Jagan Teki wrote:
>=20
>=20
> On 11/12/18 10:02 PM, Maxime Ripard wrote:
> > On Mon, Dec 10, 2018 at 09:47:27PM +0530, Jagan Teki wrote:
> > > Minimum PLL used for MIPI is 500MHz, as per manual, but
> > > lowering the min rate by 300MHz can result proper working
> > > nkms divider with the help of desired dclock rate from
> > > panel driver.
> > >=20
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > > ---
> > >   drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunx=
i-ng/ccu-sun50i-a64.c
> > > index 181b599dc163..b623c8150b4f 100644
> > > --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> > > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> > > @@ -183,6 +183,7 @@ static struct ccu_nkm pll_mipi_clk =3D {
> > >   	.n		=3D _SUNXI_CCU_MULT(8, 4),
> > >   	.k		=3D _SUNXI_CCU_MULT_MIN(4, 2, 2),
> > >   	.m		=3D _SUNXI_CCU_DIV(0, 4),
> > > +	.min_rate	=3D 300000000,		/* Actual rate is 500MHz */
> >=20
> > That comment still doesn't make any sense. Is it running at 500MHz or 3=
00?
>=20
> It running in 300MHz, actual rate is 500MHz.

If it's running at 300MHz, its actual rate should be 300MHz...

> > Also, IIRC you had a patch adding support for maximum boundaries in
> > your previous patch, where did it go?
>=20
> Since I don't have any usecase to test I droped it. the same mentioned on
> the previous version.

Ok.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2q3wpw76o4wgyupz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXA/q4QAKCRDj7w1vZxhR
xc5xAP9NU7qTH3t2fXk0kZMIpaxASJhZYZ3t/1G38gffs4UA3wEAxd0/syHxubbV
aMACGKcluqKixGfJ/gp1y2UrEdppjQg=
=teNi
-----END PGP SIGNATURE-----

--2q3wpw76o4wgyupz--
