Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D7AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D840121523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMTKorav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D840121523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbeITXH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:07:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45556 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbeITXH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:07:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so10193979wrb.12;
        Thu, 20 Sep 2018 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Mvn36hofEfpPYpcukR+o6LwbHt1GjireKAgB3TC2U50=;
        b=hMTKoravMYNas+nuIcZfBd5dd7yOKW68Ci71HaOf7X5FZqGyzFaHL4U4PkwlucG+0F
         z8d2vDzAZnst7Y/zNst4Z1aF2Gm1GX1z6aptkTN02ojcM3UMQ4MpMI5wGtS2LIyJQZ1X
         T88PzgIHUDZpJIZEsD/Hg//k5jcsv49fj8JrzEeoGU3qihfCltnM4WBnNyCct6V1gYue
         yWV5oWM/tkl2pUqAct+M7QjvE+o1mBnb4U8QnIITOi51CcsMSDL/5qKTBmmhHvCVqXfp
         6jgML4mjbIv7iWTj9zBVTbo0gZGeSorm/2LMzUwZvzXDt4uQYQKXuJhgkf+RoE3z13IA
         syZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mvn36hofEfpPYpcukR+o6LwbHt1GjireKAgB3TC2U50=;
        b=WhCAmJi5gzoOK2ZOSWiMFjHVBHB4yyKlTmpB7da0NnNg2fuySq1A6QtUB6uUVkIKh/
         Y6PEIKzNasZsNN0ya4yq7Uj7Q/36ZnlaEJ+LHEj5gPY45JiHCfhxgncjwmg06VDy+uMR
         DfahpFohtcDk1Tov8CYMTmCyeGbPw5G2yT9GBzXKs2nxZrtkQ9+IVs+96dCgUGvrqoq6
         prTFgMjyBKMRomvbFBu80k3gL2N/dRwAhkGjQMiuhvLVgcs361b/W3SbberE4kSWQd8L
         7qk4d/mBDM1GPzKP9A12S8S/7Ogmj/JfPGK0XE+sMzAZq1+3PZj55NGLSSFWZ/oVbA4A
         VNLA==
X-Gm-Message-State: APzg51B9gFrOIUiq80kcmbOEfo2Bx79iRrn4f+c1PUmqrCHaMQgzJGJX
        IthmPKEYBqrF1ESwsBM+d0U=
X-Google-Smtp-Source: ANB0VdZhFC9FjghumF/PDWV+mESNjf06HhsJ5PEG9Dye1n9iHSCmq+ocpcAuqGlIDeAgN+6t1YchKw==
X-Received: by 2002:adf:fe06:: with SMTP id n6-v6mr35097238wrr.171.1537464204115;
        Thu, 20 Sep 2018 10:23:24 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id q200-v6sm3466562wmd.2.2018.09.20.10.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:23:23 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v5 00/15] Compiler Attributes
Date:   Thu, 20 Sep 2018 19:22:46 +0200
Message-Id: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
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

Finally, the nonstring variable attribute series has been applied on top
of this one.

You can also fetch it from:

  https://github.com/ojeda/linux/tree/compiler-attributes-v5

Enjoy!

Cheers,
Miguel

Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Olof Johansson <olof@lxom.net>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Paul Lawrence <paullawrence@google.com>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Martin Sebor <msebor@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Joe Perches <joe@perches.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-ext4@vger.kernel.org
Cc: linux-sparse@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org

v4 -> v5

  * Removed the 2 __naked patches, since Greg just applied them to master;
    and rebased on top of that. The only change in the range-diff is in
    "Compiler Attributes: always use the extra-underscores syntax" due
    to the move of __naked to compiler_types.h.

  * Applied the nonstring series on top of this one (last 4 patches).
    Rationale:
      - the nonstring series would anyway be modified again by this one
        (so it has been rebased after the general cleanup).
      - ext4's "local" nonstring was merged
      - easier to manage (and easier to see the end result)

    The first 2 patches of the last 4 add the warning back at W=1 and
    add the __nonstring attribute. The other two serve as an example
    of usage and as a cleanup.

  * Cc lists removed from each commit; using a single list in the cover letter;
    and a new, revised list of Cc (wider audience).

Miguel Ojeda (15):
  Compiler Attributes: remove unused attributes
  Compiler Attributes: always use the extra-underscores syntax
  Compiler Attributes: remove unneeded tests
  Compiler Attributes: homogenize __must_be_array
  Compiler Attributes: remove unneeded sparse (__CHECKER__) tests
  Compiler Attributes: add missing SPDX ID in compiler_types.h
  Compiler Attributes: use feature checks instead of version checks
  Compiler Attributes: KENTRY used twice the "used" attribute
  Compiler Attributes: remove uses of __attribute__ from compiler.h
  Compiler Attributes: add Doc/process/programming-language.rst
  Compiler Attributes: add MAINTAINERS entry
  Compiler Attributes: add support for __nonstring (gcc >= 8)
  Compiler Attributes: enable -Wstringop-truncation on W=1 (gcc >= 8)
  Compiler Attributes: auxdisplay: panel: use __nonstring
  Compiler Attributes: ext4: remove local __nonstring definition

 Documentation/process/index.rst               |   1 +
 .../process/programming-language.rst          |  45 +++
 MAINTAINERS                                   |   5 +
 drivers/auxdisplay/panel.c                    |   7 +-
 fs/ext4/ext4.h                                |   9 -
 include/linux/compiler-clang.h                |   5 -
 include/linux/compiler-gcc.h                  |  70 +----
 include/linux/compiler-intel.h                |   9 -
 include/linux/compiler.h                      |  19 +-
 include/linux/compiler_attributes.h           | 258 ++++++++++++++++++
 include/linux/compiler_types.h                | 101 +------
 scripts/Makefile.extrawarn                    |   1 +
 12 files changed, 341 insertions(+), 189 deletions(-)
 create mode 100644 Documentation/process/programming-language.rst
 create mode 100644 include/linux/compiler_attributes.h

-- 
2.17.1

