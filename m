Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE8CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541222150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541222150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbeISTJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:09:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59678 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730876AbeISTJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:09:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D15791596;
        Wed, 19 Sep 2018 06:31:02 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24A073F73C;
        Wed, 19 Sep 2018 06:31:01 -0700 (PDT)
Subject: Re: [PATCH 16/21] arm64: dts: ls1046a: add smmu node
To:     laurentiu.tudor@nxp.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     madalin.bucur@nxp.com, roy.pledge@nxp.com, leoyang.li@nxp.com,
        shawnguo@kernel.org, davem@davemloft.net
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
 <20180919123613.15092-17-laurentiu.tudor@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a4d32163-71b1-35df-3a4c-eb27b605fc46@arm.com>
Date:   Wed, 19 Sep 2018 14:30:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919123613.15092-17-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/18 13:36, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> This allows for the SMMU device to be probed by the SMMU kernel driver.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 42 +++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index ef83786b8b90..06863d3e4a7d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -228,6 +228,48 @@
>   			bus-width = <4>;
>   		};
>   
> +		mmu: iommu@9000000 {
> +			compatible = "arm,mmu-500";
> +			reg = <0 0x9000000 0 0x400000>;
> +			dma-coherent;
> +			#global-interrupts = <2>;
> +			#iommu-cells = <1>;
> +			interrupts = <0 142 4>, /* global secure fault */

Either that's not really the secure global interrupt, or those context 
interrupts are wrong.

Robin.

> +				     <0 143 4>, /* combined secure interrupt */
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>,
> +				     <0 142 4>;
> +		};
> +
>   		scfg: scfg@1570000 {
>   			compatible = "fsl,ls1046a-scfg", "syscon";
>   			reg = <0x0 0x1570000 0x0 0x10000>;
> 
