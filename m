Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA82ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54962087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54962087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeIQB0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:26:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47016 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbeIQB0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:26:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6757627DAE3
Received: by earth.universe (Postfix, from userid 1000)
        id E7E1A3C0C4E; Sun, 16 Sep 2018 14:10:45 +0200 (CEST)
Date:   Sun, 16 Sep 2018 14:10:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
Message-ID: <20180916121045.aptj6nciwskfg4st@earth.universe>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180614151435.6471-1-ctatlor97@gmail.com>
 <20180614151435.6471-3-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g3f65enptyo5t6vn"
Content-Disposition: inline
In-Reply-To: <20180614151435.6471-3-ctatlor97@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g3f65enptyo5t6vn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for my long delay in reviewing this. I like the binding,
but the "qcom," specific properties should become common properties
in

Documentation/devicetree/bindings/power/supply/battery.txt

and referenced via monitored-battery.

-- Sebastian

On Thu, Jun 14, 2018 at 04:14:16PM +0100, Craig Tatlor wrote:
> Add bindings for the Qualcomm Battery Monitoring system.
>=20
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>=20
> * Changes from v6:
>   s/celcius/celsius
>   change uah to uAh.
>=20
> * Changes from v5:                                                       =
                                                                           =
                                                                =20
>   Mentions which values are 8 bit.                                       =
                                                                           =
                                                                =20
>                                                                          =
                                                                           =
                                                                =20
> * Changes from v4:                                                       =
                                                                           =
                                                                =20
>   Uses proper units and expands some definitions,                        =
                                                                           =
                                                                =20
>   along with changing vadc@ to adc@.   =20
>=20
>  .../bindings/power/supply/qcom_bms.txt        | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/qcom_b=
ms.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/qcom_bms.txt =
b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> new file mode 100644
> index 000000000000..dc0a9ab9aa64
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> @@ -0,0 +1,92 @@
> +Qualcomm Battery Monitoring System
> +
> +The Qualcomm Battery Monitoring System is found inside of Qualcomm PM8941
> +PMICs. It provides open circuit voltage (OCV) and coulomb counter regist=
ers
> +that allow the OS to infer a capacity level.
> +
> +Required properties:
> +- compatible:                   Should contain "qcom,pm8941-bms".
> +- reg:                          Specifies the SPMI address and length of=
 the
> +				controller's registers.
> +- interrupts:                   OCV threshold interrupt.
> +- io-channels:                  Should contain IIO channel specifier for=
 the
> +				ADC channel that reports battery temperature.
> +- io-channel-names:             Should contain "temp".
> +- qcom,fcc-temp-legend-celsius: An 8 bit array containing the temperatur=
e,
> +				in degC, for each column of the full charge
> +				capacity lookup table.
> +- qcom,fcc-lut-microamp-hours:  An array of full charge capacity values =
in uAh,
> +				one entry for each temperature defined in in
> +				qcom,fcc-temp-legend-celsius.
> +- qcom,ocv-temp-legend-celsius: An 8 bit array containing the temperatur=
e,
> +				in degC, for each column of the OCV lookup
> +				table.
> +- qcom,ocv-capacity-legend:     An 8 bit array containing the capacity f=
or each
> +				row of the OCV lookup table.
> +- qcom,ocv-lut-microvolt:       An array of OCV values in uV, one entry =
for each
> +				capacity defined in qcom,ocv-capacity-legend.
> +
> +Example:
> +		pm8941_vadc: adc@3100 {
> +			compatible =3D "qcom,spmi-vadc";
> +			reg =3D <0x3100>;
> +			interrupts =3D <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			#io-channel-cells =3D <1>;
> +
> +			bat_temp {
> +				reg =3D <VADC_LR_MUX1_BAT_THERM>;
> +			};
> +		};
> +
> +		bms@4000 {
> +			compatible =3D "qcom,pm8941-bms";
> +			reg =3D <0x4000>;
> +			interrupts =3D <0x0 0x40 0x4 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names =3D "ocv_thr";
> +
> +			io-channels =3D <&pm8941_vadc VADC_LR_MUX1_BAT_THERM>;
> +			io-channel-names =3D "temp";
> +
> +			qcom,fcc-temp-legend-celsius =3D /bits/ 8 <(-10) 0 25 50 65>;
> +			qcom,fcc-lut-microamp-hours =3D <3230000 3260000 3380000 3410000 3360=
000>;
> +
> +			qcom,ocv-capacity-legend =3D /bits/ 8 <100 95 90 85 80 75
> +							     70 65 60 55 50 45
> +							     40 35 30 25 20 15
> +							     10 9 8 7 6 5 4 3 2
> +							     1 0>;
> +			qcom,ocv-temp-legend-celsius =3D /bits/ 8 <(-10) 0 25 50 65>;
> +			qcom,ocv-lut-microvolt =3D <43050000 43050000 43030000 42990000 42950=
000
> +						  42770000 42570000 42550000 42510000 42310000
> +						  42180000 41980000 41970000 41920000 41720000
> +						  41590000 41390000 41450000 41400000 41200000
> +						  41010000 40810000 40920000 40890000 40690000
> +						  40480000 40280000 40440000 40420000 40220000
> +						  40040000 39840000 40010000 39980000 39780000
> +						  39620000 39420000 39550000 39560000 39360000
> +						  39210000 39010000 39090000 39160000 38960000
> +						  38830000 38630000 38740000 38790000 38590000
> +						  38550000 38350000 38440000 38430000 38230000
> +						  38310000 38110000 38230000 38180000 37980000
> +						  38190000 37990000 38040000 38000000 37800000
> +						  38060000 37860000 37900000 37840000 37640000
> +						  37890000 37690000 37770000 37660000 37460000
> +						  37720000 37520000 37560000 37450000 37250000
> +						  37480000 37280000 37290000 37250000 37050000
> +						  37240000 37040000 37020000 36990000 36790000
> +						  37030000 36830000 36730000 36700000 36500000
> +						  36940000 36740000 36670000 36640000 36440000
> +						  36850000 36650000 36600000 36590000 36390000
> +						  36750000 36550000 36520000 36550000 36350000
> +						  36690000 36490000 36380000 36400000 36200000
> +						  36460000 36260000 36180000 36120000 35920000
> +						  36080000 35880000 35680000 35640000 35440000
> +						  35510000 35310000 35050000 35020000 34820000
> +						  34730000 34530000 34300000 34250000 34050000
> +						  33870000 33670000 33040000 32820000 32620000
> +						  30000000 30000000 30000000 30000000 30000000>;
> +		};
> +	};
> +};
> --=20
> 2.17.0
>=20

--g3f65enptyo5t6vn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlueSEMACgkQ2O7X88g7
+ppdHxAAjIDVAc7QVdBbCr7UTNQ222Z0hyrbj0I65gSnz29UX2NtPkSL7K3t1j5C
Z6F0mYSxybCJBGGM/AOdkESEth8o7hjmkMW6K/HhdRuTBmshkrG+03J6mp5dCfBP
hXXl8xkDPcJ4BzK14TmkUExqEh0/mgoUH0vK4MfoneTTzqFdOZTFZXqYANaS6wBf
Hiw6NR2bB5qOxLrxH/Ulx40+Rdpj5flYf/Epc70aWEmSZAth6JYjGmB0J8XnktAX
6GjYJ3GatbzC5BN2YuVrD5WBpSt+E825m6QPbGRJC0IhASwBbGNFR+ZLHkHEP8qY
P2yxIgq5fvJO4PXV03QnSdaxPeLzHxzCN78gKfwrpO+kdFx4hoE9G6oAsFNlcQVL
MdI2QGYxGca7rUhMIMdeGEl6zlfd1R6/cW88H8olvbEJGc+xmDQcI2qEMFD9+9dy
fnzAa3GoSyOiJnK+D8HIGC6wTWaYFT2rHbDRx71YGNVvKk3aP2X+xQECZS2hjsTn
xwhOMhSV8oJA/SNdzk9HfLBbGpEnF3mdkoOzouuR1/vy8JcWDd4jv+B0E1EgR6Ii
Zj6t/4OGbr78SF6aQpUWK0cjZXT8986GdVpbp4eqlPn3nSMybYqRvv/q6tS3eM4E
YF2ORHClD9euaf0OtR1go0EO/qJAe/udjcoGltON/5OKcbsCzX8=
=uOSG
-----END PGP SIGNATURE-----

--g3f65enptyo5t6vn--
