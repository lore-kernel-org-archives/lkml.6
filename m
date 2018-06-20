Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EC8C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150D620875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150D620875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754177AbeFTOrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:47:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55671 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753619AbeFTOrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:47:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8287620799; Wed, 20 Jun 2018 16:47:51 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 06C20206D8;
        Wed, 20 Jun 2018 16:47:41 +0200 (CEST)
Date:   Wed, 20 Jun 2018 16:47:41 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Piotr Bugalski <bugalski.piotr@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: Re: [RFC PATCH 2/2] dt-bindings: spi: QuadSPI driver for Atmel
 SAMA5D2 documentation
Message-ID: <20180620164741.2a8da424@bbrezillon>
In-Reply-To: <20180618162124.21749-3-bugalski.piotr@gmail.com>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com>
        <20180618162124.21749-3-bugalski.piotr@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

On Mon, 18 Jun 2018 18:21:24 +0200
Piotr Bugalski <bugalski.piotr@gmail.com> wrote:

> Documentation for DT-binding change.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>

I'm pretty sure I didn't make a single suggestion about the DT
bindings you use here ;-).

> Signed-off-by: Piotr Bugalski <pbu@cryptera.com>
> 
> ---
>  .../devicetree/bindings/spi/spi_atmel-qspi.txt     | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt

I'll comment on this aspect in more details when replying to the cover
letter, but I think you should re-use the bindings defined in
Documentation/devicetree/bindings/mtd/atmel-quadspi.txt (IOW, move the
existing file to the Documentation/devicetree/bindings/spi directory).

It's the same HW block, and just because you develop a new driver to
replace the old one doesn't mean you should have 2 different bindings in
parallel.

> 
> diff --git a/Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt b/Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt
> new file mode 100644
> index 000000000000..d52b534c9c2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt
> @@ -0,0 +1,41 @@
> +* Atmel Quad Serial Peripheral Interface (QSPI)
> +
> +Required properties:
> +- compatible:     Should be "atmel,sama5d2-spi-qspi".
> +- reg:            Should contain the locations and lengths of the base registers
> +                  and the mapped memory.
> +- reg-names:      Should contain the resource reg names:
> +                  - qspi_base: configuration register address space
> +                  - qspi_mmap: memory mapped address space
> +- interrupts:     Should contain the interrupt for the device.
> +- clocks:         The phandle of the clock needed by the QSPI controller.
> +- #address-cells: Should be <1>.
> +- #size-cells:    Should be <0>.
> +
> +Example:
> +
> +qspi1: spi@f0024000 {
> +	compatible = "atmel,sama5d2-spi-qspi";
> +	reg = <0xf0024000 0x100>, <0xd8000000 0x08000000>;
> +	reg-names = "qspi_base", "qspi_mmap";
> +	interrupts = <53 IRQ_TYPE_LEVEL_HIGH 7>;
> +	clocks = <&qspi1_clk>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_qspi1_default>;
> +	status = "okay";
> +
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "winbond,w25m02gv", "spi-nand";

"winbond,w25m02gv" is undocumented and unnecessary since SPI NANDs are
automatically detected. Also, maybe you should declare a SPI NOR in the
example since SPI NAND support has not yet been merged.

> +		reg = <0>;
> +		spi-max-frequency = <83000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <4>;
> +
> +		...
> +	};
> +};
> +

Regards,

Boris
