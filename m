Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeEUCWc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 22:22:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeEUCWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 22:22:30 -0400
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org>
 <CAFkk2KRozscmd4kQSJKwKmY3WpTody7S5XZZObf8SKLF62k6+w@mail.gmail.com>
 <CAFkk2KRkEt3+786QvyjzPPAm+3HDe2+ydzZJpshfdKyUDQVfuw@mail.gmail.com>
 <CAFkk2KRvSxu+x-nb045=3L63KEk5h9URr5QYLPoYp6rqqTR4qA@mail.gmail.com>
 <3d9be2f2-3fbe-411b-8529-0e0847f01346@infradead.org>
 <CAFkk2KRWon_S--dxYw82cDyGXKTFA6jxrrQwstzLvHPs=6-dqQ@mail.gmail.com>
 <c4ec710f-b2bd-b9f0-c33a-159aa53ca73c@infradead.org>
 <1378afb3-2b0e-da7a-5721-a8fa727e4382@infradead.org>
 <CAFkk2KStOwHKmFLpNVA1GNscvi-0wihJVM_uaYNemoy6XWDxiQ@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <63c7222b-b324-2cca-b4f9-3e07cd59780b@infradead.org>
Date: Sun, 20 May 2018 19:22:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAFkk2KStOwHKmFLpNVA1GNscvi-0wihJVM_uaYNemoy6XWDxiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/20/2018 12:51 AM, Ulf Magnusson wrote:
> On Sun, May 20, 2018 at 6:03 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 05/19/2018 08:45 PM, Randy Dunlap wrote:
>>> On 05/08/2018 09:59 AM, Ulf Magnusson wrote:
>>>> Hello,
>>>>
>>>> I've added incremental search for jumping directly to a symbol now.
>>>> Regular expressions are supported as well.
>>>>
>>>> Some screenshots below:
>>>>
>>>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss10.png
>>>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss11.png
>>>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss13.png
>>>>
>>>> The last screenshot shows how things might look after you jump to a
>>>> symbol. The jumped-to symbol wasn't visible in this case, so show-all
>>>> mode was turned on automatically.
>>>
>>> Hi Ulf,
>>>
>>>
>>>
>>> Hm, OK, I used the trick that you supplied a few weeks ago and I have the UI now.
>>>
>>>     ARCH=x86 SRCARCH=x86 KERNELVERSION=`make kernelversion` \
>>>         Kconfiglib/menuconfig.py
>>>
>>> so yes, a real Makefile target would be nice. :)
>>
>> I want to see all kconfig symbols that end with "_DEBUG" (so excluding
>> _DEBUGFS).  Using:
>>
>> /.*_DEBUG$
>>
>> shows me 6 symbols:
>> ATH9K_COMMON_DEBUG
>> DVB_B2C2_FLEXCOP_DEBUG
>> HAVE_DMA_API_DEBUG
>> IP_DCCP_TFRC_DEBUG
>> NFS_DEBUG
>> PM_SLEEP_DEBUG
>>
>> so where are the other (approx.) 176?
>> see:
>> $ find . -name Kconfig\* | xargs grep "config.*_DEBUG$" | grep -v \.orig | wc
>>     182     364    9179
>>
>>
>> Anyway, something for you to look at. :)
>>
>> --
>> ~Randy
> 
> I changed it to search the symbol name and the prompt separately:
> https://github.com/ulfalizer/Kconfiglib/commit/e0905818ef376c977d0a4540ea72d61b8f554bb5
> 
> Should work the way you expected now. It's more intuitive for the prompt too. :)

Yes, and a user shouldn't need to know about the implementation details.

> Can just do 'debug$' by the way. No '.*' required.

Yep, I had already figured that out.

thanks,
-- 
~Randy
