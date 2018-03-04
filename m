Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeCDLJQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 06:09:16 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:55356 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbeCDLJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 06:09:14 -0500
X-Google-Smtp-Source: AG47ELudJOvrBoI0UqmZppXDksILFycgviaUqNNE/CS2EURYYOmo6cT2WNCZPt0OEjBCvWmPGX/wrA==
Subject: Re: Fwd: Re: Hibernation on i386 failure...
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <1cd7fdbb-3b3e-02b5-743b-2cc8c4d755b5@intel.com>
 <92900026-5110-bde7-fba2-89d545bca29a@gmail.com> <20180109223047.GA26431@amd>
 <cf0cf715-a8bb-9bc9-e308-223712498f31@gmail.com> <20180303210617.GA22392@amd>
 <f840d714-2a84-505f-35c4-3bf22c95e907@gmail.com> <20180304082547.GA7931@amd>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <c5c17099-7f23-aa5e-831e-4bfed4782478@gmail.com>
Date: Sun, 4 Mar 2018 06:09:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0
 SeaMonkey/2.49.2
MIME-Version: 1.0
In-Reply-To: <20180304082547.GA7931@amd>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Sat 2018-03-03 19:03:48, Woody Suwalski wrote:
>> Pavel Machek wrote:
>>> Hi!
>>>
>>>>> On Tue 2018-01-09 16:54:51, Woody Suwalski wrote:
>>>>>> Hey Pavel, so you have found that issue earlier... Do you have a patch to
>>>>>> try?
>>>>> Did I? I do not remember clearly.
>>>>>
>>>>> Anyway, here are my hibernation-related patches... Absolutely no
>>>>> guarantees.
>>>> Pavel, here is my attempt to convert your patch to 4.15 git, it builds
>>>> cleanly, and it does not work. If you have a moment to spare - could you
>>>> check if it is a classic case "everything is good, just does not
>>>> work"?
>>> Sorry for the delay.
>>>
>>> I've tested today's linux-next, and hibernation works for me, no
>>> patches needed.
>>>
>>> Best regards,
>>> 									Pavel
>> My January tests have showed that hibernation does work if I turn off the
>> CONFIG_RELOCATABLE option.
>> So can you confirm that you have it enabled and it works again? I will try
>> it on 4.16-rc4 tomorrow...
> I was actually testing with linux-next:
>
> commit 80253003d5da3b82d6bebfb755a04c24011e90e2
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Fri Mar 2 14:17:11 2018 +1100
>
>      Add linux-next specific files for 20180302
>
> # git clone
>    git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>    # git fetch linux-next
>    # git fetch --tags linux-next
>    git remote update
>    # then: git checkout next-20170201
>
> And yes, I do have CONFIG_RELOCATABLE on:
>
> CONFIG_RELOCATABLE=y
> # CONFIG_RANDOMIZE_BASE is not set
> CONFIG_X86_NEED_RELOCS=y
>
> Best regards,
> 									Pavel
Almost there. Yes I have noticed the linux-next, but I wanted to see 
first if the same does not work in the mainline - then it would have 
pointed to the difference between the branches.

However the important part is your "CONFIG_RANDOMIZE_BASE is not set". 
Try to turn it on and check hibernation. I have used the 
CONFIG_RELOCATABLE entry, because it turns off the randomized 
automatically, and on its own it I had no use for it. BTW. turning the 
relocatable field on by default also brings randomization on, so you 
must have specifically disable it. Why?

So the real issue is: can the 32-bit kernel use randomization, _and_ 
hibernate on linux-next???

Thanks, Woody
