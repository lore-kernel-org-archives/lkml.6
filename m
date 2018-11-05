Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B9DC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D48420869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D48420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeKETaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:30:10 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60203 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbeKETaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:30:09 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BC027207B0; Mon,  5 Nov 2018 11:11:10 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 88E46206D8;
        Mon,  5 Nov 2018 11:11:10 +0100 (CET)
Date:   Mon, 5 Nov 2018 11:11:10 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@openedev.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH v2 02/15] clk: sunxi-ng: Add check for
 minimal rate to NKM PLLs
Message-ID: <20181105101110.agfik3oppd6ck25c@flea>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-3-jagan@amarulasolutions.com>
 <20181024180436.5n3i3z6h2yezc4cv@flea>
 <CAMty3ZC2wn-DjR+93yc-n-bAmVCHaEqR_=4XPddoo+7LjebTEg@mail.gmail.com>
 <20181029085843.3bslqwktxbp2ywk2@flea>
 <e7566001-8933-adbb-4c30-7a3f66ebae4e@openedev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="24qnld42rl357a2y"
Content-Disposition: inline
In-Reply-To: <e7566001-8933-adbb-4c30-7a3f66ebae4e@openedev.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24qnld42rl357a2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2018 at 06:10:47PM +0530, Jagan Teki wrote:
> On 29/10/18 2:28 PM, Maxime Ripard wrote:
> > On Thu, Oct 25, 2018 at 04:25:59PM +0530, Jagan Teki wrote:
> > > On Wed, Oct 24, 2018 at 11:34 PM Maxime Ripard
> > > <maxime.ripard@bootlin.com> wrote:
> > > >=20
> > > > On Tue, Oct 23, 2018 at 09:20:22PM +0530, Jagan Teki wrote:
> > > > > Some NKM PLLs doesn't work well when their output clock rate is s=
et below
> > > > > certain rate.
> > > > >=20
> > > > > So, add support for minimal rate for relevant PLLs.
> > > > >=20
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > ---
> > > > > Changes for v2:
> > > > > - new patch
> > > > >=20
> > > > >   drivers/clk/sunxi-ng/ccu_nkm.c | 7 +++++++
> > > > >   drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
> > > > >   2 files changed, 8 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-n=
g/ccu_nkm.c
> > > > > index 841840e35e61..d17539dc88dd 100644
> > > > > --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> > > > > +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> > > > > @@ -125,6 +125,13 @@ static unsigned long ccu_nkm_round_rate(stru=
ct ccu_mux_internal *mux,
> > > > >        if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> > > > >                rate *=3D nkm->fixed_post_div;
> > > > >=20
> > > > > +     if (rate < nkm->min_rate) {
> > > > > +             rate =3D nkm->min_rate;
> > > > > +             if (nkm->common.features & CCU_FEATURE_FIXED_POSTDI=
V)
> > > > > +                     rate /=3D nkm->fixed_post_div;
> > > >=20
> > > > I'm not sure this is right. Is the post divider taken into account =
to
> > > > calculate the minimum, or is the minimum on the rate before the fix=
ed
> > > > post divider.
> > >=20
> > > Since we are returning from here, we need to take care post div which
> > > is actually doing at the end of round_rate.
> >=20
> > That's not my point though. Does the rate needs to be superior to min
> > / post_div, or min?
>=20
> ie what I'm trying to say, since it's common code min or max should /
> post_div and PLL_MIPI doesn't use any post_div.
>=20
> We need to take care post_div though the current test (PLL_MIPI) in not u=
sed
> since it's common code. just like nkmp, nm etc.
>=20
> >=20
> > > >=20
> > > > How did you test this?
> > >=20
> > > I've not used this on PLL_MIPI atleast, so I didn't test this.
> >=20
> > If you've never tested this, why are you adding that code?
>=20
> Like above, it's common code. otherwise might effect.

Adding untested, unverified and unneeded code is just bloat, nothing
else.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--24qnld42rl357a2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+AXPgAKCRDj7w1vZxhR
xZGZAP9paH3R1hjXBV/78pQJPBNmhdWRfP1ia9/7402ZarjPbgEAhMrhFLZ5XMu9
d1StSmseaJ/1DULVvnx5QFCiTcr5QQ8=
=540+
-----END PGP SIGNATURE-----

--24qnld42rl357a2y--
