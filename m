Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D83C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675D22133F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544058332;
	bh=Ew1oZ9WiJmSi/wEqdIaIqFMzUoSpqztyJt+RUFCAfZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vGnvLVdyKe2jICR3ZkpTfxKGyFXw1QeBV2vPfbM8NCN3a1L1S08hSq1n0zBM4+xcQ
	 9MzZRZ2C9/4lglnQ8Ib1v3LqjwlVCUEV6g48sCPIY5P7EsLjaZ2gRmAaXYz5kfeZw6
	 A8TV+8jGt5J8r+EhS27FjVZxo6IuXA2UiGFfU060=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675D22133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeLFBFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:05:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeLFBFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:05:30 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 832382081B;
        Thu,  6 Dec 2018 01:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544058329;
        bh=Ew1oZ9WiJmSi/wEqdIaIqFMzUoSpqztyJt+RUFCAfZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUkpP5QeE8bpESetLxa7Tr5nkGP87RebHK+Os2K4ZiMrx8414ohMnpgpyN1X27LRL
         0q5BFz+xYAzB/EQVebXqOW1eymte843U9II5adVvPROPBfNiB86mJTTBW0NwkRcGtc
         hvQ8g6flSMgqP30bwHKp2Rld7m1dCA2eZbtWWGi8=
Date:   Thu, 6 Dec 2018 09:04:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, dan.j.williams@intel.com, zw@zh-kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Wen He <wen.he_1@nxp.com>
Subject: Re: [v11 5/7] arm64: dts: ls1043a: add qdma device tree nodes
Message-ID: <20181206010445.GQ3987@dragon>
References: <20181030023604.34027-1-peng.ma@nxp.com>
 <20181030023604.34027-5-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030023604.34027-5-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:36:02AM +0800, Peng Ma wrote:
> add the qDMA device tree nodes for LS1043A devices.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> change in v11:
> 	- no
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 7881e3d..d560141 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -734,6 +734,28 @@
>  					<0000 0 0 3 &gic 0 156 0x4>,
>  					<0000 0 0 4 &gic 0 157 0x4>;
>  		};
> +
> +		qdma: dma-controller@8380000 {
> +			compatible = "fsl,ls1021a-qdma", "fsl,ls1043a-qdma";
> +			reg = <0x0 0x8380000 0x0 0x1000>, /* Controller regs */
> +			      <0x0 0x8390000 0x0 0x10000>, /* Status regs */
> +			      <0x0 0x83a0000 0x0 0x40000>; /* Block regs */
> +			interrupts = <0 153 0x4>,
> +				     <0 39 0x4>,
> +				     <0 40 0x4>,
> +				     <0 41 0x4>,
> +				     <0 42 0x4>;

I know this dts file did not use GIC_SPI and IRQ_TYPE_xxx defines from
the beginning.  But please use them for new additions.

Shawn

> +			interrupt-names = "qdma-error", "qdma-queue0",
> +				"qdma-queue1", "qdma-queue2", "qdma-queue3";
> +			dma-channels = <8>;
> +			block-number = <1>;
> +			block-offset = <0x10000>;
> +			fsl,dma-queues = <2>;
> +			status-sizes = <64>;
> +			queue-sizes = <64 64>;
> +			big-endian;
> +		};
> +
>  	};
>  
>  	firmware {
> -- 
> 1.7.1
> 
