Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B994C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349C42081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349C42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387947AbeKFGvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:51:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45817 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFGvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:51:43 -0500
Received: by mail-ot1-f67.google.com with SMTP id g10so9456882otl.12;
        Mon, 05 Nov 2018 13:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xPvPcPFawgp5xQZ9ti8l+bNNaaP73L23IOJrkGBIAJE=;
        b=SI02AG+zj1p6d7/70qqGd71ijrCrQFW48VvrJk3jqrgREyknUuZTQ6VtbXi+UH+ES5
         hnNDvj/V7TLQBWRs1Yt4e+CizsoLik7S/yI69O8NlYBpbHrrtSl2k5cDQbD7lNkvndP7
         NHT/qRNfd79tqKT2hvzk5lJRD/crKE1ZU1T7Un/SZrpHV1hlI/O6WY8w5xs6LvuzXrEu
         jUjwjnNhS6kOmahuAzFssjq5V5a+5ZIubJEJE4Aa37MjyraRwfJ6WcIm0KLjme+G+DJn
         rwCNCT24v5jkJ33bPxru1Jwe5q1YNfsGk7NVxBxefxwl2dBmrVZvqC2WvvgHWDZzvnvR
         zN5A==
X-Gm-Message-State: AGRZ1gKbobEySAjSjbfxR/wBdftNiYbyo9JOSpK8wjKrUajE9NCRxNcg
        OXJ9r6Um8K1pkf72VTsgXA==
X-Google-Smtp-Source: AJdET5dq00a42wBonDlMY++qDBB5olhtABGZkS212eg2wbDirG4BDbkJvStwfpGiTBYxpp0iH5TT4g==
X-Received: by 2002:a9d:754f:: with SMTP id b15mr13823675otl.231.1541453402285;
        Mon, 05 Nov 2018 13:30:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l18sm16591436otb.68.2018.11.05.13.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 13:30:01 -0800 (PST)
Date:   Mon, 5 Nov 2018 15:30:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/17] dt-bindings: cpufreq: Add binding for
 NVIDIA Tegra20/30
Message-ID: <20181105213000.GA13425@bogus>
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021205501.23943-4-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 11:54:47PM +0300, Dmitry Osipenko wrote:
> Add device-tree binding that describes CPU frequency-scaling hardware
> found on NVIDIA Tegra20/30 SoC's.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> new file mode 100644
> index 000000000000..a8023ea7a99f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> @@ -0,0 +1,96 @@
> +Binding for NVIDIA Tegra20 CPUFreq
> +==================================
> +
> +Required properties:
> +- clocks: Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +  - pll_x: main-parent for CPU clock, must be the first entry
> +  - intermediate: intermediate-parent for CPU clock
> +  - cclk: the CPU clock
> +- operating-points-v2: See ../bindings/opp/opp.txt for details.
> +- #cooling-cells: Should be 2. See ../thermal/thermal.txt for details.
> +
> +For each opp entry in 'operating-points-v2' table:
> +- opp-supported-hw: Two bitfields indicating:
> +	On Tegra20:
> +	1. CPU process ID mask
> +	2. SoC speedo ID mask
> +
> +	On Tegra30:
> +	1. CPU process ID mask
> +	2. CPU speedo ID mask
> +
> +	A bitwise AND is performed against these values and if any bit
> +	matches, the OPP gets enabled.
> +
> +- opp-microvolt: CPU voltage triplet.
> +
> +Optional properties:
> +- cpu-supply: Phandle to the CPU power supply.
> +- core-supply: Phandle to the CORE power supply.
> +- rtc-supply: Phandle to the RTC power supply, required only for Tegra20.
> +
> +Voltage supply requirements:
> +- Tegra20:
> +	CORE and RTC regulators must be coupled using the regulator-coupled-with
> +	property and regulator-coupled-max-spread property must be set to no
> +	more than 170mV.
> +
> +	See ../regulator/regulator.txt for more detail about the properties.
> +
> +- Tegra30:
> +	CORE and CPU regulators must be coupled using the regulator-coupled-with
> +	property and regulator-coupled-max-spread property must be set to no
> +	more than 300mV. Each of CORE and CPU regulators must set
> +	regulator-max-step-microvolt property to no more than 100mV.
> +
> +	See ../regulator/regulator.txt for more detail about the properties.
> +
> +
> +Example:
> +	regulators {
> +		cpu_reg: regulator0 {
> +			regulator-name = "vdd_cpu";
> +		};
> +
> +		core_reg: regulator1 {
> +			regulator-name = "vdd_core";
> +			regulator-coupled-with = <&rtc_reg>;
> +			regulator-coupled-max-spread = <170000>;
> +		};
> +
> +		rtc_reg: regulator2 {
> +			regulator-name = "vdd_rtc";
> +			regulator-coupled-with = <&core_reg>;
> +			regulator-coupled-max-spread = <170000>;
> +		};
> +	};
> +
> +	cpu0_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +
> +		opp@456000000 {
> +			clock-latency-ns = <125000>;
> +			opp-microvolt = <825000 825000 1125000>;
> +			opp-supported-hw = <0x03 0x0001>;
> +			opp-hz = /bits/ 64 <456000000>;
> +		};
> +
> +		...
> +	};
> +
> +	cpus {
> +		cpu@0 {
> +			compatible = "arm,cortex-a9";
> +			clocks = <&tegra_car TEGRA20_CLK_PLL_X>,
> +				 <&tegra_car TEGRA20_CLK_PLL_P>,
> +				 <&tegra_car TEGRA20_CLK_CCLK>;
> +			clock-names = "pll_x", "intermediate", "cclk";

I still object to having clocks (and supplies) which don't reflect the 
h/w and are documented in the CA9 TRM.

> +			operating-points-v2 = <&cpu0_opp_table>;
> +			cpu-supply = <&cpu_reg>;
> +			core-supply = <&core_reg>;
> +			rtc-supply = <&rtc_reg>;

Supplies are suspect too, but perhaps supplies and power domains are 
beyond the scope of the TRM and part of the physical design.

Rob
