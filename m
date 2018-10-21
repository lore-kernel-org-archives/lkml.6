Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0F8ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3FC2083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu1nb9X9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3FC2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeJVDm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 23:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbeJVDm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 23:42:29 -0400
Received: from earth.universe (unknown [62.214.5.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 888DC20658;
        Sun, 21 Oct 2018 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540150027;
        bh=DQantDa2DRZvntC4/uobEQGOw15PK0GejlSTBcPH4Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iu1nb9X9/PKL/puEjYO+snZnNqlI9/KgtYPxSv4Wc3rNXS7MIfDqt3P1wDwTMgDOg
         2rl5eOy13cv1vMr2gITe3UiIhIBv2wLBMFQzhO1iy52vE8x2UzMgzVz6V/UH/eMUjo
         dW0//QIzDhLrGN8li+oLVxoCbYpa/iDNV0DwYziI=
Received: by earth.universe (Postfix, from userid 1000)
        id D3F603C098F; Sun, 21 Oct 2018 18:24:30 +0200 (CEST)
Date:   Sun, 21 Oct 2018 18:24:30 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: Re: [PATCH v5 3/6] dt-bindings: power: Introduce properties to
 present the battery OCV capacity table
Message-ID: <20181021162430.qfz2teauewdy5jva@earth.universe>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
 <3a0c6487c9503cf64432f630e65790cc5c3f70ab.1539915051.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lgjqzksp5zzrqfpo"
Content-Disposition: inline
In-Reply-To: <3a0c6487c9503cf64432f630e65790cc5c3f70ab.1539915051.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lgjqzksp5zzrqfpo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2018 at 06:53:12PM +0800, Baolin Wang wrote:
> Some battery driver will use the open circuit voltage (OCV) value to look
> up the corresponding battery capacity percent in one certain degree Celsi=
us.
> Thus this patch provides some battery properties to present the OCV table
> temperatures and OCV capacity table values.
>=20
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Looks good to me.

-- Sebastian

> Changes from v4:
>  - Improve the description of ocv-capacity-table-n to make the order clea=
r.
>=20
> Changes from v3:
>  - Split binding into one separate patch.
>  - Rename ocv-capacity-table-temperatures to ocv-capacity-celsius.
>  - Add some words to specify the OCV's unit.
>=20
> Changes from v2:
>  - Use type __be32 to calculate the table length.
>  - Update error messages.
>  - Add some helper functions.
>=20
> Changes from v1:
>  - New patch in v2.
> ---
>  .../devicetree/bindings/power/supply/battery.txt   |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b=
/Documentation/devicetree/bindings/power/supply/battery.txt
> index 938d027..89871ab 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -23,6 +23,17 @@ Optional Properties:
>   - constant-charge-current-max-microamp: maximum constant input current
>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
>   - factory-internal-resistance-micro-ohms: battery factory internal resi=
stance
> + - ocv-capacity-table-0: An array providing the open circuit voltage (OC=
V)
> +   of the battery and corresponding battery capacity percent, which is u=
sed
> +   to look up battery capacity according to current OCV value. And the o=
pen
> +   circuit voltage unit is microvolt.
> + - ocv-capacity-table-1: Same as ocv-capacity-table-0
> + ......
> + - ocv-capacity-table-n: Same as ocv-capacity-table-0
> + - ocv-capacity-celsius: An array containing the temperature in degree C=
elsius,
> +   for each of the battery capacity lookup table. The first temperature =
value
> +   specifies the OCV table 0, and the second temperature value specifies=
 the
> +   OCV table 1, and so on.
> =20
>  Battery properties are named, where possible, for the corresponding
>  elements in enum power_supply_property, defined in
> @@ -44,6 +55,10 @@ Example:
>  		constant-charge-current-max-microamp =3D <900000>;
>  		constant-charge-voltage-max-microvolt =3D <4200000>;
>  		factory-internal-resistance-micro-ohms =3D <250000>;
> +		ocv-capacity-celsius =3D <(-10) 0 10>;
> +		ocv-capacity-table-0 =3D <4185000 100>, <4113000 95>, <4066000 90>, ..=
=2E;
> +		ocv-capacity-table-1 =3D <4200000 100>, <4185000 95>, <4113000 90>, ..=
=2E;
> +		ocv-capacity-table-2 =3D <4250000 100>, <4200000 95>, <4185000 90>, ..=
=2E;
>  	};
> =20
>  	charger: charger@11 {
> --=20
> 1.7.9.5
>=20

--lgjqzksp5zzrqfpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvMqD4ACgkQ2O7X88g7
+po+qA//YPKLr1a2+dJGER6QU5BNbQLcQW98aYF04eTnq5R+sGX9+zCgH/uvQVJ7
BS98J+pMSi/Bpq3AHIrfPnTrjdROGk9BG3RjdRqSd8eFLgEI9i9yUEXnwdY/RxCH
WTXai4lBLeN7vvcTRu6s2FYIzA1m84B/BzEU4Dy5KjLVIKqQzUSZSB6WDW7P6DSF
YOa/9Vh7bjKfijaCnmJk4SQM8rFyxFzAiWHnfe+sbNv/jLEU6LK5D0rbJnD5Cr2M
oIn0JY6m/BfydAanAvlsD9hG7lhRsciePXtGw9XP5EVBuMgb2VSMJZmp0Qs51UhR
oO6P2io2tJpyi9RxO1yHFGCm0+k+J7h6Wwy+IW/MSDtT6m4PSmfKQwmHKGA5g5dz
AlOUNfsSy/GbNmmpnM7M+lEGZNNgo2ue6neCRaJ7V6NhpuptwW6gE0OOUT9zg94x
9Hya3Of0HTdiIBFchfFyUbxI7zTBlsiqLU93jOMe/Ggsh4AO8kZDhTCfa0BvHSAx
Ixt+34Yl6lpP1PT5exMPVFk7YkgjOR2K44YnsDe4cKB5FGIEQw7zoCIiD1yydbmJ
BvGDnp62TAI/LKrVbUy5JeM9kb/6g2Gnn8o0nMUWJbsePL07GatWThvkOJOnxTqZ
ZDAOW/y5/J6/mTzw9ik1Jig/8iHd6KPp0MVUVHTlUWJe0/f9wZo=
=Rlqe
-----END PGP SIGNATURE-----

--lgjqzksp5zzrqfpo--
