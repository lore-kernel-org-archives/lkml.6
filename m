Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbeBVNU4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:20:56 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43370 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753821AbeBVNUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:20:54 -0500
X-Google-Smtp-Source: AH8x225evFuJYLgzaQM6u7WGQcSbtQE1mx+eenaQwu7uyJRa1/jXjsh9GSmP8UoHKi7R3/Vd1Hna3yAYC52aDR5YZ1M=
MIME-Version: 1.0
In-Reply-To: <1519301715-31798-3-git-send-email-yamada.masahiro@socionext.com>
References: <1519301715-31798-1-git-send-email-yamada.masahiro@socionext.com> <1519301715-31798-3-git-send-email-yamada.masahiro@socionext.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Feb 2018 14:20:53 +0100
X-Google-Sender-Auth: op229qQY1w2L_e9xythnvFaSKVU
Message-ID: <CAMuHMdXsobaUdxMO-3=B56_2pQ2MzG7vxOqt+GzG_OC1T5bL7w@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] m68k: rename UL() to TO_UL()
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On Thu, Feb 22, 2018 at 1:15 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> ARM, ARM64 and UniCore32 define UL(x) like follows:
>   #define UL(x) _AC(x, UL)
>
> While, M68K defines it differently:
>   #define UL(x) ((unsigned long) (x))
>
> I want to move the former to a common header.  Beforehand, this
> commit renames the latter to avoid name conflict.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> V2: https://patchwork.kernel.org/patch/9498273/
>
> Changes in v3: None
> Changes in v2:
>  - Split out as a prerequisite patch
>
>  arch/m68k/mm/init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
> index e85acd1..583a8e5 100644
> --- a/arch/m68k/mm/init.c
> +++ b/arch/m68k/mm/init.c
> @@ -122,9 +122,9 @@ void free_initmem(void)
>
>  void __init print_memmap(void)
>  {
> -#define UL(x) ((unsigned long) (x))
> -#define MLK(b, t) UL(b), UL(t), (UL(t) - UL(b)) >> 10
> -#define MLM(b, t) UL(b), UL(t), (UL(t) - UL(b)) >> 20
> +#define TO_UL(x) ((unsigned long) (x))
> +#define MLK(b, t) TO_UL(b), TO_UL(t), (TO_UL(t) - TO_UL(b)) >> 10
> +#define MLM(b, t) TO_UL(b), TO_UL(t), (TO_UL(t) - TO_UL(b)) >> 20
>  #define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), 1024)

Please note that this code patch is scheduled for removal in v4.17, cfr.
"[PATCH] m68k/mm: Stop printing the virtual memory layout"
(https://lkml.org/lkml/2018/2/12/97).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
