Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71126C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259A2213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544058377;
	bh=n0y/FePU5u0P26muBmNfdRLnEU2yU1MyrxUikW8Ok5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uBcN0vvtu9mA3UNkx1f+ScruFLUmQKlLfO2fQSTnLr9fLDfK1xBiOiyfL9Bc4nnEi
	 wfNDomO9iC5IdhYj6ZY/02FzhUF8N79vLiY6XwCBCqWxRUApx7OGRjwszLja0sXAsl
	 lFPBkLs1X0vp0cNeHsr51yYCSN7evxn41x7PghyI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259A2213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbeLFBGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:06:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbeLFBGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:06:16 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42A442133F;
        Thu,  6 Dec 2018 01:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544058375;
        bh=n0y/FePU5u0P26muBmNfdRLnEU2yU1MyrxUikW8Ok5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgFka1JPRPFb0327BQKVKZNsaCMRz22/YyI3EX6Kjvpg5K/MqRxKy6+B9g/AWA1Lf
         G3VnszjGhTeh7yVf7Ln0Hxc6/d8UtLRuNz8XelCW6lmnpMw6XjFQBqxh73tLKVEBT0
         P7a6TyzWaqBDjDpU1Lg2VG2IDXjpkHUT37aJ8ARo=
Date:   Thu, 6 Dec 2018 09:05:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, dan.j.williams@intel.com, zw@zh-kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Wen He <wen.he_1@nxp.com>
Subject: Re: [v11 6/7] arm64: dts: ls1046a: add qdma device tree nodes
Message-ID: <20181206010531.GR3987@dragon>
References: <20181030023604.34027-1-peng.ma@nxp.com>
 <20181030023604.34027-6-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030023604.34027-6-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:36:03AM +0800, Peng Ma wrote:
> add the qDMA device tree nodes for LS1046A devices.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> change in v11:
> 	- no
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index ef83786..dc65318 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -704,6 +704,27 @@
>  					<0000 0 0 4 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		qdma: dma-controller@8380000 {
> +			compatible = "fsl,ls1046a-qdma", "fsl,ls1021a-qdma";
> +			reg = <0x0 0x8380000 0x0 0x1000>, /* Controller regs */
> +			      <0x0 0x8390000 0x0 0x10000>, /* Status regs */
> +			      <0x0 0x83a0000 0x0 0x40000>; /* Block regs */
> +			interrupts = <0 153 0x4>,
> +				     <0 39 0x4>,
> +				     <0 40 0x4>,
> +				     <0 41 0x4>,
> +				     <0 42 0x4>;

Use GIC_SPI and IRQ_TYPE_xxx defines.

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
>  	reserved-memory {
> -- 
> 1.7.1
> 
