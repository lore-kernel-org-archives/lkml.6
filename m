Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AF1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093C92083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PiV/2GNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093C92083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeIAB0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:26:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36061 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIAB0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:26:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id e11-v6so6006159plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 14:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bio1/EvjYxG92soGhk1gFCdvf45JsVdwiwH2NlU2Hm0=;
        b=PiV/2GNvYLQvt6gm1u0nn1nGZae5RR1Ks+t6ow695ZsvNI7C6LQRhgOtbHnb8p7MpX
         QVna0qENLQ6Y7YlCJ35aGv7Wvu5IiERFq2XkS4DcBC0wY7XPnM8Qoy+FuTC9hTp2v3u+
         Ar/mXhNU5uu/A8KS0h1aDSKDklvhwkW9mqQsJ0kiilXd6/0EX2P2awnXvLNJ2tQvLncA
         vSDSxfIws4Cwgt2AdaSLN0NNsCFYvcqKP241XcED+ky1F0RaQaxwcHbPFxdY+wooZaCa
         LokMFWv+X95j89whgeTGheO/OlvljvgVzwB+yjbNzrZ8jR4j9NAMLNlRSyD1T213cp+Y
         HhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bio1/EvjYxG92soGhk1gFCdvf45JsVdwiwH2NlU2Hm0=;
        b=S1XBzbtAzwVa9P1WHxWq0Bjd3UgKI53Ka0jv8Z9AG+pV+HEtkaQ82Sf4u4bN5PaDlA
         t+BSBU12vBFujSNMYN3lHvbIk3U1IdKyVFFWhrXo4LubOyKW5tDmrR5esBTTTSlKcPOG
         n+gvztnnsJog9u8ehTLaEpuuIjfsCJuO1VUZrdaND7ILIfs6BMovBgvf1Z0uX0YanDE7
         B27W+PVJZFjfq4hUqOAg4YfJufNqMX/Za4drOvBPrMtnKlQGLeXfnJKOeWnOapqizpOT
         oCuHrI85+W4yjeLsZ9SimSoMeIXcs6Ciw5HFtnxwDRJWGX+OPiMRIYuvbp8AP7am0KwY
         hUMw==
X-Gm-Message-State: APzg51AIgUa7/Rw8hqmgJThQ37bCZiA5FxjkGnM1Oe814sW4WJ79Ui0G
        gUHrnBJTX74mr4CWfGIYCvvwTaxilSiDmva5Zo6YGQ==
X-Google-Smtp-Source: ANB0VdZyXg6roMuuzILL2Bz0FTzqKjhUP1mgEg5w5Vyva0/5dLXk8ADg/bwodoKaQyJcBXHx3z786UXV/TsiAgB2WaQ=
X-Received: by 2002:a17:902:7102:: with SMTP id a2-v6mr17247231pll.217.1535750215857;
 Fri, 31 Aug 2018 14:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com> <20180831170514.24665-4-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180831170514.24665-4-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 31 Aug 2018 14:16:44 -0700
Message-ID: <CAKwvOdkukFvZw6HkwXN96Y_WRaSkATPjMFsFhvW-jVG8Fxg2Bw@mail.gmail.com>
Subject: Re: [PATCH 4/7] Compiler Attributes: homogenize __must_be_array
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
> Different definitions of __must_be_array:
>
>   * gcc: disabled for __CHECKER__
>
>   * clang: same definition as gcc's, but without __CHECKER__
>
>   * intel: the comment claims __builtin_types_compatible_p()
>     is unsupported; but icc seems to support it since 13.0.1
>     (released in 2012). See https://godbolt.org/z/S0l6QQ

Indeed.  It seems that if we can't find a contact for ICC, then 13.0.1
(the oldest version supported by godbolt) is a best effort, IMO.  If
we end up adding patches for minimal compiler versions, maybe v13.0.1
is a good minimal for ICC.  But I would really defer to someone who
has an install of ICC (not me).

>
> Therefore, we can remove all of them and have a single definition
> in compiler.h
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
>  include/linux/compiler-clang.h | 1 -
>  include/linux/compiler-gcc.h   | 7 -------
>  include/linux/compiler-intel.h | 3 ---
>  include/linux/compiler.h       | 7 +++++++
>  4 files changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index efda74f4eeba..0aee694d3ab8 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -41,6 +41,5 @@
>   * compilers, like ICC.
>   */
>  #define barrier() __asm__ __volatile__("" : : : "memory")
> -#define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>  #define __assume_aligned(a, ...)       \
>         __attribute__((assume_aligned(a, ## __VA_ARGS__)))
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index dbfbecf703f8..66e1eb8822d9 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -68,13 +68,6 @@
>   */
>  #define uninitialized_var(x) x = x
>
> -#ifdef __CHECKER__
> -#define __must_be_array(a)     0
> -#else
> -/* &a[0] degrades to a pointer: a different type from an array */
> -#define __must_be_array(a)     BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
> -#endif
> -
>  #ifdef RETPOLINE
>  #define __noretpoline __attribute__((indirect_branch("keep")))
>  #endif
> diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
> index 4c7f9befa9f6..18bd4362deaa 100644
> --- a/include/linux/compiler-intel.h
> +++ b/include/linux/compiler-intel.h
> @@ -29,9 +29,6 @@
>   */
>  #define OPTIMIZER_HIDE_VAR(var) barrier()
>
> -/* Intel ECC compiler doesn't support __builtin_types_compatible_p() */
> -#define __must_be_array(a) 0
> -
>  #endif
>
>  /* icc has this, but it's called _bswap16 */
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index e0e55eb3f242..e4a702f99e50 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -357,4 +357,11 @@ static inline void *offset_to_ptr(const int *off)
>         compiletime_assert(__native_word(t),                            \
>                 "Need native word sized stores/loads for atomicity.")
>
> +#ifdef __CHECKER__
> +#define __must_be_array(a)     0
> +#else
> +/* &a[0] degrades to a pointer: a different type from an array */
> +#define __must_be_array(a)     BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
> +#endif
> +
>  #endif /* __LINUX_COMPILER_H */
> --
> 2.17.1
>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
