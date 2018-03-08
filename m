Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755708AbeCHMwD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 07:52:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50794 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754558AbeCHMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 07:52:01 -0500
Subject: Re: [PATCH v2 0/6] Add mmc support for STM32F7 boards
To: Lee Jones <lee.jones@linaro.org>,
        Patrice CHOTARD <patrice.chotard@st.com>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
 <44ed2e2c-83f1-77f5-fa70-29c5525b9ee7@st.com>
 <20180307083538.vicxhbu72jex7zi6@dell>
 <f006750d-1fa9-4bbf-8f4d-32abee21cadd@st.com>
 <20180307105721.yxrun3xztrgun4me@dell>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <a835548c-13d6-ffe9-8557-7e288c868308@st.com>
Date: Thu, 8 Mar 2018 13:51:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307105721.yxrun3xztrgun4me@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee

On 03/07/2018 11:57 AM, Lee Jones wrote:
> On Wed, 07 Mar 2018, Patrice CHOTARD wrote:
> 
>> Hi Lee
>>
>> On 03/07/2018 09:35 AM, Lee Jones wrote:
>>> On Mon, 05 Mar 2018, Alexandre Torgue wrote:
>>>
>>>> Hi Patrice,
>>>>
>>>> On 03/01/2018 11:53 AM, patrice.chotard@st.com wrote:
>>>>> From: Patrice Chotard <patrice.chotard@st.com>
>>>>>
>>>>> This series adds :
>>>>>     _ SDIO pins definition for STM32F7 SoCs family
>>>>>     _ add sdio1 DT entry for STM32F746 Discovery board
>>>>>     _ add sdio1 DT entry for STM32F746 Evaluation board
>>>>>     _ add sdio1 DT entry for STM32F769 Discovery board
>>>>>     _ add SDMMC2 entry in stm32f7-rcc.h
>>>>>     _ replace sdio2 hard coded value in stm32f746.dtsi
>>>>>
>>>>> v2: _ rename sdio_pins / sdio_od_pins to sdio_pins_a / sdio_od_pins_a
>>>>>          and update board dts files accordingly.
>>>>>
>>>>>
>>>>> Patrice Chotard (6):
>>>>>      ARM: dts: stm32: Add sdio pins definition for stm32f7
>>>>>      ARM: dts: stm32: Enable sdio1 for stm32f746-disco
>>>>>      ARM: dts: stm32: Enable sdio1 for stm32f746-eval
>>>>>      ARM: dts: stm32: Enable sdio1 for stm32f769-disco
>>>>>      dt-bindings: mfd: Add STM32F7 SDMMC2 rcc entry
>>>>>      ARM: dts: stm32: Fix sdio2 rcc hard coded value
>>>>>
>>>>>     arch/arm/boot/dts/stm32746g-eval.dts   | 17 ++++++++++
>>>>>     arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 62 ++++++++++++++++++++++++++++++++++
>>>>>     arch/arm/boot/dts/stm32f746-disco.dts  | 19 +++++++++++
>>>>>     arch/arm/boot/dts/stm32f746.dtsi       |  2 +-
>>>>>     arch/arm/boot/dts/stm32f769-disco.dts  | 19 +++++++++++
>>>>>     include/dt-bindings/mfd/stm32f7-rcc.h  |  1 +
>>>>>     6 files changed, 119 insertions(+), 1 deletion(-)
>>>>>
>>>> Series applied on stm32-next.
>>>
>>> Even the MFD patch?
>>>
>>
>> Yes, the MFD part has been taken by Alex.
> 
> You should really wait for all of the appropriate Acks.  This helps to
> avoid possible merge conflicts when Linus starts pulling branches
> during the merge-window.

I took it maybe too quickly. Sorry for that. As it was only a new define 
without impact in mfd driver I didn't wait for an "ack". But yes, it is 
not very "fair" :$. I agree that we need to wait for relevant ack.

cheers
alex

> 
> As it happens, I do not think Alex's tree and MFD will conflict this
> time, but it's something to bear in mind in the future.
> 
> Please add my:
> 
>    Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> ... to the patch.
> 
