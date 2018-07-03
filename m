Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86913C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4912064D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4912064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933948AbeGCQft (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:35:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52480 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932392AbeGCQfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:35:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3005E7A9;
        Tue,  3 Jul 2018 09:35:47 -0700 (PDT)
Received: from [10.1.210.23] (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 785E33F5BA;
        Tue,  3 Jul 2018 09:35:43 -0700 (PDT)
Subject: Re: [PATCH 7/7 v5] arm64: dts: ls208xa: comply with the iommu map
 binding for fsl_mc
To:     Nipun Gupta <nipun.gupta@nxp.com>, will.deacon@arm.com,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        laurentiu.tudor@nxp.com, bhelgaas@google.com
Cc:     hch@lst.de, joro@8bytes.org, m.szyprowski@samsung.com,
        shawnguo@kernel.org, frowand.list@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-8-git-send-email-nipun.gupta@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <88626adc-6f5b-86df-88a0-620d258f8053@arm.com>
Date:   Tue, 3 Jul 2018 17:35:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526824191-7000-8-git-send-email-nipun.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/18 14:49, Nipun Gupta wrote:
> fsl-mc bus support the new iommu-map property. Comply to this binding
> for fsl_mc bus.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index 137ef4d..6010505 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -184,6 +184,7 @@
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		ranges;
> +		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
>   
>   		clockgen: clocking@1300000 {
>   			compatible = "fsl,ls2080a-clockgen";
> @@ -357,6 +358,8 @@
>   			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
>   			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
>   			msi-parent = <&its>;
> +			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
> +			dma-coherent;
>   			#address-cells = <3>;
>   			#size-cells = <1>;
>   
> @@ -460,6 +463,8 @@
>   			compatible = "arm,mmu-500";
>   			reg = <0 0x5000000 0 0x800000>;
>   			#global-interrupts = <12>;
> +			#iommu-cells = <1>;
> +			stream-match-mask = <0x7C00>;
>   			interrupts = <0 13 4>, /* global secure fault */
>   				     <0 14 4>, /* combined secure interrupt */
>   				     <0 15 4>, /* global non-secure fault */
> @@ -502,7 +507,6 @@
>   				     <0 204 4>, <0 205 4>,
>   				     <0 206 4>, <0 207 4>,
>   				     <0 208 4>, <0 209 4>;
> -			mmu-masters = <&fsl_mc 0x300 0>;

Since we're in here, is the SMMU itself also coherent? If it is, you 
probably want to say so and avoid the overhead of pointlessly cleaning 
cache lines on every page table update.

Robin.

>   		};
>   
>   		dspi: dspi@2100000 {
> 
