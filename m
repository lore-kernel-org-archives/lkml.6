Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18177C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BAA218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfAYPrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:47:43 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54293 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfAYPrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:47:41 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6905520397; Fri, 25 Jan 2019 16:47:38 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 388EF20397;
        Fri, 25 Jan 2019 16:47:28 +0100 (CET)
Date:   Fri, 25 Jan 2019 16:47:28 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v6 12/22] dt-bindings: sun6i-dsi: Add VCC-DSI supply
 property
Message-ID: <20190125154728.v555gwwmramamm32@flea>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-13-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rxheysiip7de6ngo"
Content-Disposition: inline
In-Reply-To: <20190124195900.22620-13-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rxheysiip7de6ngo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 01:28:50AM +0530, Jagan Teki wrote:
> Most of the Allwinner MIPI DSI controllers are supply with
> VCC-DSI pin. which need to supply for some of the boards to
> trigger the power.
>=20
> So, document the supply property so-that the required board
> can eable it via device tree.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.tx=
t b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> index 6a6cf5de08b0..69e233e8fad1 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> @@ -27,6 +27,9 @@ Required properties:
>      first port should be the input endpoint, usually coming from the
>      associated TCON.
> =20
> +Optional properties:
> +  - vcc-dsi-supply: the VCC-DSI power supply of the DSI encoder
> +

It looks like the VCC power rail is found on all the Allwinner SoCs,
so it should be made mandatory.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rxheysiip7de6ngo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEsvkAAKCRDj7w1vZxhR
xf/OAP0WFHQ2cdrPgixtVKbGRa8+3plVbGmUXVqKYzSxl+m8RgD+MLbJ/e6QTJxZ
Qeh6FvUCYWAnW67OMEHzja+FQr7BAgY=
=RBpI
-----END PGP SIGNATURE-----

--rxheysiip7de6ngo--
