Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FB6ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC742084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC742084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbeJ2Rry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:47:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54209 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbeJ2Rry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:47:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C3AAA208D9; Mon, 29 Oct 2018 10:00:09 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id 82E7520791;
        Mon, 29 Oct 2018 09:59:59 +0100 (CET)
Date:   Mon, 29 Oct 2018 10:00:00 +0100
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
Subject: Re: [PATCH v2 04/15] drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64
 MIPI DSI support
Message-ID: <20181029090000.woypmozwc7sbtusk@flea>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-5-jagan@amarulasolutions.com>
 <20181024180632.zrb3lrqsznspmwbk@flea>
 <CAMty3ZDLd=vbYUut6Cwo9VKFR4T1u1p58FLg9vhN79JS1=0rag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2m2feqxvtut5wn62"
Content-Disposition: inline
In-Reply-To: <CAMty3ZDLd=vbYUut6Cwo9VKFR4T1u1p58FLg9vhN79JS1=0rag@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2m2feqxvtut5wn62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2018 at 04:32:06PM +0530, Jagan Teki wrote:
> On Wed, Oct 24, 2018 at 11:36 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Tue, Oct 23, 2018 at 09:20:24PM +0530, Jagan Teki wrote:
> > > The MIPI DSI controller on Allwinner A64 is similar to
> > > Allwinner A31 without support of DSI mod clock(CLK_DSI_SCLK)
> > >
> > > So, alter has_mod_clk bool via driver data for respective
> > > SoC's compatible.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v2:
> > > - none
> > >
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 47 ++++++++++++++++++++----=
--
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  5 +++
> > >  2 files changed, 41 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm=
/sun4i/sun6i_mipi_dsi.c
> > > index e3b34a345546..8e9c76febca2 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/component.h>
> > >  #include <linux/crc-ccitt.h>
> > >  #include <linux/of_address.h>
> > > +#include <linux/of_device.h>
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/reset.h>
> > > @@ -981,6 +982,8 @@ static int sun6i_dsi_probe(struct platform_device=
 *pdev)
> > >       dsi->host.ops =3D &sun6i_dsi_host_ops;
> > >       dsi->host.dev =3D dev;
> > >
> > > +     dsi->variant =3D of_device_get_match_data(dev);
> > > +
> > >       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >       base =3D devm_ioremap_resource(dev, res);
> > >       if (IS_ERR(base)) {
> > > @@ -1001,17 +1004,20 @@ static int sun6i_dsi_probe(struct platform_de=
vice *pdev)
> > >               return PTR_ERR(dsi->reset);
> > >       }
> > >
> > > -     dsi->mod_clk =3D devm_clk_get(dev, "mod");
> > > -     if (IS_ERR(dsi->mod_clk)) {
> > > -             dev_err(dev, "Couldn't get the DSI mod clock\n");
> > > -             return PTR_ERR(dsi->mod_clk);
> > > +     if (dsi->variant->has_mod_clk) {
> > > +             dsi->mod_clk =3D devm_clk_get(dev, "mod");
> > > +             if (IS_ERR(dsi->mod_clk)) {
> > > +                     dev_err(dev, "Couldn't get the DSI mod clock\n"=
);
> > > +                     return PTR_ERR(dsi->mod_clk);
> > > +             }
> > >       }
> > >
> > >       /*
> > >        * In order to operate properly, that clock seems to be always
> > >        * set to 297MHz.
> > >        */
> > > -     clk_set_rate_exclusive(dsi->mod_clk, 297000000);
> > > +     if (dsi->variant->has_mod_clk)
> > > +             clk_set_rate_exclusive(dsi->mod_clk, 297000000);
> > >
> > >       dphy_node =3D of_parse_phandle(dev->of_node, "phys", 0);
> > >       ret =3D sun6i_dphy_probe(dsi, dphy_node);
> > > @@ -1043,7 +1049,8 @@ static int sun6i_dsi_probe(struct platform_devi=
ce *pdev)
> > >       pm_runtime_disable(dev);
> > >       sun6i_dphy_remove(dsi);
> > >  err_unprotect_clk:
> > > -     clk_rate_exclusive_put(dsi->mod_clk);
> > > +     if (dsi->variant->has_mod_clk)
> > > +             clk_rate_exclusive_put(dsi->mod_clk);
> > >       return ret;
> > >  }
> > >
> > > @@ -1056,7 +1063,8 @@ static int sun6i_dsi_remove(struct platform_dev=
ice *pdev)
> > >       mipi_dsi_host_unregister(&dsi->host);
> > >       pm_runtime_disable(dev);
> > >       sun6i_dphy_remove(dsi);
> > > -     clk_rate_exclusive_put(dsi->mod_clk);
> > > +     if (dsi->variant->has_mod_clk)
> > > +             clk_rate_exclusive_put(dsi->mod_clk);
> > >
> > >       return 0;
> > >  }
> > > @@ -1066,7 +1074,8 @@ static int __maybe_unused sun6i_dsi_runtime_res=
ume(struct device *dev)
> > >       struct sun6i_dsi *dsi =3D dev_get_drvdata(dev);
> > >
> > >       reset_control_deassert(dsi->reset);
> > > -     clk_prepare_enable(dsi->mod_clk);
> > > +     if (dsi->variant->has_mod_clk)
> > > +             clk_prepare_enable(dsi->mod_clk);
> > >
> > >       /*
> > >        * Enable the DSI block.
> > > @@ -1094,7 +1103,8 @@ static int __maybe_unused sun6i_dsi_runtime_sus=
pend(struct device *dev)
> > >  {
> > >       struct sun6i_dsi *dsi =3D dev_get_drvdata(dev);
> > >
> > > -     clk_disable_unprepare(dsi->mod_clk);
> > > +     if (dsi->variant->has_mod_clk)
> > > +             clk_disable_unprepare(dsi->mod_clk);
> > >       reset_control_assert(dsi->reset);
> > >
> > >       return 0;
> > > @@ -1106,9 +1116,24 @@ static const struct dev_pm_ops sun6i_dsi_pm_op=
s =3D {
> > >                          NULL)
> > >  };
> > >
> > > +static const struct sun6i_dsi_variant sun6i_a31_dsi =3D {
> > > +     .has_mod_clk =3D true,
> > > +};
> > > +
> > > +static const struct sun6i_dsi_variant sun50i_a64_dsi =3D {
> > > +     .has_mod_clk =3D false,
> >
> > This is the default already.
>=20
> True but we need to assign the .data. how about checking device
> compatible? I'm thinking of difference in driver data in future
> between SoC's

That's not my point. You'll need the structure, but has_mod_clk will
be initialised to false already, so you can drop the explicit
assignment.

> >
> > > +};
> > > +
> > >  static const struct of_device_id sun6i_dsi_of_table[] =3D {
> > > -     { .compatible =3D "allwinner,sun6i-a31-mipi-dsi" },
> > > -     { }
> > > +     {
> > > +             .compatible =3D "allwinner,sun6i-a31-mipi-dsi",
> > > +             .data =3D &sun6i_a31_dsi,
> > > +     },
> > > +     {
> > > +             .compatible =3D "allwinner,sun50i-a64-mipi-dsi",
> > > +             .data =3D &sun50i_a64_dsi,
> > > +     },
> > > +     { /* sentinel */ }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm=
/sun4i/sun6i_mipi_dsi.h
> > > index dbbc5b3ecbda..597b62227019 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > > @@ -20,6 +20,10 @@ struct sun6i_dphy {
> > >       struct reset_control    *reset;
> > >  };
> > >
> > > +struct sun6i_dsi_variant {
> > > +     bool                    has_mod_clk;
> > > +};
> > > +
> >
> > This should be part of a separate patch.
>=20
> How come, because has_mod_clk is using in driver file?

You're doing two things here: Adding a quirk structure, and adding
support for an SoC. This should be two patches.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2m2feqxvtut5wn62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9bMDwAKCRDj7w1vZxhR
xUmXAP4vN8ffjHY6iO11vIeN0E/jNfdln4ZsVJAXWa1MWoBj9AEA8JQFj1Ze5T8u
vhjk54qPb//J2tuKKz2joVzJADM+2gk=
=1Tm4
-----END PGP SIGNATURE-----

--2m2feqxvtut5wn62--
