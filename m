Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF53ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDAB2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdqCVp6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDAB2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeKICZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:25:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39342 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeKICZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:25:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so14681320lfh.6;
        Thu, 08 Nov 2018 08:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zXnRXOfnvVT0kIMLcmYurg6s0QlYf/CqB1SBtFRg1cM=;
        b=VdqCVp6OgS5jIsHCb+hkr945Jln6ZrRtVT9dmJXFaeoSglquVIDOiEm95ZPAsj4SN9
         0mrmvW3bAZT/hZng9vxlcwPCTnsOXIirLAnzYyFH4xgZVyr8UIJOy8nLLQDBVmKA58ec
         uRwFaQxt9RXhjnlmDQ4dSZIkPgOVc6ZYHKHiae3i6gg+cv0+sbc8RpOHxV+2qQRE7WzZ
         +ZkCKPIR0i9rr6OSEIElVnW1Xcb8wK5Jk93SyKRAq6ICyWwBz8igY4u9sbFx/nrhiwP2
         tSc4WxVbcNK2CsRDerhspNNC8g+4Q5wOkLggQmMGfoek7UZsWtcHdS4VktYAU3oZZZV4
         wJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zXnRXOfnvVT0kIMLcmYurg6s0QlYf/CqB1SBtFRg1cM=;
        b=HRWtPvqkOC/2v0aD8swOiXvlLIhLa3FRuFlz6DRdd7SX+11M+7gwtEalMbWpsGDnnu
         bHtQhPkEmjBpm+xU6YGxV4PJEvQAiT8N9vHpj7F4qMX7ohKVuNGkn9L/Z6a4IPGmM3Lu
         QFouUarcnmsRQAbP1ktETXhu8zdogvZdNwKlad15dXPjbSGEisWPX0AZWn/tkAclDMWY
         ANhtqZ3rYIafORYO5FWqS8hdRC5s2Xi4Wz3yY4Q1p353CKDC6R1BhRA4yeeFH9VJb/cG
         xgyV37hmhri122lpBUwMgVI/o+wJqEdicMudMMFQpIXb5oMoAezvckmv8KHTqP3Bi4Nu
         P79Q==
X-Gm-Message-State: AGRZ1gKrjWkKD6eNyxuaFwEJ1ijtnPKS4vFIMxu6Mfqk3uyGTAgzCvUi
        Hn9VXVtbcVyKPhZ4Y20Ygx/qWVlW
X-Google-Smtp-Source: AJdET5eGB2r40VzH4GZvBpMYw0BqqjU8uvEOaQu/27yL/fKPoQanQiTa5EnhWZhZzJ4AMMMsuyrLrw==
X-Received: by 2002:a19:4287:: with SMTP id p129mr3358044lfa.135.1541695740228;
        Thu, 08 Nov 2018 08:49:00 -0800 (PST)
Received: from [192.168.2.145] (109-252-91-202.nat.spd-mgts.ru. [109.252.91.202])
        by smtp.googlemail.com with ESMTPSA id j13-v6sm758668ljh.42.2018.11.08.08.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 08:48:59 -0800 (PST)
Subject: Re: [RFC PATCH v2 03/17] dt-bindings: cpufreq: Add binding for NVIDIA
 Tegra20/30
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-4-digetx@gmail.com> <20181105213000.GA13425@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0fc53853-862c-4cc3-6548-d347bc68bdd6@gmail.com>
Date:   Thu, 8 Nov 2018 19:48:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181105213000.GA13425@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.11.2018 0:30, Rob Herring wrote:
> On Sun, Oct 21, 2018 at 11:54:47PM +0300, Dmitry Osipenko wrote:
>> Add device-tree binding that describes CPU frequency-scaling hardware
>> found on NVIDIA Tegra20/30 SoC's.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 96 +++++++++++++++++++
>>  1 file changed, 96 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>> new file mode 100644
>> index 000000000000..a8023ea7a99f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>> @@ -0,0 +1,96 @@
>> +Binding for NVIDIA Tegra20 CPUFreq
>> +==================================
>> +
>> +Required properties:
>> +- clocks: Must contain an entry for each entry in clock-names.
>> +  See ../clocks/clock-bindings.txt for details.
>> +- clock-names: Must include the following entries:
>> +  - pll_x: main-parent for CPU clock, must be the first entry
>> +  - intermediate: intermediate-parent for CPU clock
>> +  - cclk: the CPU clock
>> +- operating-points-v2: See ../bindings/opp/opp.txt for details.
>> +- #cooling-cells: Should be 2. See ../thermal/thermal.txt for details.
>> +
>> +For each opp entry in 'operating-points-v2' table:
>> +- opp-supported-hw: Two bitfields indicating:
>> +	On Tegra20:
>> +	1. CPU process ID mask
>> +	2. SoC speedo ID mask
>> +
>> +	On Tegra30:
>> +	1. CPU process ID mask
>> +	2. CPU speedo ID mask
>> +
>> +	A bitwise AND is performed against these values and if any bit
>> +	matches, the OPP gets enabled.
>> +
>> +- opp-microvolt: CPU voltage triplet.
>> +
>> +Optional properties:
>> +- cpu-supply: Phandle to the CPU power supply.
>> +- core-supply: Phandle to the CORE power supply.
>> +- rtc-supply: Phandle to the RTC power supply, required only for Tegra20.
>> +
>> +Voltage supply requirements:
>> +- Tegra20:
>> +	CORE and RTC regulators must be coupled using the regulator-coupled-with
>> +	property and regulator-coupled-max-spread property must be set to no
>> +	more than 170mV.
>> +
>> +	See ../regulator/regulator.txt for more detail about the properties.
>> +
>> +- Tegra30:
>> +	CORE and CPU regulators must be coupled using the regulator-coupled-with
>> +	property and regulator-coupled-max-spread property must be set to no
>> +	more than 300mV. Each of CORE and CPU regulators must set
>> +	regulator-max-step-microvolt property to no more than 100mV.
>> +
>> +	See ../regulator/regulator.txt for more detail about the properties.
>> +
>> +
>> +Example:
>> +	regulators {
>> +		cpu_reg: regulator0 {
>> +			regulator-name = "vdd_cpu";
>> +		};
>> +
>> +		core_reg: regulator1 {
>> +			regulator-name = "vdd_core";
>> +			regulator-coupled-with = <&rtc_reg>;
>> +			regulator-coupled-max-spread = <170000>;
>> +		};
>> +
>> +		rtc_reg: regulator2 {
>> +			regulator-name = "vdd_rtc";
>> +			regulator-coupled-with = <&core_reg>;
>> +			regulator-coupled-max-spread = <170000>;
>> +		};
>> +	};
>> +
>> +	cpu0_opp_table: opp_table0 {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp@456000000 {
>> +			clock-latency-ns = <125000>;
>> +			opp-microvolt = <825000 825000 1125000>;
>> +			opp-supported-hw = <0x03 0x0001>;
>> +			opp-hz = /bits/ 64 <456000000>;
>> +		};
>> +
>> +		...
>> +	};
>> +
>> +	cpus {
>> +		cpu@0 {
>> +			compatible = "arm,cortex-a9";
>> +			clocks = <&tegra_car TEGRA20_CLK_PLL_X>,
>> +				 <&tegra_car TEGRA20_CLK_PLL_P>,
>> +				 <&tegra_car TEGRA20_CLK_CCLK>;
>> +			clock-names = "pll_x", "intermediate", "cclk";
> 
> I still object to having clocks (and supplies) which don't reflect the 
> h/w and are documented in the CA9 TRM.
> 
>> +			operating-points-v2 = <&cpu0_opp_table>;
>> +			cpu-supply = <&cpu_reg>;
>> +			core-supply = <&core_reg>;
>> +			rtc-supply = <&rtc_reg>;
> 
> Supplies are suspect too, but perhaps supplies and power domains are 
> beyond the scope of the TRM and part of the physical design.

Is it possible to have a "firmware" device-tree node specifically for cpufreq driver? Something like this:

cpufreq {
	compatible = "nvidia,tegra20-cpufreq";
	clocks = <&tegra_car TEGRA20_CLK_PLL_X>,
		 <&tegra_car TEGRA20_CLK_PLL_P>;
	clock-names = "pll_x", "intermediate";
};

We may also need a Tegra-specific DVFS helper-driver that will help to manage CPU-CORE voltage dependency. Yet I'll have to examine this all in more details, but maybe it will be nicer if DVFS could be instantiated via device-tree as well. It will provide a Tegra-specific DVFS API and manage CORE / RTC dependencies for the CPUFreq and peripheral drivers, also helping to maintain proper voltages during kernel boot-up until all drivers are brought into action.

cpufreq {
	compatible = "nvidia,tegra20-dvfs";
	cpu-supply = <&cpu_vdd_reg>;
	core-supply = <&core_vdd_reg>;
	rtc-supply = <&rtc_vdd_reg>;
};

So my question is:

Is it possible to have device-tree nodes that solely describe firmware? Kernel drivers in this case.
