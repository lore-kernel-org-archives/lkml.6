Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeCMIkM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:40:12 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:50216 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbeCMIkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:40:11 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w2D8e4XG014099
X-Nifty-SrcIP: [209.85.213.53]
X-Google-Smtp-Source: AG47ELtGDwNHp/QG/3Fh2JwK/dZsOLGEycdsTiAIJAVTJnSe8TVjk/CC0Hjd9t73IDisYJEleiV3ugAuox8JbU+smuw=
MIME-Version: 1.0
In-Reply-To: <1519301715-31798-6-git-send-email-yamada.masahiro@socionext.com>
References: <1519301715-31798-1-git-send-email-yamada.masahiro@socionext.com> <1519301715-31798-6-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 13 Mar 2018 17:39:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR+Bio=ukXGMJYT=YrZ7k0XfkxRv4fPbbvNi33RLLToSQ@mail.gmail.com>
Message-ID: <CAK7LNAR+Bio=ukXGMJYT=YrZ7k0XfkxRv4fPbbvNi33RLLToSQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] linux/const.h: move BIT(_ULL) to linux/const.h for
 use in assembly
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

2018-02-22 21:15 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Commit 2fc016c5bd8a ("linux/const.h: Add _BITUL() and _BITULL()")
> introduced _BITUL() and _BITULL().  Its git-log says the difference
> from the already existing BIT() are:
>
>   1. The namespace is such that they can be used in uapi definitions.
>   2. The type is set with the _AC() macro to allow it to be used in
>      assembly.
>   3. The type is explicitly specified to be UL or ULL.
>
> However, I found _BITUL() is mostly used in kernel-space since it is
> handy to share headers between C and assembly.  If we only need '2.',
> we can improve the existing BIT() for use in assembly, allowing us to
> avoid unnecessary underscore prefixes.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

This patch conflicts with the one from Will Deacon.
(https://patchwork.kernel.org/patch/10242531/)

I think his patch is better than mine.

So, could you drop this one from your tree, please?
(only this one from the series.)

Thanks




> V2: https://patchwork.kernel.org/patch/9498271/
>
> Changes in v3: None
> Changes in v2: None
>
>  include/linux/bitops.h | 3 +--
>  include/linux/const.h  | 3 +++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 4cac4e1..8a856be 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -1,11 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef _LINUX_BITOPS_H
>  #define _LINUX_BITOPS_H
> +#include <linux/const.h>
>  #include <asm/types.h>
>
>  #ifdef __KERNEL__
> -#define BIT(nr)                        (1UL << (nr))
> -#define BIT_ULL(nr)            (1ULL << (nr))
>  #define BIT_MASK(nr)           (1UL << ((nr) % BITS_PER_LONG))
>  #define BIT_WORD(nr)           ((nr) / BITS_PER_LONG)
>  #define BIT_ULL_MASK(nr)       (1ULL << ((nr) % BITS_PER_LONG_LONG))
> diff --git a/include/linux/const.h b/include/linux/const.h
> index 7b55a55..200892d 100644
> --- a/include/linux/const.h
> +++ b/include/linux/const.h
> @@ -6,4 +6,7 @@
>  #define UL(x)          (_UL(x))
>  #define ULL(x)         (_ULL(x))
>
> +#define BIT(x)         (_BITUL(x))
> +#define BIT_ULL(x)     (_BITULL(x))
> +
>  #endif /* _LINUX_CONST_H */
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
