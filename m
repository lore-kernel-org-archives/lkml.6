Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598F6C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEFE2174B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEFE2174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389209AbeHGTHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:07:50 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41869 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeHGTHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:07:49 -0400
Received: by mail-io0-f195.google.com with SMTP id q4-v6so1665773iob.8;
        Tue, 07 Aug 2018 09:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e/DqiLuEp0N4wln7ZqRjxljPRJob9936QzFrtd2oY3g=;
        b=KukmmrVs28zajEtemDELwRNmHN2K9KbUlqZdQZQvkUIBUZWQyHCR9jnfp3sXpGWgso
         +5aG1/D7YwRoAzba1veAYtE767CzgP8h1v543x55BkMtLdhcyQhGCn/Oc7joPPnLutfi
         htlb2foV/wPU/l50LdXD0onJ/LQxEVwL5nGNhmOAel3hkxnnUFtJV9YOAz2zXlBxLWUl
         iBPCkY6/yWw60EEuT/pQHdoLy53GbvbOOVEOeUVZBehZpKoE+7zB4aCBNJd42TEXTZCk
         tRCP7lUJg5milH86/pI92W3rFoKhxgJ7sso0SNhc5s81Mn8c8qTiCfX588+4BeQuOd2e
         /t1g==
X-Gm-Message-State: AOUpUlHSH52E0QBS8NpVYQ6Dptq8NaD81gsN6v/p1Gyj5Fx8dZE14EO8
        wg0JG25YnVwT+EdEF7tTpA==
X-Google-Smtp-Source: AAOMgpeIswcEUPpznMb8KbvnRmwkYvS+3vJ6QgJp+2KiBXW7h4Nd9isHFp8tsQBjLnUHMU5+NI3f5A==
X-Received: by 2002:a6b:3fd4:: with SMTP id m203-v6mr6073608ioa.124.1533660757986;
        Tue, 07 Aug 2018 09:52:37 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id x73-v6sm976779ita.30.2018.08.07.09.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 09:52:37 -0700 (PDT)
Date:   Tue, 7 Aug 2018 10:52:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Message-ID: <20180807165236.GA4765@rob-hp-laptop>
References: <20180802191554.20176-1-marcus.folkesson@gmail.com>
 <20180802191554.20176-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802191554.20176-2-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 09:15:53PM +0200, Marcus Folkesson wrote:
> MCP3911 is a dual channel Analog Front End (AFE) containing two
> synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Signed-off-by: Kent Gustavsson <kent@minoris.se>
> ---
> 
> Notes:
>     v3:
>     	- add bindings for interrupt
>     	- prefix device-addr with `microchip`
>     	- drop `clock-names`
>     v2:
>     	- drop channel width
>     	- drop `external_vref`
>     	- replace `external-clock` with proper clock bindings
> 
>  .../devicetree/bindings/iio/adc/mcp3911.txt        | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> new file mode 100644
> index 000000000000..432da7a28783
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> @@ -0,0 +1,32 @@
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
> + - clocks: Phandle and clock identifier for sampling clock
> + - interrupt-parent: Phandle to the parent interrupt controller
> +	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

Drop this. It is implied.

With that, 

Reviewed-by: Rob Herring <robh@kernel.org>

> + - interrupts: IRQ line for the ADC
> +	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> + - microchip,device-addr: Device address when multiple MCP3911 chips are present on the
> +	same SPI bus. Valid values are 0-3. Defaults to 0.
> + - vref-supply: Phandle to the external reference voltage supply.
> +
> +Example:
> +adc@0 {
> +	compatible = "microchip,mcp3911";
> +	reg = <0>;
> +	interrupt-parent = <&gpio5>;
> +	interrupts = <15 IRQ_TYPE_EDGE_RISING>;
> +	spi-max-frequency = <20000000>;
> +	microchip,device-addr = <0>;
> +	vref-supply = <&vref_reg>;
> +	clocks = <&xtal>;
> +};
> -- 
> 2.11.0.rc2
> 
