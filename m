Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9932CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691632086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691632086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbeK0VFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:05:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33972 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeK0VFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:05:00 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E8FE820736; Tue, 27 Nov 2018 11:07:34 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id B9387206A1;
        Tue, 27 Nov 2018 11:07:24 +0100 (CET)
Date:   Tue, 27 Nov 2018 11:07:24 +0100
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
Message-ID: <20181127100724.od5rm7vxdn7qemdv@flea>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-4-jagan@amarulasolutions.com>
 <20181119083036.riydru5xefao3xte@flea>
 <CAMty3ZBDBDqtH5_m4g-kkKKx+JqcC-r9mc-H+_WWgkLubMWPew@mail.gmail.com>
 <20181120154532.mykbbrc3homwf2fi@flea>
 <CAMty3ZCZtTa=YYxVnqvOHSGxA4vkXf6iinhoKfVN7B6CHFg_xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ljkfb22ybl2pyuox"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCZtTa=YYxVnqvOHSGxA4vkXf6iinhoKfVN7B6CHFg_xQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ljkfb22ybl2pyuox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2018 at 09:52:23PM +0530, Jagan Teki wrote:
> On Tue, Nov 20, 2018 at 9:15 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Mon, Nov 19, 2018 at 04:30:37PM +0530, Jagan Teki wrote:
> > > On Mon, Nov 19, 2018 at 2:00 PM Maxime Ripard <maxime.ripard@bootlin.=
com> wrote:
> > > >
> > > > On Fri, Nov 16, 2018 at 10:09:07PM +0530, Jagan Teki wrote:
> > > > > Burst mode display timings are different from convectional
> > > > > video mode so update the horizontal and vertical timings.
> > > > >
> > > > > Reference code taken from BSP (from linux-sunxi/
> > > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > > >
> > > > > dsi_hsa  =3D 0;
> > > > > dsi_hbp  =3D 0;
> > > > > dsi_hact =3D x*dsi_pixel_bits[format]/8;
> > > > > dsi_hblk =3D dsi_hact;
> > > > > dsi_hfp  =3D 0;
> > > > > dsi_vblk =3D 0;
> > > > >
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > >
> > > > How is that matching the code you have in the rest of your patch?
> > >
> > > +       if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
> > > +               timings.hblk =3D (mode->hdisplay * Bpp);
> > > +       else
> > > +               sun6i_dsi_get_timings(dsi, mode, &timings);
> > >
> > > It's again your request to "keep the couple of function to make more
> > > readable"
> >
> > That function in particular doesn't make it much more readable, but
> > more importantly, your commit log doesn't match what you code does.
>=20
> May be I can update the commit message if the function is OK. for
> burst most of the timings are 0 so I used structure with memset to
> keep not assigning 0's explicitly. otherwise do you have any
> suggestions, please let me know.

Drop the part that move the timings setup to another function in this
patch.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ljkfb22ybl2pyuox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0XXAAKCRDj7w1vZxhR
xfiTAQDLRk6S/mdFXIIvipxhGxjnywdbpZZJr8SEtb+OkflHeAD+PIxbcJWQnrvO
lDURsNJiGFd6/wV4NLX/fOFCrAGPvQ4=
=vqsG
-----END PGP SIGNATURE-----

--ljkfb22ybl2pyuox--
