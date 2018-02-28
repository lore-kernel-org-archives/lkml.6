Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbeB1THr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:07:47 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:42388 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932365AbeB1THp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:07:45 -0500
X-Google-Smtp-Source: AH8x226wphMvTsc8EJk9RYXFYlMSGBmWnAU4FFVuqJkjxLra6rYabQXhisvKJUYqfIdgYP24pyZ4Uw==
Reply-To: minyard@acm.org
Subject: Re: Regression in IPMI on 4.15.6
From: Corey Minyard <minyard@acm.org>
To: Laura Abbott <labbott@redhat.com>
Cc: openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7b4cd699-1a77-5412-5346-b30e44bfc9c9@redhat.com>
 <33fb6125-7ffa-0d3a-e1d6-1a849b816867@acm.org>
 <bdb67791-9a2c-bd04-5678-efb6b3cdf962@acm.org>
Message-ID: <dc401118-8398-5985-3cb0-9a63bfe26148@acm.org>
Date: Wed, 28 Feb 2018 13:07:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <bdb67791-9a2c-bd04-5678-efb6b3cdf962@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 08:17 AM, Corey Minyard wrote:
> On 02/28/2018 07:53 AM, Corey Minyard wrote:
>> On 02/27/2018 05:55 PM, Laura Abbott wrote:
>>> Hi,
>>>
>>> Fedora got a bug report of a crash in IPMI on 4.15.6
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1549316
>>> Unfortunately, it's only a screenshot but it's fairly
>>> clear. It looks like a panic in the error handling path
>>> in platform_device_unregister. Any ideas?
>>>
>>
>
> You may also run into another issue.  You can pull the
> individual patch at
>
> https://github.com/cminyard/linux-ipmi.git 
> c8a1972e77dbe321ce5ce0247056e727234cbaec

Actually, it needed a few more tweaks.  Can you do change
426fa6179dae677134dfb37b21d057819418515b
instead?  It's "ipmi: Fix some error cleanup issues"

I can send you patches, if you like.  If you could test and get back
to me, that would be great.

BTW, the IPMI setup in your system is incorrect.  SMBIOS says it's at a
memory address, but it's at an I/O address.  And the address given
doesn't appear to be a valid address, the value read doesn't appear
to be a valid value.

-corey

>
> for that fix.
>
> -corey
>
>> Yeah, this is fixed by 174134ac7602 "ipmi_si: Fix error
>> handling of platform device" in mainstream.
>>
>> I guess I need to request a backport of this.
>>
>> Thanks for reporting.
>>
>> -corey
>>
>>
>>> Thanks,
>>> Laura
>>
>>
>
