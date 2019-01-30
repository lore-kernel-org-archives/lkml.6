Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4D9C282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C46620989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548868047;
	bh=hxHgq29i2ahJqFGbr8mtwjzZWXgzJy1DV+B+YGysbic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F/DFkJ2tjlYUNfkXg9BnIP29NFUr52NQZBeHO1BmwsJUO9I36lvGfR3BmRBQofzfn
	 yo2f55vBYBe2BQr2vsTWZbvk7J9EswJjmwSZPA4aNjfSXAoURoPE9oUDhx8cAZdCOo
	 rQI07cTuepTCZgNBOxJGOb9V+BLyP4M7lVF0BJDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbfA3RHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:07:25 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41755 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731717AbfA3RHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:07:25 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so215499oii.8;
        Wed, 30 Jan 2019 09:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VWbOUAUiSBkf45uCURxayCf9HX7azBkvTGSQB7xn/GY=;
        b=HErlxLXqDf3tP4lpS/bVtvNASEaYBoaWQq3DusP/S46PuYX6zc8ZTdcsOU2Sv2lv+U
         FWQNxMRNtxZGYwMDowr8WB7DMlQ6Poy3O8BddYUD31Q33x9cALK0d13mSPjP2SQWWDg+
         /Dt5PoUWRm1CcR0I2tRZmPucrHGR5JCj2VHNja5D5JAYtrJP4IYjZJZUmXQDY1GytMHZ
         7O+zZ127GGZylpETquRO23f9oponD7Up2BDs151VCaeVebzYOXF0q2clWC3R8GgxHLyr
         aureMlDuUlTYAu3Zbpj7cwumtN4vWn+TiPUUohTPMS5Mvo5+x26k4iIPv8RovbxjJ1dG
         BQxg==
X-Gm-Message-State: AJcUukd1XiEPkuQ4eCPVkuhk5YI9MXwWTrBEmuvV00YVsFRcXUz9HDNM
        QLW5C71yLk2bY1VMp4ZLW/MqGIo=
X-Google-Smtp-Source: ALg8bN5Gwwah8J0X4bckThL9HrT8iI87ApNh6M4NAQd8dcvu8fqfTg9f1Lt+A0f8KbBlyW9sROTWXw==
X-Received: by 2002:aca:dec1:: with SMTP id v184mr12280171oig.217.1548868044279;
        Wed, 30 Jan 2019 09:07:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z15sm784342oib.23.2019.01.30.09.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 09:07:23 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:07:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio:dac:dac7612: device tree bindings
Message-ID: <20190130170723.GA24708@bogus>
References: <20190128094931.4430-1-ricardo@ribalda.com>
 <20190128094931.4430-2-ricardo@ribalda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128094931.4430-2-ricardo@ribalda.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:49:31AM +0100, Ricardo Ribalda Delgado wrote:
> Bindings for dac7612.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> ---
>  .../bindings/iio/dac/ti,dac7612.txt           | 29 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> new file mode 100644
> index 000000000000..e1b8158fab35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> @@ -0,0 +1,29 @@
> +* Texas Instruments Dual, 12-Bit Serial Input Digital-to-Analog Converter
> +
> +The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with guaranteed
> +12-bit monotonicity performance over the industrial temperature range.
> +Is is programmable through an SPI interface.
> +
> +The internal DACs are loaded when the LOADDACS pin is pulled down.
> +
> +http://www.ti.com/lit/ds/sbas106/sbas106.pdf
> +
> +Required Properties:
> +- compatible: Should be one of:
> +		"ti,dac7612"
> +		"ti,dac7612u"
> +		"ti,dac7612b"

What's the difference? I can only find 'u' and 'ub' variants and nothing 
about how those are different. So maybe just 1 string is enough?

> +- reg: Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Optional Properties:
> +- loaddacs-gpios: GPIO descriptor for the LOADDACS pin.

Needs a 'ti' vendor prefix.

> +- spi-*: Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +
> +	dac7612@1 {

dac@1

> +		compatible = "ti,dac7612";
> +		reg = <0x1>;
> +		loaddacs-gpios = <&msmgpio 25 GPIO_ACTIVE_LOW>;
> +	};
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 30ba5435906b..e28e5afaae16 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14882,6 +14882,7 @@ M:	Ricardo Ribalda <ricardo@ribalda.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  F:	drivers/iio/dac/ti-dac7612.c
> +F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
>  
>  THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>
> -- 
> 2.20.1
> 
