Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754174AbeDPJCA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:02:00 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:41952 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbeDPJB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:01:59 -0400
X-Google-Smtp-Source: AIpwx49e2bvnbGfCfESFqBeIuQtp4uAk+AkGKWtaPJueweB6as03cnNTFs62DoAjRaNnnyYeEXS+VDQD+6krkTvofW8=
MIME-Version: 1.0
In-Reply-To: <CA+55aFx62iBkj+hOmhLksUtvjwTcm_o1dwcyvaNnVpJ-AmvzVQ@mail.gmail.com>
References: <CA+55aFx62iBkj+hOmhLksUtvjwTcm_o1dwcyvaNnVpJ-AmvzVQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Apr 2018 11:01:57 +0200
X-Google-Sender-Auth: XH9dQFNUXXYc8lXjt8caVynZYo8
Message-ID: <CAMuHMdUQyiY6cPqYViHtgEX1rnBmSbrmQOivtCmSAO_b3ci5Uw@mail.gmail.com>
Subject: Re: Linux 4.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 3:55 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> We actually have a fair amount of other removal and cleanups too. I
> was somewhat pleasantly surprised by the number of pull requests that
> actually ended up removing a lot of lines. Some of it was staging
> drivers that finally gave up the ghost (like irda), but we also got
> rid of some copyright language boiler-plate in favor of just the spdx
> lines. And some pre-shipped lexer/parser files are no more, we're
> better off just generating them.
>
> End result: we actually removed more lines than we added:
>
>  13538 files changed, 627723 insertions(+), 818855 deletions(-)
>
> which is probably a first. Ever. In the history of the universe. Or at
> least kernel releases.
>
> I'd call it momentous, but I think the arch removal was most of it,
> and I'm sure people will quickly rectify that momentary glitch of
> actually shrinking the kernel source code.

For the first time ever(?), we also had a kernel size reduction, according
to bloat-o-meter (for an m68k atari_defconfig kernel):

    add/remove: 341/440 grow/shrink: 445/359 up/down: 60125/-133422 (-73297)

which brings us (size-wise) back to v4.13-and-a-half.
This is mostly attributed to the removal of lots of SyS_* functions.

However, my enthusiasm was tempered when I noticed  the same size reduction
is not reflected in actual kernel size:

       text    data     bss     dec     hex filename
    3313377 836572 177724 4327673 4208f9 vmlinux-v4.16
    3327960 834636 173112 4335708 42285c vmlinux-v4.17-rc1

or at runtime:

-Memory: 268040K/276480K available (2980K kernel code, 308K rwdata,
784K rodata, 144K init, 172K bss,  8440K reserved, 0K cma-reserved)
+Memory: 268028K/276480K available (2994K kernel code, 301K rwdata,
788K rodata, 144K init, 167K bss, 8452K reserved, 0K cma-reserved)

Probably I (and bloat-o-meter) are missing something?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
