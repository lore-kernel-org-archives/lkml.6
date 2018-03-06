Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754197AbeCFXyz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 18:54:55 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:40694 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeCFXyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 18:54:54 -0500
X-Google-Smtp-Source: AG47ELtdGdmVlk4wYqD1efj+ktodu6O6cX8Y+XwMDWJPMs7U3dM1FzYypGFJHOEXA+mILt6ueSh1ZA==
Subject: Re: Regression in IPMI on 4.15.6
To: minyard@acm.org
Cc: openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7b4cd699-1a77-5412-5346-b30e44bfc9c9@redhat.com>
 <33fb6125-7ffa-0d3a-e1d6-1a849b816867@acm.org>
 <bdb67791-9a2c-bd04-5678-efb6b3cdf962@acm.org>
 <dc401118-8398-5985-3cb0-9a63bfe26148@acm.org>
 <1b8caafa-0611-c431-a292-38c895db4660@acm.org>
 <1cd07864-3fae-3b35-27bb-2be33873d171@redhat.com>
 <b6946972-ad4e-32a3-0f99-56a870b60268@acm.org>
 <44fff37d-ad7d-ac1f-c4a2-5bfb29ad79d7@acm.org>
 <714c8c29-b361-44b0-94dd-1a5b9a799209@redhat.com>
 <bcb4a975-d31b-e6cc-0816-bcb78db668c9@acm.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <8935b057-d4d2-6807-de64-765de7e198f8@redhat.com>
Date: Tue, 6 Mar 2018 15:54:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <bcb4a975-d31b-e6cc-0816-bcb78db668c9@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2018 09:19 AM, Corey Minyard wrote:
> On 03/06/2018 11:17 AM, Laura Abbott wrote:
>> On 03/05/2018 11:39 AM, Corey Minyard wrote:
>>> On 03/05/2018 01:31 PM, Corey Minyard wrote:
>>>> On 03/05/2018 01:07 PM, Laura Abbott wrote:
>>>>> On 03/02/2018 05:46 AM, Corey Minyard wrote:
>>>>>> On 02/28/2018 01:07 PM, Corey Minyard wrote:
>>>>>>> On 02/28/2018 08:17 AM, Corey Minyard wrote:
>>>>>>>> On 02/28/2018 07:53 AM, Corey Minyard wrote:
>>>>>>>>> On 02/27/2018 05:55 PM, Laura Abbott wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> Fedora got a bug report of a crash in IPMI on 4.15.6
>>>>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1549316
>>>>>>>>>> Unfortunately, it's only a screenshot but it's fairly
>>>>>>>>>> clear. It looks like a panic in the error handling path
>>>>>>>>>> in platform_device_unregister. Any ideas?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> You may also run into another issue.  You can pull the
>>>>>>>> individual patch at
>>>>>>>>
>>>>>>>> https://github.com/cminyard/linux-ipmi.git c8a1972e77dbe321ce5ce0247056e727234cbaec
>>>>>>>
>>>>>>> Actually, it needed a few more tweaks.  Can you do change
>>>>>>> 426fa6179dae677134dfb37b21d057819418515b
>>>>>>> instead?  It's "ipmi: Fix some error cleanup issues"
>>>>>>>
>>>>>>> I can send you patches, if you like.  If you could test and get back
>>>>>>> to me, that would be great.
>>>>>>
>>>>>> Laura, have you had a chance to test this?  I'd like to get it in soon,
>>>>>> if possible.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> -corey
>>>>>>
>>>>>
>>>>> I think "ipmi: Re-use existing macros for built-in properties" is broken:
>>>>>
>>>>
>>>> That particular requires some new stuff.  I was just wanting you to pull that individual patch,
>>>> not the whole branch.  I can just send the two patches, if you like.
>>>
>>> Or, I just pulled in 4.15.6 and cherry picked those two patches to:
>>>
>>> https://github.com/cminyard/linux-ipmi.git fix-pdev-unreg
>>>
>>> Hopefully that makes things easier.
>>>
>>> -corey
>>>
>>
>> Yes, the reporter said it worked fine.
>>
> 
> It would be helpful to me to have a "Tested-by" line.  Can I put one in?
> If so, whose name/email do I use?
> 
> Thanks for testing.
> 
> -corey


You can use the reporter and tester:

Tested-by: Bill Perkins <wmp@grnwood.net>
