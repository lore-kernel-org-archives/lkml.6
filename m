Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbeCETbv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:31:51 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42303 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeCETbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:31:50 -0500
X-Google-Smtp-Source: AG47ELukUKjoD1fuHSZSQDpA236303fzDpGKavPNf3rLW4iA7K09zGCkRW7KLkE5JRH11hUOZAz59Q==
Reply-To: minyard@acm.org
Subject: Re: Regression in IPMI on 4.15.6
To: Laura Abbott <labbott@redhat.com>
Cc: openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7b4cd699-1a77-5412-5346-b30e44bfc9c9@redhat.com>
 <33fb6125-7ffa-0d3a-e1d6-1a849b816867@acm.org>
 <bdb67791-9a2c-bd04-5678-efb6b3cdf962@acm.org>
 <dc401118-8398-5985-3cb0-9a63bfe26148@acm.org>
 <1b8caafa-0611-c431-a292-38c895db4660@acm.org>
 <1cd07864-3fae-3b35-27bb-2be33873d171@redhat.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <b6946972-ad4e-32a3-0f99-56a870b60268@acm.org>
Date: Mon, 5 Mar 2018 13:31:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1cd07864-3fae-3b35-27bb-2be33873d171@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 01:07 PM, Laura Abbott wrote:
> On 03/02/2018 05:46 AM, Corey Minyard wrote:
>> On 02/28/2018 01:07 PM, Corey Minyard wrote:
>>> On 02/28/2018 08:17 AM, Corey Minyard wrote:
>>>> On 02/28/2018 07:53 AM, Corey Minyard wrote:
>>>>> On 02/27/2018 05:55 PM, Laura Abbott wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Fedora got a bug report of a crash in IPMI on 4.15.6
>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1549316
>>>>>> Unfortunately, it's only a screenshot but it's fairly
>>>>>> clear. It looks like a panic in the error handling path
>>>>>> in platform_device_unregister. Any ideas?
>>>>>>
>>>>>
>>>>
>>>> You may also run into another issue.  You can pull the
>>>> individual patch at
>>>>
>>>> https://github.com/cminyard/linux-ipmi.git 
>>>> c8a1972e77dbe321ce5ce0247056e727234cbaec
>>>
>>> Actually, it needed a few more tweaks.  Can you do change
>>> 426fa6179dae677134dfb37b21d057819418515b
>>> instead?  It's "ipmi: Fix some error cleanup issues"
>>>
>>> I can send you patches, if you like.  If you could test and get back
>>> to me, that would be great.
>>
>> Laura, have you had a chance to test this?  I'd like to get it in soon,
>> if possible.
>>
>> Thanks,
>>
>> -corey
>>
>
> I think "ipmi: Re-use existing macros for built-in properties" is broken:
>

That particular requires some new stuff.  I was just wanting you to pull 
that individual patch,
not the whole branch.  I can just send the two patches, if you like.

-corey

> In file included from ./include/linux/acpi.h:28:0,
>                  from ./include/linux/ipmi.h:21,
>                  from drivers/char/ipmi/ipmi_dmi.c:7:
> drivers/char/ipmi/ipmi_dmi.c: In function ‘dmi_add_platform_ipmi’:
> ./include/linux/property.h:236:1: error: expected expression before 
> ‘{’ token
>  {       \
>  ^
> ./include/linux/property.h:244:2: note: in expansion of macro 
> ‘PROPERTY_ENTRY_INTEGER’
>   PROPERTY_ENTRY_INTEGER(_name_, u8, _val_)
>   ^~~~~~~~~~~~~~~~~~~~~~
> drivers/char/ipmi/ipmi_dmi.c:79:15: note: in expansion of macro 
> ‘PROPERTY_ENTRY_U8’
>    p[pidx++] = PROPERTY_ENTRY_U8("ipmi-type", si_type);
>                ^~~~~~~~~~~~~~~~~
> ./include/linux/property.h:236:1: error: expected expression before 
> ‘{’ token
>  {       \
>  ^
> ./include/linux/property.h:244:2: note: in expansion of macro 
> ‘PROPERTY_ENTRY_INTEGER’
>   PROPERTY_ENTRY_INTEGER(_name_, u8, _val_)
>   ^~~~~~~~~~~~~~~~~~~~~~
> drivers/char/ipmi/ipmi_dmi.c:81:14: note: in expansion of macro 
> ‘PROPERTY_ENTRY_U8’
>   p[pidx++] = PROPERTY_ENTRY_U8("slave-addr", slave_addr);
>               ^~~~~~~~~~~~~~~~~
> ./include/linux/property.h:236:1: error: expected expression before 
> ‘{’ token
>  {       \
>  ^
> ./include/linux/property.h:244:2: note: in expansion of macro 
> ‘PROPERTY_ENTRY_INTEGER’
>   PROPERTY_ENTRY_INTEGER(_name_, u8, _val_)
>   ^~~~~~~~~~~~~~~~~~~~~~
> drivers/char/ipmi/ipmi_dmi.c:82:14: note: in expansion of macro 
> ‘PROPERTY_ENTRY_U8’
>   p[pidx++] = PROPERTY_ENTRY_U8("addr-source", SI_SMBIOS);
>               ^~~~~~~~~~~~~~~~~
> ./include/linux/property.h:236:1: error: expected expression before 
> ‘{’ token
>  {       \
>  ^
> ./include/linux/property.h:246:2: note: in expansion of macro 
> ‘PROPERTY_ENTRY_INTEGER’
>   PROPERTY_ENTRY_INTEGER(_name_, u16, _val_)
>   ^~~~~~~~~~~~~~~~~~~~~~
> drivers/char/ipmi/ipmi_dmi.c:107:15: note: in expansion of macro 
> ‘PROPERTY_ENTRY_U16’
>    p[pidx++] = PROPERTY_ENTRY_U16("i2c-addr", base_addr);
>                ^~~~~~~~~~~~~~~~~~
>
> I don't think that macro is actually a replacement?
>
> Thanks,
> Laura
>
>>>
>>> BTW, the IPMI setup in your system is incorrect.  SMBIOS says it's at a
>>> memory address, but it's at an I/O address.  And the address given
>>> doesn't appear to be a valid address, the value read doesn't appear
>>> to be a valid value.
>>>
>>> -corey
>>>
>>>>
>>>> for that fix.
>>>>
>>>> -corey
>>>>
>>>>> Yeah, this is fixed by 174134ac7602 "ipmi_si: Fix error
>>>>> handling of platform device" in mainstream.
>>>>>
>>>>> I guess I need to request a backport of this.
>>>>>
>>>>> Thanks for reporting.
>>>>>
>>>>> -corey
>>>>>
>>>>>
>>>>>> Thanks,
>>>>>> Laura
>>>>>
>>>>>
>>>>
>>>
>>
>
