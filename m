Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02414C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE2720858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE2720858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJHRbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:31:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39518 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeJHRbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:31:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E84E9207CC; Mon,  8 Oct 2018 12:20:30 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id B2A5D2072D;
        Mon,  8 Oct 2018 12:20:20 +0200 (CEST)
Date:   Mon, 8 Oct 2018 12:20:21 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v2 25/29] drm: sun4i: add quirks for TCON TOP
Message-ID: <20181008102021.ox34mqbw65euvsb4@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-26-jernej.skrabec@siol.net>
 <20181008085112.mejpwvl3dpu7sopy@flea>
 <CAGb2v64avzzrGJeg2HU_Ze686C1nmVsNwXJGzsUbQvQTZKuSMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5u3grpihdexgzvi"
Content-Disposition: inline
In-Reply-To: <CAGb2v64avzzrGJeg2HU_Ze686C1nmVsNwXJGzsUbQvQTZKuSMw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5u3grpihdexgzvi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 05:06:45PM +0800, Chen-Yu Tsai wrote:
> On Mon, Oct 8, 2018 at 4:51 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Sun, Oct 07, 2018 at 11:39:01AM +0200, Jernej Skrabec wrote:
> > > From: Icenowy Zheng <icenowy@aosc.io>
> > >
> > > Some SoCs, such as H6, doesn't have a full-featured TCON TOP.
> > >
> > > Add quirks support for TCON TOP.
> > >
> > > Currently the presence of TCON_TV1 and DSI is controlled via the quir=
ks
> > > structure.
> > >
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 43 ++++++++++++++++++++----=
--
> > >  1 file changed, 34 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm=
/sun4i/sun8i_tcon_top.c
> > > index 37158548b447..ed13233cad88 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > @@ -9,11 +9,17 @@
> > >  #include <linux/component.h>
> > >  #include <linux/device.h>
> > >  #include <linux/module.h>
> > > +#include <linux/of_device.h>
> > >  #include <linux/of_graph.h>
> > >  #include <linux/platform_device.h>
> > >
> > >  #include "sun8i_tcon_top.h"
> > >
> > > +struct sun8i_tcon_top_quirks {
> > > +     bool has_tcon_tv1;
> > > +     bool has_dsi;
> > > +};
> > > +
> > >  static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *node)
> > >  {
> > >       return !!of_match_node(sun8i_tcon_top_of_table, node);
> > > @@ -121,10 +127,13 @@ static int sun8i_tcon_top_bind(struct device *d=
ev, struct device *master,
> > >       struct platform_device *pdev =3D to_platform_device(dev);
> > >       struct clk_hw_onecell_data *clk_data;
> > >       struct sun8i_tcon_top *tcon_top;
> > > +     const struct sun8i_tcon_top_quirks *quirks;
> > >       struct resource *res;
> > >       void __iomem *regs;
> > >       int ret, i;
> > >
> > > +     quirks =3D of_device_get_match_data(&pdev->dev);
> > > +
> > >       tcon_top =3D devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
> > >       if (!tcon_top)
> > >               return -ENOMEM;
> > > @@ -187,15 +196,23 @@ static int sun8i_tcon_top_bind(struct device *d=
ev, struct device *master,
> > >                                            &tcon_top->reg_lock,
> > >                                            TCON_TOP_TCON_TV0_GATE, 0);
> > >
> > > -     clk_data->hws[CLK_TCON_TOP_TV1] =3D
> > > -             sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> > > -                                          &tcon_top->reg_lock,
> > > -                                          TCON_TOP_TCON_TV1_GATE, 1);
> > > +     if (quirks->has_tcon_tv1) {
> > > +             clk_data->hws[CLK_TCON_TOP_TV1] =3D
> > > +                     sun8i_tcon_top_register_gate(dev, "tcon-tv1", r=
egs,
> > > +                                                  &tcon_top->reg_loc=
k,
> > > +                                                  TCON_TOP_TCON_TV1_=
GATE, 1);
> > > +     } else {
> > > +             clk_data->hws[CLK_TCON_TOP_TV1] =3D NULL;
> > > +     }
> > >
> > > -     clk_data->hws[CLK_TCON_TOP_DSI] =3D
> > > -             sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > > -                                          &tcon_top->reg_lock,
> > > -                                          TCON_TOP_TCON_DSI_GATE, 2);
> > > +     if (quirks->has_dsi) {
> > > +             clk_data->hws[CLK_TCON_TOP_DSI] =3D
> > > +                     sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > > +                                                  &tcon_top->reg_loc=
k,
> > > +                                                  TCON_TOP_TCON_DSI_=
GATE, 2);
> > > +     } else {
> > > +             clk_data->hws[CLK_TCON_TOP_DSI] =3D NULL;
> >
> > clk_data has been kzalloc'd so its content is already NULL.
> >
> > And you shouldn't have brackets for single line blocks.
> >
> > with that fixed,
>=20
> FYI checkpatch.pl complains if you use brackets for the if block
> but not for the else block. They should be matching.

Checkpatch might not warn on this, but
https://www.kernel.org/doc/Documentation/process/coding-style.rst,
section 3 is pretty clear on whether we should use them or not.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--r5u3grpihdexgzvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu7L2QACgkQ0rTAlCFN
r3SCvQ/+I1VZqOyeEpjeR4ZTp/UXi85Oblv9cj9w4Gh/d8EUAdJp6BbGjq47cS70
sSQfEER2VVjE3OGGLuE5ntTb4wX+LCJOwOrUEKU4Sg05CvrkK65EM+wMD3/SUKb6
R5QOPmNREs8DGTHFLopF+Jhl1h50szwkUzXIBAZQBWBRwWBMP6GxDf0X6FcSXc+G
YilzIfDwnHxmIXRDpHffxVUt6TzpEjn7QE3JndaDCgQzajCITXczY9JsiSt6lOKh
DfqB1CpXbJyemYvkY6gxJk13HnNiPU88LHBngl4FcCi3a5hAeOtekWJ7ndk2J6aX
zcA4FDlOE2s70oiM1u67exlIoS15n5Qe2rc788BER+Yuv6dlLp1bAHUG5E5itjIF
JShFBx/fJldilHr90B76NbwJyL13RTl2XIO4EZSpa4xLDXe+SmTgySO2oiEDGJ12
pDfjq4M0GX7s/JRMJr6jbals0vXPSP0ejaA7L7x4OtjvBZ8jf1/jZUejRcFZR6bi
SGRVuY5OkovisOW4AD4b+MURzUUzWNqzhWQGu1xnklZ7JMNrpPB5APIA8dq40w5S
e3g0pb1SKvLZ7Pm3gcGeAk2dHop61qrT6SmsWj1+UCPVohP1xBlsKMtwq2dM867b
aeUoZ7kSc86Vd3JI+KpFWTuiCfrdYixHlPw6odstJqfPd4EU0EA=
=t/60
-----END PGP SIGNATURE-----

--r5u3grpihdexgzvi--
