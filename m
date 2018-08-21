Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE37BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D98220645
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IiiRlqJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D98220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeHUL2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:28:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44230 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeHUL2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:28:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so8119560pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 01:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ysblBpWsSYlGrMuWHggjeJA5xNcIbxXDH4eJgqtURg=;
        b=IiiRlqJVynexRE1xGfzB1tj/f3/4r9OACiQOb0PYmTOUUEZxwO+1t7OEKGAG5/00tc
         8HuGEjK/6+K+0FAsNSgQDpq04W/26NJI7poSgj1WPIpbbuAvVDvV1oQH5CElLixyeVxM
         LWylTkEKrjBGvMMSLzO2yvCGqpFm+kt/B/d2b/yhKh+Yb7uo31lLz9nQBevHPv5UA5Ph
         3aURX/xCyjsaA10y5rP85w6+kYLk01IlhiI7ZlI/vf3+5MIeNuSOoL9Hd2jlHEG4Alec
         ZPeiJnWr4na4Tqiqau/jIjjBi+Buw86Vd7hgYv0Nd6Eyqc6yExcPqz/m+wUjPYFVGDXY
         l6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ysblBpWsSYlGrMuWHggjeJA5xNcIbxXDH4eJgqtURg=;
        b=iTtva/csGh4jH9aB6R5KKTsKSNZGpLO5dj35+ESMGELOg6ujImLJyHg4dNaMCROoDZ
         +jO7diuGS+/VzZuLy76Bay2UNlQNeueSOGDyrlsdjc/DJnoPd5FDUYtDBY2SP8D/t4nx
         5lJmmuoHAAXbAR0mOewFvzx+ue79XrzY67bWibwRHZKo5ERf5BqtiRWefhs/DOBqwqw7
         GdTDHfU+eTEZ8ynk7DofkYXa8XEdEJA5lAgJLEWlRmVckaa6lJCkitf0UYk+HhIBuROC
         uuq5NVZWvYwCbbU4wU9q1J1VnAeHMgYZnRt4ZAGq0n3fYKGQyXwycpnYQUasHMbfK1vt
         gKZQ==
X-Gm-Message-State: AOUpUlFSleTYEkTfVumcpA+h8/DaDu3NKXmGrkAKaPmAAUca+tIsKbdB
        iElIYYZQ+rgCUvIcjvFluccHrqYuHDncGEIw/9e1hw==
X-Google-Smtp-Source: AA+uWPzVowcLBa56kJPCLaP7PkOn60ReSLRi2cRJIIrZX8uRFob7icYSCjA9EMUKJx9wiJFP7SlzYV6K4fNKDtb5kPU=
X-Received: by 2002:a63:c24c:: with SMTP id l12-v6mr19018455pgg.255.1534838969759;
 Tue, 21 Aug 2018 01:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Aug 2018 01:09:17 -0700
Message-ID: <CAKwvOd=_JzbMpeVZ=JJ6RB19N0h-4O0AMrxggQO=fjzmYPyUow@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, joe@perches.com,
        corbet@lwn.net, Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for noticing, and sending this patch.  I'm happy to see others
testing with Clang.  I noticed this too near the end of the day
https://github.com/ClangBuiltLinux/linux/issues/27.

On Mon, Aug 20, 2018 at 11:48 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> missed the fact that <linux/compiler-gcc.h> is included by Clang
> as well as by GCC.
>
> Clang actually defines __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__
> and it looks like GCC 4.2.1.
>
>   $ scripts/gcc-version.sh -p clang
>   040201

If you too are wondering why, see: https://reviews.llvm.org/D51011#1206981.

>
> If you try to build the kernel with Clang, you will get the
> "Sorry, your compiler is too old - please upgrade it."
> followed by a bunch of "unknown attribute" warnings.
>
> Add !defined(__clang__) to the minimum version check.

I think this may eventually be part of a more-proper compiler check
from the C preprocessor.

>
> Also, revive the version test blocks for versions >= 4.2.1
> in order to disable features not supported by Clang.

Eh, this I'm not too enthused to see these being added back.

>
> Fixes: cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  include/linux/compiler-gcc.h | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 250b9b7..8e41fd2 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -10,7 +10,7 @@
>                      + __GNUC_MINOR__ * 100     \
>                      + __GNUC_PATCHLEVEL__)
>
> -#if GCC_VERSION < 40600
> +#if !defined(__clang__) && GCC_VERSION < 40600
>  # error Sorry, your compiler is too old - please upgrade it.
>  #endif
>
> @@ -163,7 +163,16 @@
>  #define __used                 __attribute__((__used__))
>  #define __compiler_offsetof(a, b)                                      \
>         __builtin_offsetof(a, b)
> +#define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>
> +/*
> + * GCC version specific checks
> + *
> + * Keep the version checks for 4.2.1 or newer
> + * because Clang defines GCC_VERSION as 40201
> + */
> +
> +#if GCC_VERSION >= 40300
>  /* Mark functions as cold. gcc will assume any path leading to a call
>   * to them will be unlikely.  This means a lot of manual unlikely()s
>   * are unnecessary now for any paths leading to the usual suspects
> @@ -182,15 +191,20 @@
>
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>
> +#ifndef __CHECKER__
> +# define __compiletime_warning(message) __attribute__((warning(message)))
> +# define __compiletime_error(message) __attribute__((error(message)))
> +#endif /* __CHECKER__ */
> +#endif /* GCC_VERSION >= 40300 */
> +
> +#if GCC_VERSION >= 40400
>  #define __optimize(level)      __attribute__((__optimize__(level)))
>  #define __nostackprotector     __optimize("no-stack-protector")
> +#endif /* GCC_VERSION >= 40400 */
>
> -#define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
> +#if GCC_VERSION >= 40500
>
>  #ifndef __CHECKER__
> -#define __compiletime_warning(message) __attribute__((warning(message)))
> -#define __compiletime_error(message) __attribute__((error(message)))
> -
>  #ifdef LATENT_ENTROPY_PLUGIN
>  #define __latent_entropy __attribute__((latent_entropy))
>  #endif
> @@ -232,6 +246,9 @@
>  #define randomized_struct_fields_end   } __randomize_layout;
>  #endif
>
> +#endif /* GCC_VERSION >= 40500 */
> +
> +#if GCC_VERSION >= 40600
>  /*
>   * When used with Link Time Optimization, gcc can optimize away C functions or
>   * variables which are referenced only from assembly code.  __visible tells the
> @@ -240,7 +257,7 @@
>   */
>  #define __visible      __attribute__((externally_visible))
>
> -/* gcc version specific checks */
> +#endif /* GCC_VERSION >= 40600 */
>
>  #if GCC_VERSION >= 40900 && !defined(__CHECKER__)
>  /*
> @@ -274,8 +291,10 @@
>   * folding in __builtin_bswap*() (yet), so don't set these for it.
>   */
>  #if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP) && !defined(__CHECKER__)
> +#if GCC_VERSION >= 40400
>  #define __HAVE_BUILTIN_BSWAP32__
>  #define __HAVE_BUILTIN_BSWAP64__
> +#endif
>  #if GCC_VERSION >= 40800
>  #define __HAVE_BUILTIN_BSWAP16__
>  #endif
> @@ -327,9 +346,12 @@
>  #define __diag_GCC_warn                warning
>  #define __diag_GCC_error       error
>
> +/* Compilers before gcc-4.6 do not understand "#pragma GCC diagnostic push" */
> +#if GCC_VERSION >= 40600
>  #define __diag_str1(s)         #s
>  #define __diag_str(s)          __diag_str1(s)
>  #define __diag(s)              _Pragma(__diag_str(GCC diagnostic s))
> +#endif
>
>  #if GCC_VERSION >= 80000
>  #define __diag_GCC_8(s)                __diag(s)
> --
> 2.7.4
>

I think the current state of always including compiler-gcc.h, then
possibly including compiler-clang.h or compiler-intel.h to overwrite
some things is kind of a spaghetti mess, because now we wind up with
these circular dependencies on GCC_VERSION.  And that Clang just
happened to declare __GNUC_MAJOR__ and friends in a way that didn't
blow up until today was a bit of luck; that was a time bomb waiting to
go off.  I think it's time to shave this yak.  Adding these
GCC_VERSION checks back doesn't simplify the state of things.

I think a more proper fix might be something along the lines of (in
compiler_types.h):

#include <linux/compiler-generic.h> /* potential new header for common
definitions (or just put them above) */
#if /* more proper check for gcc and JUST gcc */
#include <linux/compiler-gcc.h>
#elif /* compiler check for icc */
#include <linux/compiler-intel.h>
#elif /* compiler check for clang */
#include <linux/compiler-clang.h>
#endif

#ifndef /* something from the above that's not mission critical */
#warning "compiler missing foo"
#undef foo
#endif

#ifndef /* something from above that IS mission critical */
#error "compiler missing bar"
#endif

I appreciate the patch, but I think there's another way we can clean this up.
-- 
Thanks,
~Nick Desaulniers
