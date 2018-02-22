Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeBVGUa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:20:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38068 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVGU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:20:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E91A60540
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v4 3/4] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: andy.gross@linaro.org, devicetree@vger.kernel.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        sboyd@codeaurora.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org
References: <20180216060503.22006-1-rnayak@codeaurora.org>
 <20180216060503.22006-4-rnayak@codeaurora.org>
 <20180219163651.66936056@why.wild-wind.fr.eu.org>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <4b7a34ec-04f1-d0fd-be55-10b4258dbbe6@codeaurora.org>
Date: Thu, 22 Feb 2018 11:50:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180219163651.66936056@why.wild-wind.fr.eu.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/19/2018 10:06 PM, Marc Zyngier wrote:
> On Fri, 16 Feb 2018 11:35:02 +0530
> Rajendra Nayak <rnayak@codeaurora.org> wrote:
> 
>> Add a skeletal sdm845 SoC dtsi and MTP board dts/dtsi files
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  15 ++
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 277 ++++++++++++++++++++++++++++++++
>>  3 files changed, 293 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi

[...]

>> +
>> +	soc: soc {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0 0 0xffffffff>;
>> +		compatible = "simple-bus";
>> +
>> +		intc: interrupt-controller@17a00000 {
>> +			compatible = "arm,gic-v3";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +			#interrupt-cells = <3>;
>> +			interrupt-controller;
>> +			#redistributor-regions = <1>;
>> +			redistributor-stride = <0x0 0x20000>;
>> +			reg = <0x17a00000 0x10000>,     /* GICD */
>> +			      <0x17a60000 0x100000>;    /* GICR * 8 */
>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			gic-its@17a40000 {
>> +				compatible = "arm,gic-v3-its";
>> +				msi-controller;
>> +				#msi-cells = <1>;
>> +				reg = <0x17a40000 0x20000>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gcc: clock-controller@100000 {
>> +			compatible = "qcom,gcc-sdm845";
>> +			reg = <0x100000 0x1f0000>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +		};
>> +
>> +		tlmm: pinctrl@3400000 {
>> +			compatible = "qcom,sdm845-pinctrl";
>> +			reg = <0x03400000 0xc00000>;
>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_NONE>;
> 
> Please do not use IRQ_TYPE_NONE, ever. It doesn't exist in the GIC
> binding. Set it to the actual trigger value.

Thanks Marc for the review. I fixed these up and did a respin.
			

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
