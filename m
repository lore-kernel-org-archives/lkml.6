Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D99C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3574F208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3574F208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeJPU73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:59:29 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44220 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeJPU72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:59:28 -0400
Received: from wd0405.dip.tu-dresden.de ([141.76.109.149] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gCP5q-0004ho-Az; Tue, 16 Oct 2018 15:09:02 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARM: dts: rv1108-evb: enable eMMC support
Date:   Tue, 16 Oct 2018 15:09:01 +0200
Message-ID: <6815120.yyevdQbq0d@phil>
In-Reply-To: <20181009213656.27719-1-otavio@ossystems.com.br>
References: <20181009213656.27719-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Otavio,

Am Dienstag, 9. Oktober 2018, 23:36:56 CEST schrieb Otavio Salvador:
> Enable eMMC support for rv1108 evaluation board.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> ---
> 
>  arch/arm/boot/dts/rv1108-evb.dts |  8 ++++++++
>  arch/arm/boot/dts/rv1108.dtsi    | 29 +++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
> index 70f0106d1252..f3c6f52c49e6 100644
> --- a/arch/arm/boot/dts/rv1108-evb.dts
> +++ b/arch/arm/boot/dts/rv1108-evb.dts
> @@ -226,6 +226,14 @@
>  	status = "okay";
>  };
>  
> +&emmc {
> +	cap-mmc-highspeed;
> +	supports-emmc;
> +	non-removable;
> +	num-slots = <1>;

num-slots should not be present anymore on new additions

Also missing the pinctrl settings you're defining below?
Aka pinctrl-0 = <&emmc_*>; + pinctrl-names = "default"


Heiko

> +	status = "okay";
> +};
> +
>  &u2phy {
>  	status = "okay";
>  
> diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
> index 76ea24636feb..f14a733d85f6 100644
> --- a/arch/arm/boot/dts/rv1108.dtsi
> +++ b/arch/arm/boot/dts/rv1108.dtsi
> @@ -772,6 +772,35 @@
>  			};
>  		};
>  
> +		emmc {
> +			emmc_clk: emmc-clk {
> +				rockchip,pins = <2 RK_PB6 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
> +			};
> +
> +			emmc_cmd: emmc-cmd {
> +				rockchip,pins = <2 RK_PB4 RK_FUNC_2 &pcfg_pull_up_drv_8ma>;
> +			};
> +
> +			emmc_pwren: emmc-pwren {
> +				rockchip,pins = <2 RK_PC2 RK_FUNC_2 &pcfg_pull_none>;
> +			};
> +
> +			emmc_bus1: emmc-bus1 {
> +				rockchip,pins = <2 RK_PA0 RK_FUNC_2 &pcfg_pull_up_drv_8ma>;
> +			};
> +
> +			emmc_bus8: emmc-bus8 {
> +				rockchip,pins = <2 RK_PA0 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
> +						<2 RK_PA1 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
> +						<2 RK_PA2 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
> +						<2 RK_PA3 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
> +						<2 RK_PA4 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
> +						<2 RK_PA5 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
> +						<2 RK_PA6 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
> +						<2 RK_PA7 RK_FUNC_2 &pcfg_pull_up_drv_8ma>;
> +			};
> +		};
> +
>  		sdmmc {
>  			sdmmc_clk: sdmmc-clk {
>  				rockchip,pins = <3 RK_PC4 RK_FUNC_1 &pcfg_pull_none_drv_4ma>;
> 




