Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240C2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A5420869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnJAePBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A5420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeIDAzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:55:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44491 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbeIDAzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:55:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so1721239wro.11;
        Mon, 03 Sep 2018 13:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JxZfHZLAlw2fNcQyZZeLSKrRnZnfVnqnwBDPvad1T3w=;
        b=QnJAePBw4gvwd1i0hVKesOpnX43gTVeT8rqmODVelq0DM/Ef5VQTPOq0gY1AHqdUgk
         wtiSegaugCj509hqs4NSRLXLxZCfzWP84Zj3dGIsRa/AcXOq3mS75C1V6BqyoMXmdOhd
         PYdD2p9KI21Q63xNP2IVPkTPmkacgLNcdQWA7SX9HNpKgs9JMX88zje3i8SLh/jqcqi3
         KxKm4VApIBEZuyjZNtDIeqT8B84IVdbFvgU0iOoQkPzgO5MTWKDbzn8ykjzVby0g/aXX
         HVCX77WdTojzxVeEm54JjqpUICUtheoHOyKYziPjGIyFph1TAJlMW+hfmzpW2MzdJksa
         njpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JxZfHZLAlw2fNcQyZZeLSKrRnZnfVnqnwBDPvad1T3w=;
        b=XhnVOwojZGBCrAZsVEB4yEnw1E3MkRQp9yO0TLUQvr8z/d464fir4rjlO2iBnfcGc7
         VvnZOStj9l3XvWSHXK1PESvG7uiM6L5qn9s/Q+x/r9SjiCFYalrPU1hCd0ItYNjpRx9T
         +7KXS/Hyys96X2A8mJ3iKfccH1zoq5bNgiksJpMcYCOSiz3Pc/9YWzlJ7bo6pO2WOhQh
         pFV8GyaUGMZMjBRQXMKz8KPj4BEZFbMLsWUW024JhG0mlV93ItvFFQ2eP/epzQ7UKnhq
         tonp/h7xkEToZ2w7ZDdOvpBA25yquEf7o5km8sFt2AoS9NOSVouk2aMDxgOU0z9Ey00H
         YKgw==
X-Gm-Message-State: APzg51D0MDd5r5SksUf5el78oothr8swF0OY/ss8JeXxwXy/iX1lW8pF
        HesdO68CTz4Iqs6GxEisax0=
X-Google-Smtp-Source: ANB0VdY+DI8g5DA4k5/ggSKH02NfDNfno3R589b4Rt48bHnT70VgQpFid1NfFR1Eni/+iJLVlRTktw==
X-Received: by 2002:adf:ed88:: with SMTP id c8-v6mr20169657wro.264.1536006823158;
        Mon, 03 Sep 2018 13:33:43 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id 132-v6sm12354870wmd.13.2018.09.03.13.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 13:33:42 -0700 (PDT)
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
Subject: [PATCH v3 00/12] Compiler Attributes
Date:   Mon,  3 Sep 2018 22:33:04 +0200
Message-Id: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
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

  https://github.com/ojeda/linux/tree/compiler-attributes-v3

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

v2 -> v3:

  New:

  * Remove duplicated "used" attribute in KENTRY
  * Silence sparse warnings on __has_attribute & simplify the macro block
  * Add Documentation/process/programming-language.rst
  * Improve _attribute.h description
  * Improve some commit descriptions
  * Add Reviewed-by's/Acked-by's/Suggested-by's
    (hopefully I didn't miss anybody!)
  * Rebase on top of v4.19-rc2
  * Cc Rasmus, Luc

  From reviews:

  * Fix __attribute_const__ rename typo (Nick)
  * Add SPDX identifier to _attributes.h (Nick)
  * Add SPDX identifier to _types.h (Greg)
  * Remove __attribute__ uses from compiler.h (Nick)
  * Tweak clang doc comments (Nick)
  * Move __naked out of -gcc.h to be shared (Arnd)
  * Use __name__ syntax instead (Rasmus)
  * Update sparse description (Luc)
  * Remove __CHECKER__ test from __must_be_array (Luc)
  * Add note on __has_attribute regarding sparse (Luc)
  * Cc linux-sparse (Luc)

It is quite a lot of stuff changed this time around, I hope I haven't missed
anything said in the emails. Please take a look!

Compile-tested for a while on (x86_64, gcc-7.3, allmodconfig).

Miguel Ojeda (12):
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

 Documentation/process/index.rst               |   1 +
 .../process/programming-language.rst          |  44 ++++
 include/linux/compiler-clang.h                |   5 -
 include/linux/compiler-gcc.h                  |  84 +-----
 include/linux/compiler-intel.h                |   9 -
 include/linux/compiler.h                      |  19 +-
 include/linux/compiler_attributes.h           | 239 ++++++++++++++++++
 include/linux/compiler_types.h                | 101 ++------
 8 files changed, 314 insertions(+), 188 deletions(-)
 create mode 100644 Documentation/process/programming-language.rst
 create mode 100644 include/linux/compiler_attributes.h

-- 
2.17.1

