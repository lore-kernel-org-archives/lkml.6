Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AABC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5217F20861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548135393;
	bh=dAAkPQ3gOmuzStx+LnylDQEjHYPNOTVeO1hQ2mmNb9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FG2UCy3BVXJcl+AXJWk6rXyr7ufCV/NZWnZ2CGpi88KF+rb2b6XLTwq5vppwlPRGK
	 RbCspVshrF3bSRPpfPFC8MKSxfftNAhXNPZU1pE+TWLi6+zOH9ePsF+8jQ/SuWj/aY
	 MKFnw9ZGmMknWgBIAj6ExVpWOxMJtm5CinuCq068=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfAVFgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAVFgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:36:31 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CED420861;
        Tue, 22 Jan 2019 05:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548135390;
        bh=dAAkPQ3gOmuzStx+LnylDQEjHYPNOTVeO1hQ2mmNb9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xlP5+WWq3fS1UuaX2gpR7FBrvXSOY6TkRKIlHMzE6cV23VAz4amFfgLHALd6EEg2v
         wCzj03ag08TdsYdgyX1d41l9Y9IrLMS9tETBNzKM+OBD91qdPVHVkJSVO3AoVFa3Eu
         xuHpXwNnboYB1BEs7AJXS/OB/MZFqQe2GlJDtU4I=
Date:   Tue, 22 Jan 2019 13:35:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.tang@nxp.com
Subject: Re: [v3] arm64: dts: lx2160a: add sata node support
Message-ID: <20190122053552.GF19233@dragon>
References: <20190117021224.19021-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117021224.19021-1-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 02:12:24AM +0000, Peng Ma wrote:
> Add SATA device nodes for fsl-lx2160a and enable support
> for QDS and RDB boards.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for V3:
> 	- updated the commit log 
> 
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |   16 +++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   16 +++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   44 +++++++++++++++++++++
>  3 files changed, 76 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> index 99a22ab..1a5acf6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -95,6 +95,22 @@
>  	};
>  };
>  
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
> +
>  &uart0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 6481e5f..5b6799e 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -102,6 +102,22 @@
>  	};
>  };
>  
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
> +
>  &uart0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index a79f5c1..592034b 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -671,6 +671,50 @@
>  			status = "disabled";
>  		};
>  
> +		sata0: sata@3200000 {
> +			compatible = "fsl,lx2160a-ahci";

I can not find this compatible in any bindings doc.

Shawn

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
> +
>  		smmu: iommu@5000000 {
>  			compatible = "arm,mmu-500";
>  			reg = <0 0x5000000 0 0x800000>;
> -- 
> 1.7.1
> 
