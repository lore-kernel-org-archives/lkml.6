Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeC0Fpp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 01:45:45 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:27371 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeC0Fpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 01:45:43 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w2R5jMVX030223
X-Nifty-SrcIP: [209.85.213.47]
X-Google-Smtp-Source: AG47ELs4nj00x6QAqOZPB5JFg4R/6a8fA9UlTR7WOIvkGTqw8FFQZHP5AOTJ7EgHR6h3m/uGO6m92yC0dJmYA4Czk/I=
MIME-Version: 1.0
In-Reply-To: <20180325223239.14778-1-linux@rasmusvillemoes.dk>
References: <20180325223239.14778-1-linux@rasmusvillemoes.dk>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 27 Mar 2018 14:44:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQgwp=Q5n+auuYSPLE0FqeK+UGyrRukFY9Qx--PTkLduw@mail.gmail.com>
Message-ID: <CAK7LNAQgwp=Q5n+auuYSPLE0FqeK+UGyrRukFY9Qx--PTkLduw@mail.gmail.com>
Subject: Re: [PATCH] objtool: fix build with future Make
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2R5jpcH016727

2018-03-26 7:32 GMT+09:00 Rasmus Villemoes <linux@rasmusvillemoes.dk>:
> I tried building using a freshly built Make (4.2.1-69-g8a731d1), but the
> objtool build broke with
>
> orc_dump.c: In function ‘orc_dump’:
> orc_dump.c:106:2: error: ‘elf_getshnum’ is deprecated [-Werror=deprecated-declarations]
>   if (elf_getshdrnum(elf, &nr_sections)) {
>
> Turns out that with that new Make, the backslash was not removed, so cpp
> didn't see a #include directive, grep found nothing, and
> -DLIBELF_USE_DEPRECATED was wrongly put in CFLAGS.
>
> Now, that new Make behaviour is documented in their NEWS file:
>
>   * WARNING: Backward-incompatibility!
>     Number signs (#) appearing inside a macro reference or function invocation
>     no longer introduce comments and should not be escaped with backslashes:
>     thus a call such as:
>       foo := $(shell echo '#')
>     is legal.  Previously the number sign needed to be escaped, for example:
>       foo := $(shell echo '\#')
>     Now this latter will resolve to "\#".  If you want to write makefiles
>     portable to both versions, assign the number sign to a variable:
>       C := \#
>       foo := $(shell echo '$C')
>     This was claimed to be fixed in 3.81, but wasn't, for some reason.
>     To detect this change search for 'nocomment' in the .FEATURES variable.
>
> There are likely other places in the tree that will need fixing, so
> cc-ing Kbuild, but with this at least a x86-64 defconfig builds.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>




-- 
Best Regards
Masahiro Yamada
