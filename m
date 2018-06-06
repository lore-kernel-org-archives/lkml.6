Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PCiEYVRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C98660555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753757AbeFFRHl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:07:41 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:47365 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932202AbeFFRHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:07:39 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w56H7X9q023909
X-Nifty-SrcIP: [209.85.213.43]
X-Google-Smtp-Source: ADUXVKIEzxHsIKj1XMlxr11qHijRAbFBs6fDvxt/IBGDzw8isowY6fT3RaHAmWkFyaIRRImKHNTo1ErNdgU79IgImJ0=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 7 Jun 2018 02:06:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQhF_A1CE28_4qe0DWS4pDeR1xw399NATm7X2UUKLe7=w@mail.gmail.com>
Message-ID: <CAK7LNAQhF_A1CE28_4qe0DWS4pDeR1xw399NATm7X2UUKLe7=w@mail.gmail.com>
Subject: [GIT PULL 1/2] Kbuild updates for v4.18
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull Kbuild updates for v4.18



The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v4.18

for you to fetch changes up to 1f2f01b122d7c78a9e842a126ef168afb279552b:

  kbuild: add machine size to CHECKFLAGS (2018-06-01 11:36:58 +0900)

----------------------------------------------------------------
Kbuild updates for v4.18

- improve fixdep to coalesce consecutive slashes in dep-files

- fix some issues of the maintainer string generation in deb-pkg script

- remove unused CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX and clean-up
  several tools and linker scripts

- clean-up modpost

- allow to enable the dead code/data elimination for PowerPC in EXPERT mode

- improve two coccinelle scripts for better performance

- pass endianness and machine size flags to sparse for all architecture

- misc fixes

----------------------------------------------------------------
Joey Pabalinas (1):
      scripts/tags.sh: use `find` for $ALLSOURCE_ARCHS generation

Julia Lawall (2):
      coccinelle: mini_lock: improve performance
      coccinelle: deref_null: improve performance

Luc Van Oostenryck (3):
      kbuild: $(CHECK) doesnt need NOSTDINC_FLAGS twice
      kbuild: add endianness flag to CHEKCFLAGS
      kbuild: add machine size to CHECKFLAGS

Masahiro Yamada (12):
      modpost: remove symbol prefix support
      genksyms: remove symbol prefix support
      kallsyms: remove symbol prefix support
      depmod.sh: remove symbol prefix support
      export.h: remove code for prefixing symbols with underscore
      kbuild: remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
      vmlinux.lds.h: remove no-op macro VMLINUX_SYMBOL()
      checkpatch: remove VMLINUX_SYMBOL() check
      modpost: pass struct elf_info pointer to get_modinfo()
      modpost: use strstarts() helper more widely
      modpost: remove redundant is_vmlinux() test
      modpost: constify *modname function argument where possible

Nicholas Piggin (4):
      kbuild: Fix asm-generic/vmlinux.lds.h for LD_DEAD_CODE_DATA_ELIMINATION
      kbuild: LD_DEAD_CODE_DATA_ELIMINATION no
-ffunction-sections/-fdata-sections for module build
      kbuild: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selectable if enabled
      powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selected

Nicolas Pitre (1):
      fixdep: suppress consecutive / from file paths in dependency list files

Riku Voipio (1):
      kbuild: deb-pkg improve maintainer address generation

nixiaoming (1):
      scripts: Fixed printf format mismatch

 Makefile                                 |  13 +-
 arch/Kconfig                             |  21 ---
 arch/alpha/Makefile                      |   2 +-
 arch/arm/Makefile                        |   2 +-
 arch/arm64/Makefile                      |   2 +-
 arch/ia64/Makefile                       |   2 +-
 arch/mips/Makefile                       |   3 -
 arch/openrisc/Makefile                   |   1 -
 arch/parisc/Makefile                     |   4 +-
 arch/powerpc/Kconfig                     |   1 +
 arch/powerpc/kernel/vmlinux.lds.S        |  22 +--
 arch/s390/Makefile                       |   2 +-
 arch/sparc/Makefile                      |   2 +-
 arch/x86/Makefile                        |   2 +-
 include/asm-generic/export.h             |  34 ++--
 include/asm-generic/vmlinux.lds.h        | 334
++++++++++++++++++-----------------
 include/linux/export.h                   |  16 +-
 init/Kconfig                             |  27 +++
 scripts/Makefile.build                   |   9 +-
 scripts/adjust_autoksyms.sh              |   3 -
 scripts/basic/fixdep.c                   |   6 +-
 scripts/checkpatch.pl                    |  10 --
 scripts/coccinelle/locks/mini_lock.cocci |   6 +-
 scripts/coccinelle/null/deref_null.cocci |  40 ++---
 scripts/depmod.sh                        |  25 +--
 scripts/genksyms/genksyms.c              |  11 +-
 scripts/kallsyms.c                       |  49 ++---
 scripts/link-vmlinux.sh                  |   4 -
 scripts/mod/modpost.c                    |  97 +++++-----
 scripts/package/mkdebian                 |  27 ++-
 scripts/recordmcount.c                   |   2 +-
 scripts/recordmcount.h                   |   2 +-
 scripts/tags.sh                          |  11 +-
 33 files changed, 349 insertions(+), 443 deletions(-)


-- 
Best Regards
Masahiro Yamada
