Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70652C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312872087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312872087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeJHWSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:18:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49339 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeJHWSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:18:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 87139207BF; Mon,  8 Oct 2018 17:05:55 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 534B62072D;
        Mon,  8 Oct 2018 17:05:45 +0200 (CEST)
Date:   Mon, 8 Oct 2018 17:05:46 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@openedev.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
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
Subject: Re: [linux-sunxi] Re: [PATCH 07/12] drm/sun4i: sun6i_mipi_dsi: Fix
 TCON DRQ set bits
Message-ID: <20181008150546.xob5es7gkn7t6kie@flea>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-8-jagan@amarulasolutions.com>
 <20180927165853.dpluekbqzat663q7@flea>
 <CAMty3ZDUxqokipNqnn6c618pebdVBWc8Pfzaz+4+SYqR42Yerg@mail.gmail.com>
 <20181002132008.qtatwtbb3ldu75ay@flea>
 <45dbebe9-d0bd-4a1c-f8ee-3afd64cf35f9@openedev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5fsz2e6ww2xvfdes"
Content-Disposition: inline
In-Reply-To: <45dbebe9-d0bd-4a1c-f8ee-3afd64cf35f9@openedev.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5fsz2e6ww2xvfdes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2018 at 08:52:06AM +0530, Jagan Teki wrote:
> On Tuesday 02 October 2018 06:50 PM, Maxime Ripard wrote:
> > On Thu, Sep 27, 2018 at 11:15:50PM +0530, Jagan Teki wrote:
> > > On Thu, Sep 27, 2018 at 10:28 PM Maxime Ripard
> > > <maxime.ripard@bootlin.com> wrote:
> > > >=20
> > > > On Thu, Sep 27, 2018 at 05:18:45PM +0530, Jagan Teki wrote:
> > > > > TCON DRQ set bits for non-burst DSI mode can computed via
> > > > > horizontal front porch instead of front porch + sync timings.
> > > > >=20
> > > > > Since there no documentation for TCON_DRQ_REG(0x7c) register
> > > > > this change is taken as reference from BPI-M64-bsp.
> > > >=20
> > > > Detailing more what the issue is would be great.
> > > >=20
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > ---
> > > > >   drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
> > > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu=
/drm/sun4i/sun6i_mipi_dsi.c
> > > > > index 599284971ab6..9918fdb990ff 100644
> > > > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > > @@ -367,9 +367,9 @@ static void sun6i_dsi_setup_burst(struct sun6=
i_dsi *dsi,
> > > > >        struct mipi_dsi_device *device =3D dsi->device;
> > > > >        u32 val =3D 0;
> > > >=20
> > > > The computation here is in the A64 driver:
> > > >=20
> > > > if ((panel->lcd_ht - panel->lcd_x - panel->lcd_hbp) < 21) {
> > > >          dsi_dev[sel]->dsi_tcon_drq.bits.drq_mode =3D 0;
> > > > } else {
> > > >          dsi_dev[sel]->dsi_tcon_drq.bits.drq_set =3D
> > > >                  (panel->lcd_ht-panel->lcd_x-panel->lcd_hbp-20) *
> > > >                  dsi_pixel_bits[panel->lcd_dsi_format]/(8*4);
> > > > }
> > > >=20
> > > > It is testing that the sync + front porch is smaller than 21, and
> > > > otherwise sets the drq.
> > > >=20
> > > > > -     if ((mode->hsync_end - mode->hdisplay) > 20) {
> > > >=20
> > > > My code here is testing that the difference between hsync_end and
> > > > hdisplay is superior to 20, and sets the DRQ if true. The condition=
 is
> > > > reversed, but otherwise, that difference is the front porch plus the
> > > > sync length.
> > >=20
> > > True, I understand this, but does drq setting here is specific to SoC?
> > > I thought of finding DRQ in A31 BSP but I couldn't find the code. do
> > > you have bsp somewhere in github?
> > >=20
> > > >=20
> > > > > +     if ((mode->hsync_start - mode->hdisplay) > 20) {
> > > >=20
> > > > However, you are testing for just the front porch, unlike what your
> > > > commit log is saying, and unlike what allwinner's code is saying. So
> > > > this deserves some explanation.
> > >=20
> > > but A64 is doing this, do you think it's completely A64 specific or
> > > testing panel with front porch drq?
> >=20
> > See the above code excerpt:
> > panel->lcd_ht - panel->lcd_x - panel->lcd_hbp
> >=20
> > This is hsync + front porch. Not the sole front porch. So no, it's not
> > doing this.
>=20
> =3D> panel->lcd_ht - panel->lcd_x - panel->lcd_hbp
>=20
> from drivers/video/sunxi/disp2/disp/de/disp_lcd.c
> timmings->hor_front_porch=3D panel_info->lcd_ht-panel_info->lcd_hbp -
> panel_info->lcd_x;
>=20
> =3D> (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x) -
> panel->lcd_x - panel->hbp
> =3D> timmings->hor_front_porch
> =3D> mode->hsync_start - mode->hdisplay
>=20
> This is simply a front porch.

And this should be in your commit log as well.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5fsz2e6ww2xvfdes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu7ckkACgkQ0rTAlCFN
r3Sk7BAAgXuZtTcbLXRz1NxmT//nrdYq1Eu2MeJp2U5yYYbS/q1oNoW9jQsENxBY
qNbGL9i4KGQqJUm6anth/BOS8b/83ULBTduBRhNVhh9GeVWlRQT8RspHvU6IFhnz
oJmOUPAnzjueWF34aoz0gQfHXN9NcVMmlR1fGZ3TmpHvb88mX0W7NElsc8id9WpP
f+pa8ytgXeXEMRN1WlKGBh26so+yp1xbl0D6miTfDY6/0ESzqlq3YcHTP61Mzfne
P+BMKCYdw6TDrDL/1jqIw+eYrij7MkBUswOXrp6NPLO2Zgn+lopOZaTogc/nK3Dt
6S5Y6We/qG51bSqHlaLhtyzVDMsd7egItb4639Kuv8kl5Kp3+neoBUGj52eh9un9
fuX2Nv7kr+p1oL19Wr0ecbKCQDeqOpx0G7BXSWuNQr2mNDKZu7F7wkXZbZmMX5sF
J+Sw6muWzrVOD7+LdIyffiHGHBTWpvBb36J/RImiZqKkm7kl7XnLPixujy7ffMrr
Piub7XQKjF4u142suWt7LiGezMxi8Gsc+bCDob6AUdy1X5xVItQzhMxTcpWmR7hJ
HnF/TYS7hOYePQ62gJD8j1ESG4aTGGKbcCp+xBZt5vgEI0DOMPlKgGQ2QTuJacUJ
13wERsGPdaWBWxSpWTiBytFTg8CQG7uFq/K54HOYCWnsPBtugFc=
=/j+A
-----END PGP SIGNATURE-----

--5fsz2e6ww2xvfdes--
