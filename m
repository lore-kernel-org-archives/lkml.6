Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400B9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E9420C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E9420C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbeGKQK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:10:26 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35092 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeGKQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:10:26 -0400
Received: by mail-oi0-f68.google.com with SMTP id i12-v6so50235629oik.2;
        Wed, 11 Jul 2018 09:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=96BGb03MY9Tnfl/or+RrWuR/kUW1z838Ll98EZioRps=;
        b=U2uElFMg1EHT3wYKEuVym/yXBohFQ4ZMem6z607ma2xgNVLs883mgcbzMjUeh59PnV
         Tt+Fk3UndV3r496yjCPiadT/fZIHgtJdhoAGy8x/cw8q3nrj8c6UOSNnuy6VqefRcC9e
         I/CwDkRA3N59ZGJz77TdcQzE+pdmMAWAQAjPKQOa5eV+6doqSQLpomgdkcKZ2P4OKDRS
         OdAq/5P54GZqb9j230T4q/qlblhsyyNyTFdtK1Cf1viAlZMVRsA1Jxz11cGWBMXUME5D
         IlV6NpiP0CQVuzjv05mO4SvGO6Ng0HovAOiANQS7ufedJRtoixIX4ZJiVSKzLJHT0E8R
         he0g==
X-Gm-Message-State: APt69E38X70pEuMgydK6UWE9kxMENH/WkkdhQRxUaMaKiA/SSpAYmuez
        t5s8jNZ8JBzRwJGaZmgbhg==
X-Google-Smtp-Source: AAOMgpcHQnFfFt16WRXLDFh8Oq+GlZWTbXjjeukztNej7aFle6EcjcPHJT79V+MklkEe/9cKrxpLlg==
X-Received: by 2002:aca:5c8b:: with SMTP id q133-v6mr31202450oib.223.1531325125191;
        Wed, 11 Jul 2018 09:05:25 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id i204-v6sm10209792oia.41.2018.07.11.09.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:05:24 -0700 (PDT)
Date:   Wed, 11 Jul 2018 10:05:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>
Cc:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, richard@nod.at,
        miquel.raynal@bootlin.com, broonie@kernel.org, david.wolfe@nxp.com,
        fabio.estevam@nxp.com, prabhakar.kushwaha@nxp.com,
        yogeshnarayan.gaur@nxp.com, han.xu@nxp.com, shawnguo@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/12] dt-bindings: spi: Adjust the bindings for the
 FSL QSPI driver
Message-ID: <20180711160521.GA16884@rob-hp-laptop>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-6-git-send-email-frieder.schrempf@exceet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530789310-16254-6-git-send-email-frieder.schrempf@exceet.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 01:15:01PM +0200, Frieder Schrempf wrote:
> Adjust the documentation of the new SPI memory interface based
> driver to reflect the new drivers settings.

Bindings shouldn't change (other than new properties) due to driver 
changes.

> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
> ---
> Changes in v2:
> ==============
> * Split the moving and editing of the dt-bindings in two patches
> 
>  .../devicetree/bindings/spi/spi-fsl-qspi.txt    | 22 ++++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
> index 483e9cf..8b4eed7 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
> @@ -3,9 +3,8 @@
>  Required properties:
>    - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
>  		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
> -		 "fsl,ls1021a-qspi"
> +		 "fsl,ls1021a-qspi", "fsl,ls2080a-qspi"
>  		 or
> -		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
>  		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"

So the 2080a h/w was compatible with the 1021a h/w, but now it is not? 
How did the h/w change?

>    - reg : the first contains the register location and length,
>            the second contains the memory mapping address and length
> @@ -15,14 +14,15 @@ Required properties:
>    - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
>  
>  Optional properties:
> -  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
> -                              Each bus can be connected with two NOR flashes.
> -			      Most of the time, each bus only has one NOR flash
> -			      connected, this is the default case.
> -			      But if there are two NOR flashes connected to the
> -			      bus, you should enable this property.
> -			      (Please check the board's schematic.)

You can't just remove properties without explanation. Why is this no 
longer needed? What about backwards compatibility with existing dtbs?

> -  - big-endian : That means the IP register is big endian
> +  - big-endian : That means the IP registers format is big endian

This is a standard property so it doesn't really need to be redefined 
here, but just reference the definition.

> +
> +Required SPI slave node properties:
> +  - reg: There are two buses (A and B) with two chip selects each.
> +	 This encodes to which bus and CS the flash is connected:
> +		<0>: Bus A, CS 0
> +		<1>: Bus A, CS 1
> +		<2>: Bus B, CS 0
> +		<3>: Bus B, CS 1
>  
>  Example:
>  
> @@ -40,7 +40,7 @@ qspi0: quadspi@40044000 {
>  	};
>  };
>  
> -Example showing the usage of two SPI NOR devices:
> +Example showing the usage of two SPI NOR devices on bus A:
>  
>  &qspi2 {
>  	pinctrl-names = "default";
> -- 
> 2.7.4
> 
