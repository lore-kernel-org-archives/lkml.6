Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B82ECDE46
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B57B20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B57B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeKERuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:50:09 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55625 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKERuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:50:09 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7106F2080A; Mon,  5 Nov 2018 09:31:35 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 38CBA207CF;
        Mon,  5 Nov 2018 09:31:25 +0100 (CET)
Date:   Mon, 5 Nov 2018 09:31:25 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
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
Subject: Re: [PATCH v3 12/25] drm/sun4i: sun6i_mipi_dsi: Add DSI hblk packet
 overhead
Message-ID: <20181105083125.xyfwdrkrjzrltfzf@flea>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-13-jagan@amarulasolutions.com>
 <20181029092227.mdxgvg5aqzh22j72@flea>
 <CAMty3ZBHU5eXRLLJmUroLgSKcF6O9gHOHRM1XBnt9_Lp7B8rEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ci7q6bhdxh7l4w2f"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBHU5eXRLLJmUroLgSKcF6O9gHOHRM1XBnt9_Lp7B8rEA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ci7q6bhdxh7l4w2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2018 at 07:56:27PM +0530, Jagan Teki wrote:
> On Mon, Oct 29, 2018 at 2:52 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Fri, Oct 26, 2018 at 08:13:31PM +0530, Jagan Teki wrote:
> > > Add 10 bytes packet overhead for hblk where blank is set using
> > > a blanking packet like (4 bytes + 4 bytes + payload + 2 bytes)
> > >
> > > This is according to BSP code from BPI-M64-bsp
> > > (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > dsi_hblk =3D (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
> > >
> > > So, add 10 bytes packet overhead for DSI hblk.
> > >
> > > Tested on 2-lane, 4-lane MIPI-DSI LCD panels.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > Tested-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v3:
> > > - new patch
> > > Changes for v2:
> > > - none
> > >
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm=
/sun4i/sun6i_mipi_dsi.c
> > > index 596e560263bf..cf42be1f1ba1 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -461,7 +461,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_=
dsi *dsi,
> > >  {
> > >       struct mipi_dsi_device *device =3D dsi->device;
> > >       unsigned int Bpp =3D mipi_dsi_pixel_format_to_bpp(device->forma=
t) / 8;
> > > -     u16 hbp, hfp, hsa, hblk, vblk;
> > > +     u16 hbp, hfp, hsa, hblk_max, hblk, vblk;
> > >       size_t bytes;
> > >       u8 *buffer;
> > >
> > > @@ -494,8 +494,13 @@ static void sun6i_dsi_setup_timings(struct sun6i=
_dsi *dsi,
> > >
> > >       /*
> > >        * hblk seems to be the line + porches length.
> > > +      * The blank is set using a blanking packet (4 bytes + 4 bytes +
> > > +      * payload + 2 bytes). So minimal size is 10 bytes
> > >        */
> > > -     hblk =3D (mode->htotal - (mode->hsync_end - mode->hsync_start))=
 * Bpp;
> > > +#define HBLK_PACKET_OVERHEAD 10
> > > +     hblk_max =3D (mode->htotal - (mode->hsync_end - mode->hsync_sta=
rt)) * Bpp;
> > > +     hblk_max -=3D HBLK_PACKET_OVERHEAD;
> > > +     hblk =3D max((unsigned int)HBLK_PACKET_OVERHEAD, hblk_max);
> >
> > I'd rather use the same convention than the other assignments done
> > before in that function.
>=20
> Yes, old code did use hsa. but it's added 10 bytes packet head instead
> of subtracting it.
>=20
> hblk =3D mode->htotal * Bpp - hsa;
> =3D> mode->htotal * Bpp - (mode->hsync_end - mode->hsync_start) * Bpp -
> HSA_PACKET_OVERHEAD);
> =3D> (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp +
> HSA_PACKET_OVERHEAD;
>=20
> And it should be
> (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp -
> HSA_PACKET_OVERHEAD;
>=20
> This patch is simply doing the same by explicitly adding packet over
> ahead macro, which again used in hfp.

That's not my point.

The rest of the driver uses a construct that would be:

hblk =3D max((unsigned int)HBLK_PACKET_OVERHEAD,
           (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp - H=
BLK_PACKET_OVERHEAD);

We want to remain consistent.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ci7q6bhdxh7l4w2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9//3QAKCRDj7w1vZxhR
xXDlAQCy41zJkLARcZDuRMle7LiwCzB51w1Y9O1/0zZ7+XJpwwEA/W21ByuwF0lq
b4vhD9U6mdnJ7ri/04Us9m1k9pKHMgw=
=oSFB
-----END PGP SIGNATURE-----

--ci7q6bhdxh7l4w2f--
