Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B1AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48CC20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547604371;
	bh=yL62E1MSsM+fjN8pSX8/J71nC2mdkCIoqBNx+bYjIIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1J0en2E1RKffIZSaY5gDwv/xYvTCqe//ZHrPcOJcssYdo5bzWFAPI2yrFVxjltNIP
	 FtwibAp82OahROF7kOydJRLkKDLbWuKmU51oYfH5z9ukLQLqkFG7rPHmawj3X/t3tZ
	 SyhGqxP5j9Ert8/+TjRqNt2Y0aHSMxXbim9skFDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfAPCGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:06:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbfAPCGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:06:09 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E7762082F;
        Wed, 16 Jan 2019 02:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547604368;
        bh=yL62E1MSsM+fjN8pSX8/J71nC2mdkCIoqBNx+bYjIIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d2pwfKoDt7uQ46J3tdNIoK2Ph7jh+QjAAG+Q6XGOpblPJ9xenyrcdVf05SRM+wjMG
         hXL6icef2cZcNxWvQklJXDvxmnaIIPTZES2n7xEcYNYYtpIPQN/2Pe12lag7akeesA
         W9fobg5HbzoW6o1mPfJPQmhpkvPlml1tlPwIYQ1A=
Date:   Wed, 16 Jan 2019 10:05:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2] arm64: dts: lx2160a: add sata node support
Message-ID: <20190116020543.GB15808@dragon>
References: <20190114095500.1600-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114095500.1600-1-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 09:55:00AM +0000, Peng Ma wrote:
> Add sata node support and Enable sata support

I would suggest you reword the commit log like below:

Add SATA device nodes for fsl-lx2160a and enable support for QDS and RDB
boards.

> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for V2:
> 	- put the 'status' at the end of property list
> 	- add lx2160aqds sata support
> 
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |   16 +++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   16 +++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   44 +++++++++++++++++++++
>  3 files changed, 76 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> index 99a22ab..0289955 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -110,3 +110,19 @@
>  &usb1 {
>  	status = "okay";
>  };
> +
> +&sata0 {

Please sort the labeling nodes alphabetically.

Shawn

> +	status = "okay";
> +};
> +
> +&sata1 {
> +	status = "okay";
> +};
> +
> +&sata2 {
> +	status = "okay";
> +};
> +
> +&sata3 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 6481e5f..aacca27 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -117,3 +117,19 @@
>  &usb1 {
>  	status = "okay";
>  };
> +
> +&sata0 {
> +	status = "okay";
> +};
> +
> +&sata1 {
> +	status = "okay";
> +};
> +
> +&sata2 {
> +	status = "okay";
> +};
> +
> +&sata3 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index a79f5c1..4390aea 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -762,5 +762,49 @@
>  				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
>  			dma-coherent;
>  		};
> +
> +		sata0: sata@3200000 {

Please sort nodes with unit-address in order of the address.

Shawn

> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3200000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +			status = "disabled";
> +		};
> +
> +		sata1: sata@3210000 {
> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3210000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +			status = "disabled";
> +		};
> +
> +		sata2: sata@3220000 {
> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3220000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +			status = "disabled";
> +		};
> +
> +		sata3: sata@3230000 {
> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3230000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +			status = "disabled";
> +		};
>  	};
>  };
> -- 
> 1.7.1
> 
