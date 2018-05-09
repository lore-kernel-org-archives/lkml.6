Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756199AbeEIHVp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:21:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17556 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755826AbeEIHVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:21:43 -0400
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Alexandre TORGUE <alexandre.torgue@st.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh@kernel.org>
CC: Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: rtc: update stm32-rtc documentation for
 st,syscfg property
Thread-Topic: [PATCH 3/4] dt-bindings: rtc: update stm32-rtc documentation for
 st,syscfg property
Thread-Index: AQHT1+Fn4tx9/DtxBUOu3CUc7ROmuqQT1dSAgAqakICAALSbAIAH1kWA
Date: Wed, 9 May 2018 07:21:00 +0000
Message-ID: <bf861b1b-5a55-e144-5999-b41d9d2cea8b@st.com>
References: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
 <1524144103-21432-4-git-send-email-amelie.delaunay@st.com>
 <20180427025803.mn32y5xle2p6knn6@rob-hp-laptop>
 <20180503205351.GE10960@piout.net>
 <a2cbe252-c957-103d-aae1-4a8fce9116fa@st.com>
In-Reply-To: <a2cbe252-c957-103d-aae1-4a8fce9116fa@st.com>
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
Content-ID: <8813105358D8D047AEABABC37D977E2C@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w497LpZO017582

Hi,

On 05/04/2018 09:40 AM, Alexandre Torgue wrote:
> Hi Alexandre,
> 
> On 05/03/2018 10:53 PM, Alexandre Belloni wrote:
>> Amelie,
>>
>> On 26/04/2018 21:58:03-0500, Rob Herring wrote:
>>> On Thu, Apr 19, 2018 at 03:21:42PM +0200, Amelie Delaunay wrote:
>>>> RTC driver should not be aware of the PWR registers offset and bits
>>>> position. Furthermore, we can imagine that Disable Backup Protection 
>>>> (DBP)
>>>> relative register and bit mask could change depending on the SoC. So 
>>>> this
>>>> patch moves st,syscfg property from single pwrcfg phandle to pwrcfg
>>>> phandle/offset/mask triplet.
>>>>
>>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt | 10 
>>>> ++++++----
>>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt 
>>>> b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
>>>> index a66692a..00f8b5d 100644
>>>> --- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
>>>> +++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
>>>> @@ -14,8 +14,10 @@ Required properties:
>>>>       It is required only on stm32h7.
>>>>   - interrupt-parent: phandle for the interrupt controller.
>>>>   - interrupts: rtc alarm interrupt.
>>>> -- st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup 
>>>> domain
>>>> -  (RTC registers) write protection.
>>>> +- st,syscfg: phandle/offset/mask triplet. The phandle to pwrcfg 
>>>> used to
>>>> +  access control register at offset, and change the dbp (Disable 
>>>> Backup
>>>> +  Protection) bit represented by the mask, mandatory to 
>>>> disable/enable backup
>>>> +  domain (RTC registers) write protection.
>>>
>>> It's fine to add this, but you are breaking compatibility in the driver
>>> with existing DTBs by requiring these new fields.
>>>
>>
>> I'm fine with that change but I would like confirmation that this has
>> been well thought. Maybe Maxime or Alexandre could give their ack.
>>
> 
> It's a good thing to remove PWR registers information from RTC driver. 
> My only concern was the compatibility with old DT but we can accept it. 
> Indeed, Kernel will continue to boot fine, only RTC will not probe if we 
> use old DT.
> 
> Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
> 
> Regards
> alex

I am going to send a series to update st,syscfg property in 
stm32f429/stm32f746/stm32h743 RTC node.

Thanks,
Amelie
