Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAFEC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596572082E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfAYJoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:44:24 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42269 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbfAYJoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:44:24 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B31D3209B6; Fri, 25 Jan 2019 10:44:21 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 80A4420798;
        Fri, 25 Jan 2019 10:44:21 +0100 (CET)
Date:   Fri, 25 Jan 2019 10:44:22 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] ARM: sun8i: a23: Enable display pipeline
Message-ID: <20190125094422.cpisr63pk7af3nnq@flea>
References: <20190125032314.20915-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rscg5zrsk3zckgor"
Content-Disposition: inline
In-Reply-To: <20190125032314.20915-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rscg5zrsk3zckgor
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 11:23:03AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
>=20
> This series enables the display pipeline on the Allwinner A23 SoC.
> A few fixes are included for corner cases when the frontend isn't
> enabled.
>=20
> The A23 display pipeline is very much the same as the A33, except
> that the A23 does not have the SAT IP block embedded within the
> display backend.
>=20
> MIPI DSI is not covered as I do not have a device that uses it.
>=20
> Patch 1 fixes the pll-mipi clock on the A23.
>=20
> Patch 2 adds compatible strings for the various hardware blocks
> of the A23 display pipeline.
>=20
> Patch 3 through 5 fix some issues in our DRM plane support, namely
> declaring support for formats when we shouldn't.
>=20
> Patch 6 adds support for the A23 display pipeline to the driver.
>=20
> Patch 7 is a small cleanup before moving the display pipeline device
> nodes.
>=20
> Patch 8 moves the display nodes from the A33-specific dtsi file to
> the A23-A33 shared dtsi file. Note that the MIPI DSI device nodes are
> not moved.
>=20
> Patch 9 adds compatible strings to the display nodes in the A23-specific
> dtsi file.
>=20
> Patch 10 enables the display pipeline for the shared A23/A33 Q8 tablet
> dtsi file. The compatible string should be filled in by the tablet dts
> files.
>=20
> Patch 11 fills in the compatible string for the standard A23 Q8 tablet.
> Note the compatible string is not for the specific model used in the
> tablet, as it varies between production runs. Rather it is just one that
> works.
>=20
> Please have a look. Patch 3 might be worth applying as a fix, but might
> not be worth the trouble. It could just as easily be applied for -next
> and then backported.
>=20
> Also, the fixes tags are no longer line wrapped, unlike patches I've
> sent in the past.

Applied all, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rscg5zrsk3zckgor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEradQAKCRDj7w1vZxhR
xU1iAP4gdJXMRt2zbfjcLw4OB2DzAijDTr0FQfYjolcT9AHgHgD+I0KOJCZ9tJAM
iiCJXi+JYKLhP+SyLjnL4p20FOAw+ww=
=+w+u
-----END PGP SIGNATURE-----

--rscg5zrsk3zckgor--
