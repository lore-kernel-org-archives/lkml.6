Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeBZJqu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:46:50 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46682 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeBZJqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:46:47 -0500
X-Google-Smtp-Source: AG47ELuWGn/zWMMESh8zv/4HpOzhXgTCfjtGhiDyf5hM+MFKwe5ct6CJ018VJgh7aMENCO5o5nN//2ba+f9IHPzbxNo=
MIME-Version: 1.0
In-Reply-To: <1518425633-19803-1-git-send-email-geert@linux-m68k.org>
References: <1518425633-19803-1-git-send-email-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2018 10:46:46 +0100
X-Google-Sender-Auth: B7f1pY5q3lVhG2hHgFXEqfLwb5s
Message-ID: <CAMuHMdX22KBFnX_yObmb8ZBrDHtmMg9kfeDQBftcxELjGWUBpg@mail.gmail.com>
Subject: Re: [PATCH] m68k/mm: Stop printing the virtual memory layout
To: linux-m68k <linux-m68k@vger.kernel.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>, Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 9:53 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with
> %p"), the virtual memory layout printed during boot up contains "ptrval"
> instead of actual addresses:
>
>     Memory: 268040K/276480K available (2979K kernel code, 310K rwdata, 784K rodata, 144K init, 172K bss, 8440K reserved, 0K cma-reserved)
>     Virtual kernel memory layout:
>         vector  : 0x003d2e74 - 0x003d3274   (   1 KiB)
>         kmap    : 0xd0000000 - 0xf0000000   ( 512 MiB)
>         vmalloc : 0x11800000 - 0xd0000000   (3048 MiB)
>         lowmem  : 0x00000000 - 0x11000000   ( 272 MiB)
>           .init : 0x(ptrval) - 0x(ptrval)   ( 144 KiB)
>           .text : 0x(ptrval) - 0x(ptrval)   (2980 KiB)
>           .data : 0x(ptrval) - 0x(ptrval)   (1095 KiB)
>           .bss  : 0x(ptrval) - 0x(ptrval)   ( 173 KiB)
>
> Instead of changing the printing to "%px", and leaking virtual memory
> layout information again, just remove the printing completely, cfr. e.g.
> commit 071929dbdd865f77 ("arm64: Stop printing the virtual memory
> layout").
>
> All interesting information (actual section sizes) is already printed by
> mem_init_print_info() just above anyway.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied and queue for v4.17.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
