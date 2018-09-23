Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F67ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823E821473
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823E821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeIXBrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 21:47:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:45313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbeIXBrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 21:47:01 -0400
Received: from [192.168.20.60] ([92.116.133.205]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJjOu-1g33tq0G3A-0016FV; Sun, 23
 Sep 2018 21:48:14 +0200
Subject: Re: [PATCH 0/4] System call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>, linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        marcin.juszkiewicz@linaro.org
References: <1536913603-4584-1-git-send-email-firoz.khan@linaro.org>
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
Message-ID: <844186da-0900-3c50-31f4-8600581b5675@gmx.de>
Date:   Sun, 23 Sep 2018 21:48:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1536913603-4584-1-git-send-email-firoz.khan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yd1sUQjY7F4fqBHvQRW6n1huTeksu9NeImWXz4RhwIwEtW/dFXf
 9Ks90PfQyp6GPv+gLP5AyuQ6QtBCjJcXMTlTdeYGDK+XihvC2o02r6apd05IOQlzqNioTCt
 Mj42C7t/tZ074V3mxydWzCoeCT/7PXHXhXpMyU9ijs4DDkkDMDAgjDOJYmdleL0m45Z/vX7
 2GW/2o5ONMDPvZeGsl7FQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qsNgqpjHM3w=:kHcdAcNhbYkYXcApX8zD+E
 oo+be2BlAKxDaLuJxXKrDIraYSkxImQxniCklxHHDRrO2EqPiIpcYuI/WUSaBPs2uIlES77EV
 ExSwt2g9XVE67YfJ1R506iqp1/at/JorzB45Y8rm/vYxTyqjTxafKXmA2ThlrDtymtAypHpps
 R0sksEzU4dJJk/aqiVi0X2SxMFPd8Cm3tz8krzYlPy2vfP40TzGxLucdGYRWXTEoK9YcxltR4
 ZfrfxK1mhSEOm63W1ElCJTw2r6nDjLEjFePvbOs1fJ3EoHNjr0BwqxUWjS6/oYihdWCOpAKKV
 qnOgPFHykCoH745QObFx8k+DcnHvzoVqc24EbzEj2kx7snFoiDNLv/ZLfV/dxOBBQqXvpCiSc
 OBAEpOfUZry4Z30Uk7m41JIQW7p6XT+S/5s5SDEikO1w58NO1L/CpHHvECu1Gceh6ll70y7AO
 PzziGSi/Ag8rJSFvRmwu8JGfhEHI8U7vg1IYUPPvrTlYYY2HgVm2muelYde6Do3sbxbjZ4VZQ
 UXGCBlZ2c6zDfSsUV+lM3Obb4r7aHO5Eo2/eCdB0Tmq58TLPlBQf4sKgkh5gurJh6SF9gjTwx
 EBK3BOyIJBy/Qu2H3zVaFqtgMRiwsddxKtYIbw+3hn/n2HFd4qbrM66KiHS8xO0i2oF2+Zrjb
 BRaYR1YWnqCsgY6d4x6FbHHWeN+Rjh1bn6hPviEYkcXe+QJPHxCcJkHjyWYRIUeEfapjCZhQp
 ebu9kOkItI6G3Wj/wh//dRFq2+YSx6cTBUF9o3tfTN/wRY76U8XN3SezwPiUZ1uIYjDvVTeg2
 33gbP0FkdxULKzg90zAAL9QgpFi191zmj8kLLzqC9eksBHVMW0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On 14.09.2018 10:26, Firoz Khan wrote:
> The purpose of this patch series is:
> 1. We can easily add/modify/delete system call by changing entry 
> in syscall.tbl file. No need to manually edit many files.
> 
> 2. It is easy to unify the system call implementation across all 
> the architectures. 

I like the idea.
 
> The system call tables are in different format in all architecture 
> and it will be difficult to manually add or modify the system calls
> in the respective files manually. To make it easy by keeping a script 
> and which'll generate the header file and syscall table file so this 
> change will unify them across all architectures.
> 
> syscall.tbl contains the list of available system calls along with 
> system call number and corresponding entry point. Add a new system 
> call in this architecture will be possible by adding new entry in 
> the syscall.tbl file.
> 
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>         - Compat entry name, if required.
> 
> ARM, s390 and x86 architecuture does exist the similar support. I 
> leverage their implementation to come up with a generic solution.
> 
> I have done the same support for work for alpha, m68k, microblaze, 
> ia64, mips, powerpc, sh, sparc, and xtensa. But I started sending 
> the patch for one architecuture for review. Below mentioned git
> repository contains more details.
> Git repo:- https://github.com/frzkhn/system_call_table_generator/
> 
> Finally, this is the ground work for solving the Y2038 issue. We 
> need to add/change two dozen of system calls to solve Y2038 issue. 
> So this patch series will help to easily modify from existing 
> system call to Y2038 compatible system calls.
> 
> I started working system call table generation on 4.17-rc1. I used 
> marcin's script - https://github.com/hrw/syscalls-table to generate 
> the syscall.tbl file. And this will be the input to the system call 
> table generation script. But there are couple system call got add 
> in the latest rc release. If run Marcin's script on latest release,
> It will generate a new syscall.tbl. But I still use the old file - 
> syscall.tbl and once all review got over I'll update syscall.tbl 
> alone w.r.to the tip of the kernel. The impact of this thing, few 
> of the system call won't work. 
> 
> Firoz Khan (4):
>   parisc: Move __IGNORE* entries to non uapi header
>   parisc: Replace __NR_Linux_syscalls macro with __NR_syscalls
>   parisc: Add system call table generation support
>   parisc: uapi header and system call table file generation
> 
>  arch/parisc/Makefile                       |   4 +
>  arch/parisc/include/asm/Kbuild             |   3 +
>  arch/parisc/include/asm/unistd.h           |   8 +
>  arch/parisc/include/uapi/asm/Kbuild        |   2 +
>  arch/parisc/include/uapi/asm/unistd.h      | 377 +----------------------
>  arch/parisc/kernel/syscall.S               |  14 +-
>  arch/parisc/kernel/syscall_table.S         | 459 -----------------------------
>  arch/parisc/kernel/syscall_table_32.S      |  11 +
>  arch/parisc/kernel/syscall_table_64.S      |  19 ++
>  arch/parisc/kernel/syscalls/Makefile       |  52 ++++
>  arch/parisc/kernel/syscalls/syscall_32.tbl | 358 ++++++++++++++++++++++
>  arch/parisc/kernel/syscalls/syscall_64.tbl | 357 ++++++++++++++++++++++
>  arch/parisc/kernel/syscalls/syscallhdr.sh  |  38 +++
>  arch/parisc/kernel/syscalls/syscalltbl.sh  |  36 +++
>  14 files changed, 896 insertions(+), 842 deletions(-)
>  delete mode 100644 arch/parisc/kernel/syscall_table.S
>  create mode 100644 arch/parisc/kernel/syscall_table_32.S
>  create mode 100644 arch/parisc/kernel/syscall_table_64.S
>  create mode 100644 arch/parisc/kernel/syscalls/Makefile
>  create mode 100644 arch/parisc/kernel/syscalls/syscall_32.tbl
>  create mode 100644 arch/parisc/kernel/syscalls/syscall_64.tbl
>  create mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh

Your parisc patches don't apply any longer.
If you update them (with the feedback given by others), I'm happy
to test your patch again on parisc.

Helge
