Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D216CC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C4B20858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C4B20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJHTop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:44:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44294 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbeJHTop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:44:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AB488207C4; Mon,  8 Oct 2018 14:33:12 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 74E6E20726;
        Mon,  8 Oct 2018 14:33:12 +0200 (CEST)
Date:   Mon, 8 Oct 2018 14:33:13 +0200
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
Message-ID: <20181008123313.sxqzulfuktslchhy@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-26-jernej.skrabec@siol.net>
 <20181008085112.mejpwvl3dpu7sopy@flea>
 <CAGb2v64avzzrGJeg2HU_Ze686C1nmVsNwXJGzsUbQvQTZKuSMw@mail.gmail.com>
 <20181008102021.ox34mqbw65euvsb4@flea>
 <CAGb2v65vG2sCMLOFSVAko+MUBDQa_A+qrMZLFe20QXJhApd1Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lij4si3huvsbt5ic"
Content-Disposition: inline
In-Reply-To: <CAGb2v65vG2sCMLOFSVAko+MUBDQa_A+qrMZLFe20QXJhApd1Gw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lij4si3huvsbt5ic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 06:50:44PM +0800, Chen-Yu Tsai wrote:
> On Mon, Oct 8, 2018 at 6:20 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Mon, Oct 08, 2018 at 05:06:45PM +0800, Chen-Yu Tsai wrote:
> > > On Mon, Oct 8, 2018 at 4:51 PM Maxime Ripard <maxime.ripard@bootlin.c=
om> wrote:
> > > >
> > > > On Sun, Oct 07, 2018 at 11:39:01AM +0200, Jernej Skrabec wrote:
> > > > > From: Icenowy Zheng <icenowy@aosc.io>
> > > > >
> > > > > Some SoCs, such as H6, doesn't have a full-featured TCON TOP.
> > > > >
> > > > > Add quirks support for TCON TOP.
> > > > >
> > > > > Currently the presence of TCON_TV1 and DSI is controlled via the =
quirks
> > > > > structure.
> > > > >
> > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > ---
> > > > >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 43 ++++++++++++++++++++=
------
> > > > >  1 file changed, 34 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu=
/drm/sun4i/sun8i_tcon_top.c
> > > > > index 37158548b447..ed13233cad88 100644
> > > > > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > > @@ -9,11 +9,17 @@
> > > > >  #include <linux/component.h>
> > > > >  #include <linux/device.h>
> > > > >  #include <linux/module.h>
> > > > > +#include <linux/of_device.h>
> > > > >  #include <linux/of_graph.h>
> > > > >  #include <linux/platform_device.h>
> > > > >
> > > > >  #include "sun8i_tcon_top.h"
> > > > >
> > > > > +struct sun8i_tcon_top_quirks {
> > > > > +     bool has_tcon_tv1;
> > > > > +     bool has_dsi;
> > > > > +};
> > > > > +
> > > > >  static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *=
node)
> > > > >  {
> > > > >       return !!of_match_node(sun8i_tcon_top_of_table, node);
> > > > > @@ -121,10 +127,13 @@ static int sun8i_tcon_top_bind(struct devic=
e *dev, struct device *master,
> > > > >       struct platform_device *pdev =3D to_platform_device(dev);
> > > > >       struct clk_hw_onecell_data *clk_data;
> > > > >       struct sun8i_tcon_top *tcon_top;
> > > > > +     const struct sun8i_tcon_top_quirks *quirks;
> > > > >       struct resource *res;
> > > > >       void __iomem *regs;
> > > > >       int ret, i;
> > > > >
> > > > > +     quirks =3D of_device_get_match_data(&pdev->dev);
> > > > > +
> > > > >       tcon_top =3D devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNE=
L);
> > > > >       if (!tcon_top)
> > > > >               return -ENOMEM;
> > > > > @@ -187,15 +196,23 @@ static int sun8i_tcon_top_bind(struct devic=
e *dev, struct device *master,
> > > > >                                            &tcon_top->reg_lock,
> > > > >                                            TCON_TOP_TCON_TV0_GATE=
, 0);
> > > > >
> > > > > -     clk_data->hws[CLK_TCON_TOP_TV1] =3D
> > > > > -             sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> > > > > -                                          &tcon_top->reg_lock,
> > > > > -                                          TCON_TOP_TCON_TV1_GATE=
, 1);
> > > > > +     if (quirks->has_tcon_tv1) {
> > > > > +             clk_data->hws[CLK_TCON_TOP_TV1] =3D
> > > > > +                     sun8i_tcon_top_register_gate(dev, "tcon-tv1=
", regs,
> > > > > +                                                  &tcon_top->reg=
_lock,
> > > > > +                                                  TCON_TOP_TCON_=
TV1_GATE, 1);
> > > > > +     } else {
> > > > > +             clk_data->hws[CLK_TCON_TOP_TV1] =3D NULL;
> > > > > +     }
> > > > >
> > > > > -     clk_data->hws[CLK_TCON_TOP_DSI] =3D
> > > > > -             sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > > > > -                                          &tcon_top->reg_lock,
> > > > > -                                          TCON_TOP_TCON_DSI_GATE=
, 2);
> > > > > +     if (quirks->has_dsi) {
> > > > > +             clk_data->hws[CLK_TCON_TOP_DSI] =3D
> > > > > +                     sun8i_tcon_top_register_gate(dev, "dsi", re=
gs,
> > > > > +                                                  &tcon_top->reg=
_lock,
> > > > > +                                                  TCON_TOP_TCON_=
DSI_GATE, 2);
> > > > > +     } else {
> > > > > +             clk_data->hws[CLK_TCON_TOP_DSI] =3D NULL;
> > > >
> > > > clk_data has been kzalloc'd so its content is already NULL.
> > > >
> > > > And you shouldn't have brackets for single line blocks.
> > > >
> > > > with that fixed,
> > >
> > > FYI checkpatch.pl complains if you use brackets for the if block
> > > but not for the else block. They should be matching.
> >
> > Checkpatch might not warn on this, but
> > https://www.kernel.org/doc/Documentation/process/coding-style.rst,
> > section 3 is pretty clear on whether we should use them or not.
>=20
> Right. What I'm pointing out what checkpatch.pl complains about is
> shown in the second last example in section 3:
>=20
>     This does not apply if only one branch of a conditional statement
> is a single
>     statement; in the latter case use braces in both branches:
>=20
> Which is where I think your comment on "shouldn't have brackets for
> single line blocks"
> is pointing in the opposite direction.

I think we have a communication failure :)

The two blocks above are single line blocks, even though the line is
wrapped. So whether or not there is an else condition or not doesn't
matter, you shouldn't have braces at all.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lij4si3huvsbt5ic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu7TogACgkQ0rTAlCFN
r3QhpA/8DxvkrijXgVayMy4NuU/Fnv937XrDhepdrCsnY9ur9yaAvgI7uLHN7t1W
FgC0/jK7RUGz8AJyKD87cL64XrPJNSAic+Nymi9iycuJxSosWuXcoqKArOMOrwCM
TmQyIzwuBVmbouFHvlZJmrusKZoezhQ3spZ8M79XsGRnlZPAr5Z6eMvNXuGaURJQ
v+uTCL+OmOJWFzBzRkROpqUgb0DTsDSBYkrkXTZCGBXRjqFMZWOSGJYwsFgt3LR5
Y8UQ4Vy7vxSK/0O+QRCXu7f7C3C9jyubyE0Y5Euz9x7BkxbdgQoFliSMa/Y3RONP
1HjXbCR1z5PA/KtZoT3rUD+eiiiX97GS2fJT/G7DDJrXenAaPFerJA9kkK8KfJE9
uJtvATn9Bn4m719DW5XJUkdMXd4Nta72G2hDPqBfP2tQOovYnvc9dAi4vu53jarp
lJm0JK+jTTcSHllv+Oka+piijzHqLBh9ypkFwuEkUuUGUbvDR0f8gE4zVknKucO7
tp1qK7M5k1TGVy7EqRMdXpO2Q0l6SVsxJmDDTqGVWEGAujdbg1M1WQd+jelv2qDr
rt9nolUG3+6bbwwNBlJZJ94aX3mEy1prAGWu+ACJaIN79VFrsjW95LE34eZSgnBd
IBSDEMYbZr8HfK966gM4gG0pZjOQUGr1quK1ArKQ81ZZhcgNtS0=
=UhMN
-----END PGP SIGNATURE-----

--lij4si3huvsbt5ic--
