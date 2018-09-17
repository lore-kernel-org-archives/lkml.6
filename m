Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FEBECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056B62147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056B62147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeIRBPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:15:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:39513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbeIRBPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:15:49 -0400
Received: from [192.168.20.60] ([92.116.177.82]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lm3bl-1fTCpS03MX-00ZcTK; Mon, 17
 Sep 2018 21:46:55 +0200
Subject: Re: [RFC] parisc64: change __kernel_suseconds_t to match glibc
To:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc:     y2038@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180913160010.905798-1-arnd@arndb.de>
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
Message-ID: <de79d285-7cbc-e547-547b-cf3e0627950d@gmx.de>
Date:   Mon, 17 Sep 2018 21:46:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180913160010.905798-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wHfSp2tS6CVUa0kL11aWOzZZW3M/vP47S39ZWQ/tgh6VpGr1IJm
 VKKcRwqmElosb8PlLBSYvtB0g+sPZiLFiDDBvyyQjQctCd8hl96YCTQpyOvB4XFs6ysUQ48
 lyct2EMkCTEHVazvZq5ioM5GIdMCiQdnWtpl7o9AKr2Rdny+TZx67vJ8z8fSPxx1Y7o2TNt
 8XxRi3iS0TH9zX+qa8KAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qb5KmUFI7xY=:nYvV6ug1BgqHRh8ikULvWY
 O2p5tX6mnoP0LtD0kgh2OXlM5ttoIwVEbZakOiBe8imr648JOrGDYcyr2oqTUEGx4u01/Uwyf
 854fLH4lTONZtUvC8DyO3SZNplsqLcXndE0JKn51YqQTHOkH00vvqPZlJfKG17TetPgnabL0V
 zCAkig2fG+9O5H4PAyXgSb2nmAGJPvhJbuwgPFtNtpHd+wCglwwgWZho9CQqsLXl5sOyvf87I
 3XKMgc+htsWTT1UX2yVPLgFPyj4nc95quwCk20xpA19NT/q09bVViuXwgBr+NfZoOMoLD2EvZ
 /dhcbFrGqQ794ptixfCkP2/xxmSyvM0WCv4mKvDxI884bWD2BIvGOlMe3OVl6kJIosZ/JuvuS
 nTS68LaJQEm5UaXpHBflPJCi5hwCfDDUA7u4Pa7VykzrzzJe4p9jf8z8BJBfgZ1kTq1xjoJaC
 iFXydO3yWX/vUbISzHl8U+GfJeSFkZ6zpGSD0I9PyuWs6bFE4JX37VK1AWMncuNO7erCBnJj/
 /qjwCo9bUProkF5OtqZCmrODM3h1xwzwLCeZsr7zyCuR9Rz6ymYfQ2jSJwTwQR2i+54GV3UL9
 imVxHYf1xY7UGJva5JasyNya91uS8sWmklPX/aJXZFRaIGAtm51tOJySiigOFNSRM/QMZ/SkC
 W8CbwyUUdi8L8kL4ek/5cgmgdEE2zgB3EJKJH817fUgmiYP0MgCm/QqJjVVkAZdjfJOQbSfNt
 jjEtc/d8pco+0CNXglppMVv+o4+jxsT0bg0tCtDZ16O0wNDaOQwoLsocLYFTcDLR+3zzMer/H
 siBbg9MBfY5aGLoAI1TyXVG0ZR8GXXo9/uekbFSPdP+APn6+l8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 13.09.2018 17:59, Arnd Bergmann wrote:
> There are only two 64-bit architecture ports that have a 32-bit
> suseconds_t: sparc64 and parisc64. I've encountered a number of problems
> with this, while trying to get a proper 64-bit time_t working on 32-bit
> architectures. Having a 32-bit suseconds_t combined with a 64-bit time_t
> means that we get extra padding in data structures that may leak kernel
> stack data to user space, and it breaks all code that assumes that
> timespec and timeval have the same layout.
> 
> While we can't change sparc64, it seems that glibc on parisc64 has always
> set suseconds_t to 'long', and the current version would give incorrect
> results for gettimeofday() and many other interfaces: timestamps passed
> from user space into the kernel result in tv_usec being always zero
> (the lower bits contain the intended value but are ignored) while data
> passed from the kernel to user space contains either zeroes or random
> data in tv_usec.

Should this wrong behavior be visible with 32-bit userspace or
with 64-bit userspace (or both)?
I didn't noticed such wrong behavior yet.

Can you suggest some test programs to verify?
LTP seems to be correct.
 
> Based on that, it seems best to change the user API in the kernel in
> an incompatible way to match what glibc expects.

Basically that sounds the right way to go, but as said before,
I didn't see such issues.

> Note that the distros I could find (gentoo and debian) all just
> have 32-bit user space, which does not suffer from this problem.

That's correct.
Kernel can be 32- or 64-bit, but userspace is currentl 32-bit only.

So, breaking any 64-bit userspace is OK, since we don't have it yet.
Breaking 32-bit userspace needs some thoughts...

Helge


> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/parisc/include/uapi/asm/posix_types.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/parisc/include/uapi/asm/posix_types.h b/arch/parisc/include/uapi/asm/posix_types.h
> index 2785632c85e7..8dce56f5dcee 100644
> --- a/arch/parisc/include/uapi/asm/posix_types.h
> +++ b/arch/parisc/include/uapi/asm/posix_types.h
> @@ -16,9 +16,6 @@ typedef unsigned short		__kernel_mode_t;
>  typedef unsigned short		__kernel_ipc_pid_t;
>  #define __kernel_ipc_pid_t __kernel_ipc_pid_t
>  
> -typedef int			__kernel_suseconds_t;
> -#define __kernel_suseconds_t __kernel_suseconds_t
> -
>  typedef long long		__kernel_off64_t;
>  typedef unsigned long long	__kernel_ino64_t;
>  
> 

