Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754948AbeDPNP7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:15:59 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37698 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753479AbeDPNP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:15:57 -0400
X-Google-Smtp-Source: AIpwx49PcnAoT75idlIllFpsVrnn99ArAMnX7YHawYvqO1abTkz3C4y7md1CqNw0EvMQhDVFnKwxrWtVhgV3YXEpTMw=
MIME-Version: 1.0
In-Reply-To: <1523884165-17044-1-git-send-email-geert@linux-m68k.org>
References: <1523884165-17044-1-git-send-email-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Apr 2018 15:15:56 +0200
X-Google-Sender-Auth: zGcFdxJMAlmPnT5oVSpGGcSzoQ8
Message-ID: <CAMuHMdVKszYm5jH+o8iLdBdPTcsnpUr3rs4Z3kPtKXXH4fs8fw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.17-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "the arch/x86 maintainers" <x86@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 3:09 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.17-rc1[1] compared to v4.16[2].
>
> Summarized:
>   - build errors: +2/-10
>   - build warnings: +1407/-1867
>
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/head/60cc43fc888428bb2f18f08997432d426a243338/ (244 out of 246 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/0adb32858b0bddf4ada5f364a84ed60b196dbcda/ (all 246 configs)
>
>
> *** ERRORS ***
>
> 2 error regressions:
>   + /kisskb/src/include/linux/thread_info.h: error: call to '__bad_copy_from' declared with attribute error: copy source size is too small:  => 138:19

i386-allmodconfig

>   + error: No rule to make target arch/parisc/kernel/binfmt_elf32.o:  => N/A

parisc64/a500_defconfig (patch available)

> *** WARNINGS ***
>
> [Deleted 799 lines about "warning: ... [-Wpointer-sign]" on parisc-allmodconfig]
> [Deleted 1480 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on parisc-allmodconfig]

BTW, are there any plans to fix/silence these warrnings?
Or should I look into automating their removal from the logs/report
(optimistic me keeps on postponing that task :-)?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
