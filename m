Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9132DC4646E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5045F217B4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5045F217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbeHDAct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 20:32:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:46835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731682AbeHDAct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 20:32:49 -0400
Received: from [192.168.43.192] ([80.187.96.219]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqALY-1gPA8k0Z4C-00djc1; Sat, 04
 Aug 2018 00:34:22 +0200
Subject: Re: [PATCH] parisc: prefer _THIS_IP_ and _RET_IP_ statement
 expressions
To:     Nick Desaulniers <ndesaulniers@google.com>, dave.anglin@bell.net
Cc:     jejb@parisc-linux.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alistair Strachan <astrachan@google.com>
References: <20180801182258.17834-1-ndesaulniers@google.com>
 <78c667f9-5c8b-3835-83eb-4b59e27e4f7e@bell.net>
 <CAKwvOdmdrA+UvAWyqe8sNJt5nxHXHsSwf5Yxih9HYgVL+kovxQ@mail.gmail.com>
 <fe7b57d8-b586-a390-31d2-2274f69db3c0@bell.net>
 <CAKwvOd=CLBFZRQ4HQb_+VCydDEvsbC2w2gD4hTwvp_jm1zqN9Q@mail.gmail.com>
 <54b2139b-53d2-01c5-f240-93a692cdbc59@bell.net>
 <CAKwvOdktvrZL8T_5K2VtQtgt_mscS7kzVXYVy0O7CSuGX53Y5A@mail.gmail.com>
 <536ef1b1-cfa2-f66d-4261-fb8405964632@bell.net>
 <CAKwvOdmwj76aESZNKhzfPmhfzGKvrfDut7oD5KAwA+VR-JukSg@mail.gmail.com>
 <80743c1c-2a8c-7bce-2068-24c63790eba7@bell.net>
 <CAKwvOdmDwO1U1sk=3-6zXFrVw6by1e_9VBx1WWMCx_rMqYSw-A@mail.gmail.com>
 <81a7e33a-0403-b6d4-fcba-c2168a608ba6@bell.net>
 <CAKwvOdmXi_EY5=sOO9tRqeoFrHjLsF9L988cGC2yjnFYBxac4w@mail.gmail.com>
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
Message-ID: <1d577675-c337-d433-f235-1e46e5d56d4c@gmx.de>
Date:   Sat, 4 Aug 2018 00:34:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmXi_EY5=sOO9tRqeoFrHjLsF9L988cGC2yjnFYBxac4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yAzJ0t/hyAB+DkGNm6p/76zum8c3ISL5C/1DiDa1+mixbbQFIy7
 hWQFd0cKcdhPQ3YcRxj00URU26O6W1VWA46I23TnA+bwUM3DOWrz5VoXHlGKiBEYEF2Joks
 xpLmCDNDS5TEwuAUFC7BMv1tP5ILEWZbQhniUyozqz7Z3p4n8DGFbUqWNxiOOJ2TpL+WSaY
 MH5yvnX+rBUFf7rtiqPhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ak8G7+lxQ9Y=:bmPPkQS0Mngsl1+lVftLVu
 KeFSkONYPXh7q/SUnxMTA74vqF/WI1n+440YgoEHnktkhxzcB5IWyT+LUvLJS/18ltUTnjaDZ
 vp71hizeUQnN7bYur+qHjM7+efD3YXRBEh9Ty90OD4SJ7KtQlssG0hxf0kNcYT2+pCxzp7Yt3
 XDoGUgRTq6Kzu34ZkxODD4SpM6XYQlAZSD22azje6f0wXBtoZJ8G7IK/czTWElUW3joO67dXb
 CDAPOvnmFgEMJBLko33GU8k9+ocINugogtPHeCzPOnV6YkY3kIm5spMrXIq97Ptta0ER8b/cJ
 LVYqNz2PgxtEdMpk7MY7mHTKZcz+nT4cPD6Sa0lG1iXcO1FbCcUtJr9pwZDjLlpVCrQrcWCan
 qvnM8QHpy8VlwPE730m1alkH6oH24KbijPe4Ie6kXZNTVoEwK4d27TcMGlCG4j80V8XEHVBIJ
 blv0ZL46Sa1hEKD+NwS+b0Bbx2bdGnYFE/+49rWMD5yho4f+/xSltLsSE9xJrHBSHPOcGUu36
 JBnqUGBIv7W44KISSKy0D2b0B3NXLBBOorY27YovN2z7cBPkJ2V1Ne1Y+2diSg+1E882BqOLE
 zt/9dy9x7/EGqPCbzfFIR2oQmGBX3VL1LIQ8ngpUQeMBLUyCm7pHYu/BKa2C+N+9fOarRVOZO
 V9257QfVvUD69RUABasg/hlFy6SnMyDF/mbxu42LQJcHfnNw80ghNCJN+/7EwrALi0g464R0t
 DSaV9qya2AMLcoTf4xOqQyekmcVfdsdANe0Z3hvayiyK2wadZddDAbm3Hhdz9R9IgUdzuvrj5
 WJbBPBR
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.2018 22:33, Nick Desaulniers wrote:
> On Fri, Aug 3, 2018 at 12:09 PM John David Anglin <dave.anglin@bell.net> wrote:
>>
>> On 2018-08-03 2:11 PM, Nick Desaulniers wrote:
>>> But the kernel uses the generic_THIS_IP_  *everywhere*, not parisc's
>>> custom current_text_addr().  So if this did actually break unwinding,
>>> you should have noticed by now.
>> The unwind problem was noticed.
> 
> So parisc is currently broken (doesn't unwind) due to the pervasive
> use of _THIS_IP_ (generic C) throughout the kernel?

I tested it on the 32bit kernel.
The answer is: No. Unwinding works (with and without your patch).
 
> If no, that implies this patch (generic C) causes no unwinding problems.

correct.

> If yes, that implies that the diff I posted later in this thread
> (inline assembly) is preferable, and that parisc has bigger problems
> (and probably needs to do rewrite the unwinding code to handle these
> extra labels everywhere).
> 
>> Patches were recently applied to gcc and binutils to try and fix it.
>> The gcc patch moved
>> branch tables to rodata so that the label at the head of the table
>> wasn't in text.
>>
>> https://gcc.gnu.org/ml/gcc-patches/2018-07/msg01804.html
>> https://sourceware.org/ml/binutils/2018-07/msg00474.html
>>
>> When I saw your suggested change, I realized there was another source of
>> text labels
>> that need linker relocations.
> 
> Thank you for the links.
> 
> On Fri, Aug 3, 2018 at 10:57 AM John David Anglin <dave.anglin@bell.net> wrote:
>> The label breaks the unwind data, not the unwind code.  So, localizing
>> the use of
>> current_text_addr() to the parisc unwind code doesn't help.
> 
> Have you confirmed that applying my patch breaks *the ability to
> unwind correctly*?

I tested your patch (on 32bit).
Your patch does not break anything.

> It looks like return_address() is used in
> ftrace_return_address(), so I assume you can boot a kernel with my
> patch applied, and CONFIG_FTRACE=y, then run:
> 
> $ sudo trace-cmd record -p function date
> $ trace-cmd report | grep date- | less
> 
> and see if the stacks aren't unwound or look messed up.

I faced issues with trace-cmd, but calling ftracing functions manually worked.

So, your patch is basically OK and doesn't break anything.
But I agree with Dave that Andrew, that THIS_IP is ugly.

Helge
