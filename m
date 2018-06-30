Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7F7C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2660F25429
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxv5qnIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2660F25429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeF3PyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 11:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751114AbeF3PyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 11:54:14 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D56B24D8E;
        Sat, 30 Jun 2018 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530374053;
        bh=fEfycDdObRYXIJuRvb0IQleI8yz/vDoxstTAJiMendE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wxv5qnIHqlx6h6b1dET+7p5Qpot/37AVJFL8ieEhoM5OQKnetpHMMsmRlb7to0W4s
         wvbMvlOtBmakmjcY8ARS8ZNHRAMGcmNve/rv4NbuYsf9G6dHuXI9uCBb9SgBTMgdWl
         O1vaUwAfpfv/fR/I+P0hzQjFXedTSFYwa8D0kSyc=
Date:   Sat, 30 Jun 2018 16:54:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mchehab@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
        <rdunlap@infradead.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Message-ID: <20180630165407.2a878dbd@archlinux>
In-Reply-To: <1530261550-21224-1-git-send-email-stefan.popa@analog.com>
References: <1530261550-21224-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018 11:39:10 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
One minor inline. =20

We could look at making some of these properties generic
(slew-time for example) but I'm not sure we fully understand
the 'space' yet to know exactly how this could be described
for all devices.  Hence perhaps best to leave it as it is for now.

Jonathan

> ---
> Changes in v4:
> 	- Nothing changed, just to follow the patch set version.
> Changes in v3:
> 	- AD5758 can be both a current and voltage output DAC. The
> 	  decision is made based on the DT and the channel type is set
> 	  during probe.
> 	- range was replaced by range-microvolt and range-microamp
> 	- dc-dc-mode, range-microvolt and range-microamp are required
> 	  properties.
> 	- Introduced a slew-time-us property from which slew rate clock
> 	  and slew rate step are calculated using a best match algorithm.
> 	- Added units in the name of the properties.
> 	- Offered more explanation for the various modes of operation.
>=20
> Changes in v2:
> 	- Nothing changed, just to follow the patch set version.
>=20
>  .../devicetree/bindings/iio/dac/ad5758.txt         | 73 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Docum=
entation/devicetree/bindings/iio/dac/ad5758.txt
> new file mode 100644
> index 0000000..797df9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
> @@ -0,0 +1,73 @@
> +Analog Devices AD5758 DAC device driver
> +
> +Required properties for the AD5758:
> +	- compatible: Must be "adi,ad5758"
> +	- reg: SPI chip select number for the device
> +	- spi-max-frequency: Max SPI frequency to use (< 50000000)
> +	- spi-cpha: is the only mode that is supported
> +
> +Required properties:
> +
> + - adi,dc-dc-mode: Mode of operation of the dc-to-dc converter
> + 		   Dynamic Power Control (DPC)
> +		   In this mode, the AD5758 circuitry senses the output voltage and
> +		   dynamically regulates the supply voltage, VDPC+, to meet compliance
> +		   requirements plus an optimized headroom voltage for the output buff=
er.
> +
> +		   Programmable Power Control (PPC)
> +		   In this mode, the VDPC+ voltage is user-programmable to a fixed lev=
el
> +		   that needs to accommodate the maximum output load required.
> +
> +		   The output of the DAC core is either converted to a current or volt=
age
> +		   output at the VIOUT pin. Only one mode can be enabled at any one ti=
me.
> +
> +		   The following values are currently supported:
> +			* 1: DPC current mode
> +			* 2: DPC voltage mode
> +			* 3: PPC current mode
> +
> + Depending on the selected output mode (voltage or current) one of the t=
wo properties must
> + be present:
> +
> + - adi,range-microvolt: Voltage output range
> + 		The array of voltage output ranges must contain two fields:
> +	      	* <0 5000000>: 0 V to 5 V voltage range
> +		* <0 10000000>: 0 V to 10 V voltage range
> +		* <(-5000000) 5000000>: =C2=B15 V voltage range
> +		* <(-10000000) 10000000>: =C2=B110 V voltage range
> + - adi,range-microamp: Current output range
> + 		The array of current output ranges must contain two fields:
> +		* <0 20000>: 0 mA to 20 mA current range
> +		* <0 24000>: 0 mA to 24 mA current range
> +		* <4 24000>: 4 mA to 20 mA current range
> +		* <(-20000) 20000>: =C2=B120 mA current range
> +		* <(-24000) 24000>: =C2=B124 mA current range
> +		* <(-1000) 22000>: =E2=88=921 mA to +22 mA current range
> +
> +Optional properties:
> +
> + - adi,dc-dc-ilim-microamp: The dc-to-dc converter current limit
> +		   The following values are currently supported [uA]:
> +		   	* 150000
> +			* 200000
> +			* 250000
> +			* 300000
> +			* 350000
> +			* 400000
> +
> + - adi,slew-time-us: The time it takes for the output to reach the full =
scale [uS]
> + 		     The supported range is between 133us up to 1023984375us
> +
> +AD5758 Example:
> +
> +	ad5758@0 {

Node names should be generic - now we don't have dac in the device tree
spec but it feels like the right choice rather than the part number.
https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.2

> +		compatible =3D "adi,ad5758";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <1000000>;
> +		spi-cpha;
> +
> +		adi,dc-dc-mode =3D <2>;
> +		adi,range-microvolt =3D <0 10000000>;
> +		adi,dc-dc-ilim-microamp =3D <200000>;
> +		adi,slew-time-us =3D <125000>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12d102d..60b1028 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -802,6 +802,7 @@ L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/dac/ad5758.c
> +F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
> =20
>  ANALOG DEVICES INC AD5686 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>

