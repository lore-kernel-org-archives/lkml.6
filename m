Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04316C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 16:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934D42154B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 16:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Xr2WogYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934D42154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbeHYUhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 16:37:41 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:53736 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeHYUhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 16:37:41 -0400
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com [209.85.213.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w7PGvmvr010794;
        Sun, 26 Aug 2018 01:57:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w7PGvmvr010794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535216269;
        bh=enDWQocmvnfcoRYjMPJIHvLuKnZsXUTZDipcMhmVjW4=;
        h=From:Date:Subject:To:Cc:From;
        b=Xr2WogYc+Ok0bdqOAWFFL8JcJcHlp7lH7Jylm0ANm4/BODtidOls756DpZbsyI3hk
         J1nUAaRJ1APdbpLRhNQiOuebLVYJo85rM2LFwsOsbe3L0mBvnfhG95ztWWlblDCUxA
         jsU0zjukWsMkvTK+x/BubeDR4/bubaxQ4n3gYoj/8m+dcOksyM+pIbIu2jagcGxMTd
         3uRSx+1M3BQo9cgRxa68BY2JBYMS7pcaJipMXNbE7Ihkgbencn57/Cu9RL0oMsH0ip
         FHyej4YQ7x4iNmDjiUixhnV/SiEaSYKA+pAuHyuT33Crtvhq43rjC6ErMeVmT8hxE0
         SAmLTP0+WEQgw==
X-Nifty-SrcIP: [209.85.213.54]
Received: by mail-vk0-f54.google.com with SMTP id s6-v6so4639647vks.4;
        Sat, 25 Aug 2018 09:57:48 -0700 (PDT)
X-Gm-Message-State: APzg51AjqJRQ/dSrmUcTGUQaIxbGfKsOJUUur2ppSHtZPCtlgFyLNYPc
        k2biv4fiOd7Nvc25XZjE+4Wm0zimW4hf9ecdN6E=
X-Google-Smtp-Source: ANB0VdawVwZaR3Hi61XmWKy/xec72ruDM5Bs3GHSOYerwgQ2079Bbm7QKnk8gjfxe5ZYyj3iRI9Kzz4rCa/DJ4KiGV0=
X-Received: by 2002:a1f:2cce:: with SMTP id s197-v6mr3608118vks.106.1535216267726;
 Sat, 25 Aug 2018 09:57:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Sat, 25 Aug 2018 09:57:06
 -0700 (PDT)
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 26 Aug 2018 01:57:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNASV610cW8Happ7EFKjY8DZ_gb57Ppvt=qUsM5DKDq6zYw@mail.gmail.com>
Message-ID: <CAK7LNASV610cW8Happ7EFKjY8DZ_gb57Ppvt=qUsM5DKDq6zYw@mail.gmail.com>
Subject: [GIT PULL] more Kbuild updates for v4.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull more Kbuild updates.

Thanks.



The following changes since commit ad1d69735878a6bf797705b5d2a20316d35e1113:

  Merge tag 'fuse-update-4.19' of
git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse
(2018-08-21 18:47:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v4.19-2

for you to fetch changes up to d503ac531a5246e4d910f971b213807fea925956:

  kbuild: rename LDFLAGS to KBUILD_LDFLAGS (2018-08-24 08:22:08 +0900)

----------------------------------------------------------------
Kbuild updates for v4.19 (2nd)

 - add build_{menu,n,g,x}config targets for compile-testing Kconfig

 - fix and improve recursive dependency detection in Kconfig

 - fix parallel building of menuconfig/nconfig

 - fix syntax error in clang-version.sh

 - suppress distracting log from syncconfig

 - remove obsolete "rpm" target

 - remove VMLINUX_SYMBOL(_STR) macro entirely

 - fix microblaze build with CONFIG_DYNAMIC_FTRACE

 - move compiler test for dead code/data elimination to Kconfig

 - rename well-known LDFLAGS variable to KBUILD_LDFLAGS

 - misc fixes and cleanups

----------------------------------------------------------------
Andrzej Pietrasiewicz (1):
      kbuild: make sorting initramfs contents independent of locale

Masahiro Yamada (13):
      scripts/dtc: consolidate include path options in Makefile
      kconfig: error out when seeing recursive dependency
      kconfig: report recursive dependency involving 'imply'
      kconfig: improve the recursive dependency report
      kconfig: fix "Can't open ..." in parallel build
      kconfig: suppress "configuration written to .config" for syncconfig
      kbuild: remove "rpm" target, which is alias of "rpm-pkg"
      export.h: remove VMLINUX_SYMBOL() and VMLINUX_SYMBOL_STR()
      vmlinux.lds.h: remove stale <linux/export.h> include
      initramfs: move gen_initramfs_list.sh from scripts/ to usr/
      kbuild: test dead code/data elimination support in Kconfig
      kbuild: pass LDFLAGS to recordmcount.pl
      kbuild: rename LDFLAGS to KBUILD_LDFLAGS

Michael Forney (1):
      kbuild: Add a space after `!` to prevent parsing as file pattern

Michal Suchanek (1):
      kbuild: Fix LOADLIBES rename in Documentation/kbuild/makefiles.txt

Randy Dunlap (2):
      kconfig: add build-only configurator targets
      scripts: modpost: check memory allocation results

zhong jiang (1):
      Coccinelle: remove pci_alloc_consistent semantic to detect in
zalloc-simple.cocci

 Documentation/early-userspace/README       |  6 +-
 .../filesystems/ramfs-rootfs-initramfs.txt |  2 +-
 Documentation/kbuild/kconfig-language.txt  |  3 +-
 Documentation/kbuild/makefiles.txt         |  2 +-
 Makefile                                   | 18 ++---
 arch/arc/Makefile                          |  2 +-
 arch/arm/Makefile                          |  4 +-
 arch/arm64/Makefile                        |  4 +-
 arch/c6x/Makefile                          |  3 +-
 arch/h8300/Makefile                        |  2 +-
 arch/hexagon/Makefile                      |  4 +-
 arch/m68k/Makefile                         |  2 +-
 arch/microblaze/Makefile                   |  4 +-
 arch/mips/Makefile                         |  2 +-
 arch/mips/boot/compressed/Makefile         |  2 +-
 arch/mips/lasat/image/Makefile             |  2 +-
 arch/nds32/Makefile                        |  4 +-
 arch/powerpc/Makefile                      |  6 +-
 arch/riscv/Makefile                        |  4 +-
 arch/s390/Makefile                         |  2 +-
 arch/sh/Makefile                           |  4 +-
 arch/sparc/Makefile                        |  4 +-
 arch/um/Makefile                           |  2 +-
 arch/x86/Makefile                          |  4 +-
 arch/x86/Makefile.um                       |  4 +-
 arch/x86/boot/compressed/Makefile          |  6 +-
 arch/xtensa/Makefile                       |  2 +-
 arch/xtensa/boot/boot-elf/Makefile         |  2 +-
 certs/system_certificates.S                | 16 ++---
 include/asm-generic/vmlinux.lds.h          |  2 -
 include/linux/export.h                     |  7 --
 init/Kconfig                               |  2 +
 scripts/Kbuild.include                     |  4 +-
 scripts/Makefile.build                     |  6 +-
 scripts/Makefile.lib                       |  2 +-
 scripts/Makefile.modpost                   |  2 +-
 scripts/clang-version.sh                   |  2 +-
 .../api/alloc/zalloc-simple.cocci          | 41 +-----------
 scripts/dtc/Makefile                       | 18 ++---
 scripts/kconfig/Makefile                   | 16 ++++-
 scripts/kconfig/conf.c                     |  5 ++
 scripts/kconfig/symbol.c                   | 58 ++++++++++++-----
 .../Kconfig                                |  3 +-
 .../tests/err_recursive_dep/__init__.py    | 10 +++
 .../err_recursive_dep/expected_stderr      | 38 +++++++++++
 .../tests/warn_recursive_dep/__init__.py   |  9 ---
 .../warn_recursive_dep/expected_stderr     | 30 ---------
 scripts/link-vmlinux.sh                    |  4 +-
 scripts/mod/modpost.c                      |  8 +--
 usr/Makefile                               |  2 +-
 {scripts => usr}/gen_initramfs_list.sh     |  2 +-
 usr/initramfs_data.S                       |  4 +-
 52 files changed, 188 insertions(+), 209 deletions(-)
 rename scripts/kconfig/tests/{warn_recursive_dep =>
err_recursive_dep}/Kconfig (93%)
 create mode 100644 scripts/kconfig/tests/err_recursive_dep/__init__.py
 create mode 100644 scripts/kconfig/tests/err_recursive_dep/expected_stderr
 delete mode 100644 scripts/kconfig/tests/warn_recursive_dep/__init__.py
 delete mode 100644 scripts/kconfig/tests/warn_recursive_dep/expected_stderr
 rename {scripts => usr}/gen_initramfs_list.sh (99%)


-- 
Best Regards
Masahiro Yamada
