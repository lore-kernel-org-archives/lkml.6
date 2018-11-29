Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD21FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4742082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4742082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeK3CvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:51:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728363AbeK3CvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:51:05 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 061C188CC4085;
        Thu, 29 Nov 2018 23:45:14 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 23:45:14 +0800
Subject: Re: [PATCH 05/10] ARM64: dts: hisilicon: Add all CPUs in cooling maps
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, <arm@kernel.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
 <89bb8c62404aa875d597da89c18852ce81fb9f26.1542362530.git.viresh.kumar@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5C000983.3030609@hisilicon.com>
Date:   Thu, 29 Nov 2018 15:45:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <89bb8c62404aa875d597da89c18852ce81fb9f26.1542362530.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 2018/11/16 10:04, Viresh Kumar wrote:
> Each CPU can (and does) participate in cooling down the system but the
> DT only captures a handful of them, normally CPU0, in the cooling maps.
> Things work by chance currently as under normal circumstances its the
> first CPU of each cluster which is used by the operating systems to
> probe the cooling devices. But as soon as this CPU ordering changes and
> any other CPU is used to bring up the cooling device, we will start
> seeing failures.
> 
> Also the DT is rather incomplete when we list only one CPU in the
> cooling maps, as the hardware doesn't have any such limitations.
> 
> Update cooling maps to include all devices affected by individual trip
> points.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++--
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi |  9 ++++++++-
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index d943a96eedee..20ae40df61d5 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1118,12 +1118,18 @@
>  					map0 {
>  						trip = <&target>;
>  						contribution = <1024>;
> -						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  					};
>  					map1 {
>  						trip = <&target>;
>  						contribution = <512>;
> -						cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +						cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  					};
>  				};
>  			};
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 97d5bf2c6ec5..aec9e371c2a7 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -893,7 +893,14 @@
>  				cooling-maps {
>  					map0 {
>  						trip = <&target>;
> -						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  					};
>  				};
>  			};
> 

