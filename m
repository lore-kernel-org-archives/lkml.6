Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeDINI7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:08:59 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33046 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbeDINI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:08:57 -0400
X-Google-Smtp-Source: AIpwx482EjHYOYuP7ORUEbzXmUupwwweZkSffE9ouAQf+SoTPoiSRoTS+GF4GaL8noYyo5kgOUnWRw8hzkYJDA0Bu6s=
MIME-Version: 1.0
In-Reply-To: <e5bd38c0bd81236e11fd391ec3339d3bdf3c29d5.1522546571.git.fthain@telegraphics.com.au>
References: <cover.1522546571.git.fthain@telegraphics.com.au> <e5bd38c0bd81236e11fd391ec3339d3bdf3c29d5.1522546571.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Apr 2018 15:08:56 +0200
X-Google-Sender-Auth: k4nRddCl6BtCXmjlqgkhll7rOuQ
Message-ID: <CAMuHMdXC3d84tJLsr=mZx20qsF6ddvmNMSFOCY-xHmzqDF3qhQ@mail.gmail.com>
Subject: Re: [PATCH 06/12] block/swim: Fix array bounds check
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Sun, Apr 1, 2018 at 3:41 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> In the floppy_find() function in swim.c is a call to
> get_disk(swd->unit[drive].disk). The actual parameter to this call
> can be a NULL pointer when drive == swd->floppy_count. This causes
> an oops in get_disk().
>
> Data read fault at 0x00000198 in Super Data (pc=0x1be5b6)

[...]

> Fix the array index bounds check to avoid this.
>
> Fixes: 8852ecd97488 ("[PATCH] m68k: mac - Add SWIM floppy support")
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Looks like amiflop.c:find_floppy() needs a check, too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
