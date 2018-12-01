Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4632C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 17:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7123D2146F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 17:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGHhjNu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7123D2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeLBENs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 23:13:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbeLBENs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 23:13:48 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C34BD2082F;
        Sat,  1 Dec 2018 17:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543683650;
        bh=+NcLsIDzFlsYDy3CvvHtroowrjtQSBa51KarVAtEx84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jGHhjNu+YHXL4006UQ6mxHkm2DOK/RNZP6eWmmmagE0DOKueZeraLjeKJwlTNAAmt
         C8thVMNIwQLRF5q8jjBBTOHCyITofBda8tGDFRTCX/5zsb8CW/qaIFg8SVAtOr2KEC
         W9P3PqZS+0WOCDbefsH6pybgeMv/nQPcwWqXTYUs=
Date:   Sat, 1 Dec 2018 17:00:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: adc: Add docs for AD7606 ADC
Message-ID: <20181201170046.13eef1fc@archlinux>
In-Reply-To: <1543510663-14921-1-git-send-email-stefan.popa@analog.com>
References: <1543510663-14921-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 18:57:43 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> Document support for AD7606 Analog to Digital Converter.
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Looks good to me, but as it's a non trivial binding in complexity I'd
definitely like a DT maintainers input before applying this.

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- fixed indentation issues.
> 	- used gpios instead of gpio.
> 	- added vendor prefix for conversion-start-gpios, first-data-gpios,
> 	and range-gpios.
> Changes in v3:
> 	- Added adi,oversampling-ratio-gpios.
>=20
>  .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 54 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.=
txt
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/D=
ocumentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> new file mode 100644
> index 0000000..02fae23
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> @@ -0,0 +1,54 @@
> +Analog Devices AD7606 Simultaneous Sampling ADC
> +
> +Required properties for the AD7606:
> +
> +- compatible: Must be one of
> +	* "adi,ad7605-4"
> +	* "adi,ad7606-8"
> +	* "adi,ad7606-6"
> +	* "adi,ad7606-4"
> +- reg: SPI chip select number for the device
> +- spi-max-frequency: Max SPI frequency to use
> +	see: Documentation/devicetree/bindings/spi/spi-bus.txt
> +- spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
> +- avcc-supply: phandle to the Avcc power supply
> +- interrupts: IRQ line for the ADC
> +	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.=
txt
> +- adi,conversion-start-gpios: must be the device tree identifier of the =
CONVST pin.
> +		  This logic input is used to initiate conversions on the analog
> +		  input channels.
> +
> +Optional properties:
> +
> +- reset-gpios: must be the device tree identifier of the RESET pin. If s=
pecified,
> +	       it will be asserted during driver probe.
> +- standby-gpios: must be the device tree identifier of the STBY pin. Thi=
s pin is used
> +		to place the AD7606 into one of two power-down modes, Standby mode or
> +		Shutdown mode.
> +- adi,first-data-gpios: must be the device tree identifier of the FRSTDA=
TA pin.
> +		    The FRSTDATA output indicates when the first channel, V1, is
> +		    being read back on either the parallel, byte or serial interface.
> +- adi,range-gpios: must be the device tree identifier of the RANGE pin. =
The polarity on
> +	      this pin determines the input range of the analog input channels.=
 If
> +	      this pin is tied to a logic high, the analog input range is =C2=
=B110V for
> +	      all channels. If this pin is tied to a logic low, the analog inpu=
t range
> +	      is =C2=B15V for all channels.
> +
> +Example:
> +
> +	adc@0 {
> +		compatible =3D "adi,ad7606-8";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <1000000>;
> +		spi-cpol;
> +
> +		avcc-supply =3D <&adc_vref>;
> +
> +		interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent =3D <&gpio>;
> +
> +		adi,conversion-start-gpios =3D <&gpio 17 0>;
> +		reset-gpios =3D <&gpio 27 0>;
> +		adi,first-data-gpios =3D <&gpio 22 0>;
> +		standby-gpios =3D <&gpio 24 0>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 843545d..6d63db4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/adc/ad7606.c
> +F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
> =20
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>

