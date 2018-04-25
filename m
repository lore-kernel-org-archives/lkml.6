Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeDYHWv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:22:51 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46393 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750941AbeDYHWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:22:46 -0400
Subject: Re: [PATCH 1/3] dt-bindings: iio: stm32-adc: add support for
 STM32MP1.
To: Rob Herring <robh@kernel.org>
CC: <jic23@kernel.org>, <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>
References: <1524065874-434-1-git-send-email-fabrice.gasnier@st.com>
 <1524065874-434-2-git-send-email-fabrice.gasnier@st.com>
 <20180424162721.qbfsc7j3syzzykeh@rob-hp-laptop>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <ee92eb8d-9675-3c94-1c0d-f6e8f091d878@st.com>
Date: Wed, 25 Apr 2018 09:22:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424162721.qbfsc7j3syzzykeh@rob-hp-laptop>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2018 06:27 PM, Rob Herring wrote:
> On Wed, Apr 18, 2018 at 05:37:52PM +0200, Fabrice Gasnier wrote:
>> Document support for STM32MP1 ADC. It's quite similar to STM32H7 ADC.
>> Introduce "st,stm32mp1-adc" compatible to handle variants of this
>> hardware such as vregready flag, interrupts, clock rate.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>> index e8bb824..9994384 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>> @@ -24,8 +24,11 @@ Required properties:
>>  - compatible: Should be one of:
>>    "st,stm32f4-adc-core"
>>    "st,stm32h7-adc-core"
>> +  "st,stm32mp1-adc-core"
>>  - reg: Offset and length of the ADC block register set.
>> -- interrupts: Must contain the interrupt for ADC block.
>> +- interrupts: One or more interrupts for ADC block. Some parts like stm32f4
>> +  and stm32h7 share a common ADC interrupt line. stm32mp1 has separate
>> +  lines for each ADC within ADC block.
> 
> How many interrupt lines is that?

Hi Rob, Jonathan,

I should have mentioned this: stm32mp1 has two separate interrupt lines
for each ADC within ADC block.

Do you wish I send a V2 for this ? Or a patch to fix this ?

Please let me know,
BR,
Fabrice

> 
>>  - clocks: Core can use up to two clocks, depending on part used:
>>    - "adc" clock: for the analog circuitry, common to all ADCs.
>>      It's required on stm32f4.
>> @@ -53,6 +56,7 @@ Required properties:
>>  - compatible: Should be one of:
>>    "st,stm32f4-adc"
>>    "st,stm32h7-adc"
>> +  "st,stm32mp1-adc"
>>  - reg: Offset of ADC instance in ADC block (e.g. may be 0x0, 0x100, 0x200).
>>  - clocks: Input clock private to this ADC instance. It's required only on
>>    stm32f4, that has per instance clock input for registers access.
>> -- 
>> 1.9.1
>>
