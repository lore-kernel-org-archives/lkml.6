Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756273AbeEIH0h (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:26:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27722 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933771AbeEIH0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:26:34 -0400
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Rob Herring <robh@kernel.org>
CC: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: rtc: update stm32-rtc documentation for
 stm32mp1 rtc
Thread-Topic: [PATCH 2/3] dt-bindings: rtc: update stm32-rtc documentation for
 stm32mp1 rtc
Thread-Index: AQHT1+MZpSoUtCzTP0aer/yCXupqBaQT1tMAgBMlywA=
Date: Wed, 9 May 2018 07:25:53 +0000
Message-ID: <4fed55d0-95a2-c6cc-8812-7aea214d39e4@st.com>
References: <1524144845-23016-1-git-send-email-amelie.delaunay@st.com>
 <1524144845-23016-3-git-send-email-amelie.delaunay@st.com>
 <20180427030140.nmlqmpewqatabnmt@rob-hp-laptop>
In-Reply-To: <20180427030140.nmlqmpewqatabnmt@rob-hp-laptop>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA1470BDC1991D428DCA67E0059AAD01@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w497QgP5017628



On 04/27/2018 05:01 AM, Rob Herring wrote:
> On Thu, Apr 19, 2018 at 03:34:04PM +0200, Amelie Delaunay wrote:
>> RTC embedded in stm32mp1 SoC is slightly different from stm32h7 one, it
>> doesn't require to disable backup domain write protection, and rtc_ck
>> parent clock assignment isn't allowed.
>> To sum up, stm32mp1 RTC requires 2 clocks, pclk and rtc_ck, and an RTC
>> alarm interrupt.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 27 +++++++++++++++++-----
>>   1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
>> index 00f8b5d..f1c2080 100644
>> --- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
>> +++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
>> @@ -1,25 +1,31 @@
>>   STM32 Real Time Clock
>>   
>>   Required properties:
>> -- compatible: can be either "st,stm32-rtc" or "st,stm32h7-rtc", depending on
>> -  the device is compatible with stm32(f4/f7) or stm32h7.
>> +- compatible: can be "st,stm32-rtc", "st,stm32h7-rtc" or "st,stm32mp1-rtc",
>> +	      depending on the device is compatible with stm32(f4/f7), stm32h7
>> +	      or stm32mp1.
> 
> One compatible per line please.
> 
>>   - reg: address range of rtc register set.
>>   - clocks: can use up to two clocks, depending on part used:
>>     - "rtc_ck": RTC clock source.
>> -    It is required on stm32(f4/f7) and stm32h7.
>> +    It is required on stm32(f4/f7/h7/mp1).
> 
> IOW, required for all?
> 

Yes, so, I'll remove the comment as it is required for all.

>>     - "pclk": RTC APB interface clock.
>>       It is not present on stm32(f4/f7).
>> -    It is required on stm32h7.
>> +    It is required on stm32(h7/mp1).
>>   - clock-names: must be "rtc_ck" and "pclk".
>> -    It is required only on stm32h7.
>> +    It is required on stm32(h7/mp1).
>>   - interrupt-parent: phandle for the interrupt controller.
>> +    It is required on stm32(f4/f7/h7).
>>   - interrupts: rtc alarm interrupt.
>> +- interrupts-extended: replace interrupts property on stm32mp1, to specify rtc
>> +  alarm wakeup interrupt, which is on exti interrupt controller instead of gic.
>> +    It is required on stm32mp1.
> 
> Just document 'interrupts'. interrupts-extended is implicitly supported
> and what the interrupts are connected to is outside the scope of this
> binding.
> 

OK, I'll clean this.

>>   - st,syscfg: phandle/offset/mask triplet. The phandle to pwrcfg used to
>>     access control register at offset, and change the dbp (Disable Backup
>>     Protection) bit represented by the mask, mandatory to disable/enable backup
>>     domain (RTC registers) write protection.
>> +    It is required on stm32(f4/f7/h7).
>>   
>> -Optional properties (to override default rtc_ck parent clock):
>> +Optional properties (to override default rtc_ck parent clock on stm32(f4/f7/h7):
>>   - assigned-clocks: reference to the rtc_ck clock entry.
>>   - assigned-clock-parents: phandle of the new parent clock of rtc_ck.
>>   
>> @@ -48,3 +54,12 @@ Example:
>>   		interrupt-names = "alarm";
>>   		st,syscfg = <&pwrcfg 0x00 0x100>;
>>   	};
>> +
>> +	rtc: rtc@5c004000 {
>> +		compatible = "st,stm32mp1-rtc";
>> +		reg = <0x5c004000 0x400>;
>> +		clocks = <&rcc RTCAPB>, <&rcc RTC>;
>> +		clock-names = "pclk", "rtc_ck";
>> +		interrupts-extended = <&intc GIC_SPI 3 IRQ_TYPE_NONE>,
>> +				      <&exti 19 1>;
>> +	};
>> -- 
>> 2.7.4
>>

Thanks,
Amelie
