Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946558AbeCBP7n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:59:43 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:42702 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423884AbeCBP7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:59:41 -0500
X-Google-Smtp-Source: AG47ELu6j6qoXyEzhFyK5sEMo/WBrlDgFkuda+KlvstjCeNMJGOJS4NZoqf4gHylfWo722zojtE+bQ==
Subject: Re: Regression in IPMI on 4.15.6
To: minyard@acm.org
Cc: openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7b4cd699-1a77-5412-5346-b30e44bfc9c9@redhat.com>
 <33fb6125-7ffa-0d3a-e1d6-1a849b816867@acm.org>
 <bdb67791-9a2c-bd04-5678-efb6b3cdf962@acm.org>
 <dc401118-8398-5985-3cb0-9a63bfe26148@acm.org>
 <1b8caafa-0611-c431-a292-38c895db4660@acm.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <a544b6e7-6355-3635-8fc9-688daee403c8@redhat.com>
Date: Fri, 2 Mar 2018 07:59:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1b8caafa-0611-c431-a292-38c895db4660@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2018 05:46 AM, Corey Minyard wrote:
> On 02/28/2018 01:07 PM, Corey Minyard wrote:
>> On 02/28/2018 08:17 AM, Corey Minyard wrote:
>>> On 02/28/2018 07:53 AM, Corey Minyard wrote:
>>>> On 02/27/2018 05:55 PM, Laura Abbott wrote:
>>>>> Hi,
>>>>>
>>>>> Fedora got a bug report of a crash in IPMI on 4.15.6
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1549316
>>>>> Unfortunately, it's only a screenshot but it's fairly
>>>>> clear. It looks like a panic in the error handling path
>>>>> in platform_device_unregister. Any ideas?
>>>>>
>>>>
>>>
>>> You may also run into another issue.  You can pull the
>>> individual patch at
>>>
>>> https://github.com/cminyard/linux-ipmi.git c8a1972e77dbe321ce5ce0247056e727234cbaec
>>
>> Actually, it needed a few more tweaks.  Can you do change
>> 426fa6179dae677134dfb37b21d057819418515b
>> instead?  It's "ipmi: Fix some error cleanup issues"
>>
>> I can send you patches, if you like.  If you could test and get back
>> to me, that would be great.
> 
> Laura, have you had a chance to test this?  I'd like to get it in soon,
> if possible.
> 
> Thanks,
> 
> -corey
> 

Sorry, this got missed. I'll ask the reporter to reproduce today.

>>
>> BTW, the IPMI setup in your system is incorrect.  SMBIOS says it's at a
>> memory address, but it's at an I/O address.  And the address given
>> doesn't appear to be a valid address, the value read doesn't appear
>> to be a valid value.
>>
>> -corey
>>
>>>
>>> for that fix.
>>>
>>> -corey
>>>
>>>> Yeah, this is fixed by 174134ac7602 "ipmi_si: Fix error
>>>> handling of platform device" in mainstream.
>>>>
>>>> I guess I need to request a backport of this.
>>>>
>>>> Thanks for reporting.
>>>>
>>>> -corey
>>>>
>>>>
>>>>> Thanks,
>>>>> Laura
>>>>
>>>>
>>>
>>
> 
