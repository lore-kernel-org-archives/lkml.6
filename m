Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeECCWw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 22:22:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:30904 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751889AbeECCWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 22:22:50 -0400
X-UUID: 39cb3dc5fa9047788d9104c70f209c94-20180503
Message-ID: <1525314164.14792.43.camel@mtkswgap22>
Subject: Re: [PATCH V4 8/8] arm64: dts: mt6797: add pwrap support for mt6797
From: Sean Wang <sean.wang@mediatek.com>
To: <argus.lin@mediatek.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>, <wsd_upstream@mediatek.com>,
        <henryc.chen@mediatek.com>, <flora.fu@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        "shailendra . v" <shailendra.v@samsung.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date: Thu, 3 May 2018 10:22:44 +0800
In-Reply-To: <20180502092112.3991-9-argus.lin@mediatek.com>
References: <20180502092112.3991-1-argus.lin@mediatek.com>
         <20180502092112.3991-9-argus.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-02 at 17:21 +0800, argus.lin@mediatek.com wrote:
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

the child node can't be added until MT6351 support is added to
dt-binding

> +		};
> +	};
> +
>  	uart0: serial@11002000 {
>  		compatible = "mediatek,mt6797-uart",
>  			     "mediatek,mt6577-uart";
