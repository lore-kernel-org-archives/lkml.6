Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47B5C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932292080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932292080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJaFvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:51:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34270 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeJaFvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:51:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id f21-v6so8589405oig.1;
        Tue, 30 Oct 2018 13:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ate+pZYMnjPGfP4IgmpEIwNbbjZP3uOBkIpSLuqVTIc=;
        b=oAgFKk27tNKMeNhTqA1Iknagl03UjUir4qCyHow8xRbzA0xXm+JRya68sEuKdiLM9G
         l5xrsN3B4L+WtXuOC+I5JsLe6TQx2NlHqLXnk2jWxthpSSd6sXa5dsLWxWxUQiTFNpnG
         QR9IoNbTHOxqzPsVgnUGLu1jEe0qgkPpge+ApBoZcGkdgSXci++xqjkrsVru4tr7VInR
         G8mMkhKuhcPM6ggQIii1te4Kg7oJIy/rZ0V4h2iweRvgKFPbwB0DTkGzRcnM1d1j+Oov
         YvMEPV2/yR5zJLsRlVXymeNm9+vnn5G2CYgOVnlT55wcCPyjeTTPKK8nMe58Mes4Vq7j
         qcSA==
X-Gm-Message-State: AGRZ1gLqzIOBS8OCyA1l/SJSbzPJByNpFXDMyHXA6Gi4bOFGethDqRnQ
        JnwJPKtM4YTYUrI76rN6sQ==
X-Google-Smtp-Source: AJdET5eFs0PKVAiFLTGDoV7Ljatz4UPRyQby1ed6bx2OFpsxj4XWlS8TX2eZPm5CSLEGPTe2PbzCUQ==
X-Received: by 2002:a54:4607:: with SMTP id p7-v6mr202477oip.126.1540932976754;
        Tue, 30 Oct 2018 13:56:16 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u5sm1754931otb.8.2018.10.30.13.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 13:56:16 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:56:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: adc: Add docs for ad7124
Message-ID: <20181030205615.GA13185@bogus>
References: <1540831170-3150-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1540831170-3150-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 06:39:30PM +0200, Stefan Popa wrote:
> Add support for Analog Devices AD7124 4-channels and 8-channels ADC.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v2:
> 	- Nothing changed.
> Changes in v3:
> 	- Removed the "adi,channels" property.
> 	- Used the "reg" property to get the channel number and "adi,diff-channels"
> 	  for the differential pins. The "adi,channel-number" property was removed.
> 	- adi,bipolar is of boolean type.
> 
>  .../devicetree/bindings/iio/adc/adi,ad7124.txt     | 90 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> new file mode 100644
> index 0000000..46a9b71
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> @@ -0,0 +1,90 @@
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
> +		see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +
> +	  Required properties:
> +		* #address-cells: Must be 1.
> +		* #size-cells: Must be 0.
> +
> +	  Subnode(s) represent the external channels which are connected to the ADC.
> +	  Each subnode represents one channel and has the following properties:
> +		Required properties:
> +			* reg: The channel number. It can have up to 4 channels on ad7124-4
> +			  and 8 channels on ad7124-8, numbered from 0 to 15.
> +			* adi,diff-channels: Pins the channel is connected to. The first value
> +			  specifies the positive input pin, the second value the negative input pin.
> +
> +		Optional properties:
> +			* adi,bipolar: Boolean, if set the channel is used in bipolar mode.

Both this and Xilinx AMS which I just reviewed are defining a bipolar 
property. Can we come up with a common property please.

> +			* adi,reference-select: Select the reference source to use when
> +			  converting on the the specific channel. Valid values are:
> +			  0: REFIN1(+)/REFIN1(−).
> +			  1: REFIN2(+)/REFIN2(−).
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
> +		compatible = "adi,ad7124-4";
> +		reg = <0>;
> +		spi-max-frequency = <5000000>;
> +		interrupts = <25 2>;
> +		interrupt-parent = <&gpio>;
> +		refin1-supply = <&adc_vref>;
> +		clocks = <&ad7124_mclk>;
> +		clock-names = "mclk";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		channel@0 {
> +			reg = <0>;
> +			adi,diff-channels = <0 1>;
> +			adi,reference-select = <0>;
> +			adi,gain = <2>;
> +			adi,odr-hz = <10>;
> +		};
> +
> +		channel@1 {
> +			reg = <1>;
> +			adi,bipolar;
> +			adi,diff-channels = <2 3>;
> +			adi,reference-select = <0>;
> +			adi,gain = <4>;
> +			adi,odr-hz = <50>;
> +		};
> +
> +		channel@2 {
> +			reg = <2>;
> +			adi,diff-channels = <4 5>;
> +			adi,gain = <128>;
> +			adi,odr-hz = <19200>;
> +		};
> +
> +		channel@3 {
> +			reg = <3>;
> +			adi,diff-channels = <6 7>;
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
>  
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
> -- 
> 2.7.4
> 
