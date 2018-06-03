Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeFCDAX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 23:00:23 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:39246 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbeFCDAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 23:00:22 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w53304OW017870
X-Nifty-SrcIP: [209.85.213.51]
X-Google-Smtp-Source: ADUXVKKbtWuQ2XDA6bas/U7ksZ78CaL4986Vavjo5apousx9DRSm4SloLSZgBdufaNWBWfJrAb/Q0RxvdcRTOWOFYg4=
MIME-Version: 1.0
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 3 Jun 2018 11:59:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ7tCC93Ep=5QJ4VQmS83HJ7MhEyLwE1ohTMUbzCnDkqg@mail.gmail.com>
Message-ID: <CAK7LNAQ7tCC93Ep=5QJ4VQmS83HJ7MhEyLwE1ohTMUbzCnDkqg@mail.gmail.com>
Subject: Re: [PATCH 0/7] MIPS: boot: fix various problems in arch/mips/boot/Makefile
To: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi MIPS maintainers,

2018-04-16 23:47 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>
> When I was trying to fix commit 0f9da844d877 in a more correct way,
> I found various problems in arch/mips/boot/Makefile.
>
> ITS is always rebuilt when you rebuild the kernel without touching
> anything.  Many build rules are wrong.
>
> If you look at the last patch in this series, you may realize
> supporting ITB building in the kernel can cause nasty problems.
> Personally, I do not like it, but I tried my best to fix the problems.
>
> With this series, ITB is rebuilt only when necessary.
>

Is any part of this series applicable?
At least, patch 1-4 look simple to me.


Patch 5-7 should be applied together.
The last one is a bit tricky, so you can ignore 5-7 if you do not like them.
(Only the problem is, ITB files are always rebuilt even if nothing is changed.)

>
> Masahiro Yamada (7):
>   Revert "MIPS: boot: Define __ASSEMBLY__ for its.S build"
>   MIPS: boot: do not include $(cpp_flags) for preprocessing ITS
>   MIPS: boot: fix build rule of vmlinux.its.S
>   MIPS: boot: correct prerequisite image of vmlinux.*.its
>   MIPS: boot: add missing targets for vmlinux.*.its
>   MIPS: boot: merge build rules of vmlinux.*.itb by using pattern rule
>   MIPS: boot: rebuild ITB when contained DTB is updated
>
>  arch/mips/boot/Makefile | 69 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 37 insertions(+), 32 deletions(-)
>
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
