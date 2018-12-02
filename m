Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23F1C04EB9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F67D2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R/5AhqRc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IX0t9Zxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F67D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbeLBDnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:43:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60834 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLBDny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:43:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 72BA460B1E; Sun,  2 Dec 2018 03:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543722232;
        bh=OoHyfsuLAWgIe1sUg39Sveh9ihrnAhjJVzQiGxb/tG0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=R/5AhqRcdjzj//eHXOyhzp1Hp5cHYKf51Zu38dh3GbXNn+dntKmY9LWv8jTsj4Ot3
         RrOW8ycjDdW0hMpv744XYcxcBGP3qHHdbWiwNGihn+loF7eKW9XJKbLei6M44xKMaV
         Bvy3sA/bZqsnMDiA8uZdNsk7afkyq9dotaWSxM9w=
Received: from [192.168.225.247] (unknown [49.33.158.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E26E160481;
        Sun,  2 Dec 2018 03:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543722231;
        bh=OoHyfsuLAWgIe1sUg39Sveh9ihrnAhjJVzQiGxb/tG0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IX0t9ZxeFuprFxT7vOFx1QyhdQE+9CFH6dQeK+mhGi0quKRyLCQXXQLois4550mgI
         RaBpyw2G68rSgMOvXvH+Yl4lkCYJatdURdlwnW7GhPzj1ELuups2bVkpG+FbTo0m8D
         jA51ob8nhsexKZ+7ax/wdz3Z1KfnGs23k8dILM8c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E26E160481
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v10 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
To:     Rob Herring <robh@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        evgreen@google.com
References: <1542796967-5949-1-git-send-email-tdas@codeaurora.org>
 <1542796967-5949-2-git-send-email-tdas@codeaurora.org>
 <20181121180236.GS22824@google.com> <20181126185808.GA32621@bogus>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <bb1f83af-13db-cd62-6868-2d34beefdace@codeaurora.org>
Date:   Sun, 2 Dec 2018 09:13:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181126185808.GA32621@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 11/27/2018 12:28 AM, Rob Herring wrote:
> On Wed, Nov 21, 2018 at 10:02:36AM -0800, Matthias Kaehlcke wrote:
>> On Wed, Nov 21, 2018 at 04:12:46PM +0530, Taniya Das wrote:
>>> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
>>> SoCs. This is required for managing the cpu frequency transitions which are
>>> controlled by the hardware engine.
>>>
>>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>>> ---
>>>   .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 +++++++++++++++++++++
>>>   1 file changed, 172 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>>> new file mode 100644
>>> index 0000000..90e396b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>>> @@ -0,0 +1,172 @@
>>> +Qualcomm Technologies, Inc. CPUFREQ Bindings
>>> +
>>> +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
>>> +SoCs to manage frequency in hardware. It is capable of controlling frequency
>>> +for multiple clusters.
>>> +
>>> +Properties:
>>> +- compatible
>>> +	Usage:		required
>>> +	Value type:	<string>
>>> +	Definition:	must be "qcom,cpufreq-hw".
>>> +
>>> +- clocks
>>> +	Usage:		required
>>> +	Value type:	<phandle> From common clock binding.
>>> +	Definition:	clock handle for XO clock and GPLL0 clock.
>>> +
>>> +- clock-names
>>> +	Usage:		required
>>> +	Value type:	<string> From common clock binding.
>>> +	Definition:	must be "xo", "cpu_clk".
>>> +
>>> +- reg
>>> +	Usage:		required
>>> +	Value type:	<prop-encoded-array>
>>> +	Definition:	Addresses and sizes for the memory of the HW bases in
>>> +			each frequency domain.
>>> +- reg-names
>>> +	Usage:		Optional
>>> +	Value type:	<string>
>>> +	Definition:	Frequency domain name i.e.
>>> +			"freq-domain0", "freq-domain1".
>>> +
>>> +- freq-domain-cells:
>>> +	Usage:		required.
>>> +	Definition:	Number of cells in a freqency domain specifier.
>>> +
>>> +* Property qcom,freq-domain
>>> +Devices supporting freq-domain must set their "qcom,freq-domain" property with
>>> +phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT node.
>>> +
>>> +
>>> +Example:
>>> +
>>> +Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster switch
>>> +DCVS state together.
>>> +
>>> +/ {
>>> +	cpus {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <0>;
>>> +
>>> +		CPU0: cpu@0 {
>>> +			device_type = "cpu";
>>> +			compatible = "qcom,kryo385";
>>> +			reg = <0x0 0x0>;
>>> +			enable-method = "psci";
>>> +			next-level-cache = <&L2_0>;
>>> +			qcom,freq-domain = <&cpufreq_hw 0>;
>>> +			L2_0: l2-cache {
>>> +				compatible = "cache";
>>> +				next-level-cache = <&L3_0>;
>>> +				L3_0: l3-cache {
>>> +				      compatible = "cache";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		CPU1: cpu@100 {
>>> +			device_type = "cpu";
>>> +			compatible = "qcom,kryo385";
>>> +			reg = <0x0 0x100>;
>>> +			enable-method = "psci";
>>> +			next-level-cache = <&L2_100>;
>>> +			qcom,freq-domain = <&cpufreq_hw 0>;
>>> +			L2_100: l2-cache {
>>> +				compatible = "cache";
>>> +				next-level-cache = <&L3_0>;
>>> +			};
>>> +		};
>>> +
>>> +		CPU2: cpu@200 {
>>> +			device_type = "cpu";
>>> +			compatible = "qcom,kryo385";
>>> +			reg = <0x0 0x200>;
>>> +			enable-method = "psci";
>>> +			next-level-cache = <&L2_200>;
>>> +			qcom,freq-domain = <&cpufreq_hw 0>;
>>> +			L2_200: l2-cache {
>>> +				compatible = "cache";
>>> +				next-level-cache = <&L3_0>;
>>> +			};
>>> +		};
>>> +
>>> +		CPU3: cpu@300 {
>>> +			device_type = "cpu";
>>> +			compatible = "qcom,kryo385";
>>> +			reg = <0x0 0x300>;
>>> +			enable-method = "psci";
>>> +			next-level-cache = <&L2_300>;
>>> +			qcom,freq-domain = <&cpufreq_hw 0>;
>>> +			L2_300: l2-cache {
>>> +				compatible = "cache";
>>> +				next-level-cache = <&L3_0>;
>>> +			};
>>> +		};
>>> +
>>> +		CPU4: cpu@400 {
>>> +			device_type = "cpu";
>>> +			compatible = "qcom,kryo385";
>>> +			reg = <0x0 0x400>;
>>> +			enable-method = "psci";
>>> +			next-level-cache = <&L2_400>;
>>> +			qcom,freq-domain = <&cpufreq_hw 1>;
>>> +			L2_400: l2-cache {
>>> +				compatible = "cache";
>>> +				next-level-cache = <&L3_0>;
>>> +			};
>>> +		};
>>> +
>>> +		CPU5: cpu@500 {
>>> +			device_type = "cpu";
>>> +			compatible = "qcom,kryo385";
>>> +			reg = <0x0 0x500>;
>>> +			enable-method = "psci";
>>> +			next-level-cache = <&L2_500>;
>>> +			qcom,freq-domain = <&cpufreq_hw 1>;
>>> +			L2_500: l2-cache {
>>> +				compatible = "cache";
>>> +				next-level-cache = <&L3_0>;
>>> +			};
>>> +		};
>>> +
>>> +		CPU6: cpu@600 {
>>> +			device_type = "cpu";
>>> +			compatible = "qcom,kryo385";
>>> +			reg = <0x0 0x600>;
>>> +			enable-method = "psci";
>>> +			next-level-cache = <&L2_600>;
>>> +			qcom,freq-domain = <&cpufreq_hw 1>;
>>> +			L2_600: l2-cache {
>>> +				compatible = "cache";
>>> +				next-level-cache = <&L3_0>;
>>> +			};
>>> +		};
>>> +
>>> +		CPU7: cpu@700 {
>>> +			device_type = "cpu";
>>> +			compatible = "qcom,kryo385";
>>> +			reg = <0x0 0x700>;
>>> +			enable-method = "psci";
>>> +			next-level-cache = <&L2_700>;
>>> +			qcom,freq-domain = <&cpufreq_hw 1>;
>>> +			L2_700: l2-cache {
>>> +				compatible = "cache";
>>> +				next-level-cache = <&L3_0>;
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> + soc {
>>> +	cpufreq_hw: cpufreq@17d43000 {
>>> +		compatible = "qcom,cpufreq-hw";
>>> +		reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
>>> +		reg-names = "freq-domain0", "freq-domain1";
>>> +
>>> +		clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
>>> +		clock-names = "xo", "gcc_cpuss_gpll0_clk_src";
>>
>> I don't have/find the document with the clock configuration of this
>> IP block, but the 'clock-names' sound more like aliases for the actual
>> clocks specified in the 'clocks' property (especially
>> 'gcc_cpuss_gpll0_clk_src') than input signals from the IP POV, which
>> I'd expect to have more generic names.
> 
> Also, this doesn't match the documented value above.
> 
> Rob
> 

Thanks, updated it in the latest patch.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
