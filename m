Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B16C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0482083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6OcrPDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0482083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeIARul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:50:41 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34337 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeIARul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:50:41 -0400
Received: by mail-qt0-f193.google.com with SMTP id m13-v6so17612775qth.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JbNd6nTZGVQ/G/HoADVOhGQvkDreoZDDpJpiAkaciWU=;
        b=A6OcrPDhDbZYM7VVSLmVE27/qAYJuc2RquDieXWOjurFfIZGia1RidlGiApEo8igk8
         rHqbR2SYEG+lVdNQnuF62k6ARCFZvu8vgneTVe56iN60cENPFfeDiu6EtyMFXog20XEx
         c/Bp6LjIm0gVRxSpR6AFdxbP4POVTf81t8BdVmhnaduhuEoz6Ggg3MfxJRm8/7IC8fGd
         pqXCmVbUTAPgKaJ7t1tdy4OvVJ8heXTH7+gfZmEIoDW5NoSoEyx1EHBLywV3eneyUzty
         dy6MHft0xp1l/45j2xxGO4J8OIDRSny0LAe0ytHCIcMch3/YO9rRJjeD9/V0tfbC4gJf
         aEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JbNd6nTZGVQ/G/HoADVOhGQvkDreoZDDpJpiAkaciWU=;
        b=mOPpzPTRVat1bSHcXp2fOlSYo7rkwyNgWTl3YWV7Q4+mSVVHhyGGDq5PO6aJVtuiZp
         3t43F1rYjrK0pj/x0ZcqfO2JMg0Jxt1M/I+h1Jd6hnDYeJNHqiAgZyVOuCoOaeiY/1vd
         36VbzNMnkKQNFObJqvAGMLpfr+zP93yzAXM8oAgesNm9fHf/by4myoeKZxjBeC7rDj5i
         QblMBLYFxUwwV8ti4mMDfM5i9op4lGk/1f1TFqGDGtFJORKUhl2+D0oY9d7nprQum5jS
         hjGCGzN8NzFtKBYfdk/q5YIR+iIP6JxGdmn+TT6mAn/CCIzX0r7EcU17zV9xy26qRKjD
         PBLw==
X-Gm-Message-State: APzg51Bo8kvFdcuC2I6I7ls9tzYmUajs0TPCjKzkSEeI022Od2gTwKAS
        f7HEqKDBIFwiZDZZKm45vrJfodbpZXsf56T2gT4=
X-Google-Smtp-Source: ANB0Vda5JU4yTNHolbb+6TZXwRbFQGC+jxMXGvvECJ/ZSuygWcwMfTPEpiiCF1wlmdzYA5ZTuE+W9CgghJKL3FZYaBo=
X-Received: by 2002:ac8:304a:: with SMTP id g10-v6mr20287649qte.136.1535809114135;
 Sat, 01 Sep 2018 06:38:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2291:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 06:38:13 -0700 (PDT)
In-Reply-To: <CAKwvOdmF7bPJvnf38HYvnzdo8vO4K5=qkFwdTqwNnKA6PUVwpQ@mail.gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com> <CAKwvOdmF7bPJvnf38HYvnzdo8vO4K5=qkFwdTqwNnKA6PUVwpQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 1 Sep 2018 15:38:13 +0200
Message-ID: <CANiq72mfuJ2=v8U9vUs1vJVEjY2sp7f-WbTRZRHNvgh+VbAgnA@mail.gmail.com>
Subject: Re: [PATCH 7/7] Compiler Attributes: use feature checks instead of
 version checks
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Sat, Sep 1, 2018 at 1:07 AM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> Overall, pretty happy with this patch.  Still some thoughts for a v3,
>> -#define __visible      __attribute__((externally_visible))
>> diff --git a/include/linux/compiler_attributes.h b/include/linux/compile=
r_attributes.h
>> new file mode 100644
>> index 000000000000..a9dfafc8fd19
>> --- /dev/null
>> +++ b/include/linux/compiler_attributes.h
>> @@ -0,0 +1,226 @@
>
> New file needs an SPDX license identifier right?

Yeah, but I wasn't sure of adding it, since the code I moved (even if
rearranged) from _types.h does not have it either. Any legal expert
here? Is _types.h it implicitly GPL 2? We should add the identifier to
both if so.

>
>> +#ifndef __LINUX_COMPILER_ATTRIBUTES_H
>> +#define __LINUX_COMPILER_ATTRIBUTES_H
>> +
>> +/*
>> + * This file is meant to be sorted (by actual attribute name,
>> + * not by #define identifier).
>> + *
>> + * Do not add here attributes which depend on others or require extra l=
ogic.
>> + *
>> + * If an attribute is optional, state the reason in the comment.
>
> A lot of newlines in this comment. Can be condensed?
>

I tried to write it as "bullet points", but as you guys prefer!

>> + */
>> +
>> +/*
>> + * To check for optional attributes, we use __has_attribute, which is s=
upported
>> + * on gcc >=3D 5, clang >=3D 2.9 and icc >=3D 17. In the meantime, to s=
upport
>> + * 4.6 <=3D gcc < 5, we implement __has_attribute by hand.
>> + */
>> +#ifndef __has_attribute
>> +#define __has_attribute(x) __GCC4_has_attribute_##x
>> +#define __GCC4_has_attribute_externally_visible 1
>> +#define __GCC4_has_attribute_noclone 1
>> +#define __GCC4_has_attribute_optimize 1
>> +#if __GNUC_MINOR__ >=3D 8
>> +#define __GCC4_has_attribute_no_sanitize_address 1
>> +#endif
>> +#if __GNUC_MINOR__ >=3D 9
>> +#define __GCC4_has_attribute_assume_aligned 1
>> +#endif
>> +#endif
>
> I'm quite happy with this. Kudos.

Thanks! :-)

>
>> +
>> +/*
>> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes=
.html#index-alias-function-attribute
>> + */
>> +#define __alias(symbol)         __attribute__((alias(#symbol)))
>> +
>> +/*
>> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes=
.html#index-aligned-function-attribute
>> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.htm=
l#index-aligned-type-attribute
>> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes=
.html#index-aligned-variable-attribute
>> + */
>> +#define __aligned(x)            __attribute__((aligned(x)))
>> +#define __aligned_largest       __attribute__((aligned))
>> +
>> +/*
>> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes=
.html#index-always_005finline-function-attribute
>> + * clang: mentioned but no proper documentation
>
> What?! Ok, I'll add to my TODO list, but I think we can leave out that
> clang doesn't have docs (yet!).
>

If you are going to do that -- please also check noinline (same thing
happens: you can find it mentioned in an example, but it is not
documented). Anyway, the clang docs state:

"""
Clang supports GCC=E2=80=99s gnu attribute namespace. All GCC attributes wh=
ich
are accepted with the __attribute__((foo)) syntax are also accepted
as[[gnu::foo]]. This only extends to attributes which are specified by
GCC (see the list of GCC function attributes, GCC variable attributes,
and GCC type attributes). As with the GCC implementation, these
attributes must appertain to the declarator-id in a declaration, which
means they must go either at the start of the declaration or
immediately after the name being declared.
"""

in https://clang.llvm.org/docs/LanguageExtensions.html, so I guess it
is fair ;-) In any case, the GNU/C++/C2x/declspec/... compatibility
tables provided in https://clang.llvm.org/docs/AttributeReference.html
are great, and it would be *very* nice to complete that document to
have a reference for all developers accross all platforms, not just
kernel ones.

>> +
>> +/*
>> + * Note the long name.
>> + *
>> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes=
.html#index-const-function-attribute
>> + */
>> +#define __attribute_const__     __attribute__((const))
>
> So I manually wrote down the list of attributes removed from one file,
> and added to another, to make sure they balance out and that none were
> missed.  I'm quite confident that nothing was missed moving from one
> file to another.  Except this.  You've renamed __const to
> __attribute_const__.  But you renamed __attribute_const_ to __const in
> patch 3/7 in this series.  Surely one of them is a mistake?

D'oh! It seems I confused myself when rebasing stuff to split the
patches. Good catch! 3/7 has the typo, which then triggers a second
rename. The end result of the series is the good state (i.e. no change
should happen to the identifiers).

>> +/*
>> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.htm=
l#index-mode-type-attribute
>> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes=
.html#index-mode-variable-attribute
>> + */
>> +#define __mode(x)               __attribute__((mode(x)))
>> +
>> +/*
>> + * Optional: not supported by clang
>> + * Note: icc does not recognize gcc's no-tracer
>
> In that case, can you provide 3 definitions for __noclone? Something like=
:
>
> if has noclone
>   if has optimize
>     noclone =3D noclone optimize
>   else
>     noclone =3D noclone
> else
>   noclone =3D
>

So what happened here is that icc recognizes the attribute itself (not
sure if it honors it or not), so there would be no compiler using the
"noclone && !optimize" definition, which is why I left it at that.

But I see the point in your idea in case there is a 4th compiler around...

>>  #ifdef CONFIG_ENABLE_MUST_CHECK
>>  #define __must_check           __attribute__((warn_unused_result))
>
> Can this attribute be hoisted to your new header?  I guess there's a
> few other __attributes__ still in this file even after this change.
> Maybe not something that needs to be in this patch set, but what are
> your thoughts on them?

This is something I gave quite some thought... I am still not sure
what is the right idea.

The decision I took (for the moment, at least) was to leave
compiler_attributes.h as "regular" and "simple" as possible, defining
whatever attributes that are common enough (i.e. those that can be
defined simply with __has_attribute at most) -- which is why I added
the "Do not add here..." comment in the top of the file, and leaving
the CONFIG- / PLUGIN-dependent definitions out of it.

Because of that logic, I tried to simplify as much as possible all
existing things (e.g. assume_aligned by removing __CHECKER__) so that
they could be moved to compiler_attributes.h. In a way,
compiler_attributes.h defines some extensions to the C language that
all code could use anywhere (actually whether we can move them out of
__KERNEL__ etc. is another question); and I tried as well to only move
those attributes that have a direct mapping to a "standard" attribute
(e.g. "noclone" was borderline :-).

The other alternative is moving everything to compiler_attributes.h
and keeping all logic there for all attributes and pseudo-attributes,
but I thought we could risk ending up with a complex mess there as in
_types.h; and end up with the pseudo-attributes which do not map to
real attributes and that are disabled in many configurations. Again,
the "C programming language extensions" idea could be a nice one (I
actually wrote a Documentation/ file to guide newcomers on this which
I didn't include in the series yet, see below [*]).

I would like to hear opinions on this!

>>  /*
>>   * Force always-inline if the user requests it so via the .config.
>>   * GCC does not warn about unused static inline functions for
>> @@ -240,17 +184,13 @@ struct ftrace_likely_data {
>>   */
>>  #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
>>         !defined(CONFIG_OPTIMIZE_INLINING)
>> -#define inline \
>> -       inline __attribute__((always_inline, unused)) notrace __gnu_inli=
ne
>> +#define inline __always_inline __gnu_inline __maybe_unused notrace
>>  #else
>> -#define inline inline  __attribute__((unused)) notrace __gnu_inline
>> +#define inline          inline __gnu_inline __maybe_unused notrace
>
> This seems to have different spacing after the first `inline` than the
> line 2 lines above.
>

Take a look at it in fixed-sized font (the idea is that
__always_inline contains inline, so it replaces the inline below in
that case to avoid warnings about duplicated specifiers). Does that
explain it?

>>  #endif
>>
>>  #define __inline__ inline
>> -#define __inline inline
>> -#define noinline       __attribute__((noinline))
>> -
>> -#define __always_inline inline __attribute__((always_inline))
>> +#define __inline   inline
>>
>>  /*
>>   * Rather then using noinline to prevent stack consumption, use
>> --
>> 2.17.1
>>
>
> Thank you again for this patch.

You are welcome! I am glad these series is getting a warm welcome.

Cheers,
Miguel

[*]

Documentation/process/programming-language.rst:

.. _programming_language:

Programming Language
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The kernel is written in the C programming language [c-language]_.
More precisely, the kernel is typically compiled with ``gcc`` [gcc]_
under ``-std=3Dgnu89`` [gcc-c-dialect-options]_: the GNU dialect of ISO C90
(including some C99 features).

This dialect contains many extensions to the language [gnu-extensions]_,
and many of them are used within the kernel as a matter of course.

There is some support for compiling the kernel with ``clang`` [clang]_
and ``icc`` [icc]_, although at the time of writing it is not completed,
requiring third-party patches.

Attributes
----------

One of the common extensions used throughout the kernel are attributes
[gcc-attribute-syntax]_. Attributes allow to introduce
implementation-defined semantics to language entities (like variables,
functions or types) without having to make significant syntactic changes
to the language (e.g. adding a new keyword) [n2049]_.

In many cases, attributes are optional (i.e. a compiler not supporting them
should still produce proper code, even if it is slower or does not perform
as many compile-time checks/diagnostics).

The kernel defines pseudo-keywords (e.g. ``__pure``) instead of using
directly the GNU attribute syntax (e.g. ``__attribute__((pure))``).

Please refer to ``include/linux/compiler_attributes.h`` to see a reference
of all the common supported attributes.

.. [c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
.. [gcc] https://gcc.gnu.org
.. [clang] https://clang.llvm.org
.. [icc] https://software.intel.com/en-us/c-compilers
.. [gcc-c-dialect-options]
https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
.. [gnu-extensions]: https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
.. [gcc-attribute-syntax]
https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
.. [n2049] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
