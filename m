Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBEAC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B526D20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B526D20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeKHSMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:12:21 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57627 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbeKHSMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:12:19 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7A1FB224DE; Thu,  8 Nov 2018 09:37:52 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0511A20787;
        Thu,  8 Nov 2018 09:37:52 +0100 (CET)
Date:   Thu, 8 Nov 2018 09:37:51 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, shawnguo@kernel.org,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] dt-bindings: spi: Move the bindings for the
 FSL QSPI driver
Message-ID: <20181108093751.39f43e8d@bbrezillon>
In-Reply-To: <1541601809-16950-3-git-send-email-frieder.schrempf@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
        <1541601809-16950-3-git-send-email-frieder.schrempf@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Nov 2018 15:43:19 +0100
Frieder Schrempf <frieder.schrempf@kontron.de> wrote:

> From: Frieder Schrempf <frieder.schrempf@exceet.de>
> 
> Move the documentation of the old SPI NOR driver to the place of the new
> SPI memory interface based driver.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
> ---
>  .../devicetree/bindings/mtd/fsl-quadspi.txt     | 65 --------------------
>  .../devicetree/bindings/spi/spi-fsl-qspi.txt    | 65 ++++++++++++++++++++

Did you use -M when you generated patches with git format-patch?
Normally, when you move a file without changing anything, the diff is
smaller than that.

>  2 files changed, 65 insertions(+), 65 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
> deleted file mode 100644
> index 483e9cf..0000000
> --- a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
> +++ /dev/null
> @@ -1,65 +0,0 @@
> -* Freescale Quad Serial Peripheral Interface(QuadSPI)
> -
> -Required properties:
> -  - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
> -		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
> -		 "fsl,ls1021a-qspi"
> -		 or
> -		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
> -		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
> -  - reg : the first contains the register location and length,
> -          the second contains the memory mapping address and length
> -  - reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
> -  - interrupts : Should contain the interrupt for the device
> -  - clocks : The clocks needed by the QuadSPI controller
> -  - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
> -
> -Optional properties:
> -  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
> -                              Each bus can be connected with two NOR flashes.
> -			      Most of the time, each bus only has one NOR flash
> -			      connected, this is the default case.
> -			      But if there are two NOR flashes connected to the
> -			      bus, you should enable this property.
> -			      (Please check the board's schematic.)
> -  - big-endian : That means the IP register is big endian
> -
> -Example:
> -
> -qspi0: quadspi@40044000 {
> -	compatible = "fsl,vf610-qspi";
> -	reg = <0x40044000 0x1000>, <0x20000000 0x10000000>;
> -	reg-names = "QuadSPI", "QuadSPI-memory";
> -	interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
> -	clocks = <&clks VF610_CLK_QSPI0_EN>,
> -		<&clks VF610_CLK_QSPI0>;
> -	clock-names = "qspi_en", "qspi";
> -
> -	flash0: s25fl128s@0 {
> -		....
> -	};
> -};
> -
> -Example showing the usage of two SPI NOR devices:
> -
> -&qspi2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_qspi2>;
> -	status = "okay";
> -
> -	flash0: n25q256a@0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "micron,n25q256a", "jedec,spi-nor";
> -		spi-max-frequency = <29000000>;
> -		reg = <0>;
> -	};
> -
> -	flash1: n25q256a@1 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "micron,n25q256a", "jedec,spi-nor";
> -		spi-max-frequency = <29000000>;
> -		reg = <1>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
> new file mode 100644
> index 0000000..483e9cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
> @@ -0,0 +1,65 @@
> +* Freescale Quad Serial Peripheral Interface(QuadSPI)
> +
> +Required properties:
> +  - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
> +		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
> +		 "fsl,ls1021a-qspi"
> +		 or
> +		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
> +		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
> +  - reg : the first contains the register location and length,
> +          the second contains the memory mapping address and length
> +  - reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
> +  - interrupts : Should contain the interrupt for the device
> +  - clocks : The clocks needed by the QuadSPI controller
> +  - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
> +
> +Optional properties:
> +  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
> +                              Each bus can be connected with two NOR flashes.
> +			      Most of the time, each bus only has one NOR flash
> +			      connected, this is the default case.
> +			      But if there are two NOR flashes connected to the
> +			      bus, you should enable this property.
> +			      (Please check the board's schematic.)
> +  - big-endian : That means the IP register is big endian
> +
> +Example:
> +
> +qspi0: quadspi@40044000 {
> +	compatible = "fsl,vf610-qspi";
> +	reg = <0x40044000 0x1000>, <0x20000000 0x10000000>;
> +	reg-names = "QuadSPI", "QuadSPI-memory";
> +	interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&clks VF610_CLK_QSPI0_EN>,
> +		<&clks VF610_CLK_QSPI0>;
> +	clock-names = "qspi_en", "qspi";
> +
> +	flash0: s25fl128s@0 {
> +		....
> +	};
> +};
> +
> +Example showing the usage of two SPI NOR devices:
> +
> +&qspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_qspi2>;
> +	status = "okay";
> +
> +	flash0: n25q256a@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "micron,n25q256a", "jedec,spi-nor";
> +		spi-max-frequency = <29000000>;
> +		reg = <0>;
> +	};
> +
> +	flash1: n25q256a@1 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "micron,n25q256a", "jedec,spi-nor";
> +		spi-max-frequency = <29000000>;
> +		reg = <1>;
> +	};
> +};

