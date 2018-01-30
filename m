Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeA3M5R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:57:17 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33946 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbeA3M5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:57:15 -0500
X-Google-Smtp-Source: AH8x227J13Pw1VZNiIvRBFbTW2ww2528z/3YuxpO3+1pWCXx5mxI4sdg4tWnmRWo7WRsaF3HVGILnQ==
Subject: Re: [PATCH v2 2/5] arm64: dts: mt6797: add pwrap support for mt6797
To: argus.lin@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Chenglin Xu <chenglin.xu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, wsd_upstream@mediatek.com,
        henryc.chen@mediatek.com, flora.fu@mediatek.com,
        Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        "shailendra . v" <shailendra.v@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20180129090944.28687-1-argus.lin@mediatek.com>
 <20180129090944.28687-2-argus.lin@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <dcb5d00a-2239-b214-70a2-cef2e66570fa@gmail.com>
Date: Tue, 30 Jan 2018 13:57:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180129090944.28687-2-argus.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/29/2018 10:09 AM, argus.lin@mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> mt6797 is a highly integrated SoCs, and it uses
> mt6351 as Power Management IC.
> We need to add pwrap device to communicate with
> mt6351 by SPI.
> The base address of pwrap is 0x1000d000, and IRQ
> number is 178. It also using fixed 26Mhz clock
> as SPI CLK.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---

For the next round, can you put the dts patch at the end of the series. Binding
description should be the first patch, but actual dts(i) inclusion should be the
last one. It's bike shedding I know, but as you need a new series anyway.

Thanks.

>  arch/arm64/boot/dts/mediatek/mt6797.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> index 4beaa71107d7..485546efc9bf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> @@ -161,6 +161,20 @@
>  		      <0 0x10220690 0 0x10>;
>  	};
>  
> +	pwrap: pwrap@1000d000 {
> +		compatible = "mediatek,mt6797-pwrap";
> +		reg = <0 0x1000d000 0 0x1000>;
> +		reg-names = "pwrap";
> +		interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clk26m>, <&clk26m>;
> +		clock-names = "spi", "wrap";
> +
> +		pmic: mt6351 {
> +			compatible = "mediatek,mt6351";
> +			interrupt-controller;
> +		};
> +	};
> +
>  	uart0: serial@11002000 {
>  		compatible = "mediatek,mt6797-uart",
>  			     "mediatek,mt6577-uart";
> -- 
> 2.12.5
> 
> ************* Email Confidentiality Notice
>  ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe
>  
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank
>  you!
> 
