Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADB6C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E8820891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E8820891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbeGYTEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:04:02 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46420 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbeGYTEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:04:02 -0400
Received: by mail-io0-f196.google.com with SMTP id i18-v6so7017167ioj.13;
        Wed, 25 Jul 2018 10:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VJx9ON80eBY4pGNx654K1k30n5Akqz0vZj/5p34s7Ys=;
        b=Ywnfz9/GJaBXBOP9tgGq4vmgownJuiWzcGEv8v1zOHZPiUmdRoJoTht6XT5GaXIuPR
         OzbkJUucCojv1/iHRkeJL2OFCUpZkFnHKeSDiyGgTKU7B+JNFX0UXgV/1FyHv3AjU6S0
         I8TvFL0rafy6LKsrEoZ2+hIp3ujSM95wOOv9cyN2bA62HG0Tt1ZW0plyEhYMtpA27C8G
         8kBxocvSEQ1iy42CWMUv1TNgwt5ITO47Izoq+G66TEFHsDUJBrbVpyjDtTHgz4S2Ux2O
         aZOXpcDsotx2Z/Yem6KgXNlrBmu2MgMXxGq62jixUsbnfzKgRrDDkM1NSG3763Dc1iUI
         O5lg==
X-Gm-Message-State: AOUpUlE4qjKTqwaZ8N19t8Cib56IdcMvTDhLBYb1xgZT8p0QdlyxLbki
        wxhKtfPlogRf2b6kI+AjtA==
X-Google-Smtp-Source: AAOMgpfJPvjoEUZHMFqJpjzGuKK3M6RHYrzbHYDI+6H7InXsT4gFouxgy1frO06lzh4BW5xwl17iaQ==
X-Received: by 2002:a6b:a715:: with SMTP id q21-v6mr17844934ioe.61.1532541078676;
        Wed, 25 Jul 2018 10:51:18 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id e142-v6sm2689889itc.7.2018.07.25.10.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 10:51:18 -0700 (PDT)
Date:   Wed, 25 Jul 2018 11:51:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Message-ID: <20180725175117.GA825@rob-hp-laptop>
References: <20180724183004.20279-1-marcus.folkesson@gmail.com>
 <20180724183004.20279-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724183004.20279-2-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 08:30:03PM +0200, Marcus Folkesson wrote:
> MCP3911 is a dual channel Analog Front End (AFE) containing two
> synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Signed-off-by: Kent Gustavsson <kent@minoris.se>
> ---
> 
> Notes:
>     v2:
>     	- drop channel width
>     	- drop `external_vref`
>     	- replace `external-clock` with proper clock bindings
> 
>  .../devicetree/bindings/iio/adc/mcp3911.txt        | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> new file mode 100644
> index 000000000000..af5472f51a84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> @@ -0,0 +1,28 @@
> +* Microchip MCP3911 Dual channel analog front end (ADC)
> +
> +Required properties:
> + - compatible: Should be "microchip,mcp3911"
> + - reg: SPI chip select number for the device
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +	 Documentation/devicetree/bindings/spi/spi-bus.txt.
> +	 Max frequency for this chip is 20MHz.
> +
> +Optional properties:
> + - device-addr: Device address when multiple MCP3911 chips are present on the
> +	same SPI bus. Valid values are 0-3. Defaults to 0.

Isn't this the reg value?

> + - vref-supply: Phandle to the external reference voltage supply.
> + - clocks: Phandle and clock identifier (see clock-names)
> + - clock-names: "adc_clk" for the ADC (sampling) clock

Datasheet calls this clki (or mclk internally). Or just drop clock-names 
as it is pointless 
when there is only 1 clock. 

Also DR handling as an IRQ is missing.
