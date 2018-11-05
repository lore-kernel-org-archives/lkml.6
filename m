Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36005ECDE46
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B411204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B411204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeKERvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:51:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55732 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKERvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:51:52 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 26E5B207B0; Mon,  5 Nov 2018 09:33:17 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id E1087206A1;
        Mon,  5 Nov 2018 09:33:06 +0100 (CET)
Date:   Mon, 5 Nov 2018 09:33:07 +0100
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
Subject: Re: [PATCH v3 14/25] drm/sun4i: sun6i_mipi_dsi: Increase hfp packet
 overhead
Message-ID: <20181105083307.ambogsg4fopjfrda@flea>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-15-jagan@amarulasolutions.com>
 <20181029092754.2tl7i5k5qpbn4557@flea>
 <CAMty3ZC6B-o1Oij_FLpotjN_900kF6OikK323y=bQ9VPzSPDgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iazds3sud6k36fef"
Content-Disposition: inline
In-Reply-To: <CAMty3ZC6B-o1Oij_FLpotjN_900kF6OikK323y=bQ9VPzSPDgg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iazds3sud6k36fef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2018 at 07:57:56PM +0530, Jagan Teki wrote:
> On Mon, Oct 29, 2018 at 2:58 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Fri, Oct 26, 2018 at 08:13:33PM +0530, Jagan Teki wrote:
> > > Increase the hfp packet overhead with another 10 bytes, the extra
> > > 10 bytes(which is hblk packet overhead) is adding for hfp packet
> > > overhead since hfp depends on hblk.
> > >
> > > This is truely as per BSP code from BPI-M64-bsp.
> > > The real computation from BSP is
> > > (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > dsi_hbp =3D (hbp-hspw)*dsi_pixel_bits[format]/8 - (4+2);
> > > dsi_hact =3D x * dsi_pixel_bits[format]/8;
> > > dsi_hblk =3D (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
> > > dsi_hfp =3D dsi_hblk - (4+dsi_hact+2) - (4+dsi_hbp+2);
> > >
> > > Example,
> > > u32 fmt =3D dsi_pixel_bits[format]/8;
> > > =3D> ((ht-hspw)*fmt - 10) - (6 + x * fmt) - (6 + (hbp-hspw)*fmt - 6)
> > > =3D> (ht - hspw - x - (hbp - hspw)) * fmt - 16
> > > =3D> (ht - x - hbp) * fmt - 16
> > > =3D> (ht - x - (timmings->hor_total_time - timmings->hor_front_porch =
- x)
> > > * fmt - 16
> > > =3D> (timmings->hor_total_time - x - timmings->hor_total_time +
> > > timmings->hor_front_porch + x) * fmt - 16
> > > =3D> timmings->hor_front_porch * fmt - 16
> > >
> > > So, increase the DSI hfp packet overhead by hblk packet overhead.
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
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 22 +++++++++++++---------
> > >  1 file changed, 13 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm=
/sun4i/sun6i_mipi_dsi.c
> > > index 6584b51736a9..20e330186b7f 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -461,7 +461,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_=
dsi *dsi,
> > >  {
> > >       struct mipi_dsi_device *device =3D dsi->device;
> > >       unsigned int Bpp =3D mipi_dsi_pixel_format_to_bpp(device->forma=
t) / 8;
> > > -     u16 hbp, hfp, hsa, hblk_max, hblk, vblk;
> > > +     u16 hbp, hfp_pkt_overhead, hfp, hsa, hblk_max, hblk, vblk;
> > >       size_t bytes;
> > >       u8 *buffer;
> > >
> > > @@ -484,14 +484,6 @@ static void sun6i_dsi_setup_timings(struct sun6i=
_dsi *dsi,
> > >       hbp =3D max((unsigned int)HBP_PACKET_OVERHEAD,
> > >                 (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_O=
VERHEAD);
> > >
> > > -     /*
> > > -      * The frontporch is set using a blanking packet (4 bytes +
> > > -      * payload + 2 bytes). Its minimal size is therefore 6 bytes
> > > -      */
> > > -#define HFP_PACKET_OVERHEAD  6
> > > -     hfp =3D max((unsigned int)HFP_PACKET_OVERHEAD,
> > > -               (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACK=
ET_OVERHEAD);
> > > -
> > >       /*
> > >        * hblk seems to be the line + porches length.
> > >        * The blank is set using a blanking packet (4 bytes + 4 bytes +
> > > @@ -502,6 +494,18 @@ static void sun6i_dsi_setup_timings(struct sun6i=
_dsi *dsi,
> > >       hblk_max -=3D HBLK_PACKET_OVERHEAD;
> > >       hblk =3D max((unsigned int)HBLK_PACKET_OVERHEAD, hblk_max);
> > >
> > > +     /*
> > > +      * The frontporch is set using a blanking packet (4 bytes +
> > > +      * payload + 2 bytes). Its minimal size is therefore 6 bytes
> > > +      *
> > > +      * According to BSP code, extra 10 bytes(which is hblk packet o=
verhead)
> > > +      * is adding for hfp packet overhead since hfp depends on hblk.
> >
> > "According to the BSP code, another 10 bytes (the HBLK packet
> > overhead) need to be added to the front porch overhead."
> >
> > How has this been verified? Since we have registers to set all the
> > parameters, this seems kind of weird.
>=20
> Verified based on the BSP calculation which I explained in commit
> message and tested by validating these numbers with mainline vs bsp
> code.

So, not verified?

Did you have a panel that was broken due to this? Have you found that
the timings output on the DSI bus were wrong using an oscilloscope or
an analyzer? What makes you say that the Allwinner code is more
correct than we are?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--iazds3sud6k36fef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+AAQgAKCRDj7w1vZxhR
xeFLAQDEuRB7X3QE4fFt6ewszUtuZMXr/cZWA3GJpOpxLiWdzwD9Fud8EFg6p8DV
Kh9Ws5J9I3Q5H7uOUP1r1fNICfQAeQc=
=4cHu
-----END PGP SIGNATURE-----

--iazds3sud6k36fef--
