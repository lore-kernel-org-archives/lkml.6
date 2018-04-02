Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbeDBF1e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 01:27:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56182 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeDBF1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 01:27:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF8C8607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v5 03/13] ARM: dts: ipq4019: Add a few peripheral nodes
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: mark.rutland@arm.com, robh@kernel.org, devicetree@vger.kernel.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        richardcochran@gmail.com, will.deacon@arm.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        absahu@codeaurora.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        linux-soc@vger.kernel.org, sboyd@codeaurora.org,
        linux-arm-kernel@lists.infradead.org
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-4-git-send-email-sricharan@codeaurora.org>
 <20180327165059.GE1403@tuxbook-pro>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <83fc1482-1867-f66a-78ec-b47ba856f815@codeaurora.org>
Date: Mon, 2 Apr 2018 10:57:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327165059.GE1403@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
  Thanks a lot for all the reviews.

On 3/27/2018 10:20 PM, Bjorn Andersson wrote:
> On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
>> @@ -172,6 +180,22 @@
>>  			clock-names = "core", "iface";
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>> +			dmas = <&blsp_dma 5>, <&blsp_dma 4>;
>> +			dma-names = "rx", "tx";
>> +			status = "disabled";
>> +		};
>> +
>> +		spi_1: spi@78b6000 { /* BLSP1 QUP2 */
>> +			compatible = "qcom,spi-qup-v2.2.1";
>> +			reg = <0x78b6000 0x600>;
>> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
>> +				<&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			dmas = <&blsp_dma 7>, <&blsp_dma 6>;
>> +			dma-names = "rx", "tx";
>>  			status = "disabled";
>>  		};
>>  
>> @@ -184,9 +208,24 @@
>>  			clock-names = "iface", "core";
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>> +			dmas = <&blsp_dma 9>, <&blsp_dma 8>;
>> +			dma-names = "rx", "tx";
>>  			status = "disabled";
>>  		};
>>  
>> +		i2c_1: i2c@78b8000 { /* BLSP1 QUP4 */
> 
> The label, comment and the core clock disagrees on which qup this is.
> 
> Label your nodes based on the SoC naming, not your board - as this will
> prevent a future board from using e.g. blsp1 qup2 as i2c (as you already
> used the label for that).

Sure. will fix. Infact this is QUP3.

> 
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x78b8000 0x600>;
>> +			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
>> +				 <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
> 
> QUP4?

 QUP3

> 
>> +			clock-names = "iface", "core";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			dmas = <&blsp_dma 11>, <&blsp_dma 10>;
>> +			dma-names = "rx", "tx";
>> +			status = "disabled";
>> +		};
> 
> Apart from this the patch looks good.

 Thanks.

Regards,
  Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
