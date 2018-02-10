Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeBJDDo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 22:03:44 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:55303 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBJDDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 22:03:42 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w1A33dAT007863
X-Nifty-SrcIP: [209.85.213.42]
X-Google-Smtp-Source: AH8x227mG6HTpZAdUTTopDVJQYN3peIDeCfUuTW4Yae860rH589IspwmPwGxWdyx36bMyGdjnwez2ctiNuzC7vQ7QEs=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 10 Feb 2018 12:02:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpX7HWB0Wj-_rMXFogFtUamWTWEr3ypb6v-s99pr5UNw@mail.gmail.com>
Message-ID: <CAK7LNARpX7HWB0Wj-_rMXFogFtUamWTWEr3ypb6v-s99pr5UNw@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v4.16 (2nd round)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>, masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are a little more Kbuild updates (including Kconfig changes).
Please pull!


The following changes since commit 4bf772b14675411a69b3c807f73006de0fe4b649:

  Merge tag 'drm-for-v4.16' of
git://people.freedesktop.org/~airlied/linux (2018-02-01 17:48:47
-0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v4.16-2

for you to fetch changes up to 523ca58b7db2e30e3c185a7927dd80a30c1bc743:

  kconfig: remove const qualifier from sym_expand_string_value()
(2018-02-10 11:31:49 +0900)

----------------------------------------------------------------
Kbuild updates for v4.16 (2nd)

Makefile changes:
- enable unused-variable warning that was wrongly disabled for clang

Kconfig changes:
- warn blank 'help' and fix existing instances
- fix 'choice' behavior to not write out invisible symbols
- fix misc weirdness

Coccinell changes:
- fix false positive of free after managed memory alloc detection
- improve performance of NULL dereference detection

----------------------------------------------------------------
Julia Lawall (2):
      coccinelle: devm_free: reduce false positives
      coccinelle: deref_null: avoid useless computation

Masahiro Yamada (8):
      kconfig: do not write choice values when their dependency becomes n
      kconfig: show '?' prompt even if no help text is available
      kconfig: remove 'config*' pattern from .gitignnore
      kconfig: remove check_stdin()
      kconfig: echo stdin to stdout if either is redirected
      kconfig: send error messages to stderr
      kconfig: add xrealloc() helper
      kconfig: remove const qualifier from sym_expand_string_value()

Sodagudi Prasad (1):
      kbuild: clang: disable unused variable warnings only when constant

Ulf Magnusson (10):
      video: fbdev: kconfig: Remove blank help text
      mmc: kconfig: Remove blank help text
      Staging: rtl8192u: kconfig: Remove blank help text
      Staging: rtl8192e: kconfig: Remove blank help text
      lib/Kconfig.debug: Remove blank help text
      MIPS: BCM63XX: kconfig: Remove blank help text
      MIPS: kconfig: Remove blank help text
      arm: vt8500: kconfig: Remove blank help text
      nios2: kconfig: Remove blank help text
      kconfig: Warn if help text is blank

 Makefile                                  |  3 +-
 arch/arm/mach-vt8500/Kconfig              |  1 -
 arch/mips/Kconfig                         |  1 -
 arch/mips/bcm63xx/boards/Kconfig          |  1 -
 arch/nios2/Kconfig                        |  1 -
 drivers/mmc/host/Kconfig                  |  1 -
 drivers/staging/rtl8192e/rtl8192e/Kconfig |  1 -
 drivers/staging/rtl8192u/Kconfig          |  1 -
 drivers/video/fbdev/Kconfig               |  1 -
 lib/Kconfig.debug                         |  1 -
 scripts/coccinelle/free/devm_free.cocci   | 55
+++++++++++++++++++++++++++++++++-
 scripts/coccinelle/null/deref_null.cocci  |  6 ++--
 scripts/kconfig/.gitignore                |  1 -
 scripts/kconfig/conf.c                    | 40 ++++++++-----------------
 scripts/kconfig/confdata.c                |  2 +-
 scripts/kconfig/expr.c                    |  4 +--
 scripts/kconfig/lkc.h                     |  1 +
 scripts/kconfig/lkc_proto.h               |  2 +-
 scripts/kconfig/nconf.gui.c               |  3 +-
 scripts/kconfig/symbol.c                  | 22 +++++++-------
 scripts/kconfig/util.c                    | 15 ++++++++--
 scripts/kconfig/zconf.l                   | 29 ++++++++++--------
 scripts/kconfig/zconf.y                   |  6 ++++
 23 files changed, 121 insertions(+), 77 deletions(-)


-- 
Best Regards
Masahiro Yamada
