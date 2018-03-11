Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbeCKTmQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 15:42:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44087 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932161AbeCKTmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 15:42:14 -0400
X-Google-Smtp-Source: AG47ELth7pWhCq++m+I30v3uRUrHSO25rc8Eeh2k7R1ZssNzDA6hoxqs9O8hhpGCuWcjLQhSsGCoRA==
Subject: Re: [PATCH v3 14/15] arm64: dts: mt7622: add High-Speed DMA device
 nodes
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1518895232.git.sean.wang@mediatek.com>
 <a350bd0f5ce5b94bd71fd7f02af804b9c0584fd7.1518895232.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <78991976-0af0-2292-78a1-89b19e4781c0@gmail.com>
Date: Sun, 11 Mar 2018 20:39:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a350bd0f5ce5b94bd71fd7f02af804b9c0584fd7.1518895232.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/17/2018 08:54 PM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> add High-Speed DMA (HSDMA) nodes
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

NAK. AFAIK the driver is not yest upstream

Regards,
Matthias

> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index bad1e99..ffb934b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -715,6 +715,16 @@
>  		#reset-cells = <1>;
>  	};
>  
> +	hsdma: dma-controller@1b007000 {
> +		compatible = "mediatek,mt7622-hsdma";
> +		reg = <0 0x1b007000 0 0x1000>;
> +		interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&ethsys CLK_ETH_HSDMA_EN>;
> +		clock-names = "hsdma";
> +		power-domains = <&scpsys MT7622_POWER_DOMAIN_ETHSYS>;
> +		#dma-cells = <1>;
> +	};
> +
>  	eth: ethernet@1b100000 {
>  		compatible = "mediatek,mt7622-eth",
>  			     "mediatek,mt2701-eth",
> 
