Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F74C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C27F20659
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C27F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437747AbeKWCMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:12:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60540 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391685AbeKWCMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:12:49 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8BF2420712; Thu, 22 Nov 2018 16:32:56 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 90B8F20DD6;
        Thu, 22 Nov 2018 16:32:41 +0100 (CET)
Date:   Thu, 22 Nov 2018 16:32:41 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v9 1/8] ASoC: dt-bindings: sun50i-codec-analog: Add
 headphone amp regulator supply
Message-ID: <20181122153241.lzrwhkewg5q4hy2c@flea>
References: <20181122102325.29495-1-wens@csie.org>
 <20181122102325.29495-2-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="clfxfbg7mahnnpva"
Content-Disposition: inline
In-Reply-To: <20181122102325.29495-2-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--clfxfbg7mahnnpva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 06:23:18PM +0800, Chen-Yu Tsai wrote:
> On the Allwinner A64 SoC, the audio codec has a built-in headphone
> amplifier. This amplifier has a power supply separate from the rest of
> the analog audio circuitry.
>=20
> Add a regulator supply property to handle this.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.=
txt b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
> index 4f8ad0e04d20..056a098495cc 100644
> --- a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
> +++ b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
> @@ -4,9 +4,11 @@ Required properties:
>  - compatible: must be one of the following compatibles:
>  		- "allwinner,sun50i-a64-codec-analog"
>  - reg: must contain the registers location and length
> +- cpvdd-supply: Regulator supply for the headphone amplifier

I guess we should make this optional, since even if it's missing, it's
going to create a dummy regulator. and that allows to have backward
compatibility.

For the rest of the series,
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--clfxfbg7mahnnpva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/bMGQAKCRDj7w1vZxhR
xXK7AP4xw73COf+jZ+DgLz5eORkIp5iSggiG0mpFHaDj7MAkqQEA1V9ws8B/pb1G
JOTYaHCfWH9wVrNJTvbDlKLyni/sXwI=
=xruV
-----END PGP SIGNATURE-----

--clfxfbg7mahnnpva--
