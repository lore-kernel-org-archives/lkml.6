Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeDINOd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:14:33 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:34730 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeDINOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:14:31 -0400
X-Google-Smtp-Source: AIpwx4/TARL9lOQGao88eSTS/Luj5Jdzn0czm+xisdYLcSyEVAKLvGXqZDlNiUHYu0m06r7ZipxlNJ8e0AxZGk8qepw=
MIME-Version: 1.0
In-Reply-To: <803fabab1f0349bafe52b5589eff3edc077eee2d.1522546571.git.fthain@telegraphics.com.au>
References: <cover.1522546571.git.fthain@telegraphics.com.au> <803fabab1f0349bafe52b5589eff3edc077eee2d.1522546571.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Apr 2018 15:14:29 +0200
X-Google-Sender-Auth: CthSo3xa-y_4OawkOlmvQNz09Qg
Message-ID: <CAMuHMdWe6pWFd0977n4FoGsPuvhS-yYKSBVfYDR8Y8gBEej3Eg@mail.gmail.com>
Subject: Re: [PATCH 08/12] block/swim: Don't log an error message for an
 invalid ioctl
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 1, 2018 at 3:41 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The 'eject' shell command may send various different ioctl commands.
> This leads to error messages on the console even though the FDEJECT
> ioctl succeeds.
>
> ~# eject floppy
> SWIM floppy_ioctl: unknown cmd 21257
> SWIM floppy_ioctl: unknown cmd 1
>
> Don't log an error message for an invalid ioctl, just do as the
> swim3 driver does and return -ENOTTY.
>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Looks like amiflop can use a similar fix.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
