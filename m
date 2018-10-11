Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F9EC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F282077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="od66QZzY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZOruL2Em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F282077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeJKR66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:58:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50514 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeJKR66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:58:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2AB7F60BFE; Thu, 11 Oct 2018 10:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539253939;
        bh=mrwyhzqcKNbAb8fUHiQZQrCE3K1xkkGGkqW099AaxhI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=od66QZzYHbpFdGZcN1vL0OCltcdlOg77hdsI6Rf7GozbaTEK6vzIOnagnp5pMOuPb
         UqAoYATP+KF0LnLU92sMGxaM8TwsgvLF8znm074Vi3bzYV3VRSAj6aspgqXW57k7j8
         E+KRHbFxUI3PqGOCakzzl0obKUpVYiUct9CWDwng=
Received: from [10.79.167.189] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 183A260A98;
        Thu, 11 Oct 2018 10:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539253938;
        bh=mrwyhzqcKNbAb8fUHiQZQrCE3K1xkkGGkqW099AaxhI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZOruL2Em70LKKyEpsouEhNZWV9hW6XiZv7DSS/kijVz+vPRlw5/1rj78lyCNcTTvo
         imSy16FI6g0urNJN7qt5CgvPCerzb/gyc/O/VY7ZbTb8Gz21EE6w7dy58/M0DhiiMZ
         WOVjXNNx0puzV2KwDNQgr8TFsDLvQlYy9gknwHcA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 183A260A98
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v8 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        evgreen@google.com
References: <1537698793-15285-1-git-send-email-tdas@codeaurora.org>
 <1537698793-15285-2-git-send-email-tdas@codeaurora.org>
 <20180927153126.GA17218@bogus>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <2578568d-e1b8-b7b5-beeb-ad485a971f2d@codeaurora.org>
Date:   Thu, 11 Oct 2018 16:01:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927153126.GA17218@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Thanks for your review comments.

On 9/27/2018 9:01 PM, Rob Herring wrote:
> On Sun, Sep 23, 2018 at 04:03:12PM +0530, Taniya Das wrote:
>> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
>> SoCs. This is required for managing the cpu frequency transitions which are
>> controlled by the hardware engine.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 169 +++++++++++++++++++++
>>   1 file changed, 169 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>> new file mode 100644
>> index 0000000..c06941c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>> @@ -0,0 +1,169 @@
>> +Qualcomm Technologies, Inc. CPUFREQ Bindings
>> +
>> +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
>> +SoCs to manage frequency in hardware. It is capable of controlling frequency
>> +for multiple clusters.
>> +
>> +Properties:
>> +- compatible
>> +	Usage:		required
>> +	Value type:	<string>
>> +	Definition:	must be "qcom,cpufreq-hw".
>> +
>> +- clocks
>> +	Usage:		required
>> +	Value type:	<phandle> From common clock binding.
>> +	Definition:	clock handle for XO clock and GPLL0 clock.
>> +
>> +- clock-names
>> +	Usage:		required
>> +	Value type:	<string> From common clock binding.
>> +	Definition:	must be "xo", "cpu_clk".
>> +
>> +- reg
>> +	Usage:		required
>> +	Value type:	<prop-encoded-array>
>> +	Definition:	Addresses and sizes for the memory of the HW bases in
>> +			each frequency domain.
>> +- reg-names
>> +	Usage:		Optional
>> +	Value type:	<string>
>> +	Definition:	Frequency domain name i.e.
>> +			"freq-domain0", "freq-domain1".
>> +
>> +* Property qcom,freq-domain
>> +Devices supporting freq-domain must set their "qcom,freq-domain" property with
>> +phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT node.
>> +
>> +
>> +Example:
>> +
>> +Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster switch
>> +DCVS state together.
>> +
>> +/ {
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
>> +		CPU0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo385";
>> +			reg = <0x0 0x0>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_0>;
>> +			qcom,freq-domain = <&cpufreq_hw 0>;
>> +			L2_0: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +				L3_0: l3-cache {
>> +				      compatible = "cache";
>> +				};
>> +			};
>> +		};
>> +
>> +		CPU1: cpu@100 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo385";
>> +			reg = <0x0 0x100>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_100>;
>> +			qcom,freq-domain = <&cpufreq_hw 0>;
>> +			L2_100: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU2: cpu@200 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo385";
>> +			reg = <0x0 0x200>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_200>;
>> +			qcom,freq-domain = <&cpufreq_hw 0>;
>> +			L2_200: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU3: cpu@300 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo385";
>> +			reg = <0x0 0x300>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_300>;
>> +			qcom,freq-domain = <&cpufreq_hw 0>;
>> +			L2_300: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU4: cpu@400 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo385";
>> +			reg = <0x0 0x400>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_400>;
>> +			qcom,freq-domain = <&cpufreq_hw 1>;
>> +			L2_400: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU5: cpu@500 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo385";
>> +			reg = <0x0 0x500>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_500>;
>> +			qcom,freq-domain = <&cpufreq_hw 1>;
>> +			L2_500: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU6: cpu@600 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo385";
>> +			reg = <0x0 0x600>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_600>;
>> +			qcom,freq-domain = <&cpufreq_hw 1>;
>> +			L2_600: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU7: cpu@700 {
>> +			device_type = "cpu";
>> +			compatible = "qcom,kryo385";
>> +			reg = <0x0 0x700>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_700>;
>> +			qcom,freq-domain = <&cpufreq_hw 1>;
>> +			L2_700: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +	};
>> +
>> + soc {
>> +	cpufreq_hw: qcom,cpufreq-hw {
> 
> Should have a unit-address and node names should be generic. We don't
> really have one for this, but let's go with 'cpufreq', so:
> 
> cpufreq@17d43000
> 

Thanks Rob, will update in the next patch.

>> +		compatible = "qcom,cpufreq-hw";
>> +		reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
>> +		reg-names = "freq-domain0", "freq-domain1";
>> +
>> +		clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
>> +		clock-names = "xo", "cpu_clk";
>> +
>> +		#freq-domains-cells = <1>
> 
> Not documented, but I don't think you need this if it is always 1 and
> because this is not a common binding.
> 

I would add it in the next patch just to keep it documented.

> Rob
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
