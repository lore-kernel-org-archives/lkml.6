Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4E4C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9522086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FW95iO2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9522086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeIJWMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:12:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34164 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbeIJWMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:12:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so10818820pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuOIQZv6WjRvAbKrrWHpsdnwVgADihJ1PU5uAuXb3BU=;
        b=FW95iO2qZ3Ex4T/a4AkaYhrtgxza99RtCOjp73h7nI08h9c3A56V0HSbuHpsDv3Fcf
         TSBGrrH8rFiDndtU1QXuj70vmLpnyWZ+bZP+lo6EvsZ9+RCjY+C0A0WR748XaoV69QWh
         zH+UpJWEEB+nKVH5Kl6JLHcOtFwdsAQZ5liZ6dSnc+/Wim86KCRtU4V2qaK9355XjDo/
         tA7trYMmc/hKfViRtrtzKgTgmwyEozksyWVMwA7ykz2v4xJmqsxxPT7SqIPiwZdyCyQl
         8+Ow+Y1Og+KM6E+6OdfBP9pnSpCpw7238zGZ4yz2wIqkI85vySCAHfBzPG/KOW+VWvoE
         YOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuOIQZv6WjRvAbKrrWHpsdnwVgADihJ1PU5uAuXb3BU=;
        b=OrqCZ3NYE2MIlzb7SgQmNdn0YoMCeuz7ZfOi9olnIusCljbsY21zKLc/REWwGOYMmN
         DpTcZ8tQIuA+MilK6CpdXpi7zjmfpvF+MqCO7iD7M07RtZiLlZVsxxo6dfbp9T7ubKUq
         W55a3gSmGLV6UQDQXUuUwWtTqqKpDaRX5203GzDuAQye43e/vtmBA8lAXpyGTqTlocge
         MH6zeHq0h0yq3x8O1eylk1QlzVIej39Rmj2KR/K0xTfURvAbzrYrZSEU5KllsJszzNHS
         ZIzX88CqhkIzHIcY9fAhGMnb+RejNv737qYuap/hegZFUvV88OVKor/suHv+Hr4YjGTK
         Bptw==
X-Gm-Message-State: APzg51CdaS3CAqzbIsJANMBT0rq3DUXPNywg0q6kpNVXD86bO4HAW6BU
        khsImVru4zFP3pXVxoK23VitKBWLHMHtuupHlUu+ug20Wfk=
X-Google-Smtp-Source: ANB0VdaW3j13q2uNXpgiXSag3uKGq3nENeeV44OPcM+rOCjFxPRDewEMg3G68+rKrOd9X3xRxU6wESZikdECP6RkxRU=
X-Received: by 2002:a62:4b14:: with SMTP id y20-v6mr24769222pfa.93.1536599851787;
 Mon, 10 Sep 2018 10:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Sep 2018 10:17:20 -0700
Message-ID: <CAKwvOdnTxABJkQjdu6cv3e5zKB1z4n+rGkuzFxKvLAjUrqqCFA@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Compiler Attributes
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        efriedma@codeaurora.org, sparse@chrisli.org,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        joe@perches.com, asmadeus@codewreck.org,
        linux-sparse@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 2:25 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> The Compiler Attributes series is an effort to disentangle
> the include/linux/compiler*.h headers and bring them up to date.
>
> The main idea behind the series is to use feature checking macros
> (i.e. __has_attribute) instead of compiler version checks (e.g. GCC_VERSION),
> which are compiler-agnostic (so they can be shared, reducing the size
> of compiler-specific headers) and version-agnostic.
>
> Other related improvements have been performed in the headers as well,
> which on top of the use of __has_attribute it has amounted to a significant
> simplification of these headers (e.g. GCC_VERSION is now only guarding 4
> non-attribute macros).
>
> This series should also help the efforts to support compiling the kernel
> with clang and icc. A fair amount of documentation and comments have also
> been added, clarified or removed; and the headers are now more readable,
> which should help kernel developers in general.
>
> The series was triggered due to the move to gcc >= 4.6. In turn, this series
> has also triggered Sparse to gain the ability to recognize __has_attribute
> on its own.
>
> You can also fetch it from:
>
>   https://github.com/ojeda/linux/tree/compiler-attributes-v4
>
> Enjoy!
>
> Cheers,
> Miguel
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
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
> Cc: linux-sparse@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>
> v3 -> v4
>
>   This time it is an important fix I found while doing randconfigs, plus
>   the documentation sentence that Nick suggested and the MAINTAINERS file.
>
>   Compile-tested for a while on (x86_64, gcc-7.3) on a few randconfs.
>
>   New:
>
>   * Add MAINTAINERS entry for the new file (compiler_attributes.h)
>     so that we try to maintain that one as clean as possible.
>     (if someone else wants to join, feel free!)
>
>   Modified:
>
>   * Fix inline macro
>
>     __always_inline cannot be used in the inline macro,
>     because people marking a function as __always_inline would
>     expand to inline which in turn would expand back to __always_inline
>     (under some configs), which would not be expanded again.
>     Added a comment about this in the inline macro.
>
>     Also added another comment about __always_inline in compiler_attributes.h
>     to note that users expect to not have to write inline (as well as
>     the attribute). We cannot simply remove "inline" there (which would
>     solve the problem described above) because using the attribute is
>     not enough for gcc. A function marked as always_inline seems to require
>     to be marked as inline itself so that the attribute is applied:
>
>       "warning: always_inline function might not be inlinable [-Wattributes]"
>
>     From the gcc docs:
>
>       "For functions declared inline, this attribute inlines the function
>        independent of any restrictions that otherwise apply to inlining."
>
>     See https://godbolt.org/z/LpzUPj for an example.
>
>   From reviews:
>
>   * Add sentence about feature-detection in Docs (Nick)
>
> Miguel Ojeda (13):
>   Compiler Attributes: remove unused attributes
>   Compiler Attributes: always use the extra-underscores syntax
>   Compiler Attributes: remove unneeded tests
>   Compiler Attributes: homogenize __must_be_array
>   Compiler Attributes: naked was fixed in gcc 4.6
>   Compiler Attributes: naked can be shared
>   Compiler Attributes: remove unneeded sparse (__CHECKER__) tests
>   Compiler Attributes: add missing SPDX ID in compiler_types.h
>   Compiler Attributes: use feature checks instead of version checks
>   Compiler Attributes: KENTRY used twice the "used" attribute
>   Compiler Attributes: remove uses of __attribute__ from compiler.h
>   Compiler Attributes: add Doc/process/programming-language.rst
>   Compiler Attributes: Add MAINTAINERS entry
>
>  Documentation/process/index.rst               |   1 +
>  .../process/programming-language.rst          |  45 ++++
>  MAINTAINERS                                   |   5 +
>  include/linux/compiler-clang.h                |   5 -
>  include/linux/compiler-gcc.h                  |  84 +-----
>  include/linux/compiler-intel.h                |   9 -
>  include/linux/compiler.h                      |  19 +-
>  include/linux/compiler_attributes.h           | 244 ++++++++++++++++++
>  include/linux/compiler_types.h                | 105 ++------
>  9 files changed, 329 insertions(+), 188 deletions(-)
>  create mode 100644 Documentation/process/programming-language.rst
>  create mode 100644 include/linux/compiler_attributes.h
>
> --
> 2.17.1
>

For the ones I didn't already review:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
