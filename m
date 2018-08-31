Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08377C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A152083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7Bdaz0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A152083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeIABUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:20:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44663 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIABUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:20:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so6032358pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 14:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjhTV6A49Lf+cie7lDlElWuF/0UFRgU6xXOkHUOo59o=;
        b=t7Bdaz0WqXKHg/xUR1IMpHklxksEL436qzzgrfj7393WGLe5cx60v5twtCG/M7ix5G
         YoDBgoSVvGuEd3YJ0D8wjOM/VaISbnQockkcrazOe07jRv4EoxfHfxa3dB76vLsXJ+gx
         +sDRPoqsidzu+JI31N0cuvHX/PvQ5W29dzogeUMqnHvekYWf+cZ9Nrcr+HxuNxV0XY7m
         zMdqPND1fyk540T1TMt6zA8l1Siaz8GdZFj0kAkcr35HEnk+7LFb+MQ5hsGON1rWRs5R
         54R54IfcPzqJ69ay9SxE3eS2f0+jNGFkDrkeppviMKTIml1WoZa5iEGMFbhtnIsJR3Wa
         v8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjhTV6A49Lf+cie7lDlElWuF/0UFRgU6xXOkHUOo59o=;
        b=WvZp7ouT5k7T+XBxITovHYP0RkjFye1KK7e0SaWcO/IDuWlAxMY06SynZbzsjcRtTm
         Ab6zRuBL8SMZM8E35RJZkOZsZJ88Y5nHsgNb9mUsm464j/XfeVxK0PGGinOOYvtqFIMe
         Wl3tbEliy89RxLh7nE4wJUvy/gmvZCcVQn7L4AL6D0VTK+KNA8EI7gqHqaAb3zqE6tSo
         hYEe/Xv1wzO1xvSm318R6IIg2Hi3d4SgZLFfl90oGApS/3w2wYwIYBzzIp/xfOX+ZUbC
         fXVks/ya1FKkezv5zUu7cHoHP+GlVQJfBGaWzXU2cC3aVhrVPaqzOsVzwUsCLkDMe/0a
         vDBw==
X-Gm-Message-State: APzg51AIcWRNGBOIWUu0fXZmeFkHFEHa5eTzl6LTlrXy0KgoOQyXY1My
        wZJPBJmyuNlMPJknaf0oJAKGVeFtHdNEiTA3Z8NUUw==
X-Google-Smtp-Source: ANB0VdYN3aJsJl8DXyUxE7LNy7uax6EmeP98QbXHrlrYghsJf9VEbYqJd6RKnmRvaGZUWKUiPYkkRajuuaEXXF65upA=
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr8208900pgl.302.1535749850912;
 Fri, 31 Aug 2018 14:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com> <20180831170514.24665-3-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180831170514.24665-3-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 31 Aug 2018 14:10:39 -0700
Message-ID: <CAKwvOd=HDSCfPNcsa+_yDEeOGy4ZAzgOH5ry4iFNsibjLZQ7uQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] Compiler Attributes: remove unneeded tests
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, efriedma@codeaurora.org,
        sparse@chrisli.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        joe@perches.com, asmadeus@codewreck.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 10:05 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Attributes const and always_inline have tests around them
> which are unneeded, since they are supported by gcc >= 4.6,
> clang >= 3 and icc >= 13. See https://godbolt.org/z/no0OZH
>
> In the case of gnu_inline, we do not need to test for
> __GNUC_STDC_INLINE__ because, regardless of the current
> inlining behavior, we can simply always force the old
> GCC inlining behavior by using the attribute in all cases.
>
> Cc: Eli Friedman <efriedma@codeaurora.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  include/linux/compiler_types.h | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 7cd958360ead..3662b19599fc 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -158,10 +158,6 @@ struct ftrace_likely_data {
>         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
>          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>
> -#ifndef __attribute_const__
> -#define __attribute_const__    __attribute__((const))
> -#endif
> -

If there's a v2, you could order this before the patch that removed
the underscores so that patch is smaller.  Doesn't really matter
though.

>  #ifndef __noclone
>  #define __noclone
>  #endif
> @@ -196,6 +192,7 @@ struct ftrace_likely_data {
>   * [...]
>   */
>  #define __pure                 __attribute__((pure))
> +#define __const                        __attribute__((const))
>  #define __aligned(x)           __attribute__((aligned(x)))
>  #define __aligned_largest      __attribute__((aligned))
>  #define __printf(a, b)         __attribute__((format(printf, a, b)))
> @@ -227,17 +224,7 @@ struct ftrace_likely_data {
>
>  #define __compiler_offsetof(a, b)      __builtin_offsetof(a, b)
>
> -/*
> - * Feature detection for gnu_inline (gnu89 extern inline semantics). Either
> - * __GNUC_STDC_INLINE__ is defined (not using gnu89 extern inline semantics,
> - * and we opt in to the gnu89 semantics), or __GNUC_STDC_INLINE__ is not
> - * defined so the gnu89 semantics are the default.
> - */
> -#ifdef __GNUC_STDC_INLINE__
> -# define __gnu_inline  __attribute__((gnu_inline))
> -#else
> -# define __gnu_inline
> -#endif
> +#define __gnu_inline   __attribute__((gnu_inline))

Can this be moved into the block above with all the rest of required attributes?

>
>  /*
>   * Force always-inline if the user requests it so via the .config.
> @@ -263,9 +250,7 @@ struct ftrace_likely_data {
>  #define __inline inline
>  #define noinline       __attribute__((noinline))
>
> -#ifndef __always_inline
>  #define __always_inline inline __attribute__((always_inline))
> -#endif

Ditto.

>
>  /*
>   * Rather then using noinline to prevent stack consumption, use
> --
> 2.17.1
>

With the requested changes,
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
