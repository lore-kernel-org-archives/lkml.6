Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4882C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228ED24FE3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QN1AfHEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228ED24FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbeF3OPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 10:15:15 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:42174 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbeF3OPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 10:15:14 -0400
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com [209.85.213.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w5UEEr4I031526;
        Sat, 30 Jun 2018 23:14:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w5UEEr4I031526
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530368094;
        bh=ZyiYtlpOFdJgYfmmGUCF4qogL+Vt3foP+wrt9AR4roQ=;
        h=From:Date:Subject:To:Cc:From;
        b=QN1AfHEGqk5U77QnpKIQipOAgi0Q2lPZHcDhJTK3FiPZouv+h66SCDiFEYCxpYmT6
         +jaML2KIy1jew+nWqf5GktjAdA1V9RYUbkC2OyZF/jl0GDj9lobahH+rDZPutouQf5
         qRlatwgnrHbxsGg/x12d3CCGgWHdK8Bv63oTwg9FTlyqyG0hdZgVTNtZVxKqfx8UeF
         zO+skjkI1U7l3jxAfQLkqWggW+46r+qWYvYx5hQWD6PK8sGKFcJeB191TZ66WkAMIv
         qyVhtIismq4TlpexfsC/NJk9uyhl8HhC62O6rDjFSUigHk4pDw1eImLCUFDDByO5tv
         Ozjyxi/T26VGw==
X-Nifty-SrcIP: [209.85.213.46]
Received: by mail-vk0-f46.google.com with SMTP id d74-v6so6911252vke.10;
        Sat, 30 Jun 2018 07:14:54 -0700 (PDT)
X-Gm-Message-State: APt69E2jkCrXyWkwCrsEhA1XXDK2RVjjPFd3oq3kgBkEOJncsx4Zd1lK
        asp6DYM6TbYf3JDcQATS5BieM0PbdATrIQIixbk=
X-Google-Smtp-Source: AAOMgpe0eMkee31BSyqC6xW6s2psiz97jltawdWK6yekOEi20pAbSVhnuvdxuOkY8wcJ54WAUinMiLyHwHvJ/wI12Gs=
X-Received: by 2002:a1f:d982:: with SMTP id q124-v6mr11365535vkg.166.1530368092918;
 Sat, 30 Jun 2018 07:14:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 07:14:12
 -0700 (PDT)
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 30 Jun 2018 23:14:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNASY2kiCLCUoUaE3u-ddkxRj4CvaLa1-=m72MKyAFt0bhw@mail.gmail.com>
Message-ID: <CAK7LNASY2kiCLCUoUaE3u-ddkxRj4CvaLa1-=m72MKyAFt0bhw@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v4.18-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull Kbuild fixes.  Thanks!


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v4.18

for you to fetch changes up to 73d1c580f92b203f4c3a189ee98c917c65712f7e:

  kconfig: loop boundary condition fix (2018-06-28 22:48:08 +0900)

----------------------------------------------------------------
Kbuild fixes for v4.18

- introduce __diag_* macros and suppress -Wattribute-alias warnings from GCC 8

- fix stack protector test script for x86_64

- fix line number handling in Kconfig

- document that '#' starts a comment in Kconfig

- handle P_SYMBOL property in dump debugging of Kconfig

- correct help message of LD_DEAD_CODE_DATA_ELIMINATION

- fix occasional segmentation faults in Kconfig

----------------------------------------------------------------
Arnd Bergmann (2):
      kbuild: add macro for controlling warnings to linux/compiler.h
      disable -Wattribute-alias warning for SYSCALL_DEFINEx()

Dirk Gouders (2):
      kconfig: fix line numbers for if-entries in menu tree
      kconfig: handle P_SYMBOL in print_symbol()

Jerry James (1):
      kconfig: loop boundary condition fix

Masahiro Yamada (1):
      kbuild: reword help of LD_DEAD_CODE_DATA_ELIMINATION

Paul Burton (1):
      powerpc: Remove -Wattribute-alias pragmas

Randy Dunlap (1):
      kconfig: document Kconfig source file comments

Sven Joachim (1):
      stack-protector: Fix test with 32-bit userland and CONFIG_64BIT=y

 Documentation/kbuild/kconfig-language.txt |  6 ++++++
 arch/powerpc/kernel/pci_32.c              |  4 ----
 arch/powerpc/kernel/pci_64.c              |  4 ----
 arch/powerpc/kernel/rtas.c                |  4 ----
 arch/powerpc/kernel/signal_32.c           |  8 --------
 arch/powerpc/kernel/signal_64.c           |  4 ----
 arch/powerpc/kernel/syscalls.c            |  4 ----
 arch/powerpc/mm/subpage-prot.c            |  4 ----
 include/linux/compat.h                    |  8 +++++++-
 include/linux/compiler-gcc.h              | 25 +++++++++++++++++++++++++
 include/linux/compiler_types.h            | 18 ++++++++++++++++++
 include/linux/syscalls.h                  |  4 ++++
 init/Kconfig                              |  7 +++----
 scripts/gcc-x86_64-has-stack-protector.sh |  2 +-
 scripts/kconfig/expr.h                    |  3 +++
 scripts/kconfig/preprocess.c              |  2 +-
 scripts/kconfig/zconf.y                   |  8 ++++++--
 17 files changed, 74 insertions(+), 41 deletions(-)


-- 
Best Regards
Masahiro Yamada
