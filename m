Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01196C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB2A206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB2A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJBUDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:03:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36440 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbeJBUDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:03:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 697F6208C2; Tue,  2 Oct 2018 15:20:18 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3D98D20A90;
        Tue,  2 Oct 2018 15:20:08 +0200 (CEST)
Date:   Tue, 2 Oct 2018 15:20:08 +0200
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
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 07/12] drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
Message-ID: <20181002132008.qtatwtbb3ldu75ay@flea>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-8-jagan@amarulasolutions.com>
 <20180927165853.dpluekbqzat663q7@flea>
 <CAMty3ZDUxqokipNqnn6c618pebdVBWc8Pfzaz+4+SYqR42Yerg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e3ngso3ragygfnwc"
Content-Disposition: inline
In-Reply-To: <CAMty3ZDUxqokipNqnn6c618pebdVBWc8Pfzaz+4+SYqR42Yerg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e3ngso3ragygfnwc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2018 at 11:15:50PM +0530, Jagan Teki wrote:
> On Thu, Sep 27, 2018 at 10:28 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Thu, Sep 27, 2018 at 05:18:45PM +0530, Jagan Teki wrote:
> > > TCON DRQ set bits for non-burst DSI mode can computed via
> > > horizontal front porch instead of front porch + sync timings.
> > >
> > > Since there no documentation for TCON_DRQ_REG(0x7c) register
> > > this change is taken as reference from BPI-M64-bsp.
> >
> > Detailing more what the issue is would be great.
> >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm=
/sun4i/sun6i_mipi_dsi.c
> > > index 599284971ab6..9918fdb990ff 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -367,9 +367,9 @@ static void sun6i_dsi_setup_burst(struct sun6i_ds=
i *dsi,
> > >       struct mipi_dsi_device *device =3D dsi->device;
> > >       u32 val =3D 0;
> >
> > The computation here is in the A64 driver:
> >
> > if ((panel->lcd_ht - panel->lcd_x - panel->lcd_hbp) < 21) {
> >         dsi_dev[sel]->dsi_tcon_drq.bits.drq_mode =3D 0;
> > } else {
> >         dsi_dev[sel]->dsi_tcon_drq.bits.drq_set =3D
> >                 (panel->lcd_ht-panel->lcd_x-panel->lcd_hbp-20) *
> >                 dsi_pixel_bits[panel->lcd_dsi_format]/(8*4);
> > }
> >
> > It is testing that the sync + front porch is smaller than 21, and
> > otherwise sets the drq.
> >
> > > -     if ((mode->hsync_end - mode->hdisplay) > 20) {
> >
> > My code here is testing that the difference between hsync_end and
> > hdisplay is superior to 20, and sets the DRQ if true. The condition is
> > reversed, but otherwise, that difference is the front porch plus the
> > sync length.
>=20
> True, I understand this, but does drq setting here is specific to SoC?
> I thought of finding DRQ in A31 BSP but I couldn't find the code. do
> you have bsp somewhere in github?
>=20
> >
> > > +     if ((mode->hsync_start - mode->hdisplay) > 20) {
> >
> > However, you are testing for just the front porch, unlike what your
> > commit log is saying, and unlike what allwinner's code is saying. So
> > this deserves some explanation.
>=20
> but A64 is doing this, do you think it's completely A64 specific or
> testing panel with front porch drq?

See the above code excerpt:
panel->lcd_ht - panel->lcd_x - panel->lcd_hbp

This is hsync + front porch. Not the sole front porch. So no, it's not
doing this.

Maxime


--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--e3ngso3ragygfnwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluzcIcACgkQ0rTAlCFN
r3QaUA//UqgcQMvezF4AVH8GOBqM98kZm6zSSgnfvobj+hXIdaewSkDYYY5PNTa6
anrc5WJ9VtL+Y+TUJ1s/Gz8M8hd1RosFvAOQg5SaZt8ijeNuTCIUj9+mlGJi2M5f
ouh4SLSSOwY4sn7aWB44AA/Zo+Mx4aXBcvHg7xMNIxKHctemelAuFTDWvojZLNe9
foeGzILwAY8CbXIGrOxViSRnI/aUOmxXGyExHulKWUGh1e58c6F6harsUpaLDCQH
G8/DhZmYHEXhekFR1KaoncQwkdMpgPpwqJIXTB9ScDWbkRzfMjFFmdfKKN3jLTJr
/gsdqLyuQ1mhH0Mkf9lJsrBLDXXfMc8DX/9abfEBoASc7cblEWFAr1T8Qi1kiA6t
0wYss1i19BQap9nA3eJvySfz7c4lkrCJXpJxhNq8589JIBbphzGN9//m/Ij24XSr
XHndjIept97cnIR0x+zCYpscA7lisKrIyDtAwwgg4j6navWoH10Xsu8JXommr8aX
FmVpPMx8QyLObU57YVTHzKM6r6dg1fgqKq0iQqKzOeOK77T2xTcTI5gU4QYLZwzv
e+qiEmdCm0pMyBShXSW3BtM+AWPOSsAjcsyPJvsHHz4g/WxQKdZGkCc9kvbQsoA6
QdqSjUj5sFGdt8lXRL6lrjtzNWwVlb/RuHKVOe3Fp4e6jl8DSjs=
=JRz4
-----END PGP SIGNATURE-----

--e3ngso3ragygfnwc--
