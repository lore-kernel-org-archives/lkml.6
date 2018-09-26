Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AEBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E391214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wC31Ee5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E391214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeIZU1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbeIZU1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:27:24 -0400
Received: from earth.universe (guest-nat.fw1.untrust.par1.mozilla.net [185.155.181.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7262120843;
        Wed, 26 Sep 2018 14:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537971254;
        bh=qmPqRFxop3+cGjGY8nfy+fCe86cVPE8SbZfWGqwk8uY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wC31Ee5LFboUFiCfg0rWzSQ13/NBxecM2tVMqhCjFctgipeawWDQ/R3xd7TJhni/f
         7GmS4BQxOdwNxL4bMzAtMFkMIgzWcY3qjpsBnB3xuUEes7srldQgsjHIocqxXU9xjg
         WoMJPI53rq+flxgY7bhznibN6wuOEwnRmTef445M=
Received: by earth.universe (Postfix, from userid 1000)
        id 9842A3C09D6; Wed, 26 Sep 2018 16:14:08 +0200 (CEST)
Date:   Wed, 26 Sep 2018 16:14:08 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: Re: [PATCH v2 3/4] dt-bindings: power: Add Spreadtrum SC27XX fuel
 gauge unit documentation
Message-ID: <20180926141408.dumlwnjmbue4nkjm@earth.universe>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <b4b36b7b54cc227e6e7f14c314b4617863a205f5.1537930252.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f23zl5vcp3oae2xk"
Content-Disposition: inline
In-Reply-To: <b4b36b7b54cc227e6e7f14c314b4617863a205f5.1537930252.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f23zl5vcp3oae2xk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 26, 2018 at 10:59:13AM +0800, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum SC27XX series PM=
ICs
> fuel gauge unit device, which is used to calculate the battery capacity.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Looks good to me.

-- Sebastian

> Changes from v1:
>  - Renamed GPIO property.
>  - Use standand battery properties instead of 'sprd,inner-resist' and
>    'sprd,ocv-cap-table'.
>  - Remove battery node's description.
> ---
>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |   52 ++++++++++++++=
++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx=
-fg.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt=
 b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> new file mode 100644
> index 0000000..b161468
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> @@ -0,0 +1,52 @@
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
> +- battery-detect-gpios: GPIO for battery detection.
> +- io-channels: Specify the IIO ADC channel to get temperature.
> +- io-channel-names: Should be "bat-temp".
> +- monitored-battery: Phandle of battery characteristics devicetree node.
> +  See Documentation/devicetree/bindings/power/supply/battery.txt
> +
> +Example:
> +
> +	bat: battery {
> +		compatible =3D "simple-battery";
> +		charge-full-design-microamp-hours =3D <1900000>;
> +		constant-charge-voltage-max-microvolt =3D <4350000>;
> +		ocv-capacity-table-temperatures =3D <20>;
> +		ocv-capacity-table-0 =3D <4185000 100>, <4113000 95>, <4066000 90>,
> +					<4022000 85>, <3983000 80>, <3949000 75>,
> +					<3917000 70>, <3889000 65>, <3864000 60>,
> +					<3835000 55>, <3805000 50>, <3787000 45>,
> +					<3777000 40>, <3773000 35>, <3770000 30>,
> +					<3765000 25>, <3752000 20>, <3724000 15>,
> +					<3680000 10>, <3605000 5>, <3400000 0>;
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
> +			battery-detect-gpios =3D <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
> +			io-channels =3D <&pmic_adc 5>;
> +			io-channel-names =3D "bat-temp";
> +			monitored-battery =3D <&bat>;
> +		};
> +	};
> --=20
> 1.7.9.5
>=20

--f23zl5vcp3oae2xk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlurlCsACgkQ2O7X88g7
+pq5hw/9Fppud7JlWswYwKy8iOl9ahWFL+Ox5Rb4Eld97X30hAWQxTDhmjjYOmdy
a1758rB+wSH7iCl7j9yhWck/iJ3bFVNNRBeXtlFJ1USU5r7No23cshCgR0BKBbUa
w8MSvR8ayP1gKiSy3CEA8wC+n6mNNeLkeXrvu4Bqhb3SIwdo1kTmIvUgsnwqRfFv
wVcMRuPqcO47pVxlwX8xPz226GhNx+KnUvQGx+JDk2u0xke5FcvI6QA4k7V30Ryi
vL9QVG8pGFdOxwEfYv1F5F8Ucpu3KOyslEG1ih5rXY13AYPD57gRVkLJ4aVQoagp
oCI1Y21kSrPZxvvjAyY7DcUukL/cVUhVz/zTZc4FEmYMP3yogcc9t4jieP+As4SE
iCcrSCBP59ejkoHfqz8eVOl4ubbfFlRcBKH8J9K8Wx78fn7l1J2B8o4wkVC25dHu
adZtZug7UDiuJkg5ydMHy7xXySQwVmlBNeZ4x7uPO8y144M23D05l4hB9192QoeH
ZpO58Cky2F8Hik9idIhVL4HVbdmbrDofj8BQbPV8GPeoxruit67rvr2BGF/3HJg0
G+M3jWLVxu3RxVSkmYJ8MV21hmGJ9v57a0u9VGSwk1yYTGFkdbNJ3TVSPjC75GMz
KVHUZVYf02uKKuX2XKjdpARhppV2TVRjYgNQC3apCHVpL1pgzqU=
=THfg
-----END PGP SIGNATURE-----

--f23zl5vcp3oae2xk--
