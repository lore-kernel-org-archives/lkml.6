Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51194C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1D520652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLuiR7Is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1D520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeHaXAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:00:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38880 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHaXAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:00:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id f4-v6so550970pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGRN3cxj7Q2vcCn0yYaM8vqSHGngxbu42LX4Ck3to9E=;
        b=nLuiR7IsYsJIoHLxQzNau0bHdQIpJ8VARO4Ozu8fmT2HwQMMJxLmt7pF8wostZaEmW
         8o1RH07bAlRVv2k1hRX+3T/HLX6ovfcaQ/cPfIMQCKw9vyUCFHHmXXU75VO7DJHj2B64
         hX8sVogtiuZgAXkjVPxlnxkBuiHQO/YALa93LEOywfkNirlHmdyT3tkPrKrtJHKwMbyV
         0sY3Yu/OMDUr2cwoXe/xVCTIA6Hgi24Vf0/yZmJEIogQHymdOQy8+zWa6jA7Hic69PkH
         x06C7rlp/3X6lg5abrJxPVooSasOLuYAsaxlpQL0x4ljEIVJiqJD7RBKwxzEmTh4KH3v
         LWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGRN3cxj7Q2vcCn0yYaM8vqSHGngxbu42LX4Ck3to9E=;
        b=Fk7w0V8uXBKzICUCnN1GMsR6BTcA5v9v9jrU/EzbhHl/Oymab/sl2/h/oFmcWOtkCt
         SrO8CzdDX4+/fXAuBtU8SEw4VQ7ZgAOJcsoFyU3iB3hLRTfWuFmu+QyjDItrCEOzWEaf
         FjyHmdhl+3LeyrHTELAE71KgEldgPGz6XQew2V/+uJu7Pz7D995WNiClfna++DfVV3Nz
         PM/2qFVKM70X6qD081H+gp7GKO47K331IJRyxTOujtjHm71L3qUFTpxc/+//tqkqYufQ
         lTmutfqdHmr0rloMKCfeOWzB0zwkNW5lSRN/jKxHijQnQbAW7OmSzO1/sr0ixWYbhpHE
         e+0g==
X-Gm-Message-State: APzg51B3f+05wBpwlbfgOxKzqAmUKbwLX5hrhNtfCQOR9zXzJBwfVMUH
        /y0uqUrg1OCMaKvjIs6NLmag2/9JXKahikk7sm6WDV4X9WFi8mFB
X-Google-Smtp-Source: ANB0VdZpQWva059qPzdU/IjzGEbpsye5U4OO70vFAZ75eB9XYQf+AvoLFjRtWPpIS1NbNu7zZiAQ9CWf24l/qJ+/3ew=
X-Received: by 2002:a63:6243:: with SMTP id w64-v6mr15798180pgb.145.1535741519441;
 Fri, 31 Aug 2018 11:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com> <20180831170514.24665-2-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180831170514.24665-2-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 31 Aug 2018 11:51:48 -0700
Message-ID: <CAKwvOd=M8H+95qh36-xMA6F7BD1TbOFO_cP8zrVhCBCyCy7e9Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] Compiler Attributes: use the no-underscores syntax
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
> The attribute syntax optionally allows to surround attribute names
> with "__" in order to avoid collisions with macros of the same name
> (see https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html).
>
> This homogenizes all attributes to use the syntax without underscores.
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
>  include/linux/compiler-clang.h | 2 +-
>  include/linux/compiler-gcc.h   | 4 ++--
>  include/linux/compiler.h       | 4 ++--
>  include/linux/compiler_types.h | 8 ++++----
>  4 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index b1ce500fe8b3..efda74f4eeba 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -43,4 +43,4 @@
>  #define barrier() __asm__ __volatile__("" : : : "memory")
>  #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>  #define __assume_aligned(a, ...)       \
> -       __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
> +       __attribute__((assume_aligned(a, ## __VA_ARGS__)))
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 0a2d06677d83..dbfbecf703f8 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -132,7 +132,7 @@
>         } while (0)
>
>  /* Mark a function definition as prohibited from being cloned. */
> -#define __noclone      __attribute__((__noclone__, __optimize__("no-tracer")))
> +#define __noclone      __attribute__((noclone, optimize("no-tracer")))
>
>  #if defined(RANDSTRUCT_PLUGIN) && !defined(__CHECKER__)
>  #define __randomize_layout __attribute__((randomize_layout))
> @@ -165,7 +165,7 @@
>   * compiler should see some alignment anyway, when the return value is
>   * massaged by 'flags = ptr & 3; ptr &= ~3;').
>   */
> -#define __assume_aligned(a, ...) __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
> +#define __assume_aligned(a, ...) __attribute__((assume_aligned(a, ## __VA_ARGS__)))
>  #endif
>
>  /*
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 7c0157d50964..e0e55eb3f242 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -23,7 +23,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  #define __branch_check__(x, expect, is_constant) ({                    \
>                         long ______r;                                   \
>                         static struct ftrace_likely_data                \
> -                               __attribute__((__aligned__(4)))         \
> +                               __attribute__((aligned(4)))             \

Can this be __aligned(4)? As in make use of the newly feature detected
attributes?

>                                 __attribute__((section("_ftrace_annotated_branch"))) \

Sorry to ask for cleanups on code you didn't touch, but since you're
here, can you make this __section("_ftrace_annotated_branch")?

>                                 ______f = {                             \
>                                 .data.func = __func__,                  \
> @@ -59,7 +59,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>         ({                                                              \
>                 int ______r;                                            \
>                 static struct ftrace_branch_data                        \
> -                       __attribute__((__aligned__(4)))                 \
> +                       __attribute__((aligned(4)))                     \
>                         __attribute__((section("_ftrace_branch")))      \

Ditto.

>                         ______f = {                                     \
>                                 .func = __func__,                       \
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index b6534292ea33..7cd958360ead 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -159,7 +159,7 @@ struct ftrace_likely_data {
>          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>
>  #ifndef __attribute_const__
> -#define __attribute_const__    __attribute__((__const__))
> +#define __attribute_const__    __attribute__((const))
>  #endif
>
>  #ifndef __noclone
> @@ -203,14 +203,14 @@ struct ftrace_likely_data {
>  #define __maybe_unused         __attribute__((unused))
>  #define __always_unused                __attribute__((unused))
>  #define __mode(x)              __attribute__((mode(x)))
> -#define __malloc               __attribute__((__malloc__))
> -#define __used                 __attribute__((__used__))
> +#define __malloc               __attribute__((malloc))
> +#define __used                 __attribute__((used))
>  #define __noreturn             __attribute__((noreturn))
>  #define __packed               __attribute__((packed))
>  #define __weak                 __attribute__((weak))
>  #define __alias(symbol)                __attribute__((alias(#symbol)))
>  #define __cold                 __attribute__((cold))
> -#define __section(S)           __attribute__((__section__(#S)))
> +#define __section(S)           __attribute__((section(#S)))
>
>
>  #ifdef CONFIG_ENABLE_MUST_CHECK
> --
> 2.17.1
>

With the above changes requested (or follow up patch added to the series):
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Also,
Series looks great, trying to provide reviews one by one, just very
busy today (and Monday off).

-- 
Thanks,
~Nick Desaulniers
