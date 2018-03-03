Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeCCPjU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 10:39:20 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:39550 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeCCPjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 10:39:14 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w23Fd2k1004261
X-Nifty-SrcIP: [209.85.217.174]
X-Google-Smtp-Source: AG47ELsUHoFULuqVvoU8zrzRDemYxO0wgpsfnYdBTu4xdfnUttjZDGh9xo+XmEcXv0TtT1rvLIbk0+nT/sLIlbztddo=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 4 Mar 2018 00:38:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAThdvSDbAdD=JcQDdwhXnV2-coNif5Vje-=uJGVFHzVrA@mail.gmail.com>
Message-ID: <CAK7LNAThdvSDbAdD=JcQDdwhXnV2-coNif5Vje-=uJGVFHzVrA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v4.16-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are Kbuild fixes for v4.16.
Please pull!


The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v4.16

for you to fetch changes up to 50186e121ea1adcc43d0f9f790ee45e0b0f1202f:

  MAINTAINERS: take over Kconfig maintainership (2018-03-03 12:28:27 +0900)

----------------------------------------------------------------
Kbuild fixes for v4.16

- suppress sparse warnings about unknown attributes

- fix typos and stale comments

- fix build error of arch/sh

- fix wrong use of ld-option vs cc-ldoption

- remove redundant GCC_PLUGINS_CFLAGS assignment

- fix another memory leak of Kconfig

- fix line number in error messages of Kconfig

- do not write confusing CONFIG_DEFCONFIG_LIST out to .config

- add xstrdup() to Kconfig to handle memory shortage errors

- show also a Debian package name if ncurses is missing

----------------------------------------------------------------
Arvind Prasanna (1):
      kconfig: Update ncurses package names for menuconfig

Cao jin (2):
      kbuild: drop superfluous GCC_PLUGINS_CFLAGS assignment
      kbuild/kallsyms: trivial typo fix

Dafna Hirschfeld (1):
      Coccinelle: memdup: Fix typo in warning messages

Luc Van Oostenryck (1):
      kbuild: disable sparse warnings about unknown attributes

Masahiro Yamada (7):
      kconfig: add xstrdup() helper
      kconfig: set SYMBOL_AUTO to the symbol marked with defconfig_list
      sh: fix build error for empty CONFIG_BUILTIN_DTB_SOURCE
      kconfig: Don't leak choice names during parsing
      kbuild: test --build-id linker flag by ld-option instead of cc-ldoption
      kconfig: fix line number in recursive inclusion error message
      MAINTAINERS: take over Kconfig maintainership

Ulf Magnusson (1):
      Makefile: Fix lying comment re. silentoldconfig

 MAINTAINERS                                |  4 +++-
 Makefile                                   | 12 +++++-------
 arch/sh/boot/dts/Makefile                  |  4 +++-
 scripts/coccinelle/api/memdup.cocci        |  4 ++--
 scripts/kallsyms.c                         |  2 +-
 scripts/kconfig/confdata.c                 |  2 +-
 scripts/kconfig/kxgettext.c                |  2 +-
 scripts/kconfig/lkc.h                      |  1 +
 scripts/kconfig/lxdialog/check-lxdialog.sh |  3 ++-
 scripts/kconfig/menu.c                     |  1 +
 scripts/kconfig/symbol.c                   |  4 ++--
 scripts/kconfig/util.c                     | 11 +++++++++++
 scripts/kconfig/zconf.l                    | 12 ++++--------
 scripts/kconfig/zconf.y                    |  3 ++-
 scripts/link-vmlinux.sh                    |  2 +-
 15 files changed, 40 insertions(+), 27 deletions(-)


-- 
Best Regards
Masahiro Yamada
