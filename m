Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F465C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD69206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD69206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeKUCPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:15:21 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59835 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeKUCPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:15:20 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 43BB72074F; Tue, 20 Nov 2018 16:45:33 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 12FB620510;
        Tue, 20 Nov 2018 16:45:33 +0100 (CET)
Date:   Tue, 20 Nov 2018 16:45:32 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 03/12] drm/sun4i: sun6i_mipi_dsi: Setup burst mode
 timings
Message-ID: <20181120154532.mykbbrc3homwf2fi@flea>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-4-jagan@amarulasolutions.com>
 <20181119083036.riydru5xefao3xte@flea>
 <CAMty3ZBDBDqtH5_m4g-kkKKx+JqcC-r9mc-H+_WWgkLubMWPew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xfrsutrsshbzfw5b"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBDBDqtH5_m4g-kkKKx+JqcC-r9mc-H+_WWgkLubMWPew@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xfrsutrsshbzfw5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2018 at 04:30:37PM +0530, Jagan Teki wrote:
> On Mon, Nov 19, 2018 at 2:00 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Fri, Nov 16, 2018 at 10:09:07PM +0530, Jagan Teki wrote:
> > > Burst mode display timings are different from convectional
> > > video mode so update the horizontal and vertical timings.
> > >
> > > Reference code taken from BSP (from linux-sunxi/
> > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > >
> > > dsi_hsa  =3D 0;
> > > dsi_hbp  =3D 0;
> > > dsi_hact =3D x*dsi_pixel_bits[format]/8;
> > > dsi_hblk =3D dsi_hact;
> > > dsi_hfp  =3D 0;
> > > dsi_vblk =3D 0;
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > How is that matching the code you have in the rest of your patch?
>=20
> +       if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
> +               timings.hblk =3D (mode->hdisplay * Bpp);
> +       else
> +               sun6i_dsi_get_timings(dsi, mode, &timings);
>=20
> It's again your request to "keep the couple of function to make more
> readable"

That function in particular doesn't make it much more readable, but
more importantly, your commit log doesn't match what you code does.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xfrsutrsshbzfw5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/QsHAAKCRDj7w1vZxhR
xUW2AP9CmjGz8Or6XtDBPWxUe//UtTFTVDp0SCdl1EpVMpDILgEA3LOMdWqHaTP9
PVoY9pgar4iHAntHklpmvva9Qq/ZfQs=
=Qa3x
-----END PGP SIGNATURE-----

--xfrsutrsshbzfw5b--
