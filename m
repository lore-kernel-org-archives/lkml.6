Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75752ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA0820869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5EB1b7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA0820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeJUWQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 18:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbeJUWQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 18:16:11 -0400
Received: from archlinux (unknown [176.12.107.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEA8820843;
        Sun, 21 Oct 2018 14:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540130503;
        bh=+FDjSYRodE0CnzE+eA49SJAgTAkiTYoCVNPZ5TMUubw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o5EB1b7iTQrhsSKl4czWR1JIqVAxwSu70cCm1WF+CW3wFV9wgy2UMSSMKxr8EVVfG
         ++iKT1T/KIno131XYJ5fHQ7QLwUg4r3hl5MGIqKA/mLanJfGqv1lI+SJcKlmqIfxl7
         dfIKzB/pkweEQzZVdtXzNMklMKkXi9ghXZCLexqc=
Date:   Sun, 21 Oct 2018 15:01:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: adc: Add docs for ad7124
Message-ID: <20181021150137.2e2ec279@archlinux>
In-Reply-To: <1539935265-8904-1-git-send-email-stefan.popa@analog.com>
References: <1539935265-8904-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018 10:47:45 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> Add support for Analog Devices AD7124 4-channels and 8-channels ADC.
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

I'm not certain on how to do reg for the channels.  Input from
Devicetree people please!

Given I would imagine this is very similar to some previous parts, it
might help to have a cross reference in the description.

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- Nothing changed.
>=20
>  .../devicetree/bindings/iio/adc/adi,ad7124.txt     | 96 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.=
txt
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt b/D=
ocumentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> new file mode 100644
> index 0000000..77a7b92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> @@ -0,0 +1,96 @@
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
> +
> +	- adi,channels: List of external channels connected to the ADC:
> +	  Required properties:
> +		* #address-cells: Must be 2.
> +		* #size-cells: Must be 0.
> +
> +	  The child nodes of this node represent the external channels which are
> +	  connected to the ADC.
> +
> +	  Each child node represents one channel and has the following
> +	  properties:
> +		Required properties:
> +			* reg: Pins the channel is connected to. The first value specifies
> +			  the positive input pin, the second value the negative input pin.
> +			* adi,channel-number: It can have up to 4 channels on ad7124-4 and
> +			  8 channels on ad7124-8, numbered from 0 to 15.
> +
> +		Optional properties:
> +			* adi,bipolar: If set the channel is used in bipolar mode.
> +			* adi,reference-select: Select the reference source to use when
> +			  converting on the the specific channel. Valid values are:
> +			  0: REFIN1(+)/REFIN1(=E2=88=92).
> +			  1: REFIN2(+)/REFIN2(=E2=88=92).
> +			  3: AVDD
> +			  If this field is left empty, internal reference is selected.
> +			* adi,gain: Select the gain when converting on the specific channel.
> +			  Valid values are: 1, 2, 4, 8, 16, 32, 64, 128.
> +			  If this field is left empty, gain of 1 is selected.
> +			* adi,odr-hz: The output data rate can be programmed from:
> +			  9 to 19200 for full power mode (when the master clock is 614.4 kHz)
> +			  2 to 4800 for mid power mode (when the master clock is 153.6 kHz)
> +			  1 to 2400 for low power mode (when the master clock is 76.8 kHz)
> +			  If this field is left empty, odr of 9 is selected.
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
> +		adi,channels {
> +			#address-cells =3D <2>;
> +			#size-cells =3D <0>;
> +
> +			channel@0 {
> +				reg =3D <0 1>;
Normally we'd use the value of reg in the @.

I'm not actually sure what we do when there are two reg values
and they have no particular precedence.. Rob?

> +				adi,channel-number =3D <0>;
> +				adi,reference-select =3D <0>;
> +				adi,gain =3D <2>;
> +				adi,odr-hz =3D <10>;
> +			};
> +
> +			channel@1 {
> +				reg =3D <2 3>;
> +				adi,bipolar;
> +				adi,channel-number =3D <1>;
> +				adi,reference-select =3D <0>;
> +				adi,gain =3D <4>;
> +				adi,odr-hz =3D <50>;
> +			};
> +
> +			channel@2 {
> +				reg =3D <4 5>;
> +				adi,channel-number =3D <2>;
> +				adi,gain =3D <128>;
> +				adi,odr-hz =3D <19200>;
> +			};
> +
> +			channel@3 {
> +				reg =3D <6 7>;
> +				adi,channel-number =3D <3>;
> +			};
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

