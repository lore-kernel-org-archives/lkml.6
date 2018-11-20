Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B5AC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0F52087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0F52087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbeKUCOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:14:16 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59732 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeKUCOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:14:16 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AF02C207B0; Tue, 20 Nov 2018 16:44:29 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8057120745;
        Tue, 20 Nov 2018 16:44:29 +0100 (CET)
Date:   Tue, 20 Nov 2018 16:44:29 +0100
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
Subject: Re: [PATCH v2 06/12] drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during
 dsi_bind
Message-ID: <20181120154429.e4jcn2xxkbh3fits@flea>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-7-jagan@amarulasolutions.com>
 <20181119083833.d7ysiv3tenabtrdj@flea>
 <CAMty3ZCsEYFJOQAFTf3FspQWMzD-tiW_njuyCJ950RZ=Y6apEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l2eillhuo5shhqfk"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCsEYFJOQAFTf3FspQWMzD-tiW_njuyCJ950RZ=Y6apEw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l2eillhuo5shhqfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2018 at 05:06:32PM +0530, Jagan Teki wrote:
> On Mon, Nov 19, 2018 at 2:08 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Fri, Nov 16, 2018 at 10:09:10PM +0530, Jagan Teki wrote:
> > > Probe tcon0 during dsi_bind, so-that the tcon attributes like
> > > divider value, clock rate can get whenever it need.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h | 1 +
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm=
/sun4i/sun6i_mipi_dsi.c
> > > index d60955880c43..66a01061e51d 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -25,6 +25,7 @@
> > >  #include <drm/drm_panel.h>
> > >
> > >  #include "sun4i_drv.h"
> > > +#include "sun4i_tcon.h"
> > >  #include "sun6i_mipi_dsi.h"
> > >
> > >  #include <video/mipi_display.h>
> > > @@ -1007,6 +1008,7 @@ static int sun6i_dsi_bind(struct device *dev, s=
truct device *master,
> > >       struct drm_device *drm =3D data;
> > >       struct sun4i_drv *drv =3D drm->dev_private;
> > >       struct sun6i_dsi *dsi =3D dev_get_drvdata(dev);
> > > +     struct sun4i_tcon *tcon0 =3D sun4i_get_tcon0(drm);
> > >       int ret;
> > >
> > >       if (!dsi->panel)
> > > @@ -1014,6 +1016,11 @@ static int sun6i_dsi_bind(struct device *dev, =
struct device *master,
> > >
> > >       dsi->drv =3D drv;
> > >
> > > +     if (!tcon0)
> > > +             return -EPROBE_DEFER;
> >
> > You can't fall in that condition. The component framework won't call
> > bind unless every components have been probed.
>=20
> Since tcon0 is already probed is it? if so I can return -EINVAL is it ok?

Sounds good yes.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--l2eillhuo5shhqfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/Qr3QAKCRDj7w1vZxhR
xUxjAP49VbDQ0Ls0ORFIazvrCP+Q1OrnQMaPBKKEhGAc5MwOCAD/XT0/GSvIf23d
IX3HekWneH1th0MRKys7azoXjw6uCQ8=
=sdNK
-----END PGP SIGNATURE-----

--l2eillhuo5shhqfk--
