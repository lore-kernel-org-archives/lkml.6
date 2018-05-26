Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032332AbeEZSAg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 14:00:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60902 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032112AbeEZSAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 14:00:34 -0400
Subject: Re: [PATCH 3/6] arm64: dts: hisilicon: Add missing cooling device
 properties for CPUs
To: Viresh Kumar <viresh.kumar@linaro.org>, <arm@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <0754957a2c3842cf4e36fa27231d327fd8d6d499.1527225682.git.viresh.kumar@linaro.org>
CC: Vincent Guittot <vincent.guittot@linaro.org>,
        <ionela.voinescu@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
        <chris.redpath@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B09A0B4.2080400@hisilicon.com>
Date: Sat, 26 May 2018 19:00:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <0754957a2c3842cf4e36fa27231d327fd8d6d499.1527225682.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.84.85]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 2018/5/25 6:40, Viresh Kumar wrote:
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
> Do minor rearrangement as well to keep ordering consistent.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!
Applied to the hisilicon fix tree.

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 586b281cd531..247024df714f 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -88,8 +88,8 @@
>  			next-level-cache = <&CLUSTER0_L2>;
>  			clocks = <&stub_clock 0>;
>  			operating-points-v2 = <&cpu_opp_table>;
> -			#cooling-cells = <2>; /* min followed by max */
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
>  			dynamic-power-coefficient = <311>;
>  		};
>  
> @@ -101,6 +101,8 @@
>  			next-level-cache = <&CLUSTER0_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		cpu2: cpu@2 {
> @@ -111,6 +113,8 @@
>  			next-level-cache = <&CLUSTER0_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		cpu3: cpu@3 {
> @@ -121,6 +125,8 @@
>  			next-level-cache = <&CLUSTER0_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		cpu4: cpu@100 {
> @@ -131,6 +137,8 @@
>  			next-level-cache = <&CLUSTER1_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		cpu5: cpu@101 {
> @@ -141,6 +149,8 @@
>  			next-level-cache = <&CLUSTER1_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		cpu6: cpu@102 {
> @@ -151,6 +161,8 @@
>  			next-level-cache = <&CLUSTER1_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		cpu7: cpu@103 {
> @@ -161,6 +173,8 @@
>  			next-level-cache = <&CLUSTER1_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		CLUSTER0_L2: l2-cache0 {
> 
