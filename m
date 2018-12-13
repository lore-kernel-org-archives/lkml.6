Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D649AC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D4420882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D4420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbeLMGSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:18:24 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:16863 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726542AbeLMGSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:18:23 -0500
X-UUID: d1fdeb27563348d39f8cfa10bac8a64a-20181213
X-UUID: d1fdeb27563348d39f8cfa10bac8a64a-20181213
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 661874654; Thu, 13 Dec 2018 14:18:13 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Dec 2018 14:18:07 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 14:18:07 +0800
Message-ID: <1544681887.32198.1.camel@mtksdaap41>
Subject: Re: [PATCH v5 2/2] arm: dts: mt2712: add uart APDMA to device tree
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Long Cheng <long.cheng@mediatek.com>
CC:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, YT Shen <yt.shen@mediatek.com>
Date:   Thu, 13 Dec 2018 14:18:07 +0800
In-Reply-To: <1544506645-27979-3-git-send-email-long.cheng@mediatek.com>
References: <1544506645-27979-1-git-send-email-long.cheng@mediatek.com>
         <1544506645-27979-3-git-send-email-long.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 13:37 +0800, Long Cheng wrote:
> 1. add uart APDMA controller device node
> 2. add uart 0/1/2/3/4/5 DMA function
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi |   50 +++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> index 976d92a..a59728b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> @@ -300,6 +300,9 @@
>  		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
>  		clocks = <&baud_clk>, <&sys_clk>;
>  		clock-names = "baud", "bus";
> +		dmas = <&apdma 10
> +			&apdma 11>;
> +		dma-names = "tx", "rx";
>  		status = "disabled";
>  	};
>  
> @@ -378,6 +381,38 @@
>  		status = "disabled";
>  	};
>  
> +	apdma: dma-controller@11000400 {
> +		compatible = "mediatek,mt2712-uart-dma",
> +			     "mediatek,mt6577-uart-dma";

Sorting, please make sure this is before 

        auxadc: adc@11001000 {


> +		reg = <0 0x11000400 0 0x80>,
> +		      <0 0x11000480 0 0x80>,
> +		      <0 0x11000500 0 0x80>,
> +		      <0 0x11000580 0 0x80>,
> +		      <0 0x11000600 0 0x80>,
> +		      <0 0x11000680 0 0x80>,
> +		      <0 0x11000700 0 0x80>,
> +		      <0 0x11000780 0 0x80>,
> +		      <0 0x11000800 0 0x80>,
> +		      <0 0x11000880 0 0x80>,
> +		      <0 0x11000900 0 0x80>,
> +		      <0 0x11000980 0 0x80>;
> +		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 105 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 107 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 108 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 109 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 111 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&pericfg CLK_PERI_AP_DMA>;
> +		clock-names = "apdma";
> +		#dma-cells = <1>;
> +	};
> +
>  	uart0: serial@11002000 {
>  		compatible = "mediatek,mt2712-uart",
>  			     "mediatek,mt6577-uart";
> @@ -385,6 +420,9 @@


...deleted

