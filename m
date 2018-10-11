Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1230EC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF812077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF812077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeJKRyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:54:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:58011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeJKRyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:54:16 -0400
Received: from [10.95.173.99] ([155.56.40.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MAgvb-1fyhYi3Uz5-00Bxap; Thu, 11
 Oct 2018 12:27:27 +0200
Received: from [10.95.173.99] ([155.56.40.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MAgvb-1fyhYi3Uz5-00Bxap; Thu, 11
 Oct 2018 12:27:27 +0200
Subject: Re: [PATCH v3 4/6] parisc: uapi header and system call table file
 generation
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-5-git-send-email-firoz.khan@linaro.org>
 <20181009201321.GA28911@ls3530.fritz.box>
 <CALxhOnjxkq1-N59i81+ra58tZhx7Gik6iPyUsNFJY9wEJA+D1w@mail.gmail.com>
 <CALxhOnj1SnTO9Sm-1cAL9B8gEmYrOHr03K6OqF4qqt5Oh0x+4g@mail.gmail.com>
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
Message-ID: <4c659c11-85a3-68da-b7c9-60042d611a72@gmx.de>
Date:   Thu, 11 Oct 2018 12:27:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CALxhOnj1SnTO9Sm-1cAL9B8gEmYrOHr03K6OqF4qqt5Oh0x+4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ElKUU9FOrWBYGYHngiVR2fX72HeJuc9qTod9cMD/OSvIQu70pmW
 iU83NZ56sU0ySulWsrT6t+hy8Sz00jKhruWKERX/azSX4+vqFtsrZ+E5o7bnfjoD8Wpcp9s
 kO09vR7S//RQrRzugeudfhfu/Anr5E2Om9vbT5WR3RgHmBzsAaHcdBL66Z4qFkjrtoPvg1y
 PTk7ZVu4p25Fb+zK19pKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FTBpJB4Aexg=:qNcmcD0FfqqN+Sv8Zo8kLo
 olAK2RouV+zgpQ241rRzNQFe6A5nK0Me2q+DJL0kpMhwnrlO6ib6gLwOvt7K8D5+uLJ5Tt1D4
 FCRIlm3F6YnUkdVa2x5J8A99WfqYKGI7agb+BC1g236+VFoO+RQJ46AnHNjqGX6sxSudUgyR/
 nCWZEYn7R3as5DudVeD2Rljxe2hcItQfTKgrwu8yRQacFVI26tbXxPQ+aHuoG+Ce1U4x9UhzY
 Ku5i4Gq+DyAI1gJtGPllZ3/Vt/kKFnm101rtH0G1uFQ/midBF6Bm/cH7WvQpEgIE66aGhtr2v
 BI2ZdkHAZqv15UOe6fUAwwAanC9SAvpmP8UwX2KviEtFyoqkhwYJJiPXEn5/xLjsfTnnbW96u
 1S6IBJH6bq4p2drbkNeQTp1H8OIjh26FYlBS+0D63rA6E1EUrOrvCZvTZoC6niJkqmQz5OTH7
 F+pHiz69tLbVUr3laszj+OgRK78J0OsEPc73MUVEVN8VLG+ePj6P2FryAobcBMyjLKSUg3cTd
 1BORnPLVhvcj6HlB9fZ6nqU0hYyRE+p4PYl5t+CoZU8IE3UCEpn8k3Py2RqqpyMRCrx+oe1+D
 XeNMakmuLWGdxe+6xV0gTKfWa4QQnxseje0tq3nN/D38qA1tc2GpZDhuZXupYunHJxHiQDF3M
 1SnQ1O7PF7aAp6kHQJxrkZ5CAGEXNBD6rYNOw2ggtw1WNJJ+uB2VDq0FbvBCmcsZ3UdXLhK7O
 rBELQd7YLBYSxTnp7yjq4lTv4SuZsBa8In8wUVyCmPnMrjxw4kyLMQdicfCFN/xdPUxgR8M5F
 4aSlFo+wT+RiVj4HpTdtCxWHaUBy+sKZ0sdVl5Wb7p3hJb1+IQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2018 08:48, Firoz Khan wrote:
> Hi Helge,
> 
> On Thu, 11 Oct 2018 at 11:40, Firoz Khan <firoz.khan@linaro.org> wrote:
>>
>> Hi Helge,
>>
>> On Wed, 10 Oct 2018 at 01:48, Helge Deller <deller@gmx.de> wrote:
>>>
>>> * Firoz Khan <firoz.khan@linaro.org>:
>>>> System call table generation script must be run to generate
>>>> unistd_32/64.h and syscall_table_32/64/c32.h files. This patch
>>>> will have changes which will invokes the script.
>>>>
>>>> This patch will generate unistd_32/64.h and syscall_table_
>>>> 32/64/c32.h files by the syscall table generation script
>>>> invoked by arch/parisc/Makefile and the generated files against
>>>> the removed files will be identical.
>>>>
>>>> The generated uapi header file will be included in uapi/asm/
>>>> unistd_32/64.h and generated system call table support file will
>>>> be included by arch/sparc/kernel/syscall_table_32/64.S file.
>>>>
>>>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>>>> ---
>>>>  arch/parisc/Makefile                  |   4 +
>>>>  arch/parisc/include/asm/Kbuild        |   3 +
>>>>  arch/parisc/include/uapi/asm/Kbuild   |   2 +
>>>>  arch/parisc/include/uapi/asm/unistd.h | 373 +--------------------------
>>>>  arch/parisc/kernel/syscall.S          |  12 +-
>>>>  arch/parisc/kernel/syscall_table.S    | 459 ----------------------------------
>>>
>>>
>>> Can we please get rid of those two new files:
>>
>> Yes, we don't need those files some of the architecture and other
>> architecture does have same/similar files. That's why I added below
>> files, so every architecture implementation looks same.
>>
>> I feel it is better to remove these files.
>> Arnd, Do u have any comment on this?
>>
>> Thanks
>> Firoz
>>
>>>
>>>>  arch/parisc/kernel/syscall_table_32.S |  13 +
>>>>  arch/parisc/kernel/syscall_table_64.S |  20 ++
>>>
>>> Both are not needed (at least on parisc) if you apply the following
>>> patch on top of your patch series.
>>> This patch finally fixes the 64-bit kernel on parisc (tested on real
>>> hardware).
>>>
>>> Helge
>>>
>>> diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
>>> index 2523b83b88d8..45cddeeb968f 100644
>>> --- a/arch/parisc/kernel/syscall.S
>>> +++ b/arch/parisc/kernel/syscall.S
>>> @@ -923,10 +923,20 @@ ENTRY(lws_table)
>>>  END(lws_table)
>>>         /* End of lws table */
>>>
>>> -#include "syscall_table_32.S"
>>> +#define __SYSCALL(nr, entry, nargs) ASM_ULONG_INSN entry
>>> +
>>> +ENTRY(sys_call_table)
>>> +#if defined(CONFIG_64BIT)
>>> +#include <asm/syscall_table_c32.h>     /* compat syscalls */
>>> +#else
>>> +#include <asm/syscall_table_32.h>      /* 32-bit native syscalls */
>>> +#endif
>>> +END(sys_call_table)
>>> +
>>>  #ifdef CONFIG_64BIT
>>> -#define SYSCALL_TABLE_64BIT
>>> -#include "syscall_table_64.S"
>>> +ENTRY(sys_call_table64)
>>> +#include <asm/syscall_table_64.h>      /* 64-bit native syscalls */
>>> +END(sys_call_table64)
>>>  #endif
>>>
>>>         /*
> 
> I could see a patch (commit 47514da3ac20150cdf764466fbc2010c0fca0163)
> which will perform a compile-check when adding a new syscall. My patches
> will remove this feature. Is that fine?

Yes, removing that feature is OK.
Since everything is then autogenerated I don't expect such bugs.

Helge
