Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbeDMJAt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:00:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51808 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbeDMJAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:00:47 -0400
X-Google-Smtp-Source: AIpwx48NzzfzUoR8rYYz4nhIkbZHhZtQ7k4/dwjlyVjQ+bwsc/ALXwxZhvj2Si9ocNJNchuWwDn33A==
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
References: <1523436077.16235.5.camel@intel.com>
 <CGME20180413053914epcas3p3b7e3c278515ffed1b4c019b2c5af3ab4@epcas3p3.samsung.com>
 <1523597945.16235.52.camel@intel.com> <2944702.qKZ0LXufY7@amdc3058>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5afdb571-8aaa-941f-ff4f-7c4b031b5efb@linaro.org>
Date: Fri, 13 Apr 2018 11:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2944702.qKZ0LXufY7@amdc3058>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2018 10:55, Bartlomiej Zolnierkiewicz wrote:
> On Friday, April 13, 2018 01:39:05 PM Zhang Rui wrote:
>> Hi, Eduardo,
>>
>> On 四, 2018-04-12 at 21:08 -0700, Eduardo Valentin wrote:
>>> Hello,
>>>
>>> On Thu, Apr 12, 2018 at 09:55:19AM -0700, Linus Torvalds wrote:
>>>>
>>>> On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> could you please illustrate me what the kconfig & warning is?
>>>> Just "make allmodconfig" and the warning is about a uninitialized
>>>> variable.
>>>>
>>>> Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell
>>>> history
>>>> is to be believed.
>>>>
>>>>                 Linus
>>> Yeah, this has also passed my local compilation error. Somehow my
>>> gcc4.9
>>> is not catching it. Using an older gcc (gcc4.6) does catch it.
>>>
>>> Anyways, given that the conversion functions are written to cover
>>> for unexpected cal_type, the right way of fixing this is to rewrite
>>> the conversion functions to allow for returning error codes and
>>> adjusting the callers as expected.
>>>
>>> Rui, bzolnier, please consider the following fix:
>>>
>> as it is late in this merge window, I'd prefer to
>> 1. drop all the thermal-soc material in the first pull request which I
>> will send out soon.
>> 2. you can prepare another pull request containing the thermal-soc
>> materials except the exynos fixes
>> 3. exynos fixes with the problem solved can be queued for -rc2 or
>> later.
> 
> Could you please just merge the obvious fix from Arnd instead?
> 
> [ it was posted two weeks ago and ACKed by me ]
> 
> https://patchwork.kernel.org/patch/10313313/

I'm not sure these are correct fixes.

The change 480b5bfc16e1 tells:

"There should be no functional changes caused by this patch."

but the fix above returns 0 as a default value instead of '50' or '25'
for the 5440 and that impacts the threshold etc ...

IMO, the correct fix would be to define a default value '50', override
it at init time to '25' if it is a 5440. And then the variable 'temp'
and 'temp_code' get this value in the default case.




> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
