Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1999C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D5921470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D5921470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeJDPeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:34:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:59653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbeJDPeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:34:14 -0400
Received: from [10.95.173.99] ([155.56.40.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ldbqw-1fQQzY3OUM-00ikM9; Thu, 04
 Oct 2018 10:41:54 +0200
Received: from [10.95.173.99] ([155.56.40.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ldbqw-1fQQzY3OUM-00ikM9; Thu, 04
 Oct 2018 10:41:54 +0200
Subject: Re: [GIT PULL] parisc fixes for kernel v4.19
To:     gregkh <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        James.Bottomley@hansenpartnership.com,
        John David Anglin <dave.anglin@bell.net>
References: <20181002210213.GA17826@ls3530.fritz.box>
 <20181002211645.GA6454@kroah.com>
 <ad45f249-e064-d5a4-c658-eaa03bb3a04a@gmx.de>
 <20181002222452.GB11788@kroah.com>
 <dbfa0162-8ed1-b16e-a418-da3b92c76230@gmx.de>
 <20181003181612.GB28575@kroah.com>
 <CAK8P3a2ntPX4+LbYWJbDG1k-8NwkhyY0nYk-mfZU2FBF_h23Yw@mail.gmail.com>
 <20181003230226.GB27729@kroah.com>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; prefer-encrypt=mutual; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <ed8a12d5-604f-c938-f65d-051e05561dc6@gmx.de>
Date:   Thu, 4 Oct 2018 10:41:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181003230226.GB27729@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:E3l9aaPyz7Euy3KAuVeAVYqxMcF9M8n3V2+wJ1ZqwUmlGpi+suh
 sicdR3XkOv9YKuv7KZbXo613Xos+omIHoSgFK+fYwMyK8lc696DlOsIGcU/EG2nFhTcrjl6
 QQWoxUF7P1LIeoLNv6GOW8yh3fef2liZ0CAq+IvFZA5pGgeQ3H8BAXlBwjr8uLwg7Ewyw4E
 WbWQm2hFlq9N6K6HfB1FA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xajsqg9UiIM=:606w40qsMn1SJCC0wqk+Yu
 pY3MW6LydvHBMQ7OLutE20t6/r9BOaUNNeeplO9vSmTbH5cZMxcqqkUQhZHRz2R0SPmcX7sgD
 hYwMMj0H8Fkz8c3exvmFo7O+rvqFL1azogYeKY+vTBbxjLZAve3wGHpvdKWP13JWKD4dygcmF
 VJs4zTO7n7xie1BdclCDpOTIsI63+ymYEicvtZaoSepwz6BPb+qD0htOXScCELphKMy38yp4R
 0tKHv8vHlHL3aKdY9vd8hsNMrGmTSjppVI3TpCZS6UzwL4yhLm0Z/cUHGLx6KFp8MYE5aKSS+
 Pievmz5OH0e4BMBo1W6bL+xxbG4IzElPvpqeWXh6zCQ+mJsiyUKS60GVoUbBDXWNFla4kQDLE
 wV+rd8v0UvBHYmtE7eAAdAfDKTXqwHeN6xfFhAgLMEEzHmlHUdjwCGUG7ZACULvjwU4nXAaml
 ZNCKInAqgViYfyY1RfhybM126PLTwy2uyfqsMuhOkuHnos63m9CcD/Bs+6nmk2oS6sbd6wwU7
 nGFGFJJ9+c9rsvk2RTnarSxH+F+o2LeONq7etq/D+FtvoQMrPWo893gMKGf097vXTDRLmZpjI
 Z6/q/hsKW/4J8CwRuTq9V7rc5e2QUXu+TGgo59U105mtlec/3CLh55PdNlY4/dZB0lKJW1zuX
 M6AFTxAnFvnZRYtu1DuDJ/jdXD7N6jTIIOhsh7x0Bdh9bJUkr3MJC7ldFBm7dNhcR2QzIs+ro
 +Vl3AgbYtluppTFP7+0b0/AyBDhO5EXNGMWbw/GDfjS8lFsDZH9Q35hnyw997AYfKVV4EZnSX
 v8Msv6ymeEdeJh+CejY0j3mdbJEVsGmdpc8WRA2EbiXCHfvkpI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.2018 01:02, gregkh wrote:
> On Wed, Oct 03, 2018 at 09:49:08PM +0200, Arnd Bergmann wrote:
>> On Wed, Oct 3, 2018 at 8:16 PM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> On Wed, Oct 03, 2018 at 04:47:30PM +0200, Helge Deller wrote:
>>>> On 03.10.2018 00:24, Greg Kroah-Hartman wrote:
>>>>> On Tue, Oct 02, 2018 at 11:46:11PM +0200, Helge Deller wrote:
>>>>>>
>>>>>> I've tagged it for stable release.
>>>>>> So, it can go in now, or just wait until -rc1 and go in later.
>>>>>
>>>>> Why is a major API change a viable stable change?
>>>>
>>>> Of course it's not.
>>>> Esp. not if an API has been used already.
>>>> IMHO, this case is really different though...
>>>>
>>>>> What bugfix does it provide?
>>>>
>>>> It fixes that code in stable kernels which would return wrong
>>>> time values *if* someone would create a libc for 64-bit parisc
>>>> and would run it with those "stable" kernels.
>>>> Fixing it now has no side-effects, the change is a trivial
>>>> 2-line-removal patch, would bring the code in sync with
>>>> newer kernel source code, and it really fixes existing code.
>>>>
>>>> I still believe that this justifies for a backport.
>>>>
>>>> Nevertheless, if you really disagree, I'm fine dropping the
>>>> backport to stable and will only push it in the next
>>>> merge window for v4.20.
>>>
>>> To clarify, you have no users of this api anywhere (hopefully), and so
>>> the patch in question prevents anyone from using the api in the future.
>>> This makes the suseconds_t handling easier for some reason because only
>>> sparc32 is a "problem" now, right?
>>>
>>> So I don't see the "bug" that is being fixed here.  I would have pushed
>>> back on the submission for this for the stable trees as well, this isn't
>>> anything that anyone is using, so there's nothing to "fix" that I can
>>> tell.
>>>
>>> Yes, doing it in the "future" is fine, to prevent anyone from making
>>> this mistake (are new machines even being made for this arch?)  But I
>>> don't see how this is a -stable issue.
>>
>> The issue here is that glibc has in theory supported 64-bit parisc
>> user space for a long time, but it has never worked because of the
>> mismatch. It is very likely that there other problems like it that
>> /also/ prevent it from working.
>>
>> Between changing kernel or glibc, I think it's clear that the glibc
>> has made the better choice of being compatible with all other
>> architectures (except sparc64), so changing the kernel is better
>> here.
>>
>> Between fixing it this late, or doing it for the next merge window,
>> I don't care. There clearly are no users that are affected by it
>> today, and if there were, this would fix an important bug, both
>> security (kernel stack information leak) and functionality
>> (improving accuracy of gettimeofday() from seconds to
>> microseconds).
>>
>> Between backporting it to stable or not, I'd be in favor of the
>> backport: If we ever want to support 64-bit user space on parisc,
>> then it's better to have stable kernels get the same working
>> ABI that new kernels have after the fix (and any other fixes we
>> may require on top). 

Ack.

>> Or to put it another way: If the argument is
>> that there won't ever be a 64-bit user space for parisc 

FYI, I was planning to try a 64-bit user space at some point.
Just see my recent patches and mails, e.g. 
b6fc0cccb6b35815a7d1cfc9279cdbfc2c61d00d
5b00ca0b8035e49ef7c466e959c5cb457a654351
and
https://www.spinics.net/lists/linux-parisc/msg09070.html

>> and we don't care about it, 

I (and a few others) do care about it.

>> then we'd be better of removing all native 64-bit
>> syscalls from arch/parisc/kernel/syscall_table.S.
> 
> Ok, then let's treat this like any other arch/driver/subsystem that we
> remove.  Drop the file(s) in a -rc1 merge window and then if anyone
> object to it later on because they really were using it, you can easily
> revert that change.

As a maintainer of this port, I object to this.
You suggest to remove a working, functional and maintained interface for no good use.
Removing it won't save lots of bytes in the executable (or source code)
but will make my life as maintainer harder.

Thanks,
Helge

> 
> We do not backport removals of drivers/subsystems/arches to stable
> kernels, so this shouldn't happen here either.
> 
> thanks,
> 
> greg k-h
