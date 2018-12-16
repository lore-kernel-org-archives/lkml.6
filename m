Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165DCC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB1E21839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544968701;
	bh=ebxWRIUNisKL5O5HUQrMw3kK3FhmsrwPNVmhvBKz1l8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PjLYsHj6O14lndtpf1U4nxr3oOj5SFZahmPMT1ZxIvamDQVOD21nXyj/OHoqtDYVF
	 qFvZiX7ML0l1L+5B0E9iTW8ZtgTEiHiHZ6VmHbnVgUPdP38aVgyR6NSvWF+CInAXIX
	 WbuVmZdyrCAA3QXpObkkMXbxHBxFqO7xaPxhdvto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbeLPN6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:58:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730382AbeLPN6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:58:20 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C51217FA;
        Sun, 16 Dec 2018 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544968699;
        bh=ebxWRIUNisKL5O5HUQrMw3kK3FhmsrwPNVmhvBKz1l8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kDrMV9NnAzmhNi7Ii5AA4YpEmAwE8ljTcZMPDkFcOm3+YbON7URmVpoo8REf4Zwdx
         Tz90/7UOFnXyndBb6+ErcO80I64kCK0J7M1HPV1uzVkcj8Q88bjYzfYn4ouRi8hwk9
         cGgk2ZWnCRylatRQnosAut6l1/erdv6btlPr+eY8=
Date:   Sun, 16 Dec 2018 13:58:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: Re: [PATCH 11/11] dt-bindings: iio: adc: Add docs for AD7606 ADC
Message-ID: <20181216135814.79b616f2@archlinux>
In-Reply-To: <1544705183-13288-12-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
        <1544705183-13288-12-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 14:46:23 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> Document support for AD7606 Analog to Digital Converter.
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Will have to wait on this as the MAINTAINERS bit obviously isn't there yet.
Otherwise I would have just added it now.  Oh well, v2.


Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 65 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.=
txt
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/D=
ocumentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> new file mode 100644
> index 0000000..d7b6241
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> @@ -0,0 +1,65 @@
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
> +		  input channels. As the line is active high, it should be marked
> +		  GPIO_ACTIVE_HIGH.
> +
> +Optional properties:
> +
> +- reset-gpios: must be the device tree identifier of the RESET pin. If s=
pecified,
> +	       it will be asserted during driver probe. As the line is active h=
igh,
> +	       it should be marked GPIO_ACTIVE_HIGH.
> +- standby-gpios: must be the device tree identifier of the STBY pin. Thi=
s pin is used
> +		to place the AD7606 into one of two power-down modes, Standby mode or
> +		Shutdown mode. As the line is active low, it should be marked
> +		GPIO_ACTIVE_LOW.
> +- adi,first-data-gpios: must be the device tree identifier of the FRSTDA=
TA pin.
> +		    The FRSTDATA output indicates when the first channel, V1, is
> +		    being read back on either the parallel, byte or serial interface.
> +		    As the line is active high, it should be marked GPIO_ACTIVE_HIGH.
> +- adi,range-gpios: must be the device tree identifier of the RANGE pin. =
The polarity on
> +	      this pin determines the input range of the analog input channels.=
 If
> +	      this pin is tied to a logic high, the analog input range is =C2=
=B110V for
> +	      all channels. If this pin is tied to a logic low, the analog inpu=
t range
> +	      is =C2=B15V for all channels. As the line is active high, it shou=
ld be marked
> +	      GPIO_ACTIVE_HIGH.
> +- adi,oversampling-ratio-gpios: must be the device tree identifier of th=
e over-sampling
> +				mode pins. As the line is active high, it should be marked
> +				GPIO_ACTIVE_HIGH.
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
> +		adi,conversion-start-gpios =3D <&gpio 17 GPIO_ACTIVE_HIGH>;
> +		reset-gpios =3D <&gpio 27 GPIO_ACTIVE_HIGH>;
> +		adi,first-data-gpios =3D <&gpio 22 GPIO_ACTIVE_HIGH>;
> +		adi,oversampling-ratio-gpios =3D <&gpio 18 GPIO_ACTIVE_HIGH
> +						&gpio 23 GPIO_ACTIVE_HIGH
> +						&gpio 26 GPIO_ACTIVE_HIGH>;
> +		standby-gpios =3D <&gpio 24 GPIO_ACTIVE_LOW>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7256ce6..798e9a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -859,6 +859,7 @@ L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/adc/ad7606.c
> +F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
> =20
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>

