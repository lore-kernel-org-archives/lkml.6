Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_RHS_DOB,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A58FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1874A2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1874A2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeLFPfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:35:37 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46978 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbeLFPfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:35:34 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A95B620743; Thu,  6 Dec 2018 16:35:32 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 77B012037D;
        Thu,  6 Dec 2018 16:35:32 +0100 (CET)
Date:   Thu, 6 Dec 2018 16:35:32 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: allwinner: a64: Add pinmux setting
 for CSI MCLK on PE1
Message-ID: <20181206153532.6c756gccmpuj4wdw@flea>
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
 <20181206132306.11843-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cbvttiq36vayljpk"
Content-Disposition: inline
In-Reply-To: <20181206132306.11843-3-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cbvttiq36vayljpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 06:53:06PM +0530, Jagan Teki wrote:
> Some camera modules have the SoC feeding a master clock to the sensor
> instead of having a standalone crystal. This clock signal is generated
> from the clock control unit and output from the CSI MCLK function of
> pin PE1.
>=20
> Add a pinmux setting for it for camera sensors to reference.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - new patch
>=20
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index d7ab0006ebce..902b5238f1dd 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -538,6 +538,11 @@
>  				function =3D "csi0";
>  			};
> =20
> +			csi_mclk_pin: csi-mclk {
> +				pins =3D "PE1";
> +				function =3D "csi0";
> +			};
> +

We're not merging nodes that have no users.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--cbvttiq36vayljpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAlBxAAKCRDj7w1vZxhR
xQMnAPoCXJz4177Z0gPYi1tab7dXUbO0+S8NzlYsHPdhoM9eMwEArRInznK0aoTF
epDN7HgXYeTlO3/290Hr/ZcarCUC5AM=
=AP9r
-----END PGP SIGNATURE-----

--cbvttiq36vayljpk--
