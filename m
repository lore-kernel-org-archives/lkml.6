Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDC0C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CF421479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549091717;
	bh=pe2Sgi9wB9pgA71g5eSonL3P7g0Axagq1YpMcrCeSnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=f6bqYjKJFsKPCp+hlUWoAXCbsLgdGiQZG5M8AbCT1xgzjEPcgFRnnMec0BU0xTMn5
	 zJQo+FP+C5RPdaYGpgwk7BXc2+6cakD82TPYKZqWAltOtB9hLkBgbwhjAvU66s8Cqc
	 wHJB3ZZ9ItY0PgaDcX1YvDVZA0JYyopmu+2ZX3Pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfBBHPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 02:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfBBHPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 02:15:15 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 868BD20869;
        Sat,  2 Feb 2019 07:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549091714;
        bh=pe2Sgi9wB9pgA71g5eSonL3P7g0Axagq1YpMcrCeSnQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jnC27kdTCZew7WT0oAlu50LnVVmsAOemYotBxRSe2wBn3bTK/yf19u3bE9MXcl3J1
         Fnt/7o24+6r7qTPoeeoXv0OPuiJzkGhsh+mqsNqWYzaisB6Aecj8jfZgsgT/HdqdJv
         W43kHzh3aBiHNYvjak75PLtJlFziEhi0uT/F+UdI=
Date:   Sat, 2 Feb 2019 08:15:02 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 10/13] dt-bindings: spi: atmel-quadspi: make "pclk"
 mandatory
Message-ID: <20190202081502.47ca404d@bbrezillon>
In-Reply-To: <20190202040653.1217-11-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-11-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2019 04:07:39 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Naming clocks is a good practice. Make "pclk" madatory even if
> we support unnamed clock in the driver, to be backward compatible
> with old DTs.
> 
> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v3: new patch
> 
>  Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> index e9dae6264d89..1de54e87f5d6 100644
> --- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> +++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> @@ -9,6 +9,7 @@ Required properties:
>                    - qspi_mmap: memory mapped address space
>  - interrupts:     Should contain the interrupt for the device.
>  - clocks:         The phandle of the clock needed by the QSPI controller.
> +- clock-names:    Should contain "pclk" for the peripheral clock.
>  - #address-cells: Should be <1>.
>  - #size-cells:    Should be <0>.
>  
> @@ -20,6 +21,7 @@ spi@f0020000 {
>  	reg-names = "qspi_base", "qspi_mmap";
>  	interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
>  	clocks = <&pmc PMC_TYPE_PERIPHERAL 52>;
> +	clock-names = "pclk"

Missing semicolon. Once fixed you can add

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

>  	#address-cells = <1>;
>  	#size-cells = <0>;
>  	pinctrl-names = "default";

