Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFBFC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBB221479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549091861;
	bh=Sm2sNfK0Px+6ifmL2BMseCNQTGFB1pCiTCawVraGZE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=stQkW1UW3ft7SwdaxwhWwRlsOQdMQZ197+c6COSWwRN0sIcTDCFRrOnnfzQlRLLtN
	 AiqbVC/OKcKPO2OmDVv7925Tefn0lFOWud4sCCXAPt3lOM9wRU2Zt4W9Mk3bfO5doy
	 5+T7HDjgrAY2iXoPJ5va0zV3ptXGkSXg8CawVRRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfBBHRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 02:17:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfBBHRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 02:17:39 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF7E20869;
        Sat,  2 Feb 2019 07:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549091858;
        bh=Sm2sNfK0Px+6ifmL2BMseCNQTGFB1pCiTCawVraGZE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mtn6KXj3BXUp6FrM3PIVdIDzcOl5e2wv9+w5HjFtL/MLVGJtnMZrcYejQckmwxdzw
         mz+9LjNZhuRPuRlIOh8SSsux5Y/kZu25oMF72uuQhH35EOjnp9mr0gXQPPU9JynnH2
         WnZSL35j5lli5duk5BN0xihnUmTPjEiIUd0b16Uc=
Date:   Sat, 2 Feb 2019 08:17:23 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 12/13] dt-bindings: spi: atmel-quadspi: QuadSPI
 driver for Microchip SAM9X60
Message-ID: <20190202081723.30645d03@bbrezillon>
In-Reply-To: <20190202040653.1217-13-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-13-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2019 04:07:44 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
> access, the other for the qspi core and phy. Both are mandatory.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v3: "pclk" was made mandatory in previous patch. Reword clock
> descriptions.
> v2:
> - make "pclk" mandatory even for sama5d2. Unnamed clk will be
> supported in the driver.
> - drop unneeded example
> 
>  Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> index 1de54e87f5d6..fc7e83adab36 100644
> --- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> +++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> @@ -1,15 +1,19 @@
>  * Atmel Quad Serial Peripheral Interface (QSPI)
>  
>  Required properties:
> -- compatible:     Should be "atmel,sama5d2-qspi".
> +- compatible:     Should be one of the following:
> +		  - "atmel,sama5d2-qspi"
> +		  - "microchip,sam9x60-qspi"
>  - reg:            Should contain the locations and lengths of the base registers
>                    and the mapped memory.
>  - reg-names:      Should contain the resource reg names:
>                    - qspi_base: configuration register address space
>                    - qspi_mmap: memory mapped address space
>  - interrupts:     Should contain the interrupt for the device.
> -- clocks:         The phandle of the clock needed by the QSPI controller.
> -- clock-names:    Should contain "pclk" for the peripheral clock.
> +- clocks:         Should reference the peripheral clock and the QSPI system
> +                  clock if available.
> +- clock-names:    Should contain "pclk" for the peripheral clock and "qspick"
> +                  for the system clock when available.
>  - #address-cells: Should be <1>.
>  - #size-cells:    Should be <0>.
>  

