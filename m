Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AB5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D111521019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D111521019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeK3C2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:28:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726989AbeK3C2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:28:42 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 02247F9663462;
        Thu, 29 Nov 2018 23:22:48 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 23:22:45 +0800
Subject: Re: [PATCH 3/4] arm64: dts: hisilicon: Source SoC clock for UART6
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>
References: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
 <20180921060103.21370-4-manivannan.sadhasivam@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amit.kucheria@linaro.org>, <linux-clk@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5C00043E.2070607@hisilicon.com>
Date:   Thu, 29 Nov 2018 15:22:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180921060103.21370-4-manivannan.sadhasivam@linaro.org>
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
> Remove fixed clock and source SoC clock for UART6 for
> HiSilicon Hi3670 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> index 8a0ee4b08886..34a2f0dbc6f7 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -187,17 +187,12 @@
>  			#clock-cells = <1>;
>  		};
>  
> -		uart6_clk: clk_19_2M {
> -			compatible = "fixed-clock";
> -			#clock-cells = <0>;
> -			clock-frequency = <19200000>;
> -		};
> -
>  		uart6: serial@fff32000 {
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfff32000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&uart6_clk &uart6_clk>;
> +			clocks = <&crg_ctrl HI3670_CLK_UART6>,
> +				 <&crg_ctrl HI3670_PCLK>;
>  			clock-names = "uartclk", "apb_pclk";
>  			status = "disabled";
>  		};
> 

