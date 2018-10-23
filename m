Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF5BC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D190207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D190207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeJWJAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:00:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45063 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJWJAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:00:44 -0400
Received: by mail-oi1-f196.google.com with SMTP id q63-v6so646287oic.12;
        Mon, 22 Oct 2018 17:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=53if1BoyB7IOoVYyFzCCDmsbX0bWzP9QUNqbb8bldFY=;
        b=VOIApowF3fEJDvZ9emgucX3LXtR06yThKrrk5RChtIKvrUbm3y1q4C6dBQQ0CirkBo
         ycF1elAUo6XhuVzlqNJ0n0XBn0EG4vVpA5WjPeCZuDNnhTSz9phh5RPPh9hys5dx8J7f
         kNdSiesstU6fLSG/+x2YvM6Nw0fH2HKF1yKaQj1+tcJh+v/LO+6CqwFz1flpwAANlR3t
         Sy1lU0tUHeHSeCyDA+9WihSeNHBJdltaw/Hbr9/FIh0mz03fJ4gyx8djfHYgm5wMp1Iu
         rkaj4/rCm+JNasBJ33uo6dh/Shj2tlNd0OB77ElCL6zpRPQ0BEQN9fsAk4cAmGO1jJQg
         U1cA==
X-Gm-Message-State: ABuFfogfUaXha+v5m2GOWh1uL9o3qLxPXW1ViOakV9Os4Aw4H76K/Dzk
        kFkX7JMotaKJaMn0wqW5ahAkydU=
X-Google-Smtp-Source: ACcGV60DpMwAIbnVSA9P78E8PISTQKPGHKjtNLef/KDI7MThRD9hjyRn0VwUpZT0EYQekvU+gUTxwg==
X-Received: by 2002:aca:7288:: with SMTP id p130-v6mr23439737oic.252.1540255190747;
        Mon, 22 Oct 2018 17:39:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p129-v6sm10627800oia.21.2018.10.22.17.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 17:39:50 -0700 (PDT)
Date:   Mon, 22 Oct 2018 19:39:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: adc: Add docs for ad7124
Message-ID: <20181023003949.GA24213@bogus>
References: <1539935265-8904-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1539935265-8904-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 10:47:45AM +0300, Stefan Popa wrote:
> Add support for Analog Devices AD7124 4-channels and 8-channels ADC.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v2:
> 	- Nothing changed.
> 
>  .../devicetree/bindings/iio/adc/adi,ad7124.txt     | 96 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
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
> +		see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +
> +	- adi,channels: List of external channels connected to the ADC:

It's not clear here that this is a node, not a property. However, I 
think you can just get rid of this extra level unless you anticipate 
having other child nodes that aren't channels.

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

That sounds more like 2 entries than a 2 cell address.

> +			* adi,channel-number: It can have up to 4 channels on ad7124-4 and
> +			  8 channels on ad7124-8, numbered from 0 to 15.

Humm, I think the channel number would be more typically what 'reg' 
defines and then have a custom property to list the pins. There's 
probably some other multi-channel ADC examples in the tree.

> +
> +		Optional properties:
> +			* adi,bipolar: If set the channel is used in bipolar mode.

So boolean type?

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
> +		adi,channels {
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +
> +			channel@0 {
> +				reg = <0 1>;
> +				adi,channel-number = <0>;
> +				adi,reference-select = <0>;
> +				adi,gain = <2>;
> +				adi,odr-hz = <10>;
> +			};
> +
> +			channel@1 {
> +				reg = <2 3>;
> +				adi,bipolar;
> +				adi,channel-number = <1>;
> +				adi,reference-select = <0>;
> +				adi,gain = <4>;
> +				adi,odr-hz = <50>;
> +			};
> +
> +			channel@2 {
> +				reg = <4 5>;
> +				adi,channel-number = <2>;
> +				adi,gain = <128>;
> +				adi,odr-hz = <19200>;
> +			};
> +
> +			channel@3 {
> +				reg = <6 7>;
> +				adi,channel-number = <3>;
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
>  
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
> -- 
> 2.7.4
> 
