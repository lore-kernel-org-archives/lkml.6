Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC53C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCE92075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCE92075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeJHWRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:17:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49309 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeJHWRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:17:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1C8C2206A2; Mon,  8 Oct 2018 17:05:31 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2D0F3207F3;
        Mon,  8 Oct 2018 17:05:20 +0200 (CEST)
Date:   Mon, 8 Oct 2018 17:05:21 +0200
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
Subject: Re: [linux-sunxi] Re: [PATCH 06/12] drm/sun4i: sun6i_mipi_dsi: Fix
 VBP size calculation
Message-ID: <20181008150521.mespl2oqkc4j6tjb@flea>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-7-jagan@amarulasolutions.com>
 <20180927152126.vovnvwmqdfpuxgdm@flea>
 <CAMty3ZABx9Fod5W_T7JciZEsn7jGvuM-LsBFATdA=hQ2CVwELw@mail.gmail.com>
 <20180929135302.ymdzapz5npvapti2@flea>
 <63b40c20-670b-1c53-bf5e-62f64e6e02f0@openedev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rkrm4oitetupjisc"
Content-Disposition: inline
In-Reply-To: <63b40c20-670b-1c53-bf5e-62f64e6e02f0@openedev.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rkrm4oitetupjisc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 01:39:17PM +0530, Jagan Teki wrote:
> On Saturday 29 September 2018 07:23 PM, Maxime Ripard wrote:
> > On Thu, Sep 27, 2018 at 09:50:34PM +0530, Jagan Teki wrote:
> > > On Thu, Sep 27, 2018 at 8:51 PM Maxime Ripard <maxime.ripard@bootlin.=
com> wrote:
> > > >=20
> > > > On Thu, Sep 27, 2018 at 05:18:44PM +0530, Jagan Teki wrote:
> > > > > According to horizontal and vertical timings are defined
> > > > > per the diagram from include/drm/drm_modes.h
> > > > >=20
> > > > > Back porch =3D [hv]total - [hv]sync_end
> > > > >=20
> > > > > So, update SUN6I_DSI_BASIC_SIZE0_VBP calculation as
> > > > > mode->vtotal - mode->vsync_end
> > > > >=20
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > ---
> > > > >   drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
> > > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu=
/drm/sun4i/sun6i_mipi_dsi.c
> > > > > index 1c7e42015645..599284971ab6 100644
> > > > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > > @@ -526,8 +526,8 @@ static void sun6i_dsi_setup_timings(struct su=
n6i_dsi *dsi,
> > > > >        regmap_write(dsi->regs, SUN6I_DSI_BASIC_SIZE0_REG,
> > > > >                     SUN6I_DSI_BASIC_SIZE0_VSA(mode->vsync_end -
> > > > >                                               mode->vsync_start) |
> > > > > -                  SUN6I_DSI_BASIC_SIZE0_VBP(mode->vsync_start -
> > > > > -                                            mode->vdisplay));
> > > > > +                  SUN6I_DSI_BASIC_SIZE0_VBP(mode->vtotal -
> > > > > +                                            mode->vsync_end));
> > > >=20
> > > > Is it purely theoretical, or did you find some source that back tha=
t?
> > >=20
> > > VSA is done as per that, sync_end - sync start would give sync time.
> >=20
> > That's a different register though.
> >=20
> > > VBP also done in BPI-M64-bsp[1] which results back porch existing code
> > > results fron porch.
> > >=20
> > > [1] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sun=
xi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L955
> >=20
> > That code does back porch - sync length. Such a calculation doesn't
> > make much sense as is, but you're saying that it results in the front
> > porch. Again, what makes you say that?
>=20
> No what code shows is not a real back porch value used for drm it's panel
> back porch value which is a DTS property in BSP.
> (I made wrong comment on previous mail as front porch, sorry)
>=20
> here is the real code
>=20
> from drivers/video/sunxi/disp2/disp/de/disp_lcd.c
> timmings->ver_sync_time=3D panel_info->lcd_vspw;
> timmings->ver_back_porch=3D panel_info->lcd_vbp-panel_info->lcd_vspw;
>=20
>=20
> u32 vbp =3D panel->lcd_vbp;
> u32 vspw =3D panel->lcd_vspw;
> dsi_dev[sel]->dsi_basic_size0.bits.vbp =3D vbp-vspw;
>=20
> So,
>=20
> dsi_dev[sel]->dsi_basic_size0.bits.vbp =3D panel->lcd_vbp - panel->lcd_vs=
pw;
>=20
> =3D>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->lcd_v=
spw
> =3D>  timmings->ver_back_porch
> =3D>  mode->vtotal - mode->end
>=20
> VSA, which a proper value.
>=20
> dsi_dev[sel]->dsi_basic_size0.bits.vsa =3D vspw;
> =3D> panel_info->lcd_vspw;
> =3D> timmings->ver_sync_time
> =3D> mode->vsync_end - mode->vsync_start

Then please write that in your commit log.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rkrm4oitetupjisc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu7cjAACgkQ0rTAlCFN
r3RZzg//anglhD3n/3cfoeaqVGfJmTzOeVNGi5yFBctOeJU6WMiv3uehiqkW1Itt
wd8mhA/so2Z5gfEs4kP5OfnKlb/3dkLRDbl0R85TMqb1VfEVGto7wCDpoX3mByJf
/WAGbjD0oEJdamrr0oxILL7F4H0JCc96PdGgXFgJasCKEkvTUpnHv/63awomLTuC
qVOOtlHm14PZVxqFMWhbh+uhoBiKIGZ6CGnp6dbxqZ6mdYlqRsWg1hTXsjkDOkPa
qnMn9EfLCjlqX5PwHoteunlwDzVBEU73p4l5ZCWIs/QK158eN9J3KlarC0c/enY4
evxQb4dOT1EjE5Aj+BcC3ecx+uTii816A7twl2KlsntpfU9OUAvXou5fnR913uGK
pyTQgMdCSZmycTs8vduJeBPLSjbbsYUkr0ZvVWm1sxRAFHb9JzAtqBq8aSkfHVQ3
XNbCOB4YEBZNhDR0nn3A70FQ/M5jSB79sq5mhVSMUbxqznSJNIA+Gzqvdp0qYbc4
RUYt/O/snznAhBpQBSSWArGQ/zUpKREXswVvnl3d9w7Olam0+iHs2blC7yuJ43u2
iSVd4slONW7Pi+9YQ6BmKThQerYTs/v+GRq+LxbF7YG9dXljiS69KB4weDhQyAU9
0URN6S/wZgXZrnGlGggoQbGnTRjgFT5idgAfo5zBbD1yb4x6Yds=
=M3gJ
-----END PGP SIGNATURE-----

--rkrm4oitetupjisc--
