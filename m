Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2469EC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2F420868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i86wFAKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2F420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeIICMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:12:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33407 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeIICMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:12:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id v90-v6so18168039wrc.0;
        Sat, 08 Sep 2018 14:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hQLziiB7cA1CETh/GxBQlUsMkk9RYUuPHaaaolDaah0=;
        b=i86wFAKFgv+CeGVr1yvRHrQ4OtRj0qByEje4TrfNcIF/FPYmUEfNdxWTdqO7MGV65/
         zZfMHb9w69ilqfao8gsvkzSH23RybdQCF5v4zE0xC1b9LuCLuRX+ODGy50DY11IA4QJ4
         ZTWaz6eyBlaEslLLG/QzdLiPb3d/IeVEz67j0geqF/qmm9dY8qhHBH3eFhcJlsoLDYuF
         qaX40d4hVtYrZgVStjXwxbfbzcxCI8O2P2an7MqEtgIooDxBawoOvlzRzOxkDUL546Wo
         UK3j75GI6OV/3z4mIWd2TfInutx8cEUtLFjs+ECPUJywj8MVCdMm3OkcQUwMb0fB/Y4H
         VbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hQLziiB7cA1CETh/GxBQlUsMkk9RYUuPHaaaolDaah0=;
        b=gbRGaKEzlimlRR7U5KSyFtxGspEGoBjn6uUI70846JbRYqXWt4SmF0w+lKjFbC9alb
         hPwJz/wsMElE3mAMD7b2jLFWW5nHKKdKWvT4WXjOaBOE2J/yWiWan20L+df61ORAskZd
         3IGRo1UcBimFVF0auMTvOb8ONzxTBabyQP2fOaMkzf0wvzBPumwPh7fW5ioxmERWSX6p
         gkt700ukvXpwi8Ezp68MGEpln/usaxurLxNsCPyM8l2Z0C2xDcsEaCP98lJkqDhcAEwh
         ZIbsKEPtFWqcYwQqIMLz4h0iRaiXkS6gCMcnVj06gYgvRPakXbKVxNrVKZYWRQz1Qid1
         z4Rg==
X-Gm-Message-State: APzg51CQqH3q8dPDfQvLv4FnmxqC1bgoyeK9S5FLs/nBXjPmD5SHvElH
        7obwhZ7sfhs2meNjhNQbi00=
X-Google-Smtp-Source: ANB0VdaXe3+gMaVsAoLWE/idNk7r/vgHCs6JglZIPpBAhJrGiyDcVAk/FYQ6TgIpSLjUX88fz1j4yg==
X-Received: by 2002:a5d:4605:: with SMTP id t5-v6mr9364555wrq.200.1536441911169;
        Sat, 08 Sep 2018 14:25:11 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id u40-v6sm17340786wrc.43.2018.09.08.14.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:25:10 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-sparse@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 00/13] Compiler Attributes
Date:   Sat,  8 Sep 2018 23:24:46 +0200
Message-Id: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Compiler Attributes series is an effort to disentangle
the include/linux/compiler*.h headers and bring them up to date.

The main idea behind the series is to use feature checking macros
(i.e. __has_attribute) instead of compiler version checks (e.g. GCC_VERSION),
which are compiler-agnostic (so they can be shared, reducing the size
of compiler-specific headers) and version-agnostic.

Other related improvements have been performed in the headers as well,
which on top of the use of __has_attribute it has amounted to a significant
simplification of these headers (e.g. GCC_VERSION is now only guarding 4
non-attribute macros).

This series should also help the efforts to support compiling the kernel
with clang and icc. A fair amount of documentation and comments have also
been added, clarified or removed; and the headers are now more readable,
which should help kernel developers in general.

The series was triggered due to the move to gcc >= 4.6. In turn, this series
has also triggered Sparse to gain the ability to recognize __has_attribute
on its own.

You can also fetch it from:

  https://github.com/ojeda/linux/tree/compiler-attributes-v4

Enjoy!

Cheers,
Miguel

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

v3 -> v4

  This time it is an important fix I found while doing randconfigs, plus
  the documentation sentence that Nick suggested and the MAINTAINERS file.

  Compile-tested for a while on (x86_64, gcc-7.3) on a few randconfs.

  New:

  * Add MAINTAINERS entry for the new file (compiler_attributes.h)
    so that we try to maintain that one as clean as possible.
    (if someone else wants to join, feel free!)

  Modified:

  * Fix inline macro

    __always_inline cannot be used in the inline macro,
    because people marking a function as __always_inline would
    expand to inline which in turn would expand back to __always_inline
    (under some configs), which would not be expanded again.
    Added a comment about this in the inline macro.

    Also added another comment about __always_inline in compiler_attributes.h
    to note that users expect to not have to write inline (as well as
    the attribute). We cannot simply remove "inline" there (which would
    solve the problem described above) because using the attribute is
    not enough for gcc. A function marked as always_inline seems to require
    to be marked as inline itself so that the attribute is applied:

      "warning: always_inline function might not be inlinable [-Wattributes]"

    From the gcc docs:

      "For functions declared inline, this attribute inlines the function
       independent of any restrictions that otherwise apply to inlining."

    See https://godbolt.org/z/LpzUPj for an example.

  From reviews:

  * Add sentence about feature-detection in Docs (Nick)

Miguel Ojeda (13):
  Compiler Attributes: remove unused attributes
  Compiler Attributes: always use the extra-underscores syntax
  Compiler Attributes: remove unneeded tests
  Compiler Attributes: homogenize __must_be_array
  Compiler Attributes: naked was fixed in gcc 4.6
  Compiler Attributes: naked can be shared
  Compiler Attributes: remove unneeded sparse (__CHECKER__) tests
  Compiler Attributes: add missing SPDX ID in compiler_types.h
  Compiler Attributes: use feature checks instead of version checks
  Compiler Attributes: KENTRY used twice the "used" attribute
  Compiler Attributes: remove uses of __attribute__ from compiler.h
  Compiler Attributes: add Doc/process/programming-language.rst
  Compiler Attributes: Add MAINTAINERS entry

 Documentation/process/index.rst               |   1 +
 .../process/programming-language.rst          |  45 ++++
 MAINTAINERS                                   |   5 +
 include/linux/compiler-clang.h                |   5 -
 include/linux/compiler-gcc.h                  |  84 +-----
 include/linux/compiler-intel.h                |   9 -
 include/linux/compiler.h                      |  19 +-
 include/linux/compiler_attributes.h           | 244 ++++++++++++++++++
 include/linux/compiler_types.h                | 105 ++------
 9 files changed, 329 insertions(+), 188 deletions(-)
 create mode 100644 Documentation/process/programming-language.rst
 create mode 100644 include/linux/compiler_attributes.h

-- 
2.17.1

