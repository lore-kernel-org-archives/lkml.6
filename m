Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934657AbeEWTaA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:30:00 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45207 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934492AbeEWT34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:29:56 -0400
X-Google-Smtp-Source: AB8JxZp0YYwUerz/2SV2UkMSz9Kv4UHOG+qCUlP6UJOCIXBT4IuJT96do5vQW+kVypwuqRm67ZO9fg==
Subject: Re: [PATCH 1/5] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
To: Rob Herring <robh@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
 <1527014840-21236-2-git-send-email-ray.jui@broadcom.com>
 <af81ea74-fb80-11e2-7bdc-d3607bdbd46b@arm.com>
 <c542388f-e417-f624-ade1-95f9a2fc8a3b@broadcom.com>
 <20180523185944.GA9989@rob-hp-laptop>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <4b0ec4ab-2d9e-1e4b-e294-c175805f4013@broadcom.com>
Date: Wed, 23 May 2018 12:29:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180523185944.GA9989@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/2018 11:59 AM, Rob Herring wrote:
> On Wed, May 23, 2018 at 09:25:49AM -0700, Ray Jui wrote:
>>
>>
>> On 5/23/2018 3:57 AM, Robin Murphy wrote:
>>> On 22/05/18 19:47, Ray Jui wrote:
>>>> Update the SP805 binding document to add optional 'timeout-sec'
>>>> devicetree property
>>>>
>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/watchdog/sp805-wdt.txt | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>> b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>> index edc4f0e..f898a86 100644
>>>> --- a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>> +++ b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>> @@ -19,6 +19,8 @@ Required properties:
>>>>    Optional properties:
>>>>    - interrupts : Should specify WDT interrupt number.
>>>> +- timeout-sec : Should specify default WDT timeout in seconds. If
>>>> unset, the
>>>> +                default timeout is 30 seconds
>>>
>>> According to the SP805 TRM, the default interval is dependent on the
>>> rate of WDOGCLK, but would typically be a lot longer than that :/
>>>
>>> On a related note, anyone have any idea why we seem to have two subtly
>>> different SP805 bindings defined?
> 
> Sigh.
> 
>> Interesting, I did not even know that until you pointed this out (and it's
>> funny that I found that I actually reviewed arm,sp805.txt internally in
>> Broadcom code review).
>>
>> It looks like one was done by Bhupesh Sharma (sp805-wdt.txt) and the other
>> was done by Anup Patel (arm,sp805.txt). Both were merged at the same time
>> around March 20, 2016: 915c56bc01d6. I'd assume both were sent out at around
>> the same time.
>>
>> It sounds like we should definitely remove one of them. Given that
>> sp805-wdt.txt appears to have more detailed descriptions on the use of the
>> clocks, should we remove arm,sp805.txt?
> 
> Take whichever text you like, but I prefer filenames using the
> compatible string and the correct string is 'arm,sp805' because '-wdt'
> is redundant. You can probably safely just update all the dts files with
> 'arm,sp805' and just remove 'arm,sp805-wdt' because it is not actually
> used (as the ID registers are).

Okay. I'll consolidate everything into arm,sp805.txt. Will also fix all 
DTS files to use "arm,sp805". The fix for actual DTS files will be in a 
different patch series.

> 
> Rob
> 
