Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265B7C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAF020838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544226466;
	bh=b8G7rxkT73TLkPU9hjvyW62L1ebNPUVDeTCtMJBJfnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hh4a2mmG/G0uNnC98OaiJiJtBUVhCf9OO99vdTM9BoVTVsiSOva4hy0FnbzgM170X
	 EF2rTpyWBKtXIQZOwsJC1/PLrftv9A5yocQkmCJShRdCuikmTt5tXyGbZ++ymgA5JV
	 Jq+aPvr8cVyMkcMT/FxJAMq3PYBA3upBAUyZZY5w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAF020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbeLGXrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:47:45 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45519 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLGXro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:47:44 -0500
Received: by mail-oi1-f194.google.com with SMTP id y1so2992600oie.12;
        Fri, 07 Dec 2018 15:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zgUiNoH5VCv3ea22aMcjPEG8bDqTd+yBwKbKL/P/Gdg=;
        b=kjEtY0GqaB/GGBrn+mL9zg62oxRvBaziizOU4+BSJiD6zBgS380adr9vLDxNtWNdVB
         n5g/0CTEmNmg9s9wUsr91oichSjcXu6UysDnNpcKY4LYxsdK/87A7maKj+bU70EuuDcR
         TTpitfnEI8aCth5FMwfXAcm2qIjwYkFDSTLTA1yt5TfAN8aqmaoY7aj2xwJAtR1unaey
         ERV24iH+ii0g9kDGx7ST26QnkTU0KThS964NZhn/7pIMuo4Ty4BUHRwb17b6HnhubZdt
         x1pYUbJTGNlIcSUS2e3pa+PLjZyNjx7ADfVRLW+49cxvCy9IYEUJCNMR/le2T3hO47is
         BZcQ==
X-Gm-Message-State: AA+aEWZV5gvz7zY2nzIa44T8cnmuUFfIQmQmbIEtQQO/6LiZns75WYRv
        jw4MRWnIg2KxM4onMW/N8w==
X-Google-Smtp-Source: AFSGD/UjL488S84hAzh5kDILhcmt1Q0mFu7jW9zdoV5R3EYFwksm3mWi5fQREINGaOoxM/weTChiMQ==
X-Received: by 2002:a05:6808:7:: with SMTP id u7mr2312364oic.272.1544226462978;
        Fri, 07 Dec 2018 15:47:42 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c23sm1963554otn.21.2018.12.07.15.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:47:42 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:47:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: adc: Add docs for AD7606 ADC
Message-ID: <20181207234741.GA20026@bogus>
References: <1543510663-14921-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543510663-14921-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 06:57:43PM +0200, Stefan Popa wrote:
> Document support for AD7606 Analog to Digital Converter.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v2:
> 	- fixed indentation issues.
> 	- used gpios instead of gpio.
> 	- added vendor prefix for conversion-start-gpios, first-data-gpios,
> 	and range-gpios.
> Changes in v3:
> 	- Added adi,oversampling-ratio-gpios.
> 
>  .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 54 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
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
> +	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +- adi,conversion-start-gpios: must be the device tree identifier of the CONVST pin.
> +		  This logic input is used to initiate conversions on the analog
> +		  input channels.

Needs to say active high or low and set the flag appropriately.

> +
> +Optional properties:
> +
> +- reset-gpios: must be the device tree identifier of the RESET pin. If specified,
> +	       it will be asserted during driver probe.

active high or low?

> +- standby-gpios: must be the device tree identifier of the STBY pin. This pin is used
> +		to place the AD7606 into one of two power-down modes, Standby mode or
> +		Shutdown mode.

active high or low?

> +- adi,first-data-gpios: must be the device tree identifier of the FRSTDATA pin.
> +		    The FRSTDATA output indicates when the first channel, V1, is
> +		    being read back on either the parallel, byte or serial interface.

active high or low?

> +- adi,range-gpios: must be the device tree identifier of the RANGE pin. The polarity on
> +	      this pin determines the input range of the analog input channels. If
> +	      this pin is tied to a logic high, the analog input range is ±10V for
> +	      all channels. If this pin is tied to a logic low, the analog input range
> +	      is ±5V for all channels.
> +
> +Example:
> +
> +	adc@0 {
> +		compatible = "adi,ad7606-8";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		spi-cpol;
> +
> +		avcc-supply = <&adc_vref>;
> +
> +		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent = <&gpio>;
> +
> +		adi,conversion-start-gpios = <&gpio 17 0>;
> +		reset-gpios = <&gpio 27 0>;
> +		adi,first-data-gpios = <&gpio 22 0>;
> +		standby-gpios = <&gpio 24 0>;
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
>  
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
> -- 
> 2.7.4
> 
