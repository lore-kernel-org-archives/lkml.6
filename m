Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDE3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B071B20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B071B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbeGRQMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:12:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47291 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730383AbeGRQMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:12:09 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0627B8F04E51C;
        Wed, 18 Jul 2018 23:33:36 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Wed, 18 Jul 2018
 23:33:30 +0800
Subject: Re: [PATCH] arm64: dts: hikey960: Remove keep-power-in-suspend
 property
To:     Ryan Grachek <ryan@edited.us>
References: <20180713155348.24343-1-ryan@edited.us>
CC:     <john.stultz@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B4F5DC4.5010500@hisilicon.com>
Date:   Wed, 18 Jul 2018 16:33:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180713155348.24343-1-ryan@edited.us>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

On 2018/7/13 16:53, Ryan Grachek wrote:
> Remove the keep-power-in-suspend property because it keeps wifi power
> on during suspend. This property is only required when enabling WoWLAN
> and should only be enabled based on need. Also remove dupplicate property
> 
> Signed-off-by: Ryan Grachek <ryan@edited.us>

Thanks!
Applied to the hisilicon dt tree.

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 1 -
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index 68c5a6c819ae..a927ce4ec40b 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -586,7 +586,6 @@
>  	ti,non-removable;
>  	non-removable;
>  	cap-power-off-card;
> -	keep-power-in-suspend;
>  	#address-cells = <0x1>;
>  	#size-cells = <0x0>;
>  	status = "ok";
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 8d477dcbfa58..4588fe4e00a8 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1050,7 +1050,6 @@
>  			reset-names = "reset";
>  			card-detect-delay = <200>;
>  			supports-highspeed;
> -			keep-power-in-suspend;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&sdio_pmx_func
>  				     &sdio_clk_cfg_func
> 

