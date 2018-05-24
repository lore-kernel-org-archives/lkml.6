Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969998AbeEXNwc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:52:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45170 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966066AbeEXNw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:52:26 -0400
Subject: Re: [PATCH 1/5] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
To: Ray Jui <ray.jui@broadcom.com>, Rob Herring <robh@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
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
 <4b0ec4ab-2d9e-1e4b-e294-c175805f4013@broadcom.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <16e0b756-d455-77f3-0560-75cacf7e3afa@arm.com>
Date: Thu, 24 May 2018 14:52:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4b0ec4ab-2d9e-1e4b-e294-c175805f4013@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/18 20:29, Ray Jui wrote:
> 
> 
> On 5/23/2018 11:59 AM, Rob Herring wrote:
>> On Wed, May 23, 2018 at 09:25:49AM -0700, Ray Jui wrote:
>>>
>>>
>>> On 5/23/2018 3:57 AM, Robin Murphy wrote:
>>>> On 22/05/18 19:47, Ray Jui wrote:
>>>>> Update the SP805 binding document to add optional 'timeout-sec'
>>>>> devicetree property
>>>>>
>>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/watchdog/sp805-wdt.txt | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>>> b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>>> index edc4f0e..f898a86 100644
>>>>> --- a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>>> +++ b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>>> @@ -19,6 +19,8 @@ Required properties:
>>>>>    Optional properties:
>>>>>    - interrupts : Should specify WDT interrupt number.
>>>>> +- timeout-sec : Should specify default WDT timeout in seconds. If
>>>>> unset, the
>>>>> +                default timeout is 30 seconds
>>>>
>>>> According to the SP805 TRM, the default interval is dependent on the
>>>> rate of WDOGCLK, but would typically be a lot longer than that :/
>>>>
>>>> On a related note, anyone have any idea why we seem to have two subtly
>>>> different SP805 bindings defined?
>>
>> Sigh.
>>
>>> Interesting, I did not even know that until you pointed this out (and 
>>> it's
>>> funny that I found that I actually reviewed arm,sp805.txt internally in
>>> Broadcom code review).
>>>
>>> It looks like one was done by Bhupesh Sharma (sp805-wdt.txt) and the 
>>> other
>>> was done by Anup Patel (arm,sp805.txt). Both were merged at the same 
>>> time
>>> around March 20, 2016: 915c56bc01d6. I'd assume both were sent out at 
>>> around
>>> the same time.
>>>
>>> It sounds like we should definitely remove one of them. Given that
>>> sp805-wdt.txt appears to have more detailed descriptions on the use 
>>> of the
>>> clocks, should we remove arm,sp805.txt?
>>
>> Take whichever text you like, but I prefer filenames using the
>> compatible string and the correct string is 'arm,sp805' because '-wdt'
>> is redundant. You can probably safely just update all the dts files with
>> 'arm,sp805' and just remove 'arm,sp805-wdt' because it is not actually
>> used (as the ID registers are).
> 
> Okay. I'll consolidate everything into arm,sp805.txt. Will also fix all 
> DTS files to use "arm,sp805". The fix for actual DTS files will be in a 
> different patch series.

Looking at the current in-tree DTs, for extra fun try to figure out 
which binding each instance was following for the clocks. The most 
common answer seems to be "neither"... :(

Robin.
