Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeBGDdh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 22:33:37 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45520 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752778AbeBGDdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 22:33:35 -0500
X-Google-Smtp-Source: AH8x2271LFnnPq14drSPQd3xP22DcGGVXHU/PRaGTRa7P2E4K82ByDdOylAg9VvR81WYNecpxgXFUQ==
Date: Wed, 7 Feb 2018 09:03:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: sean.wang@mediatek.com
Cc: robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] arm64: dts: mt7622: add cpufreq related device
 nodes
Message-ID: <20180207033331.GK28462@vireshk-i7>
References: <cover.1517910489.git.sean.wang@mediatek.com>
 <fc5bdf53b92bd7a96e94b714d8d13deebca95c28.1517910489.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc5bdf53b92bd7a96e94b714d8d13deebca95c28.1517910489.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-02-18, 17:52, sean.wang@mediatek.com wrote:
>  	cpus {
>  		#address-cells = <2>;
>  		#size-cells = <0>;
> @@ -26,6 +70,10 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			reg = <0x0 0x0>;
> +			clocks = <&infracfg CLK_INFRA_MUX1_SEL>,
> +				 <&apmixedsys CLK_APMIXED_MAIN_CORE_EN>;
> +			clock-names = "cpu", "intermediate";
> +			operating-points-v2 = <&cpu_opp_table>;
>  			enable-method = "psci";
>  			clock-frequency = <1300000000>;
>  		};
> @@ -34,6 +82,7 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53", "arm,armv8";
>  			reg = <0x0 0x1>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  			enable-method = "psci";
>  			clock-frequency = <1300000000>;
>  		};

Sorry for not picking this earlier, but you should probably add the same clock
related properties for both cpu nodes here. Things will break if CPU1 is used by
the cpufreq core to bring the cpufreq policy online.

This can happen if cpufreq driver is a module, CPU0 is hotplugged out and then
the cpufreq driver is inserted.

-- 
viresh
