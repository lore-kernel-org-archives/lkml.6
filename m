Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E93EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B2621019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B2621019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeK3C16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:27:58 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56031 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726989AbeK3C16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:27:58 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F62C4E3FA20E;
        Thu, 29 Nov 2018 23:22:01 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 23:21:57 +0800
Subject: Re: [PATCH 2/4] arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>
References: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
 <20180921060103.21370-3-manivannan.sadhasivam@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amit.kucheria@linaro.org>, <linux-clk@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5C00040F.4080507@hisilicon.com>
Date:   Thu, 29 Nov 2018 15:21:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180921060103.21370-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

On 2018/9/21 7:01, Manivannan Sadhasivam wrote:
> Add clock nodes for HiSilicon Hi3670 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 43 +++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> index c90e6f6a34ec..8a0ee4b08886 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/hi3670-clock.h>
>  
>  / {
>  	compatible = "hisilicon,hi3670";
> @@ -144,6 +145,48 @@
>  		#size-cells = <2>;
>  		ranges;
>  
> +		crg_ctrl: crg_ctrl@fff35000 {
> +			compatible = "hisilicon,hi3670-crgctrl", "syscon";
> +			reg = <0x0 0xfff35000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pctrl: pctrl@e8a09000 {
> +			compatible = "hisilicon,hi3670-pctrl", "syscon";
> +			reg = <0x0 0xe8a09000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pmuctrl: crg_ctrl@fff34000 {
> +			compatible = "hisilicon,hi3670-pmuctrl", "syscon";
> +			reg = <0x0 0xfff34000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		sctrl: sctrl@fff0a000 {
> +			compatible = "hisilicon,hi3670-sctrl", "syscon";
> +			reg = <0x0 0xfff0a000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		iomcu: iomcu@ffd7e000 {
> +			compatible = "hisilicon,hi3670-iomcu", "syscon";
> +			reg = <0x0 0xffd7e000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		media1_crg: media1_crgctrl@e87ff000 {
> +			compatible = "hisilicon,hi3670-media1-crg", "syscon";
> +			reg = <0x0 0xe87ff000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		media2_crg: media2_crgctrl@e8900000 {
> +			compatible = "hisilicon,hi3670-media2-crg","syscon";
> +			reg = <0x0 0xe8900000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		uart6_clk: clk_19_2M {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
> 

