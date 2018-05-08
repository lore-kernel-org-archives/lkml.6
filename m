Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755259AbeEHPq5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:46:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34604 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755029AbeEHPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:46:55 -0400
Subject: Re: PROBLEM: error due to conflicting types during build of
 kselftests
From: Randy Dunlap <rdunlap@infradead.org>
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
References: <CAG=yYwnMXFxHxCnYNWCb-HhpAb21kc5_e_6q-N_DRGhMVurPMQ@mail.gmail.com>
 <bd125268-a685-ba6e-efc4-130a0621855f@infradead.org>
 <CAG=yYwnq1KwAmKL5t=KFTMcRY9rDFM_5XBDNpbvzM-8J-U7TKQ@mail.gmail.com>
 <49022295-d118-4aa7-c750-36f36b6b6821@infradead.org>
Message-ID: <ccbfdf1b-ffd5-4b05-8b73-7726816da735@infradead.org>
Date: Tue, 8 May 2018 08:46:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <49022295-d118-4aa7-c750-36f36b6b6821@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28/2018 02:54 PM, Randy Dunlap wrote:
> On 04/28/2018 02:42 PM, Jeffrin Thalakkottoor wrote:
>> anyway my current is gcc (Debian 7.3.0-16) 7.3.0
>>
>> may be you can try ... make -C tools/testing/selftests 2> error.txt
> 
> I have a much older gcc, so newer must be better.  :)
> 

This patch (just posted) should fix the error that you are seeing:

https://marc.info/?l=linux-kernel&m=152577091622065&w=2


> 
>> On Sat, Apr 28, 2018 at 5:08 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>>> On 04/20/2018 11:03 AM, Jeffrin Thalakkottoor wrote:
>>>> hello,
>>>>
>>>> the following is the error found...
>>>> -----------------------------------------------------------------------------------
>>>> protection_keys.c:421:5: error: conflicting types for ‘pkey_set’
>>>>  int pkey_set(int pkey, unsigned long rights, unsigned long flags)
>>>>      ^~~~~~~~
>>>> ------------------------------------------------------------------------------------
>>>>
>>>> to reproduce this error...
>>>> make -C tools/testing/selftests
>>>
>>> Hi,
>>>
>>> I can't reproduce this problem.  What is your gcc --version?
>>>
>>> Thanks.
>>>
>>>> Details about software:
>>>>
>>>> Linux debian 4.17.0-rc1+ #1 SMP Thu Apr 19 18:59:45 IST 2018 x86_64 GNU/Linux
>>>>
>>>> GNU Make             4.2.1
>>>> Binutils             2.30
>>>> Util-linux           2.31.1
>>>> Mount                2.31.1
>>>> Linux C Library      2.27
>>>> Dynamic linker (ldd) 2.27
>>>> readlink: missing operand
>>>> Try 'readlink --help' for more information.
>>>> Procps               3.3.14
>>>> Kbd                  2.0.4
>>>> Console-tools        2.0.4
>>>> Sh-utils             8.28
>>>> Udev                 238
> 
> 


-- 
~Randy
