Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE74C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 04:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71D220873
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 04:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547352370;
	bh=dsJe1XXJhq958ofnQRjjdYqdlEq6x6Dirqju9W9Q8nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GJNrmnOVR40RTSDGwc/5/crymYh0P1ZdhmAplfj4j4rdWEy7KrQgx6nwwL2aZ4Qtg
	 Q+LyZU48ei4lkRlZNE2Ca7RtXeh/f1uONgAj4UKlf2l1pf9NdBBw5izTZVhp9E9ov5
	 Npq+Nn4mv8pEOoftK35knsbiA1dJ1UQDba84Ifmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfAMEGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 23:06:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfAMEGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 23:06:08 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 802FC20873;
        Sun, 13 Jan 2019 04:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547352367;
        bh=dsJe1XXJhq958ofnQRjjdYqdlEq6x6Dirqju9W9Q8nQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rkCStBCEyS7sBlhxUghX7HpKe/Mforwc4zkmishZKi1Mr2Gg8wm6GR9IFGEgCrs/s
         g5hyEMHE6UKLlYDI6gz6HN1CD2dNmmm9n/9LXCnNHF8hpK59VDu4gdpLchA395U2MO
         2xW0O5ZT2lQpPLUDet9OMxz9OuPpgbPJAcF09lUg=
Date:   Sun, 13 Jan 2019 12:05:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     axboe@kernel.dk, leoyang.li@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: lx2160a: add sata node support
Message-ID: <20190113040546.GL11426@dragon>
References: <20190110100533.33333-1-peng.ma@nxp.com>
 <20190110100533.33333-2-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110100533.33333-2-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 06:05:33PM +0800, Peng Ma wrote:
> Add sata node support and Enable sata support
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   16 +++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   44 +++++++++++++++++++++
>  2 files changed, 60 insertions(+), 0 deletions(-)
> 
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
> index a79f5c1..e857a14 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -762,5 +762,49 @@
>  				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
>  			dma-coherent;
>  		};
> +
> +		sata0: sata@3200000 {
> +			status = "disabled";

We usually have 'status' at the end of property list.

Shawn

> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3200000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +		};
> +
> +		sata1: sata@3210000 {
> +			status = "disabled";
> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3210000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +		};
> +
> +		sata2: sata@3220000 {
> +			status = "disabled";
> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3220000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +		};
> +
> +		sata3: sata@3230000 {
> +			status = "disabled";
> +			compatible = "fsl,lx2160a-ahci";
> +			reg = <0x0 0x3230000 0x0 0x10000>,
> +			      <0x7 0x100520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			dma-coherent;
> +		};
>  	};
>  };
> -- 
> 1.7.1
> 
