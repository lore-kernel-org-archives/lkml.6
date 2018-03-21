Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbeCUIGz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:06:55 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:47103 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCUIGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:06:52 -0400
X-Google-Smtp-Source: AG47ELuFk26ksLJrfDYWHoR9cbmaFpWzzwU4IM0/3WCJrc53Q5D99N6LKfYCl+WOXMR438VJgEBWAjhJF0rmrrJFmuM=
MIME-Version: 1.0
In-Reply-To: <20180319221622.16867-1-stefan@agner.ch>
References: <20180319221622.16867-1-stefan@agner.ch>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Mar 2018 09:06:50 +0100
X-Google-Sender-Auth: jZiID-JHY402iCPy4RttDTYEE14
Message-ID: <CAMuHMdUnLP4DU2-o6PBOJDZf9dBMGx6TTYN3rEdA5UxznZGxOw@mail.gmail.com>
Subject: Re: [PATCH v2] spi: rspi: use correct enum for DMA transfer direction
To: Stefan Agner <stefan@agner.ch>
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Mon, Mar 19, 2018 at 11:16 PM, Stefan Agner <stefan@agner.ch> wrote:
> Use enum dma_transfer_direction as required by dmaengine_prep_slave_sg
> instead of enum dma_data_direction. This won't change behavior in
> practice as the enum values are equivalent.

Thanks for catching!

BTW, spi-sh-msiof has the same issue. Will sent a fix.

> This fixes two warnings when building with clang:
>   drivers/spi/spi-rspi.c:538:26: warning: implicit conversion from enumeration
>       type 'enum dma_data_direction' to different enumeration type
>       'enum dma_transfer_direction' [-Wenum-conversion]
>                                         rx->sgl, rx->nents, DMA_FROM_DEVICE,
>                                                             ^~~~~~~~~~~~~~~
>   drivers/spi/spi-rspi.c:558:26: warning: implicit conversion from enumeration
>       type 'enum dma_data_direction' to different enumeration type
>       'enum dma_transfer_direction' [-Wenum-conversion]
>                                         tx->sgl, tx->nents, DMA_TO_DEVICE,
>                                                             ^~~~~~~~~~~~~
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

JFTR, as it's already applied
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
