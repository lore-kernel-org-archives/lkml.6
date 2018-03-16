Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeCPMk7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:40:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41432 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeCPMk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:40:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 554916016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v2 02/13] ARM: dts: ipq4019: Add a few peripheral nodes
To: Marc Zyngier <marc.zyngier@arm.com>, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, catalin.marinas@arm.com,
        will.deacon@arm.com, sboyd@codeaurora.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
 <1521193101-4586-3-git-send-email-sricharan@codeaurora.org>
 <eb50deb1-0530-866f-502e-e675cdd1e732@arm.com>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <e8b8c76f-c684-de9d-a315-1051017dcdef@codeaurora.org>
Date: Fri, 16 Mar 2018 18:10:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <eb50deb1-0530-866f-502e-e675cdd1e732@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 3/16/2018 5:47 PM, Marc Zyngier wrote:
> On 16/03/18 09:38, Sricharan R wrote:
>> Now with the driver updates for some peripherals being there,
>> add i2c, spi, pcie, bam, qpic-nand, scm nodes to enhance the available
>> peripheral support.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 134 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 134 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
>> index 10d112a..e38fffa 100644
>> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
>> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
>> @@ -25,7 +25,9 @@
> 
> [...]
> 
>> +		pcie0: pci@40000000 {
>> +			compatible = "qcom,pcie-ipq4019", "snps,dw-pcie";
>> +			reg =  <0x40000000 0xf1d
>> +				0x40000f20 0xa8
>> +				0x80000 0x2000
>> +				0x40100000 0x1000>;
>> +			reg-names = "dbi", "elbi", "parf", "config";
>> +			device_type = "pci";
>> +			linux,pci-domain = <0>;
>> +			bus-range = <0x00 0xff>;
>> +			num-lanes = <1>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			ranges = <0x81000000 0 0x40200000 0x40200000 0 0x00100000
>> +				  0x82000000 0 0x48000000 0x48000000 0 0x10000000>;
>> +
>> +			interrupts = <GIC_SPI 141 IRQ_TYPE_NONE>;
> 
> There is no such thing as IRQ_TYPE_NONE. Please replace this with the
> actual trigger information.

 ok, will update this.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
