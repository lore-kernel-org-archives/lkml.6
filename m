Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2359C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED7420855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED7420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeLKQtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:49:24 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60183 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbeLKQtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:49:24 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DD8B3208E3; Tue, 11 Dec 2018 17:49:21 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
        by mail.bootlin.com (Postfix) with ESMTPSA id F06A320DC3;
        Tue, 11 Dec 2018 17:48:59 +0100 (CET)
Date:   Tue, 11 Dec 2018 17:49:00 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
Message-ID: <20181211164900.wfmkmbrbj3nmlb3h@flea>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o2iryg5ow5l3has3"
Content-Disposition: inline
In-Reply-To: <20181210161729.29720-8-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o2iryg5ow5l3has3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 09:47:19PM +0530, Jagan Teki wrote:
> Video start delay can be computed by subtracting total vertical
> timing with front porch timing and with adding 1 delay line for TCON.
>=20
> BSP code form BPI-M64-bsp is computing video start delay as
> (from linux-sunxi/
> drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
>=20
> u32 vfp =3D panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> =3D> (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> =3D> (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
>    - panel->lcd_y - (panel->lcd_vbp)
> =3D> timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
>   			     - panel->lcd_y - panel->lcd_vbp
> =3D> timmings->ver_front_porch
>=20
> So, update the start delay computation accordingly.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Even though it's a bit better now on my A33 board and I don't have the
white stripes on the bottom of the display, there's still some
flickering with your patches applied.

Bisecting it seems to point at that patch, but reverting it doesn't
make the issue go away, so it's not really clear which one exactly is
at fault.

So, just like I asked in your v4, twice,

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/615339.=
html

> Since the documentation is quite sparse, and a MIPI-DSI analyzer is
> way too expensive, I'd really like to have at least what each of
> these commits are actually fixing, and what symptoms each of these
> were causing, and not just "the BSP does it".

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--o2iryg5ow5l3has3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXA/qfAAKCRDj7w1vZxhR
xQ9uAP9KufcyAaepQ146pqXJyHiBpHHjhCG0nERCxU1HYrCa6QEA0CTXdLfEFhRU
ma8TfNxYc8TtkrXtx0qDanfiHpkoRgg=
=qqPn
-----END PGP SIGNATURE-----

--o2iryg5ow5l3has3--
