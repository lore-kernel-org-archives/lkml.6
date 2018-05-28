Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbeE1JXi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:23:38 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:56496 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754090AbeE1JXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:23:36 -0400
Date: Mon, 28 May 2018 11:23:32 +0200
From: Simon Horman <horms@verge.net.au>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH 13/15] arm: dts: r8a7743: Add missing OPP properties for
 CPUs
Message-ID: <20180528092331.3jon45nsqfdzs5ds@verge.net.au>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <5821a6dbe413b5a217ca1e24ddf8ebfa63ba6ef0.1527244201.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5821a6dbe413b5a217ca1e24ddf8ebfa63ba6ef0.1527244201.git.viresh.kumar@linaro.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Biju Das]

On Fri, May 25, 2018 at 04:01:59PM +0530, Viresh Kumar wrote:
> The OPP properties, like "operating-points", should either be present
> for all the CPUs of a cluster or none. If these are present only for a
> subset of CPUs of a cluster then things will start falling apart as soon
> as the CPUs are brought online in a different order. For example, this
> will happen because the operating system looks for such properties in
> the CPU node it is trying to bring up, so that it can create an OPP
> table.
> 
> Add such missing properties.
> 
> Fix other missing property (clock latency) as well to make it all
> work.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks, this looks good to me and it looks like it should have:

Fixes: 0417814ea140 ("ARM: dts: r8a7743: Add OPP table for frequency scaling")

Biju, as the author of the above patch could you take a look over this fix?

> ---
>  arch/arm/boot/dts/r8a7743.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
> index 142949d7066f..e4fb31c4f0ee 100644
> --- a/arch/arm/boot/dts/r8a7743.dtsi
> +++ b/arch/arm/boot/dts/r8a7743.dtsi
> @@ -98,8 +98,17 @@
>  			reg = <1>;
>  			clock-frequency = <1500000000>;
>  			clocks = <&cpg CPG_CORE R8A7743_CLK_Z>;
> +			clock-latency = <300000>; /* 300 us */
>  			power-domains = <&sysc R8A7743_PD_CA15_CPU1>;
>  			next-level-cache = <&L2_CA15>;
> +
> +			/* kHz - uV - OPPs unknown yet */
> +			operating-points = <1500000 1000000>,
> +					   <1312500 1000000>,
> +					   <1125000 1000000>,
> +					   < 937500 1000000>,
> +					   < 750000 1000000>,
> +					   < 375000 1000000>;
>  		};
>  
>  		L2_CA15: cache-controller-0 {
> -- 
> 2.15.0.194.g9af6a3dea062
> 
