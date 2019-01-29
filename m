Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D08C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F333C2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfA2PLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:11:20 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:45022 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA2PLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:11:19 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id F39913A69A0;
        Tue, 29 Jan 2019 15:54:11 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8B1FC200012;
        Tue, 29 Jan 2019 14:54:07 +0000 (UTC)
Date:   Tue, 29 Jan 2019 15:54:03 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@openedev.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH v6 14/22] dt-bindings: sun6i-dsi: Add
 A64 DSI compatible (w/ A31 fallback)
Message-ID: <20190129145402.d6athskmfydqodvn@flea>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-15-jagan@amarulasolutions.com>
 <20190125155236.agxwkxvyefmrbvym@flea>
 <bed39fd2-1f4f-4c6b-afc6-da127326775c@openedev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yiit6eh4xmxsxmgp"
Content-Disposition: inline
In-Reply-To: <bed39fd2-1f4f-4c6b-afc6-da127326775c@openedev.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yiit6eh4xmxsxmgp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 26, 2019 at 09:39:00PM +0530, Jagan Teki wrote:
> On 25/01/19 9:22 PM, Maxime Ripard wrote:
> > On Fri, Jan 25, 2019 at 01:28:52AM +0530, Jagan Teki wrote:
> > > The MIPI DSI controller in Allwinner A64 is similar to A33.
> > >=20
> > > But unlike A33, A64 doesn't have DSI_SCLK gating which eventually
> > > set the mod clock rate for the controller.
> > >=20
> > > So, use the DSI_DPHY gating for the similar purpose of mod clock
> > > so-that the controller can operate properly.
> > >=20
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >   Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
> > >   1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-ds=
i.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > > index 69e233e8fad1..dbda2e567760 100644
> > > --- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > > +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > > @@ -12,6 +12,7 @@ The DSI Encoder generates the DSI signal from the T=
CON's.
> > >   Required properties:
> > >     - compatible: value must be one of:
> > >       * allwinner,sun6i-a31-mipi-dsi
> > > +    * "allwinner,sun50i-a64-mipi-dsi", "allwinner,sun6i-a31-mipi-dsi"
> >=20
> > The other line doesn't have quotes, we should be consistent
>=20
> You mean to say, remove quotes like this
>=20
> allwinner,sun50i-a64-mipi-dsi, allwinner,sun6i-a31-mipi-dsi

Yep

> This make confusion with comma with allwinner vs next compatible string
> isn't it? (In fact I did follow the similar like TCON in sun4i-drm.txt)

There's no really clear consensus here, andd i don't really have a
strong opinion on the matter either. Since the YAML schemas are going
to have it without double quotes, I guess we should use that
convention as well, but we want to remain consistent at least.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--yiit6eh4xmxsxmgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFBpCgAKCRDj7w1vZxhR
xV5KAP4uQCiSzyiLpf20SSf+LVg0ilVvXVaAyKZ8286iXnkfGgD+LuvzUttfKIvE
cXwtCc2cOoI9IQGGyPCJguGgsMTX3wc=
=fwZS
-----END PGP SIGNATURE-----

--yiit6eh4xmxsxmgp--
