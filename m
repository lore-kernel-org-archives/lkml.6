Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452A4C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1495320870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548869421;
	bh=X+k6se5mM7OybB0Z+rwrzJjfKrDkE4WCdAx8r65m1ro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tnoGTQaV4R3xv+9ZpgEBCesD4lQeDKjn9OUaxELVsKflSBMpuLzO/nbwS81MTo+tM
	 XaR0wt4z2kqCuV6MW8CyLCWmyF+TiXXAqOtT0q/dkTsXyyX0+HHN/REYmlE66rQUiI
	 5wMAwXJlOSqjlyxPIZ42QWHTO19JO5mFq39l+kUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbfA3RaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:30:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfA3RaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:30:19 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FA9620870;
        Wed, 30 Jan 2019 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548869418;
        bh=X+k6se5mM7OybB0Z+rwrzJjfKrDkE4WCdAx8r65m1ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VfzK9Mg2+gGrr75xRerVHWYGgzZCA5nTz7kXV8AH5fe6WFVSl81RTxYEFVT8JOd/C
         2mbanlJWdnXLEmxVD4RC5GMDu+ZKbVhTZ0kN0MMqC7Z2ZSWqjSumnEmsNsuSvgmrNl
         GC227Of/a7CyOsO+k5FqGxTCWcabMiaSC3TOgNos=
Date:   Wed, 30 Jan 2019 18:30:07 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 8/9] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Message-ID: <20190130182958.528e5ac0@bbrezillon>
In-Reply-To: <20190130150818.24902-9-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-9-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 15:08:45 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
> access, the other for the qspi core and phy. Both are mandatory.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  .../devicetree/bindings/spi/atmel-quadspi.txt      | 28 ++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> index e9dae6264d89..e7b7f297c5d7 100644
> --- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> +++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> @@ -1,14 +1,22 @@
>  * Atmel Quad Serial Peripheral Interface (QSPI)
>  
>  Required properties:
> -- compatible:     Should be "atmel,sama5d2-qspi".
> +- compatible:     Should be one of the following
> +		  - "atmel,sama5d2-qspi"
> +		  - "microchip,sam9x60-qspi"
>  - reg:            Should contain the locations and lengths of the base registers
>                    and the mapped memory.
>  - reg-names:      Should contain the resource reg names:
>                    - qspi_base: configuration register address space
>                    - qspi_mmap: memory mapped address space
>  - interrupts:     Should contain the interrupt for the device.
> -- clocks:         The phandle of the clock needed by the QSPI controller.
> +- clocks:	  - "atmel,sama5d2-qspi": the phandle of the clock needed by the
> +		  QSPI controller.
> +		  - "microchip,sam9x60-qspi": should reference the peripheral
> +		  and system QSPI clocks.
> +- clock-names:    Only for sam9x60 - should contain two strigs:

							   ^strings

And I think naming clocks even for sama5d2 is a good practice, so I'd
suggest making "pclk" mandatory even if you support unnamed clk in the
driver to be backward compatible with old DTs.

> +		  - "pclk" for the peripheral clock
> +		  - "qspick" for the system clock
>  - #address-cells: Should be <1>.
>  - #size-cells:    Should be <0>.
>  
> @@ -29,3 +37,19 @@ spi@f0020000 {
>  		...
>  	};
>  };
> +
> +qspi@f0014000 {
> +	compatible = "microchip,sam9x60-qspi";
> +	reg = <0xf0014000 0x100>, <0x70000000 0x08000000>;
> +	reg-names = "qspi_base", "qspi_mmap";
> +	interrupts = <35 IRQ_TYPE_LEVEL_HIGH 7>;
> +	clocks =  <&pmc PMC_TYPE_PERIPHERAL 35>, <&pmc PMC_TYPE_SYSTEM 19>;
> +	clock-names = "pclk", "qspick";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +
> +	flash@0 {
> +		...
> +	};
> +};

No need to add one example per compat, especially when all that
changes is the compat string and an extra clk. 

