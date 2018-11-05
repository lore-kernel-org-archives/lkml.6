Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D6AECDE46
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B51A20866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B51A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeKERxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:53:08 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55815 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKERxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:53:08 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0AFA6207B0; Mon,  5 Nov 2018 09:34:34 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id C801C206A1;
        Mon,  5 Nov 2018 09:34:05 +0100 (CET)
Date:   Mon, 5 Nov 2018 09:34:05 +0100
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
Subject: Re: [PATCH v3 16/25] drm/sun4i: sun6i_mipi_dsi: Add support for
 VCC-DSI voltage regulator
Message-ID: <20181105083405.zhhnulfsyyvlzusf@flea>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-17-jagan@amarulasolutions.com>
 <20181029093142.hgn4q6o7q32voutf@flea>
 <CAMty3ZBky1kP-1Q+ja2BpcbTxdHgQOFn=T4bcnZwMz6zP+AcOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2qv36qiifiyzutuf"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBky1kP-1Q+ja2BpcbTxdHgQOFn=T4bcnZwMz6zP+AcOQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2qv36qiifiyzutuf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2018 at 08:18:05PM +0530, Jagan Teki wrote:
> On Mon, Oct 29, 2018 at 3:01 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Fri, Oct 26, 2018 at 08:13:35PM +0530, Jagan Teki wrote:
> > > Some boards have VCC-DSI pin connected to voltage regulator which may
> > > not be turned on by default.
> > >
> > > Add support for such boards by adding voltage regulator handling code=
 to
> > > MIPI DSI driver.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > Tested-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v3:
> > > - new patch
> > > Changes for v2:
> > > - none
> > >
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++++++++++
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  3 +++
> > >  2 files changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm=
/sun4i/sun6i_mipi_dsi.c
> > > index 42bd7506abaf..bc57343592e0 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -949,6 +949,12 @@ static int sun6i_dsi_bind(struct device *dev, st=
ruct device *master,
> > >
> > >       dsi->drv =3D drv;
> > >
> > > +     ret =3D regulator_enable(dsi->regulator);
> > > +     if (ret) {
> > > +             dev_err(dev, "Failed to enable regulator\n");
> > > +             return ret;
> > > +     }
> > > +
> >
> > The regulator should be enabled only when the device is in use.
>=20
> True, but there is no device specific quirk needed because who ever
> not needed simply use dummy regulator
> [    0.245821] sun6i-mipi-dsi 1ca0000.dsi: 1ca0000.dsi supply vcc-dsi
> not found, using dummy regulato
> r
>=20
> even like HVCC in hdmi driver [1]
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c?id=3D633ba1e086e1abbeef1ffd8999=
11de8cf3987d9f

That's not my point. You should enable the regulator only when the DSI
bridge is being enabled, not when the driver has probed.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2qv36qiifiyzutuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+AAfQAKCRDj7w1vZxhR
xd1oAP0Urbi1rvfK+je57t0m58ZwVyBuK41Gmb4baeB/Wd/hzwEAxxeWPqC2+ZXe
bXolpYlKicdGlbse9KJDHPX2oAHKpgE=
=eprQ
-----END PGP SIGNATURE-----

--2qv36qiifiyzutuf--
