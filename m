Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EFDECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B50D2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B50D2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbeGRQOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:14:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9649 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731031AbeGRQOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:14:04 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4DBD9E151F28;
        Wed, 18 Jul 2018 23:34:55 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.382.0; Wed, 18 Jul 2018
 23:34:55 +0800
Subject: Re: [PATCH] arm64: dts: hikey960: Remove deprecated MMC properties
To:     Ryan Grachek <ryan@edited.us>
References: <20180618180825.21497-1-ryan@edited.us>
CC:     <john.stultz@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B4F5E18.60703@hisilicon.com>
Date:   Wed, 18 Jul 2018 16:34:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180618180825.21497-1-ryan@edited.us>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

On 2018/6/18 19:08, Ryan Grachek wrote:
> Signed-off-by: Ryan Grachek <ryan@edited.us>

Thanks!
Applied to the hisilicon dt tree.

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 1 -
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 8 --------
>  2 files changed, 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index c706f70ce9f2..abc991619c75 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -611,7 +611,6 @@
>  	broken-cd;
>  	/* WL_EN */
>  	vmmc-supply = <&wlan_en>;
> -	ti,non-removable;
>  	non-removable;
>  	cap-power-off-card;
>  	keep-power-in-suspend;
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 484b837757f3..74c0509f99e9 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1121,7 +1121,6 @@
>  			bus-width = <0x4>;
>  			disable-wp;
>  			cap-sd-highspeed;
> -			supports-highspeed;
>  			card-detect-delay = <200>;
>  			reg = <0x0 0xff37f000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1142,12 +1141,6 @@
>  			sd-uhs-sdr50;
>  			sd-uhs-sdr104;
>  			status = "disabled";
> -
> -			slot@0 {
> -				reg = <0x0>;
> -				bus-width = <4>;
> -				disable-wp;
> -			};
>  		};
>  
>  		/* SDIO */
> @@ -1162,7 +1155,6 @@
>  			reset-names = "reset";
>  			card-detect-delay = <200>;
>  			cap-sd-highspeed;
> -			supports-highspeed;
>  			keep-power-in-suspend;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&sdio_pmx_func
> 

