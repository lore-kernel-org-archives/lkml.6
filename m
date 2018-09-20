Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA51CECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ED921532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OqRd8fsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44ED921532
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388003AbeIUADP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:03:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34560 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeIUADO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:03:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so4825358pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dLv9BFMsAwxCi/XYmlJKxqLD7eDnACUAKnEAGhV/fQ=;
        b=OqRd8fsY65MwISMMW5lykrjmCcOT34FiK3qyFvRNMMqtivOS4oWGCJ+hBS4tpwLWYj
         5glFiTQqmU6VVycj4LmI1uknhSxb6+qqpwM9pFwRevOQhbVdzNOmZ13M+pHIzWza8iO4
         mG8+3XMBQUo7LYMn9zkpeRdowzcW4EVYBaAH29qDZdV5zvVA1XLpny8YG1D2f3pDuAt7
         J3OhVtICODVPRlAEjeawPR2D07of4QACCWlGlf65YakLJsiR82UeAFPOhomLb6Osgtid
         lI5cDGTK+0pVsQyx8iInmv4BBWuPyj/bBxNYGEp4vyiuoOIU5eYwpk3aGP3p3fXYWKPn
         k2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dLv9BFMsAwxCi/XYmlJKxqLD7eDnACUAKnEAGhV/fQ=;
        b=Nnjz9A7DmJPw8hyKYko11Htf6rbpHElhnLJiLV8alAd2bMzscTJYQAy9aSPelzjgP1
         gx9+mpJTbUOcz4nK5H+wkjegQhJFd35Rlncz2eGZWx7zG+W4JyaD6jcHpnjhajd8iqIT
         l6uNviuFLD5okMbisg71NGYMNaZrtPqG6owrJNxg69bAzIAavluMdwRqE89ZgmfzRNib
         /cb1MemwUtCjXWaD0zIJDJT9Mu+GtyrhIwNqFwy530oo/89t0jfB3P1VowwFH6wMI+Rr
         BEOkYs0MCZyAp6ZGpko0w/8RfI1V/cdCOVvRRgbF16TeZY0g7VbM1t0kGjY5IOjSpitd
         qW/A==
X-Gm-Message-State: APzg51BvvIvRDCBxAxwlpObfDgL+iWYvN04nlY/eOom/MF1r009FWT2L
        4nMbid7Jm6kQLNrbQ1+GzQrmR3WIiiw1ClfXERZ8SQ==
X-Google-Smtp-Source: ANB0VdY8KZlpSW6gX0nWeae/iEzGzDX5InOHLzEWy1YMZqbV2Ms4vbei91gthvAk46rJGhvK9xJClMrZ20maRTvKDBw=
X-Received: by 2002:a62:591a:: with SMTP id n26-v6mr42590521pfb.94.1537467508667;
 Thu, 20 Sep 2018 11:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Sep 2018 11:18:17 -0700
Message-ID: <CAKwvOdk2O+-FqXU1R8m=vSbZuMGJxY-_4AWd+tFpcTDKhWWFaw@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] Compiler Attributes
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, adilger.kernel@dilger.ca,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, rostedt@goodmis.org,
        mchehab+samsung@kernel.org, olof@lxom.net,
        konstantin@linuxfoundation.org,
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
        w@1wt.eu, msebor@gmail.com, sparse@chrisli.org,
        Jonathan Corbet <corbet@lwn.net>, tytso@mit.edu,
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

On Thu, Sep 20, 2018 at 10:23 AM Miguel Ojeda
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
> Finally, the nonstring variable attribute series has been applied on top
> of this one.
>
> You can also fetch it from:
>
>   https://github.com/ojeda/linux/tree/compiler-attributes-v5
>
> Enjoy!
>
> Cheers,
> Miguel

Thanks for this series.  I've reviewed the rest of the patches in the
series that didn't already have my reviewed by tags on them.  They
look good to go to me.

>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Olof Johansson <olof@lxom.net>
> Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Paul Lawrence <paullawrence@google.com>
> Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: Martin Sebor <msebor@gmail.com>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Joe Perches <joe@perches.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-ext4@vger.kernel.org
> Cc: linux-sparse@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
>
> v4 -> v5
>
>   * Removed the 2 __naked patches, since Greg just applied them to master;
>     and rebased on top of that. The only change in the range-diff is in
>     "Compiler Attributes: always use the extra-underscores syntax" due
>     to the move of __naked to compiler_types.h.
>
>   * Applied the nonstring series on top of this one (last 4 patches).
>     Rationale:
>       - the nonstring series would anyway be modified again by this one
>         (so it has been rebased after the general cleanup).
>       - ext4's "local" nonstring was merged
>       - easier to manage (and easier to see the end result)
>
>     The first 2 patches of the last 4 add the warning back at W=1 and
>     add the __nonstring attribute. The other two serve as an example
>     of usage and as a cleanup.
>
>   * Cc lists removed from each commit; using a single list in the cover letter;
>     and a new, revised list of Cc (wider audience).
>
> Miguel Ojeda (15):
>   Compiler Attributes: remove unused attributes
>   Compiler Attributes: always use the extra-underscores syntax
>   Compiler Attributes: remove unneeded tests
>   Compiler Attributes: homogenize __must_be_array
>   Compiler Attributes: remove unneeded sparse (__CHECKER__) tests
>   Compiler Attributes: add missing SPDX ID in compiler_types.h
>   Compiler Attributes: use feature checks instead of version checks
>   Compiler Attributes: KENTRY used twice the "used" attribute
>   Compiler Attributes: remove uses of __attribute__ from compiler.h
>   Compiler Attributes: add Doc/process/programming-language.rst
>   Compiler Attributes: add MAINTAINERS entry
>   Compiler Attributes: add support for __nonstring (gcc >= 8)
>   Compiler Attributes: enable -Wstringop-truncation on W=1 (gcc >= 8)
>   Compiler Attributes: auxdisplay: panel: use __nonstring
>   Compiler Attributes: ext4: remove local __nonstring definition
>
>  Documentation/process/index.rst               |   1 +
>  .../process/programming-language.rst          |  45 +++
>  MAINTAINERS                                   |   5 +
>  drivers/auxdisplay/panel.c                    |   7 +-
>  fs/ext4/ext4.h                                |   9 -
>  include/linux/compiler-clang.h                |   5 -
>  include/linux/compiler-gcc.h                  |  70 +----
>  include/linux/compiler-intel.h                |   9 -
>  include/linux/compiler.h                      |  19 +-
>  include/linux/compiler_attributes.h           | 258 ++++++++++++++++++
>  include/linux/compiler_types.h                | 101 +------
>  scripts/Makefile.extrawarn                    |   1 +
>  12 files changed, 341 insertions(+), 189 deletions(-)
>  create mode 100644 Documentation/process/programming-language.rst
>  create mode 100644 include/linux/compiler_attributes.h
>
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
