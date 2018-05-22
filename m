Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeEVPvw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:51:52 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37935 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751272AbeEVPvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:51:46 -0400
Subject: Re: [PATCH v2 3/3] ARM: dts: stm32: Add ADC support to stm32mp157c
To: Jonathan Cameron <jic23@kernel.org>, <alexandre.torgue@st.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>
References: <1525247091-18143-1-git-send-email-fabrice.gasnier@st.com>
 <1525247091-18143-4-git-send-email-fabrice.gasnier@st.com>
 <20180507182317.7406c682@archlinux>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <cf74dc2b-ba17-be3d-b3ca-7cda515bf7a6@st.com>
Date: Tue, 22 May 2018 17:51:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507182317.7406c682@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 07:23 PM, Jonathan Cameron wrote:
> On Wed, 2 May 2018 09:44:51 +0200
> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> 
>> stm32mp157c has an ADC block with two physical ADCs.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> The driver support is now queued up in the IIO tree and should
> be in Linux next later this week.

Hi,

Many Thanks Jonathan :-)

Alex, I just sent an updated version (v3) of this patch (with additional
dmas).

Best Regards,
Fabrice

> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  arch/arm/boot/dts/stm32mp157c.dtsi | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
>> index bc3eddc..7758a90 100644
>> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
>> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
>> @@ -160,6 +160,38 @@
>>  			status = "disabled";
>>  		};
>>  
>> +		adc: adc@48003000 {
>> +			compatible = "st,stm32mp1-adc-core";
>> +			reg = <0x48003000 0x400>;
>> +			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&rcc ADC12>, <&rcc ADC12_K>;
>> +			clock-names = "bus", "adc";
>> +			interrupt-controller;
>> +			#interrupt-cells = <1>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +
>> +			adc1: adc@0 {
>> +				compatible = "st,stm32mp1-adc";
>> +				#io-channel-cells = <1>;
>> +				reg = <0x0>;
>> +				interrupt-parent = <&adc>;
>> +				interrupts = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			adc2: adc@100 {
>> +				compatible = "st,stm32mp1-adc";
>> +				#io-channel-cells = <1>;
>> +				reg = <0x100>;
>> +				interrupt-parent = <&adc>;
>> +				interrupts = <1>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>>  		rcc: rcc@50000000 {
>>  			compatible = "st,stm32mp1-rcc", "syscon";
>>  			reg = <0x50000000 0x1000>;
> 
