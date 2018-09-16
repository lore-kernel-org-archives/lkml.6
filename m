Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E538BECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43B4208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43B4208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeIQB1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:27:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47032 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbeIQB0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:26:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9DD5B27DAE5
Received: by earth.universe (Postfix, from userid 1000)
        id 6F1A53C0C52; Sun, 16 Sep 2018 15:57:21 +0200 (CEST)
Date:   Sun, 16 Sep 2018 15:57:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang@linaro.org>,
        Craig Tatlor <ctatlor97@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: Add Spreadtrum SC27XX fuel gauge
 unit documentation
Message-ID: <20180916135721.rhu3rn4fsrmmgnbf@earth.universe>
References: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d2rtcggg5cqwck6e"
Content-Disposition: inline
In-Reply-To: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d2rtcggg5cqwck6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 12, 2018 at 03:29:38PM +0800, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum SC27XX series PM=
ICs
> fuel gauge unit device, which is used to calculate the battery capacity.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |   55 ++++++++++++++=
++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx=
-fg.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt=
 b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> new file mode 100644
> index 0000000..7447bae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> @@ -0,0 +1,55 @@
> +Spreadtrum SC27XX PMICs Fuel Gauge Unit Power Supply Bindings
> +
> +Required properties:
> +- compatible: Should be one of the following:
> +  "sprd,sc2720-fgu",
> +  "sprd,sc2721-fgu",
> +  "sprd,sc2723-fgu",
> +  "sprd,sc2730-fgu",
> +  "sprd,sc2731-fgu".
> +- reg: The address offset of fuel gauge unit.
> +- bat-detect-gpio: GPIO for battery detection.
> +- io-channels: Specify the IIO ADC channel to get temperature.
> +- io-channel-names: Should be "bat-temp".
> +- sprd,inner-resist: Specify the the battery inner resistance (mOhm).

This should be a property of the battery.without the sprd, prefix.

> +- sprd,ocv-cap-table: Provide the battery capacity percent with correspo=
nding
> +  open circuit voltage (ocv) of the battery, which is used to look up cu=
rrent
> +  battery capacity according to current baterry ocv values.

This should also be part of the battery binding. I just reviewed a
patchset for the Qualcomm Battery Monitoring System, which needs the
same functionality. The Qualcomm binding is more advanced, but
should also support this simpler case. Thus I think it makes sense
to use its description as base for adding support for this feature
to Documentation/devicetree/bindings/power/supply/battery.txt

-- Sebastian

> +- monitored-battery: Phandle of battery characteristics devicetree node.
> +  The fuel gauge uses the following battery properties:
> +- charge-full-design-microamp-hours: battery design capacity.
> +- constant-charge-voltage-max-microvolt: maximum constant input voltage.
> +  See Documentation/devicetree/bindings/power/supply/battery.txt
> +
> +Example:
> +
> +	bat: battery {
> +		compatible =3D "simple-battery";
> +		charge-full-design-microamp-hours =3D <1900000>;
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
> +		fgu@a00 {
> +			compatible =3D "sprd,sc2731-fgu";
> +			reg =3D <0xa00>;
> +			bat-detect-gpio =3D <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
> +			io-channels =3D <&pmic_adc 5>;
> +			io-channel-names =3D "bat-temp";
> +			sprd,inner-resist =3D <250>;
> +			sprd,ocv-cap-table =3D <4185 100>, <4113 95>, <4066 90>, <4022 85>, <=
3983 80>, <3949 75>, <3917 70>,
> +				<3889 65>, <3864 60>, <3835 55>, <3805 50>, <3787 45>, <3777 40>, <3=
773 35>, <3770 30>,
> +				<3765 25>, <3752 20>, <3724 15>, <3680 10>, <3605 5>, <3400 0>;
> +			monitored-battery =3D <&bat>;
> +		};
> +	};
> --=20
> 1.7.9.5
>=20

--d2rtcggg5cqwck6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlueYUEACgkQ2O7X88g7
+prBpA/+L4vfCccaNDqookIw9lLx8g654kCwWqFEMlyu6kGJ5NxPKW7bp5pgYbLr
IFjWqntkQg816WJUYz1Bz7eV3XJYTn7uSufIKz5pee5f45RZsa5NcNHOSqWDaBka
kgbJZSs3tQDksaIv1wTQWH18T/mE2rpoIszvtnrbIBUDL9QDqwLQXhXHJKsq9e0S
SgIMAFMIwZ9sP9HN1hn4NHj5SUv0ZHNR5JK1wL9WWpvWxfYuGd6Zz+Ekz2x6IZvh
aMTkcngN9eV/DfPUagBZZmiAYrMTQ4JrOeHj1AQWuZra0/6/D+zVg/ES093JN0LH
F8u7jB7X0b5V0MPSFDmDsSXgrPLLki/upHl79oDLEjTBtq6TyU30/dU1MJN3lo0R
nkCgiHe3uscelpWVkSDRxk806CpPUNPFxh6VcXLY01JCEPyAaDiU/Y2qC4+e3Gvn
3Y0Xg3SiakKCEnkPbpxJ0xco8QsCR4ErGu5qWQUVNALD1XLAaCUapTIiSgd0IBIk
4Hlq4Hi24m1Ox42B0sPrh55BRgyfICW5pllnPqPkhTS9z1qvBaYlhO8B1GMmuqSH
FtUTPc9QriOHGICK6W9bWs93NO2hw+jnx0Su3s05+RRR6nO9MujLIWrETIA22fC0
CFZNDdopuVuTrCnqhu3jD8T4AcP/WLkZpuCeYjJFmdUjhXxYGCM=
=qeQf
-----END PGP SIGNATURE-----

--d2rtcggg5cqwck6e--
