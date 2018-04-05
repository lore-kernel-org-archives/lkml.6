Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeDEEnI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 00:43:08 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:65159 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeDEEnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 00:43:06 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w354gkYT014489
X-Nifty-SrcIP: [209.85.217.177]
X-Google-Smtp-Source: AIpwx4/2G+CP2XS8MKDQFKaPTYG3oOba5rA7QPqvmMg91f1jTtVjrstPEBYS83Ra140sRenTDh7JMVnPdWkG9JN18lQ=
MIME-Version: 1.0
In-Reply-To: <20180329004805.7278-3-labbott@redhat.com>
References: <20180329004805.7278-1-labbott@redhat.com> <20180329004805.7278-3-labbott@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 5 Apr 2018 13:42:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNASd5Ano4G0Uay8MffBp0yb5TQ_1C+WaGv57pPv_J15_gQ@mail.gmail.com>
Message-ID: <CAK7LNASd5Ano4G0Uay8MffBp0yb5TQ_1C+WaGv57pPv_J15_gQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] objtool: Support HOSTCFLAGS and HOSTLDFLAGS
To: Laura Abbott <labbott@redhat.com>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-29 9:48 GMT+09:00 Laura Abbott <labbott@redhat.com>:
> It may be useful to compile host programs with different flags (e.g.
> hardening). Ensure that objtool picks up the appropriate flags.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---


I saw some similar patches before.

I thought they are fixing this way
https://patchwork.kernel.org/patch/10251259/

but, I am not tacking the progress.




>  tools/objtool/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index e6acc281dd37..0ff3bcac1ca9 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -31,8 +31,9 @@ INCLUDES := -I$(srctree)/tools/include \
>             -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
>             -I$(srctree)/tools/objtool/arch/$(ARCH)/include
>  WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
> -CFLAGS   += -Wall -Werror $(WARNINGS) -fomit-frame-pointer -O2 -g $(INCLUDES)
> -LDFLAGS  += -lelf $(LIBSUBCMD)
> +CFLAGS   += -Wall -Werror $(WARNINGS) $(HOSTCFLAGS) -fomit-frame-pointer -O2 -g \
> +           $(INCLUDES)
> +LDFLAGS  += -lelf $(LIBSUBCMD) $(HOSTLDFLAGS)
>
>  # Allow old libelf to be used:
>  elfshdr := $(shell echo '\#include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
> --
> 2.16.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
