Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbeEDHlM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:41:12 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42932 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751199AbeEDHlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:41:08 -0400
Subject: Re: [PATCH 3/4] dt-bindings: rtc: update stm32-rtc documentation for
 st,syscfg property
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh@kernel.org>
CC: Amelie Delaunay <amelie.delaunay@st.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
 <1524144103-21432-4-git-send-email-amelie.delaunay@st.com>
 <20180427025803.mn32y5xle2p6knn6@rob-hp-laptop>
 <20180503205351.GE10960@piout.net>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <a2cbe252-c957-103d-aae1-4a8fce9116fa@st.com>
Date: Fri, 4 May 2018 09:40:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503205351.GE10960@piout.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 05/03/2018 10:53 PM, Alexandre Belloni wrote:
> Amelie,
> 
> On 26/04/2018 21:58:03-0500, Rob Herring wrote:
>> On Thu, Apr 19, 2018 at 03:21:42PM +0200, Amelie Delaunay wrote:
>>> RTC driver should not be aware of the PWR registers offset and bits
>>> position. Furthermore, we can imagine that Disable Backup Protection (DBP)
>>> relative register and bit mask could change depending on the SoC. So this
>>> patch moves st,syscfg property from single pwrcfg phandle to pwrcfg
>>> phandle/offset/mask triplet.
>>>
>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>>> ---
>>>   Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt | 10 ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
>>> index a66692a..00f8b5d 100644
>>> --- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
>>> +++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
>>> @@ -14,8 +14,10 @@ Required properties:
>>>       It is required only on stm32h7.
>>>   - interrupt-parent: phandle for the interrupt controller.
>>>   - interrupts: rtc alarm interrupt.
>>> -- st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup domain
>>> -  (RTC registers) write protection.
>>> +- st,syscfg: phandle/offset/mask triplet. The phandle to pwrcfg used to
>>> +  access control register at offset, and change the dbp (Disable Backup
>>> +  Protection) bit represented by the mask, mandatory to disable/enable backup
>>> +  domain (RTC registers) write protection.
>>
>> It's fine to add this, but you are breaking compatibility in the driver
>> with existing DTBs by requiring these new fields.
>>
> 
> I'm fine with that change but I would like confirmation that this has
> been well thought. Maybe Maxime or Alexandre could give their ack.
> 

It's a good thing to remove PWR registers information from RTC driver. 
My only concern was the compatibility with old DT but we can accept it. 
Indeed, Kernel will continue to boot fine, only RTC will not probe if we 
use old DT.

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

Regards
alex
