Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDD6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B43A21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B43A21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbeITGmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:42:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41858 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeITGmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:42:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 12A75263B12
Received: by earth.universe (Postfix, from userid 1000)
        id C1C943C0A85; Thu, 20 Sep 2018 03:02:11 +0200 (CEST)
Date:   Thu, 20 Sep 2018 03:02:11 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, yuanjiang.yu@spreadtrum.com, krzk@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: power: Add Spreadtrum SC2731 charger
 documentation
Message-ID: <20180920010211.lh6yys7ywunkgdxj@earth.universe>
References: <8a8d31119bc723a0012afa8e517015dbba68fee9.1537214465.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tpouyxcs6juyqmza"
Content-Disposition: inline
In-Reply-To: <8a8d31119bc723a0012afa8e517015dbba68fee9.1537214465.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tpouyxcs6juyqmza
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 17, 2018 at 01:03:30PM -0700, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum SC2731 charger
> device.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Thanks, queued.

-- Sebastian

> Changes from v2:
>  - Add reviewed tag from Krzysztof.
>=20
> Changes from v1:
>  - Add parent node.
>  - Add some battery standard properties.
> ---
>  .../bindings/power/supply/sc2731_charger.txt       | 40 ++++++++++++++++=
++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc2731=
_charger.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sc2731_charge=
r.txt b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
> new file mode 100644
> index 0000000..5266fab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
> @@ -0,0 +1,40 @@
> +Spreadtrum SC2731 PMIC battery charger binding
> +
> +Required properties:
> + - compatible: Should be "sprd,sc2731-charger".
> + - reg: Address offset of charger register.
> + - phys: Contains a phandle to the USB phy.
> +
> +Optional Properties:
> +- monitored-battery: phandle of battery characteristics devicetree node.
> +  The charger uses the following battery properties:
> +- charge-term-current-microamp: current for charge termination phase.
> +- constant-charge-voltage-max-microvolt: maximum constant input voltage.
> +  See Documentation/devicetree/bindings/power/supply/battery.txt
> +
> +Example:
> +
> +	bat: battery {
> +		compatible =3D "simple-battery";
> +		charge-term-current-microamp =3D <120000>;
> +		constant-charge-voltage-max-microvolt =3D <4350000>;
> +		......
> +	};
> +
> +	sc2731_pmic: pmic@0 {
> +		compatible =3D "sprd,sc2731";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <26000000>;
> +		interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells =3D <2>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		charger@0 {
> +			compatible =3D "sprd,sc2731-charger";
> +			reg =3D <0x0>;
> +			phys =3D <&ssphy>;
> +			monitored-battery =3D <&bat>;
> +		};
> +	};
> --=20
> 1.9.1
>=20

--tpouyxcs6juyqmza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlui8ZAACgkQ2O7X88g7
+poAmg/9HHciFJ2gHSaxipm/LD8MFMVQUSFY3rjLftplCCDwP3ygL8sISO4/GYdW
EdtFDl77Ylj5Cuft/PTyhj0+s6lDZtcPwU7JtR2c3QFqswUjILJCwSC4Gr/T9Kqc
N6XCQCmMQUFhUD/DlmRxtomqJlIUep9tQ79ZfQnv1whhV9n2gfCpFGvpk/umru4K
XFRk0ZM6qaeVOWKPNj4uz0WCTjGGisyjlFGrRMeAX6H9xqjSEVjM99OdWsWtJU4i
fw+TMMb+s9+rOM4bgOgcIVoA5VFbZODLYkY5u78OVX5LjihB0HelpV/UfaV/eO3o
ovY1JmBLzKP8KWWhr/rgjmtmU2H6Xp0bV9tIN9EP/oOQDWA/AvkGCBAP8PPw4vyL
9nRajU6tWS7aPU1vE4kyhbVBnx5DkUFPuK+GXBZoNEqnyAFSUlDqQug/513AkrOD
qfIC9Xbw2C36FFngX+VJYh1dHQ+0NHePg5J5oiJYCla2yq7AYmEgn8EGC+0GcaZQ
nF7gOc4QlUaajRYW1wIPUCcf70ndE+Y54Z7NtirQ1l1EuTd4mp+cvdyEI6YYACeS
r6MzP0WrrFTr5xWi2wr2eLO49xurF7S0+FZTfRVbyizvQesAlxS+IarG9TdHqApr
+J8LIsmW1YxeQ4IKZle+BG+N9cBdvvK7vz6NJfJ5Uo6+ql9P1jM=
=UxTA
-----END PGP SIGNATURE-----

--tpouyxcs6juyqmza--
