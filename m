Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F726C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29E720862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29E720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbeKGBSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:18:09 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54567 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387685AbeKGBSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:18:09 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A19F120741; Tue,  6 Nov 2018 16:52:17 +0100 (CET)
Received: from localhost (unknown [185.94.189.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5AC5720712;
        Tue,  6 Nov 2018 16:52:07 +0100 (CET)
Date:   Tue, 6 Nov 2018 16:52:07 +0100
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
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 02/10] drm/sun4i: sun6i_mipi_dsi: Support instruction
 loop selection
Message-ID: <20181106155207.kysq2crszzqv45ib@flea>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-3-jagan@amarulasolutions.com>
 <20181105103857.lp7ayw3p6dbthehg@flea>
 <CAMty3ZBje8F4YEfWC4qoxADhgdFjbcwZBKJwak633pUAwKAftA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iwk7rx7z5npid6ud"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBje8F4YEfWC4qoxADhgdFjbcwZBKJwak633pUAwKAftA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iwk7rx7z5npid6ud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 04:56:35PM +0530, Jagan Teki wrote:
> On Mon, Nov 5, 2018 at 4:09 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Sat, Nov 03, 2018 at 03:38:52PM +0530, Jagan Teki wrote:
> > > Instruction loop selection would require before writing
> > > loop number registers, so enable idle, LP11 bits on
> > > loop selection register.
> > >
> > > Reference code available in BSP
> > > (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > (dsi_dev[sel]->dsi_inst_loop_sel.dwval =3D 2<<(4*DSI_INST_ID_LP11) |
> > >       3<<(4*DSI_INST_ID_DLY);
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm=
/sun4i/sun6i_mipi_dsi.c
> > > index da152c21ec62..077b57ec964c 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -397,6 +397,10 @@ static void sun6i_dsi_setup_inst_loop(struct sun=
6i_dsi *dsi,
> > >       struct mipi_dsi_device *device =3D dsi->device;
> > >       u16 delay;
> > >
> > > +     regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_SEL_REG,
> > > +                  DSI_INST_ID_HSC  << (4 * DSI_INST_ID_LP11) |
> > > +                  DSI_INST_ID_HSD  << (4 * DSI_INST_ID_DLY));
> > > +
> >
> > Please put this with the other instructions settings below.
>=20
> Does that mean after computation delay code?

Yes

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--iwk7rx7z5npid6ud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+G4pwAKCRDj7w1vZxhR
xf5zAP9MQRhh1/DVKTUy1CqpnOzbp3XS5XFbEMEfhyXA3L304wD8Cd2d61VUgcPW
CDWVIgkkHip3nkRAC0rM4ZNrgH29zwA=
=Q/5+
-----END PGP SIGNATURE-----

--iwk7rx7z5npid6ud--
