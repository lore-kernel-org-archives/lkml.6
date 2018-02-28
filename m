Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeB1FIT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 00:08:19 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39230 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbeB1FIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 00:08:17 -0500
X-Google-Smtp-Source: AG47ELsynDxh9HfDhOO/EpiuzESg5c+VK1nkR6qMQPbnYqHmUpoExm1L/kwXKNCxtO2ovUI4vs7mOA==
Date: Wed, 28 Feb 2018 13:08:04 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Wang <jean.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] arm64: dts: Hi3660: Remove 'CPU_NAP' idle state
Message-ID: <20180228050803.GB20745@leoy-ThinkPad-T440>
References: <1515472362-19979-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515472362-19979-1-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Tue, Jan 09, 2018 at 12:32:42PM +0800, Leo Yan wrote:
> Thanks a lot for Vincent Guittot careful work to find bug for 'CPU_NAP'
> idle state.  At early time, the CPU CA73 CPU_NAP idle state has been
> supported on Hikey960.  Later we found the system has the hang issue
> and for resolving this issue Hisilicon released new MCU firmware, but
> unfortunately the new MCU firmware has side effect and results in the
> CA73 CPU cannot really enter CPU_NAP state and roll back to WFI state.
> 
> After discussion we cannot see the possibility to enable CA73 CPU_NAP
> state anymore on Hikey960, based on this conclusion we should remove
> this state from DT binding.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Kevin Wang <jean.wangtao@linaro.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Could you help to pick up this patch? Thanks!

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 32 ++++---------------------------
>  1 file changed, 4 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index ab0b95b..8fddf0d 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -96,11 +96,7 @@
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
>  			next-level-cache = <&A73_L2>;
> -			cpu-idle-states = <
> -					&CPU_NAP
> -					&CPU_SLEEP
> -					&CLUSTER_SLEEP_1
> -			>;
> +			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
>  		};
>  
>  		cpu5: cpu@101 {
> @@ -109,11 +105,7 @@
>  			reg = <0x0 0x101>;
>  			enable-method = "psci";
>  			next-level-cache = <&A73_L2>;
> -			cpu-idle-states = <
> -					&CPU_NAP
> -					&CPU_SLEEP
> -					&CLUSTER_SLEEP_1
> -			>;
> +			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
>  		};
>  
>  		cpu6: cpu@102 {
> @@ -122,11 +114,7 @@
>  			reg = <0x0 0x102>;
>  			enable-method = "psci";
>  			next-level-cache = <&A73_L2>;
> -			cpu-idle-states = <
> -					&CPU_NAP
> -					&CPU_SLEEP
> -					&CLUSTER_SLEEP_1
> -			>;
> +			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
>  		};
>  
>  		cpu7: cpu@103 {
> @@ -135,24 +123,12 @@
>  			reg = <0x0 0x103>;
>  			enable-method = "psci";
>  			next-level-cache = <&A73_L2>;
> -			cpu-idle-states = <
> -					&CPU_NAP
> -					&CPU_SLEEP
> -					&CLUSTER_SLEEP_1
> -			>;
> +			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
>  		};
>  
>  		idle-states {
>  			entry-method = "psci";
>  
> -			CPU_NAP: cpu-nap {
> -				compatible = "arm,idle-state";
> -				arm,psci-suspend-param = <0x0000001>;
> -				entry-latency-us = <7>;
> -				exit-latency-us = <2>;
> -				min-residency-us = <15>;
> -			};
> -
>  			CPU_SLEEP: cpu-sleep {
>  				compatible = "arm,idle-state";
>  				local-timer-stop;
> -- 
> 2.7.4
> 
