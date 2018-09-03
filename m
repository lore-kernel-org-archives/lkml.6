Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AED0C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE74B20861
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr5Mcw35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE74B20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeICFL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 01:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbeICFLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 01:11:55 -0400
Received: from dragon (unknown [45.56.155.166])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DC1D20856;
        Mon,  3 Sep 2018 00:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535936054;
        bh=HjUKWPE3bI8sqACf6QcDzJb3rkYdPh41Y/f5oxXkDC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cr5Mcw35b9Z66thOhl0KnPm3svc0hDiks4MJl9uUdfvgaacYRNsZdJsHwUBCJuvuN
         8p8mJU/QaLeXaW2e6bKNVeGBMvjTQ3B31jr55j496notBtf3oM4WgjaZvUBfttfIoQ
         3ligHFGu46bZigMhS9Y57lNStUpyT6bTKvfyvCuM=
Date:   Mon, 3 Sep 2018 08:53:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] arm64: dts: add Microsys MPX-LS1046A SoM and
 SBC-LS1046A SBC
Message-ID: <20180903005259.GV3850@dragon>
References: <20180828204544.10815-1-alexandre.belloni@bootlin.com>
 <20180828204544.10815-4-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828204544.10815-4-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 10:45:44PM +0200, Alexandre Belloni wrote:
> Microsys designs a SoM based on the LS1046A named miriac MPX-LS1046A
> https://microsys.de/products/system-on-modules/qoriqr-armr-architecture/miriactm-mpx-ls1046a/
> 
> It also provides an SBC accepting this SoM, the miriac SBC-LS1046
> https://microsys.de/en/products/single-board-computer/miriactm-sbcs/miriactm-sbc-ls1046a/
> 
> This adds a dtsi for the SoM and a dts for the SBC.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../fsl-ls1046a-miriac-mpxls1046.dtsi         |  62 ++++++++++
>  .../freescale/fsl-ls1046a-miriac-sbc1046.dts  | 117 ++++++++++++++++++
>  3 files changed, 180 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-mpxls1046.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-sbc1046.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 86e18adb695a..b0b81ca887e8 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-miriac-sbc1046.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-qds.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-mpxls1046.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-mpxls1046.dtsi
> new file mode 100644
> index 000000000000..d1948e27fdb4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-mpxls1046.dtsi
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/ {
> +	compatible = "microsys,mpxls1046a", "fsl,ls1046a";
> +};
> +
> +&duart0 {
> +	status = "okay";
> +};
> +
> +&duart1 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	temp-sensor@4c {
> +		compatible = "national,lm90";
> +		reg = <0x4c>;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "at24,24c128";
> +		reg = <0x50>;
> +	};
> +
> +	rtc@32 {
> +		compatible = "epson,rx8803";
> +		reg = <0x32>;
> +	};

We usually sort devices under bus in order of unit-address.

> +};
> +
> +&ifc {
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +
> +	ranges = <0x0 0x0 0x0 0x7e800000 0x00010000>;
> +	status = "okay";
> +
> +	nand@0,0 {
> +		compatible = "fsl,ifc-nand";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0 0x0 0x10000>;
> +	};
> +};
> +
> +&qspi {
> +	num-cs = <1>;
> +	bus-num = <0>;
> +	status = "okay";
> +
> +	qflash0: s25fs512s@0 {

Can we have a generic name for the device node?  The label name could be
specific though.

> +		compatible = "spansion,m25p80";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <20000000>;
> +		m25p,fast-read;
> +		reg = <0>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-sbc1046.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-sbc1046.dts
> new file mode 100644
> index 000000000000..f31be6ed06ea
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-miriac-sbc1046.dts
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "fsl-ls1046a.dtsi"
> +#include "fsl-ls1046a-miriac-mpxls1046.dtsi"
> +
> +/ {
> +	model = "Microsys miriac SBC-LS1046A";
> +	compatible = "microsys,sbc1046a", "microsys,mpxls1046a", "fsl,ls1046a";
> +
> +	aliases {
> +		ethernet0 = &enet2;
> +		ethernet1 = &enet4;
> +		ethernet2 = &enet5;
> +		ethernet3 = &enet6;
> +

This newline is not really necessary.

> +		serial0 = &duart0;
> +		serial1 = &duart1;
> +		serial2 = &duart2;
> +		serial3 = &duart3;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&duart0 {
> +	status = "okay";
> +};
> +
> +&duart1 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	eeprom@57 {
> +		compatible = "at24,24c128";
> +		reg = <0x57>;
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&ifc {
> +	nand@0,0 {
> +		partition@0 {
> +			reg = <0x0 0x00100000>;
> +			label = "NAND U-Boot Image";
> +			read-only;
> +		};
> +
> +		partition@100000 {
> +			reg = <0x00100000 0x00100000>;
> +			label = "NAND U-Boot Env";
> +		};
> +
> +		partition@200000 {
> +			reg = <0x00200000 0x01E00000>;
> +			label = "NAND FIT Image";
> +		};
> +
> +		partition@02000000 {
> +			reg = <0x02000000 0x1e000000>;
> +			label = "NAND (RW) UBIFS Root File System";
> +		};
> +	};
> +};
> +
> +#include "fsl-ls1046-post.dtsi"
> +
> +&fman0 {
> +	compatible = "fsl,fman", "simple-bus";
> +
> +	ethernet@e4000 {
> +		phy-handle = <&rgmii_phy1>;
> +		phy-connection-type = "rgmii";
> +	};
> +
> +	ethernet@e8000 {
> +		phy-handle = <&sgmii_phy1>;
> +		phy-connection-type = "sgmii";
> +	};
> +
> +	ethernet@ea000 {
> +		phy-handle = <&sgmii_phy2>;
> +		phy-connection-type = "sgmii";
> +	};
> +
> +	ethernet@f0000 {
> +		phy-handle = <&sgmii_phy3>;
> +		phy-connection-type = "sgmii";
> +	};
> +
> +	mdio@fc000 {
> +		rgmii_phy1: ethernet-phy@3 {
> +			reg = <3>;
> +		};
> +
> +		sgmii_phy1: ethernet-phy@2 {
> +			reg = <2>;
> +		};
> +
> +		sgmii_phy2: ethernet-phy@1 {
> +			reg = <1>;
> +		};
> +
> +		sgmii_phy3: ethernet-phy@0 {
> +			reg = <0>;
> +		};

Sort them in unit-address.

Shawn

> +	};
> +};
> -- 
> 2.18.0
> 
