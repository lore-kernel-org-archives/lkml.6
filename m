Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeDCQb3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 12:31:29 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:23388 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeDCQb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 12:31:27 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w33GV5Sb028779
X-Nifty-SrcIP: [209.85.213.48]
X-Google-Smtp-Source: AIpwx4//H43nsWlquihE6+3awvy/mWtBSzInDDhSSfpGFvVMs7UTFfGQ49jRlbMu+2yVX/e/5jrevG6YqGt3AXPlm3Y=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 4 Apr 2018 01:30:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQM7V2bz0o1Gwb+w3xjkbdJ=rvg5Hxg0iuTT=4fzZ0D3A@mail.gmail.com>
Message-ID: <CAK7LNAQM7V2bz0o1Gwb+w3xjkbdJ=rvg5Hxg0iuTT=4fzZ0D3A@mail.gmail.com>
Subject: [GIT PULL 1/2] Kbuild updates for 4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull Kbuild updates for v4.17.


You will see a merge conflict in
arch/blackfin/kernel/bfin_ksyms.c

This file was already removed since
the blackfin support was entirely dropped.
So, please remove it.




The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v4.17

for you to fetch changes up to a95b37e20db9a2b05354eec009b2188523a21c8e:

  kbuild: get <linux/compiler_types.h> out of <linux/kconfig.h>
(2018-03-31 12:22:38 +0900)

----------------------------------------------------------------
Kbuild updates for v4.17

- add a shell script to get Clang version

- improve portability of build scripts

- drop always-enabled CONFIG_THIN_ARCHIVE and remove unused code

- rename built-in.o which is now thin archive to built-in.a

- process clean/build targets one by one to get along with -j option

- simplify ld-option

- improve building with CONFIG_TRIM_UNUSED_KSYMS

- define KBUILD_MODNAME even for objects shared among multiple modules

- avoid linking multiple instances of same objects from composite objects

- move <linux/compiler_types.h> to c_flags to include it only for C files

- clean-up various Makefiles

----------------------------------------------------------------
Cao jin (1):
      kbuild: fix modname for composite modules

Masahiro Yamada (23):
      kbuild: process mixture of clean/build targets one by one
      kbuild: simplify ld-option implementation
      kbuild: remove command line interface LDFLAGS_MODULE from makefiles.txt
      kbuild: remove internally used LDFLAGS_vmlinux from kbuild.txt
      kbuild: clear LDFLAGS in the top Makefile
      kbuild: remove wrong 'touch' in adjust_autoksyms.sh
      kbuild: move 'scripts' target below
      kbuild: restore autoksyms.h touch to the top Makefile
      kbuild: move CONFIG_TRIM_UNUSED_KSYMS code unneeded for external module
      kbuild: move include/config/ksym/* to include/ksym/*
      kbuild: link vmlinux only once for CONFIG_TRIM_UNUSED_KSYMS
      kbuild: remove unnecessary $(subst $(obj)/, , ...) in modname-multi
      kbuild: define KBUILD_MODNAME even if multiple modules share objects
      kbuild: simplify modname calculation
      kbuild: move modname and modname-multi close to modname_flags
      kbuild: rename real-objs-y/m to real-obj-y/m
      kbuild: link $(real-obj-y) instead of $(obj-y) into built-in.a
      lib: zstd: clean up Makefile for simpler composite object handling
      net: liquidio: clean up Makefile for simpler composite object handling
      kbuild: remove partial section mismatch detection for built-in.a
      kbuild: clean up archive rule of built-in.a
      kbuild: clean up link rule of composite modules
      kbuild: get <linux/compiler_types.h> out of <linux/kconfig.h>

Michael Forney (2):
      kbuild: Improve portability of some sed invocations
      kbuild: Use ls(1) instead of stat(1) to obtain file size

Nicholas Piggin (2):
      kbuild: remove incremental linking option
      kbuild: rename built-in.o to built-in.a

Sami Tolvanen (1):
      kbuild: add clang-version.sh

 .gitignore                                    |   1 +
 Documentation/kbuild/kbuild.txt               |   4 --
 Documentation/kbuild/makefiles.txt            |  28 ++++-----
 Documentation/process/changes.rst             |   2 +-
 Makefile                                      |  89 ++++++++++++++-------------
 arch/Kconfig                                  |   6 --
 arch/arm/boot/deflate_xip_data.sh             |   2 +-
 arch/blackfin/kernel/bfin_ksyms.c             |   2 +-
 arch/powerpc/boot/wrapper                     |   2 +-
 arch/powerpc/kernel/Makefile                  |   2 +-
 drivers/net/ethernet/cavium/liquidio/Makefile |  51 +++++-----------
 drivers/s390/Makefile                         |   2 +-
 include/linux/kconfig.h                       |   3 -
 lib/Kconfig.debug                             |   4 +-
 lib/zstd/Makefile                             |  17 ++----
 scripts/Kbuild.include                        |   6 +-
 scripts/Makefile.build                        |  97
++++++++++--------------------
 scripts/Makefile.lib                          |  47 +++++++--------
 scripts/adjust_autoksyms.sh                   |   9 ++-
 scripts/basic/fixdep.c                        |   8 +--
 scripts/clang-version.sh                      |  33 ++++++++++
 scripts/file-size.sh                          |   4 ++
 scripts/gen_initramfs_list.sh                 |   2 +-
 scripts/headers_install.sh                    |  10 ++--
 scripts/kconfig/Makefile                      |   2 -
 scripts/link-vmlinux.sh                       | 103
++++++++++++--------------------
 scripts/namespace.pl                          |   2 +-
 usr/initramfs_data.S                          |   2 +-
 28 files changed, 235 insertions(+), 305 deletions(-)
 create mode 100755 scripts/clang-version.sh
 create mode 100755 scripts/file-size.sh


-- 
Best Regards
Masahiro Yamada
