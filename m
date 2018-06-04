Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753059AbeFDMAS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:00:18 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41803 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752448AbeFDMAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:00:16 -0400
X-Google-Smtp-Source: ADUXVKKJdMBCxMO+WDgdx1Z8QJC8UTtYAUAzFB6/gDpaOrTJQfRNSp3jg+1RKAEsN0Anee1sswxgT6RoD2m1sw8AMMI=
MIME-Version: 1.0
In-Reply-To: <af2106d65c6b845c178bb2a0837e8554be2d1e8e.1527909627.git.fthain@telegraphics.com.au>
References: <cover.1527909627.git.fthain@telegraphics.com.au>
 <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
 <7ce9a8c3996506ae6f9ab16b3cf73c287e205a89.1527909627.git.fthain@telegraphics.com.au>
 <8597ac466215f573d8bea40e74fdec2bf72fabbb.1527909627.git.fthain@telegraphics.com.au>
 <878b389293851359e53de186bf302ce52d95ad95.1527909627.git.fthain@telegraphics.com.au>
 <adba0545c06cd6c67e26c433990d036b0d7e968c.1527909627.git.fthain@telegraphics.com.au>
 <166b4c3a7347fe27f12bda86d50533cd01ee11b9.1527909627.git.fthain@telegraphics.com.au>
 <73507a3e9444da17c222cf74df41842ce30d15ee.1527909627.git.fthain@telegraphics.com.au>
 <de8edb03dbd2fd25b53d0bdf9c6d65adf9aa0aa3.1527909627.git.fthain@telegraphics.com.au>
 <ddfa9261a77d747e6523dd5cc0df84cc555dc440.1527909627.git.fthain@telegraphics.com.au>
 <af2106d65c6b845c178bb2a0837e8554be2d1e8e.1527909627.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Jun 2018 14:00:14 +0200
X-Google-Sender-Auth: T1ndPbGsFBKTjaIvek8Ix1FjNuE
Message-ID: <CAMuHMdVQxbVEQ4m+GNa8+noTaTsdyRDAVEiPxUg2zkzmxXK_0g@mail.gmail.com>
Subject: Re: [PATCH 10/11] macintosh/via-pmu: Clean up interrupt statistics
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Sat, Jun 2, 2018 at 5:27 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Replace an open-coded ffs() with the function call.
> Simplify an if-else cascade using a switch statement.
> Correct a typo and an indentation issue.
>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

A few minor nits below...

> --- a/drivers/macintosh/via-pmu.c
> +++ b/drivers/macintosh/via-pmu.c

> @@ -1470,25 +1470,25 @@ pmu_handle_data(unsigned char *data, int len)
>                                 adb_input(data+1, len-1, 1);
>  #endif /* CONFIG_ADB */
>                 }
> -       }
> +               break;
>         /* Sound/brightness button pressed */
> -       else if ((1 << pirq) & PMU_INT_SNDBRT) {
> +       case PMU_INT_SNDBRT:
>  #ifdef CONFIG_PMAC_BACKLIGHT
>                 if (len == 3)
>                         pmac_backlight_set_legacy_brightness_pmu(data[1] >> 4);
>  #endif
> -       }
> +               break;

Please add a blank line after each "break" statement.

>         /* Tick interrupt */
> -       else if ((1 << pirq) & PMU_INT_TICK) {
> -               /* Environement or tick interrupt, query batteries */
> +       case PMU_INT_TICK:

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
