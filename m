Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E58C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A283E21104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrdMHrC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A283E21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeKKWIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 17:08:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbeKKWIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 17:08:25 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15250208A3;
        Sun, 11 Nov 2018 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541938799;
        bh=3x5mNiab2D1PJgbJSnCs8qKqD9Dtps/5f+/sE3WRJ1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GrdMHrC+S1yUbJzkhAbLzWaJbuK2FB1Ja3g55YdcooCdKchkdD2DP7sD6f7UfKUQy
         rutUK1W88EvbkFa+c66JRhSLH6UcWdZKqE+pAqwHXxL+4c2TZ12RtjFZe0DSbu4Hk4
         aFD9dYfuXJ6zjt6ZgwP1h+FnobCnzxvC3b52pzy8=
Date:   Sun, 11 Nov 2018 12:19:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] dt-bindings: iio: adc: Add docs for ad7124
Message-ID: <20181111121954.145cbd2f@archlinux>
In-Reply-To: <1541778180-7862-1-git-send-email-stefan.popa@analog.com>
References: <1541778180-7862-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 17:43:00 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> Add support for Analog Devices AD7124 4-channels and 8-channels ADC.
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

Your example still includes the other things that I think you have now drop=
ped.
gain and odr.

> ---
> Changes in v2:
> 	- Nothing changed.
> Changes in v3:
> 	- Removed the "adi,channels" property.
> 	- Used the "reg" property to get the channel number and "adi,diff-channe=
ls"
> 	  for the differential pins. The "adi,channel-number" property was remov=
ed.
> 	- adi,bipolar is of boolean type.
> Changes in v4:
> 	- Used the bipolar and diff-channels properties defined in the new adc.t=
xt doc.
>=20
>  .../devicetree/bindings/iio/adc/adi,ad7124.txt     | 81 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.=
txt
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt b/D=
ocumentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> new file mode 100644
> index 0000000..fa0c43b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> @@ -0,0 +1,81 @@
> +Analog Devices AD7124 ADC device driver
> +
> +Required properties for the AD7124:
> +	- compatible: Must be one of "adi,ad7124-4" or "adi,ad7124-8"
> +	- reg: SPI chip select number for the device
> +	- spi-max-frequency: Max SPI frequency to use
> +		see: Documentation/devicetree/bindings/spi/spi-bus.txt
> +	- clocks: phandle to the master clock (mclk)
> +		see: Documentation/devicetree/bindings/clock/clock-bindings.txt
> +	- clock-names: Must be "mclk".
> +	- interrupts: IRQ line for the ADC
> +		see: Documentation/devicetree/bindings/interrupt-controller/interrupts=
.txt

Given the driver doesn't currently use it, should perhaps be optional?

> +
> +	  Required properties:
> +		* #address-cells: Must be 1.
> +		* #size-cells: Must be 0.
> +
> +	  Subnode(s) represent the external channels which are connected to the=
 ADC.
> +	  Each subnode represents one channel and has the following properties:
> +		Required properties:
> +			* reg: The channel number. It can have up to 4 channels on ad7124-4
> +			  and 8 channels on ad7124-8, numbered from 0 to 15.
> +			* diff-channels: see: Documentation/devicetree/bindings/iio/adc/adc.t=
xt
> +
> +		Optional properties:
> +			* bipolar: see: Documentation/devicetree/bindings/iio/adc/adc.txt
> +			* adi,reference-select: Select the reference source to use when
> +			  converting on the the specific channel. Valid values are:
> +			  0: REFIN1(+)/REFIN1(=E2=88=92).
> +			  1: REFIN2(+)/REFIN2(=E2=88=92).
> +			  3: AVDD
> +			  If this field is left empty, internal reference is selected.
> +
> +Optional properties:
> +	- refin1-supply: refin1 supply can be used as reference for conversion.
> +	- refin2-supply: refin2 supply can be used as reference for conversion.
> +	- avdd-supply: avdd supply can be used as reference for conversion.
> +
> +Example:
> +	adc@0 {
> +		compatible =3D "adi,ad7124-4";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <5000000>;
> +		interrupts =3D <25 2>;
> +		interrupt-parent =3D <&gpio>;
> +		refin1-supply =3D <&adc_vref>;
> +		clocks =3D <&ad7124_mclk>;
> +		clock-names =3D "mclk";
> +
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		channel@0 {
> +			reg =3D <0>;
> +			adi,diff-channels =3D <0 1>;
> +			adi,reference-select =3D <0>;
> +			adi,gain =3D <2>;
> +			adi,odr-hz =3D <10>;
I think you have dropped these two..

> +		};
> +
> +		channel@1 {
> +			reg =3D <1>;
> +			adi,bipolar;
> +			adi,diff-channels =3D <2 3>;
> +			adi,reference-select =3D <0>;
> +			adi,gain =3D <4>;
> +			adi,odr-hz =3D <50>;
> +		};
> +
> +		channel@2 {
> +			reg =3D <2>;
> +			adi,diff-channels =3D <4 5>;
> +			adi,gain =3D <128>;
> +			adi,odr-hz =3D <19200>;
> +		};
> +
> +		channel@3 {
> +			reg =3D <3>;
> +			adi,diff-channels =3D <6 7>;
> +		};
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a1bfcb..f2fa508 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/adc/ad7124.c
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> =20
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>

