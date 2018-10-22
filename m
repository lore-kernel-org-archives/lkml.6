Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D4EC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC82220645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHL6Rv/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC82220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeJWB4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:56:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36425 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbeJWB4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:56:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id l81-v6so20268158pfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFstTX7X0zaXGUYtrxG8obho4TSJKsK3S4jKTMtCpY4=;
        b=SHL6Rv/Pe38jS8Tt3nhYFbMUAznCvIcj180Zi5z+rZempqHqmYh88Eg8ct2tPBriFn
         bGqvHQp45PzFjXlw+PvlZ43EyIQMUiYGgPTbZ7JyqXSxuO5Vn3AUq55nIVCM+rZsd0SW
         T3ruH/PnYbzaRQ+t3CN2/Q2qzLM1YL7LYwcsRS0McE1itpkT2EAfqR1iQVqJfD1TWH9R
         4UvgIRQ+L0Knazgx2+zO66uFWzLzESplLDy3963ixDfuhSFoVAwT3OyN6CqZJpaqPhWT
         siXeWvQpI6XOyBoonqMFBtpftp1af684FbA+f4JkJiNSTjDEtDYSUFeRWBkBlqsnYM7W
         YmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFstTX7X0zaXGUYtrxG8obho4TSJKsK3S4jKTMtCpY4=;
        b=OAyt0vTjTrHK9a81kh2GuZKCwhAAkt/bSVdPGJ+gkeyNu6FIyBDToVcAWxja55bn3w
         m4AvZ60rQ8qXYQZjSFGJ0GAlbY0tCNO3Ls7/mas9pR3DOiwaVsoKpu6UOXlUHY7ZaB1N
         LUYEgvbszZdwX8n1suvvI9XvIG8G53OxIONe9FYmo0m5AeX4j0VCiz/ilRgHzXOlnQq6
         EdRftArL9BcfqnvHN65R5v8b0D+rtZY3qBjcAmD8GSgHAS+8h1LLC87QepnVmDexWlXs
         LYllm++B4fW1SsxX8j6ZFXXNNvHR/EmG0jBdTB3YB3ZYbpm1ETsJR/EKEkEuU1EdhcZW
         3i/Q==
X-Gm-Message-State: AGRZ1gKxxLJi0smVUIOUMJzlur88F61VSJSPLmSwW5gP8arPuDwTAslA
        HfCSQA9v7K3ZFeU9u7rJoMfTJHsHaZ2VOFa2f5FiOg==
X-Google-Smtp-Source: AJdET5dbc8wG65Sctr/d5jVoncsfxU2CDGKebxJxLKLcYyLtyMPzvsyLMlgXSH0Ih4zPFPtzivmqlzP3bY9G9S1qL3I=
X-Received: by 2002:a63:f306:: with SMTP id l6-v6mr10909116pgh.255.1540229793262;
 Mon, 22 Oct 2018 10:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com> <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Oct 2018 10:36:21 -0700
Message-ID: <CAKwvOdmPj_mm+9t1i=yLhvO0FAe6Kd7ezjOoTnp1fzcoikPHpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, dan.carpenter@oracle.com,
        adilger.kernel@dilger.ca,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, rostedt@goodmis.org,
        mchehab+samsung@kernel.org, olof@lxom.net,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        sandipan@linux.vnet.ibm.com,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        paul.burton@mips.com, David Rientjes <rientjes@google.com>,
        Willy Tarreau <w@1wt.eu>, msebor@gmail.com, sparse@chrisli.org,
        Jonathan Corbet <corbet@lwn.net>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, joe@perches.com,
        Arnd Bergmann <arnd@arndb.de>, asmadeus@codewreck.org,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 10:14 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> From the GCC manual:
>
>   fallthrough
>
>     The fallthrough attribute with a null statement serves as a
>     fallthrough statement. It hints to the compiler that a statement
>     that falls through to another case label, or user-defined label
>     in a switch statement is intentional and thus the -Wimplicit-fallthrough
>     warning must not trigger. The fallthrough attribute may appear
>     at most once in each attribute list, and may not be mixed with
>     other attributes. It can only be used in a switch statement
>     (the compiler will issue an error otherwise), after a preceding
>     statement and before a logically succeeding case label,
>     or user-defined label.
>
>   https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html
>
> Currently, most of the kernel uses fallthrough comments to silence
> the -Wimplicit-fallthrough warnings (enabled by -Wextra, in W=1).
> However, C++17 standarized an "statement attribute" (the first

s/standarized/standardized/

> of its kind) to deal with this: [[fallthrough]] is meant to be
> a new control keyword in the form of an extension.

I think we can leave the details about the [[]] notation out. IIUC,
it's only applicable to C++.

>
> In C mode, GCC supports the __fallthrough__ attribute since 7.1,
> the same time the warning and the comment parsing were introduced.
>
> While comment parsing is a good idea to deal with old codebases
> that used such a comment as documentation for humans, the best
> solution is to use the attribute:
>
>   * It is a "real" part of the AST (=> better for tooling).

+1

>
>   * It does not follow arbitrary rules for parsing (e.g. regexps
>     for the comment parsing).

+2

>
>   * It may even become standarized in C as well: there are ongoing

s/standarized/standardized/

>     proposals to import some C++ standard attributes into
>     the C standard, e.g. for fallthrough:
>
>       http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2268.pdf
>
> On top of that, it is also a better solution for the kernel, because:
>
>   * We can actually use a #define for it like for the rest of
>     attributes/extensions, which is not possible with a comment,
>     so that its naming/usage is consistent across the entire kernel.

+3

>
>   * Whenever the migration from the comments to the attribute
>     is complete, we may increase the level of the GCC warning up to 5,
>     i.e. comments will not longer be considered for warning
>     surpression:  only the attribute must be used. This would enforce

s/surpression/suppression/

>     consistency by leveraging the compiler directly (instead of
>     enforcing it with other tools).
>
>   * Further into the future, we can consider moving the warning
>     up to W=0 or even making it an error.
>
> It is worth noting that clang >= 3.2 supports the warning and
> the attribute, but only in C++ mode (and it is not enabled by
> -Wall/-Wextra/-Wpedantic like in gcc). Hopefully, they will also
> support it for C as well.

https://bugs.llvm.org/show_bug.cgi?id=39382

>
> Further, icc >= 18 does not seem to know anything about the warning;
> except that it accepts (i.e. ignores) [[fallthrough]] in C++17 mode
> (to be conformant, probably).
>
> Link: https://lore.kernel.org/lkml/20181017062255.oiu44y4zuuwilan3@mwanda/
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  include/linux/compiler_attributes.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 6b28c1b7310c..9e2153f85462 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -32,6 +32,7 @@
>  # define __GCC4_has_attribute___assume_aligned__      (__GNUC_MINOR__ >= 9)
>  # define __GCC4_has_attribute___designated_init__     0
>  # define __GCC4_has_attribute___externally_visible__  1
> +# define __GCC4_has_attribute___fallthrough__         0
>  # define __GCC4_has_attribute___noclone__             1
>  # define __GCC4_has_attribute___optimize__            1
>  # define __GCC4_has_attribute___nonstring__           0
> @@ -133,6 +134,23 @@
>  # define __visible
>  #endif
>
> +/*
> + * Currently, most of the kernel uses fallthrough comments to silence
> + * the -Wimplicit-fallthrough warnings (enabled by -Wextra, in W=1).
> + * For new instances, please use this attribute instead.
> + *
> + * Optional: only supported since gcc >= 7.1
> + * Optional: not supported by clang
> + * Optional: not supported by icc
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#index-fallthrough-statement-attribute
> + */
> +#if __has_attribute(__fallthrough__)
> +# define __fallthrough                  __attribute__((__fallthrough__))
> +#else
> +# define __fallthrough

While this is in the correct format as the other attributes in this
file, I think this particular attribute is a special case, because of
the variety of fallbacks and differing support for them.  I'd like to
see in the commit message maybe a list of tools we'd like to support
and links to the feature requests/bug reports for them.  I acknowledge
it's more work to file bugs, but it's being a good open source
citizen, IMO.

I'm also curious which is the first version of GCC to support the
comment format?

> +#endif
> +
>  /*
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-format-function-attribute
>   * clang: https://clang.llvm.org/docs/AttributeReference.html#format
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
