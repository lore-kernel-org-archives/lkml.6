Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B453C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02D52086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547316828;
	bh=v/eobD9TeoY5tAUQbQwkFtv1rf3Ca1GTeEvbHdyCujg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vl1c7iTXHlSzreLXyD9+TeBx+aZliyFbeEANlUpRxYgd39H9ut6gVl3qpqjAFoPZg
	 e8mhht8UHJqhugKEbwBZCjwbr/+kOe+SQSvJI956ckpm59h6TWC2R4A3igh2/m1/cy
	 1jnAywU2uyzFM4iegke45mUETHiuz0pwcX8ORPlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfALSNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:13:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfALSNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:13:46 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B97A320836;
        Sat, 12 Jan 2019 18:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547316825;
        bh=v/eobD9TeoY5tAUQbQwkFtv1rf3Ca1GTeEvbHdyCujg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BDY6h/R5k6J+TThDBgOk3HH+lIePC3V8zQjLvHNd+ipY/VEcD1rCRKKgYpw1GL+hz
         fYHSehUm+g35EczDyNxLXThqEWEPLuRK+8+icCbhWWHVM/csQ2Wgex480FdZgO6bLr
         7nAyeuiDV3ApM6XYZZTyRyqwvQdW4SlzjbRxzDW0=
Date:   Sat, 12 Jan 2019 18:13:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: Add docs for AD7768-1
Message-ID: <20190112181340.0efe0ea0@archlinux>
In-Reply-To: <1546867609-4273-1-git-send-email-stefan.popa@analog.com>
References: <1546867609-4273-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 15:26:49 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> Document support for AD7768-1 Analog to Digital Converter.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

A few comments inline.

J
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7768-1.txt   | 34 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
> new file mode 100644
> index 0000000..bf619fa8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
> @@ -0,0 +1,34 @@
> +Analog Devices AD7768-1 ADC device driver
> +
> +Required properties for the AD7768-1:
> +
> +- compatible: Must be "adi,ad7768-1"
> +- reg: SPI chip select number for the device
> +- spi-max-frequency: Max SPI frequency to use
> +	see: Documentation/devicetree/bindings/spi/spi-bus.txt
> +- clocks: phandle to the master clock (mclk)
> +	see: Documentation/devicetree/bindings/clock/clock-bindings.txt
> +- clock-names: Must be "mclk".
> +- interrupts: IRQ line for the ADC
> +	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +- vref-supply: vref supply can be used as reference for conversion
> +- adi,sync-in-gpios: must be the device tree identifier of the SYNC-IN pin. A pulse
> +	is always required if the configuration is changed in any way, for example
> +	if the filter decimation rate changes. As the line is active low, it should
> +	be marked GPIO_ACTIVE_LOW.
Should mention it's also used for simultaneous sampling.  The name makes that
kind of obvious, but then the comment doesn't mention it.

There are some other potential gpios it seems.  Good to get them in the binding
now even if we don't do anything much with them.  Reset definitely.  The others
maybe not as we are only supporting the spi control mode and I can't see why
we would want to do anything different. I suppose there might be boards wired
with it set to pin mode but hopefully not.

> +
> +Example:
> +
> +	adc@0 {
> +		compatible = "adi,ad7768-1";
> +		reg = <0>;
> +		spi-max-frequency = <2000000>;
> +		spi-cpol;
> +		spi-cpha;
> +		vref-supply = <&adc_vref>;
> +		interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-parent = <&gpio>;
> +		adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
> +		clocks = <&ad7768_mclk>;
> +		clock-names = "mclk";
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ba3811..e5613b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -868,6 +868,7 @@ L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/adc/ad7768-1.c
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
>  
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>

