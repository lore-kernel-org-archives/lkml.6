Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31F3C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E087206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E087206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeGSKk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:40:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58992 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbeGSKk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:40:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6D3A620876; Thu, 19 Jul 2018 11:58:03 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id EEC44203EC;
        Thu, 19 Jul 2018 11:57:52 +0200 (CEST)
Date:   Thu, 19 Jul 2018 11:57:51 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     <linux-mtd@lists.infradead.org>,
        Liang Yang <liang.yang@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: nand: meson: add Amlogic NAND
 controller driver
Message-ID: <20180719115751.34ff1a51@bbrezillon>
In-Reply-To: <20180719094612.5833-2-yixun.lan@amlogic.com>
References: <20180719094612.5833-1-yixun.lan@amlogic.com>
        <20180719094612.5833-2-yixun.lan@amlogic.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018 17:46:11 +0800
Yixun Lan <yixun.lan@amlogic.com> wrote:

> From: Liang Yang <liang.yang@amlogic.com>
> 
> Add Amlogic NAND controller dt-bindings for Meson SoC,
> Current this driver support GXBB/GXL/AXG platform.
> 
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.txt       | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> new file mode 100644
> index 000000000000..31f910dcd27a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> @@ -0,0 +1,95 @@
> +Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
> +
> +This file documents the properties in addition to those available in
> +the MTD NAND bindings.
> +
> +Required properties:
> +- compatible : contains one of:
> +  - "amlogic,meson-gxl-nfc"
> +  - "amlogic,meson-axg-nfc"
> +- clocks     :
> +	A list of phandle + clock-specifier pairs for the clocks listed
> +	in clock-names.
> +
> +- clock-names: Should contain the following:
> +	"core" - NFC module gate clock
> +	"device" - device clock from eMMC sub clock controller
> +
> +- pins     : Select pins which NFC need.
> +- nand_pins: Detail NAND pins information.

You should document pinctrl-0 and pinctrl-names, not pins and nand_pins.

> +- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
> +				controller port C

Are you sure this is still needed, even after exposing MMC/NAND clks
through the CCF?

You forgot
- #address-cells
- #size-cells
- reg
- interrupts
- 

> +
> +Optional children nodes:
> +Children nodes represent the available nand chips.
> +
> +Optional properties:
> +- amlogic,nand-enable-scrambler: enable the NAND scrambler feature.
> +	- (absent) = scrambler is disabled
> +	- (present) = scrambler is enabled

I keep thinking this is not needed if you have the NAND chip properly
defined (NAND_NEED_SCRAMBLING flag set in chip->options).

> +
> +
> +Other properties:
> +see Documentation/devicetree/bindings/mtd/nand.txt for generic bindings.
> +
> +Example demonstrate on AXG SoC:
> +
> +	sd_emmc_c_clkc: mmc@7000 {
> +		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
> +		reg = <0x0 0x7000 0x0 0x800>;
> +		status = "okay";
> +	};
> +
> +	nand: nfc@7800 {
> +		compatible = "amlogic,meson-axg-nfc";
> +		reg = <0x0 0x7800 0x0 0x100>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> +		status = "disabled";
> +
> +		clocks = <&clkc CLKID_SD_EMMC_C>,
> +			<&sd_emmc_c_clkc CLKID_MMC_DIV>;
> +		clock-names = "core", "device";
> +		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
> +
> +		status = "okay";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&nand_pins>;
> +
> +		nand@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			nand-on-flash-bbt;
> +			nand-ecc-mode = "hw";
> +			nand-ecc-strength = <8>;
> +			nand-ecc-step-size = <1024>;

I'd recommend not forcing a specific ECC config in the example.

> +
> +			amlogic,nand-enable-scrambler;
> +
> +			partition@0 {
> +				label = "boot";
> +				reg = <0x00000000 0x00200000>;
> +				read-only;
> +			};

Blank line here.

> +			partition@200000 {
> +				label = "env";
> +				reg = <0x00200000 0x00400000>;
> +			};
> +			partition@600000 {
> +				label = "system";
> +				reg = <0x00600000 0x00a00000>;
> +			};
> +			partition@1000000 {
> +				label = "rootfs";
> +				reg = <0x01000000 0x03000000>;
> +			};
> +			partition@4000000 {
> +				label = "media";
> +				reg = <0x04000000 0x8000000>;
> +			};
> +		};
> +	};

