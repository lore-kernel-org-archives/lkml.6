Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5447DC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2583A20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2583A20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeK1Ve2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:34:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48337 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbeK1Ve2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:34:28 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ED01D206D8; Wed, 28 Nov 2018 11:33:14 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1FC4720DD7;
        Wed, 28 Nov 2018 11:32:19 +0100 (CET)
Date:   Wed, 28 Nov 2018 11:32:19 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 04/15] dt-bindings: rtc: sun6i-rtc: Export internal RC
 oscillator
Message-ID: <20181128103219.b625lttcgoluhgz5@flea>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-5-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="booz6elk33kflwpj"
Content-Disposition: inline
In-Reply-To: <20181128093013.24442-5-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--booz6elk33kflwpj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 05:30:01PM +0800, Chen-Yu Tsai wrote:
> Experiments showed that on at least the H3/H5/A64 the RTC's internal
> oscillator also feeds the CPUS mux in the PRCM.
>=20
> Export this clock through the device tree, instead of having to use
> a dummy fixed-clock device node, for the PRCM to consume. This will
> properly describe the relationship between the clocks.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/rtc/sun6i-rtc.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Docume=
ntation/devicetree/bindings/rtc/sun6i-rtc.txt
> index 78c4fb472eb7..1bd37faadecb 100644
> --- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
> @@ -24,7 +24,7 @@ Required properties:
> =20
>  Required properties for new device trees
>  - clocks	: phandle to the 32kHz external oscillator
> -- clock-output-names : names of the two clock outputs. See below.
> +- clock-output-names : names of the three clock outputs. See below.
>  - #clock-cells  : must be equal to 1.
> =20
>  The RTC provides the following clocks at the given indices:
> @@ -32,6 +32,7 @@ The RTC provides the following clocks at the given indi=
ces:
>  - 1: LOSC external output, known as X32KFOUT in the datasheet.
>       This clock is not available on the A31 and is deprecated for old
>       device trees still using the "allwinner,sun6i-a31-rtc" compatible.
> +- 2: InternalOSC, or internal RC oscillator

It seems to be required only for a few RTC though (H3, H5 and R40?)

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--booz6elk33kflwpj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/5uswAKCRDj7w1vZxhR
xeZMAQDI/0l2TQDQE4latkDeQLbxx81a5mh0WiAiVsYp/WkiZwEAv4zE0ICSI7iK
DBVFBjPBy0KOPmmpaH67xLoBPuxG1Q0=
=f8qS
-----END PGP SIGNATURE-----

--booz6elk33kflwpj--
