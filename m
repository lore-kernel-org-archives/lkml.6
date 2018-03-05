Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeCES5Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:57:16 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:54867 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbeCES5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:57:14 -0500
X-Google-Smtp-Source: AG47ELsR5dsfQI9KQsu+Ysdar0AVZckpZPqW0idIE8tT07/D5qSc/d1pRP4jh4VzZQ10ySQxVnrxmQ==
Subject: Re: "x86/boot/compressed/64: Prepare trampoline memory" breaks boot
 on Zotac CI-321
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Ingo Molnar <mingo@kernel.org>,
        Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>
References: <12357ee3-0276-906a-0e7c-2c3055675af3@gmail.com>
 <CAA42JLZRxCGSsW5FKpH3AjZGbaUyrcRPdVBtMQcc4ZcxKNuDQw@mail.gmail.com>
 <8c6c0f9d-0f47-2fc9-5cb5-6335ef1152cd@gmail.com>
 <20180303100257.hzrqtshcnhzy5spl@gmail.com>
 <f399b62f-984e-c693-81f0-9abe3c49d8f1@gmail.com>
 <20180305081906.t33mocscprsrlvzp@node.shutemov.name>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a2898317-18d0-d542-a767-ee9cf256ced9@gmail.com>
Date: Mon, 5 Mar 2018 19:57:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305081906.t33mocscprsrlvzp@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.03.2018 um 09:19 schrieb Kirill A. Shutemov:
> On Sat, Mar 03, 2018 at 12:46:28PM +0100, Heiner Kallweit wrote:
>> Am 03.03.2018 um 11:02 schrieb Ingo Molnar:
>>>
>>> * Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>
>>>> Am 03.03.2018 um 00:50 schrieb Dexuan-Linux Cui:
>>>>> On Fri, Mar 2, 2018 at 12:57 PM, Heiner Kallweit <hkallweit1@gmail.com <mailto:hkallweit1@gmail.com>> wrote:
>>>>>
>>>>>     Recently my Mini PC Zotac CI-321 started to reboot immediately before
>>>>>     anything was written to the console.
>>>>>
>>>>>     Bisecting lead to b91993a87aff "x86/boot/compressed/64: Prepare
>>>>>     trampoline memory" being the change breaking boot.
>>>>>
>>>>>     If you need any more information, please let me know.
>>>>>
>>>>>     Rgds, Heiner
>>>>>
>>>>>
>>>>> This may fix the issue: https://lkml.org/lkml/2018/2/13/668
>>>>>
>>>>> Kirill posted a v2 patchset 3 days ago and I suppose the patchset should include the fix.
>>>>>
>>>> Thanks for the link. I bisected based on the latest next kernel including
>>>> v2 of the patchset (IOW - the potential fix is included already).
>>>
>>> Are you sure? b91993a87aff is the old patch-set - which I just removed from -next 
>>> and which should thus be gone in the Monday iteration of -next.
>>>
>>> I have not merged v2 in -tip yet, did it get applied via some other tree?
>>>
>>> Thanks,
>>>
>>> 	Ingo
>>>
>> I wanted to apply the fix mentioned in the link but found that the statement was movq already.
>> Therefore my (most likely false) understanding that it's v2.
>> I'll re-test once v2 is out and let you know.
> 
> movq fix is unrelated to the problem.
> 
> Please check if current linux-next plus this patchset causes a problem for
> you:
> 
> http://lkml.kernel.org/r/20180227154217.69347-1-kirill.shutemov@linux.intel.com
> 

linux-next from today boots fine with the patchset applied.

Rgds, Heiner
