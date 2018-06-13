Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 199CDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D00208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bIA7PK73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D00208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935866AbeFMOrf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:47:35 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:48039 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935691AbeFMOrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:47:33 -0400
Received: from mail-ua0-f182.google.com (mail-ua0-f182.google.com [209.85.217.182]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w5DElCtB008432;
        Wed, 13 Jun 2018 23:47:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w5DElCtB008432
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528901233;
        bh=qS9sAr12Tjs3NljMBKMzicln6sbf5qlWq8u7VEcq35o=;
        h=From:Date:Subject:To:Cc:From;
        b=bIA7PK73w2ekwKeVBN6HS/bPcVxun3lhcwvXxYhVi02L84CGjqi+jLAQHr4CEN3y9
         hTOu8jr3eF3OE5mx7WAJ6Zit7oNHE7F7HXma6nK+wswDjHE9sj+gPEsmjfiOBfyDQm
         lIkFbDnJnv2YBa82hTJQZ1dJ7bG5dEKABSOuZV0Pf+wZkdh4YgM2d5dmWiXfUypEm4
         M0Bhxg2lpOxMHO8S82a3xfP8zfcysRl3vrN99XL6zUC/vs6y6Ne4R3+mOIauJGPGoC
         dMTAZ+WOIQ+hOFtBTeamVylF2ZmHgjDoo9XkmRyNJBgIjs6aDnD/yDeuupbqggrqev
         my5Rwlbpp3mLw==
X-Nifty-SrcIP: [209.85.217.182]
Received: by mail-ua0-f182.google.com with SMTP id m21-v6so1904614uan.0;
        Wed, 13 Jun 2018 07:47:13 -0700 (PDT)
X-Gm-Message-State: APt69E3P1uWXLU9MfofZuNdJHMeUo63dnNaX6AVocI/7MocUShvKEmP5
        fAmV00B02kL+WqgWx6kDwMywLV0WOEKNgO2KHsg=
X-Google-Smtp-Source: ADUXVKI5T+ZrfwrJ8kWSlXtniz02z8NewY7SYBJp26GJqZR9uSRI2DB3NU70BQZP5ZqAQD7TBrg2iZHNn8xuy5oOsb8=
X-Received: by 2002:ab0:5061:: with SMTP id z30-v6mr3525494uaz.82.1528901232138;
 Wed, 13 Jun 2018 07:47:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 07:46:31
 -0700 (PDT)
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 13 Jun 2018 23:46:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARDLbEhbJGrKY6HGwfxL8ebAMBDa_2A+s2QkzQGEKyFHQ@mail.gmail.com>
Message-ID: <CAK7LNARDLbEhbJGrKY6HGwfxL8ebAMBDa_2A+s2QkzQGEKyFHQ@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for 4.18 (2nd round)
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

Please pull more Kbuild updates.  Thanks!



The following changes since commit c90fca951e90ba470a3dc6087667edffcf8db21b:

  Merge tag 'powerpc-4.18-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
(2018-06-07 10:23:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v4.18-2

for you to fetch changes up to 00979ce4fcc90d488c7f27f750097adc6b11bd07:

  linux/linkage.h: replace VMLINUX_SYMBOL_STR() with __stringify()
(2018-06-13 00:03:17 +0900)

----------------------------------------------------------------
Kbuild updates for v4.18 (2nd)

 - fix some bugs introduced by the recent Kconfig syntax extension

 - add some symbols about compiler information in Kconfig, such as
   CC_IS_GCC, CC_IS_CLANG, GCC_VERSION, etc.

 - test compiler capability for the stack protector in Kconfig, and
   clean-up Makefile

 - test compiler capability for GCC-plugins in Kconfig, and clean-up
   Makefile

 - allow to enable GCC-plugins for COMPILE_TEST

 - test compiler capability for KCOV in Kconfig and correct dependency

 - remove auto-detect mode of the GCOV format, which is now more nicely
   handled in Kconfig

 - test compiler capability for mprofile-kernel on PowerPC, and
   clean-up Makefile

 - misc cleanups

----------------------------------------------------------------
Masahiro Yamada (14):
      kbuild: fix endless syncconfig in case arch Makefile sets CROSS_COMPILE
      stack-protector: test compiler capability in Kconfig and drop AUTO mode
      kconfig: add CC_IS_GCC and GCC_VERSION
      kconfig: add CC_IS_CLANG and CLANG_VERSION
      arm64: move GCC version check for ARCH_SUPPORTS_INT128 to Kconfig
      gcov: remove CONFIG_GCOV_FORMAT_AUTODETECT
      kcov: test compiler capability in Kconfig and correct dependency
      gcc-plugins: move GCC version check for PowerPC to Kconfig
      gcc-plugins: test plugin support in Kconfig and clean up Makefile
      gcc-plugins: allow to enable GCC_PLUGINS for COMPILE_TEST
      gcc-plugins: disable GCC_PLUGIN_STRUCTLEAK_BYREF_ALL for COMPILE_TEST
      Documentation: kconfig: add recommended way to describe compiler support
      sh: remove no-op macro VMLINUX_SYMBOL()
      linux/linkage.h: replace VMLINUX_SYMBOL_STR() with __stringify()

Nicholas Piggin (1):
      powerpc/kbuild: move -mprofile-kernel check to Kconfig

Sam Ravnborg (1):
      kconfig: fix localmodconfig

 Documentation/kbuild/kconfig-language.txt       |  18 +++
 Makefile                                        | 147 +++++----------------
 arch/Kconfig                                    |  50 +++----
 arch/arm64/Kconfig                              |   1 +
 arch/arm64/Makefile                             |   6 -
 arch/powerpc/Kconfig                            |  18 +--
 arch/powerpc/Makefile                           |  13 +-
 arch/powerpc/include/asm/module.h               |   2 +-
 arch/powerpc/kernel/module_64.c                 |   4 +-
 arch/powerpc/kernel/trace/ftrace.c              |   6 +-
 arch/powerpc/tools/gcc-check-mprofile-kernel.sh |   1 -
 arch/sh/include/asm/vmlinux.lds.h               |   4 +-
 arch/x86/Kconfig                                |  11 +-
 include/linux/linkage.h                         |  12 +-
 init/Kconfig                                    |  15 +++
 kernel/gcov/Kconfig                             |  17 +--
 kernel/gcov/Makefile                            |   2 -
 lib/Kconfig.debug                               |  11 +-
 scripts/Kconfig.include                         |   3 +
 scripts/Makefile.gcc-plugins                    |  91 +++----------
 scripts/Makefile.kcov                           |  10 +-
 scripts/clang-version.sh                        |  18 +--
 scripts/gcc-plugins/Makefile                    |   5 +-
 scripts/gcc-x86_32-has-stack-protector.sh       |   7 +-
 scripts/gcc-x86_64-has-stack-protector.sh       |   5 -
 scripts/kconfig/streamline_config.pl            |   4 +-
 26 files changed, 173 insertions(+), 308 deletions(-)


-- 
Best Regards
Masahiro Yamada
