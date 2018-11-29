Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020F5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68E2213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68E2213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeK3Cuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:50:37 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39793 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728363AbeK3Cug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:50:36 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 348668AB5E2B5;
        Thu, 29 Nov 2018 23:44:47 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 23:44:47 +0800
Subject: Re: [PATCH 04/10] arm64: dts: hi3660: Add missing cooling device
 properties for CPUs
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, <arm@kernel.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
 <042e5e647a7b54f4322024f1b3e286b6b6d69175.1542362530.git.viresh.kumar@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5C000967.7070103@hisilicon.com>
Date:   Thu, 29 Nov 2018 15:44:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <042e5e647a7b54f4322024f1b3e286b6b6d69175.1542362530.git.viresh.kumar@linaro.org>
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
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
> 
> Add such missing properties.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index f432b0a88c65..d943a96eedee 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -79,6 +79,7 @@
>  			capacity-dmips-mhz = <592>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
>  			operating-points-v2 = <&cluster0_opp>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu2: cpu@2 {
> @@ -91,6 +92,7 @@
>  			capacity-dmips-mhz = <592>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
>  			operating-points-v2 = <&cluster0_opp>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu3: cpu@3 {
> @@ -103,6 +105,7 @@
>  			capacity-dmips-mhz = <592>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
>  			operating-points-v2 = <&cluster0_opp>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu4: cpu@100 {
> @@ -129,6 +132,7 @@
>  			capacity-dmips-mhz = <1024>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
>  			operating-points-v2 = <&cluster1_opp>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu6: cpu@102 {
> @@ -141,6 +145,7 @@
>  			capacity-dmips-mhz = <1024>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
>  			operating-points-v2 = <&cluster1_opp>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu7: cpu@103 {
> @@ -153,6 +158,7 @@
>  			capacity-dmips-mhz = <1024>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
>  			operating-points-v2 = <&cluster1_opp>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		idle-states {
> 

