Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD08C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C67C214F0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RRoBmdML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C67C214F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbeHOU5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:57:41 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:35590 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeHOU5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:57:41 -0400
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com [209.85.213.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w7FI4Kgg007601;
        Thu, 16 Aug 2018 03:04:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w7FI4Kgg007601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534356261;
        bh=h0KLP2wIVHREDmVF9lTIgabyvVjJ+yjGdcZWkOiv3gs=;
        h=From:Date:Subject:To:Cc:From;
        b=RRoBmdML3/F8EmL9nLRdGMKKF/o4L0BtnJ9JuGfPP7aKJ6UExIWCm0soBdWb+Et+0
         tzjxCDHs7jXKlYBRh65NYO5WZQgRf+ab9tyv/PiP8gywmsXVu/7IUC0+Nf3i+93WnT
         iAB1q7r/7YoToicbDYkArUDVWNhcpr/aKjtcQzCfkveOdk9FCetTGfBUu63cvuXbL4
         9YWQou8KjKcZb12kuXmZVo4cdHCQ/SMcQC4mGS3nyrFyfGb5R5/dtg6LK8DZ8ikR4S
         Jl2TGYT4IxugmB0MugKLVAqwW8DmJrdCjpPoFOES9eGpAAsGxC93U5Yt/k56PSzGAM
         krZk6VbY5pfnQ==
X-Nifty-SrcIP: [209.85.213.50]
Received: by mail-vk0-f50.google.com with SMTP id y70-v6so82847vkc.0;
        Wed, 15 Aug 2018 11:04:20 -0700 (PDT)
X-Gm-Message-State: AOUpUlE1R3Ve9EZc/qqFFJjqBQ2pRpLEMIyqWNWMxO/+NMMCEjxwBaj8
        oli7w3uN6jxA8Wofb9Bel8HMWKJGKLoa7clN2n8=
X-Google-Smtp-Source: AA+uWPz+Ao09Q9JtObQW8EGBbPYw6ibb10FQcadEepnfmBo9UBfT2N0GselaBZ6vemWc0Y9Zqgf1eqCJFD96z1uf52U=
X-Received: by 2002:a1f:4049:: with SMTP id n70-v6mr17235602vka.140.1534356259605;
 Wed, 15 Aug 2018 11:04:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 11:03:39
 -0700 (PDT)
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 16 Aug 2018 03:03:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAROqcjzSRjkpR+-gzbTJjRe=mSkZqo39uRiDZBMZh9O=g@mail.gmail.com>
Message-ID: <CAK7LNAROqcjzSRjkpR+-gzbTJjRe=mSkZqo39uRiDZBMZh9O=g@mail.gmail.com>
Subject: [GIT PULL 3/3] consolidate arch Kconfig files for v4.19
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

Please pull this patch series to consolidate arch Kconfig files.


Sorry for many conflicts.

Equivalent fixes are available in linux-next,
but I sorted the 'select' lines alphabetically
in arch/nios2/Kconfig.
(of course, this is not important, though.)


-------------------------
diff --cc arch/arm64/Kconfig
index 260ff5d,daf59d3..d0a53cc
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -279,10 -264,9 +279,6 @@@ config ARCH_SUPPORTS_UPROBE
  config ARCH_PROC_KCORE_TEXT
        def_bool y

- source "init/Kconfig"
-
- source "kernel/Kconfig.freezer"
 -config MULTI_IRQ_HANDLER
 -      def_bool y
--
  source "arch/arm64/Kconfig.platforms"

  menu "Bus support"
diff --cc arch/mips/Kconfig
index 642a56e,06a633e..2af13b1
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@@ -2988,13 -2990,6 +2984,9 @@@ config PGTABLE_LEVEL
        default 3 if 64BIT && !PAGE_SIZE_64KB
        default 2

 +config MIPS_AUTO_PFN_OFFSET
 +      bool
 +
- source "init/Kconfig"
-
- source "kernel/Kconfig.freezer"
-
  menu "Bus options (PCI, PCMCIA, EISA, ISA, TC)"

  config HW_HAS_EISA
diff --cc arch/nios2/Kconfig
index 9203504,cbe1844..f4ad113
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@@ -1,9 -1,7 +1,10 @@@
  # SPDX-License-Identifier: GPL-2.0
  config NIOS2
        def_bool y
 +      select ARCH_HAS_SYNC_DMA_FOR_CPU
 +      select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+       select ARCH_NO_SWAP
 +      select DMA_NONCOHERENT_OPS
        select TIMER_OF
        select GENERIC_ATOMIC64
        select GENERIC_CLOCKEVENTS
diff --cc arch/openrisc/Kconfig
index dfb6a79,42e3a0f..ed5f32d
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@@ -69,10 -69,9 +69,6 @@@ config STACKTRACE_SUPPOR
  config LOCKDEP_SUPPORT
        def_bool  y

- source "init/Kconfig"
-
- source "kernel/Kconfig.freezer"
 -config MULTI_IRQ_HANDLER
 -      def_bool y
--
  menu "Processor type and features"

  choice
----------------------------------------------------------------



The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kconfig-v4.19-2

for you to fetch changes up to 59e0b520c75c8b4588395aea6170e551c4189fd8:

  kconfig: add a Memory Management options" menu (2018-08-02 08:06:55 +0900)

----------------------------------------------------------------
Consolidation of Kconfig files by Christoph Hellwig.

Move the source statements of arch-independent Kconfig files instead of
duplicating the includes in every arch/$(SRCARCH)/Kconfig.

----------------------------------------------------------------
Christoph Hellwig (9):
      um: stop abusing KBUILD_KCONFIG
      um: cleanup Kconfig files
      um: create a proper drivers Kconfig
      kconfig: remove duplicate SWAP symbol defintions
      kconfig: include common Kconfig files from top-level Kconfig
      Kconfig: consolidate the "Kernel hacking" menu
      kconfig: include kernel/Kconfig.preempt from init/Kconfig
      kconfig: move the "Executable file formats" menu to fs/Kconfig.binfmt
      kconfig: add a Memory Management options" menu

Randy Dunlap (1):
      kconfig: use a menu in arch/Kconfig to reduce clutter

 Kconfig                                  |  22 ++++-
 arch/Kconfig                             |  13 +++
 arch/alpha/Kconfig                       |  23 +----
 arch/alpha/Kconfig.debug                 |   5 --
 arch/arc/Kconfig                         |  19 -----
 arch/arc/Kconfig.debug                   |   5 --
 arch/arm/Kconfig                         |  27 ------
 arch/arm/Kconfig.debug                   |   5 --
 arch/arm64/Kconfig                       |  26 ------
 arch/arm64/Kconfig.debug                 |   5 --
 arch/c6x/Kconfig                         |  41 ---------
 arch/c6x/Kconfig.debug                   |  10 +++
 arch/h8300/Kconfig                       |  36 --------
 arch/h8300/Kconfig.debug                 |   1 +
 arch/hexagon/Kconfig                     |  21 +----
 arch/hexagon/Kconfig.debug               |   1 +
 arch/ia64/Kconfig                        |  24 ------
 arch/ia64/Kconfig.debug                  |   5 --
 arch/m68k/Kconfig                        |  31 +------
 arch/m68k/Kconfig.debug                  |   5 --
 arch/microblaze/Kconfig                  |  32 +------
 arch/microblaze/Kconfig.debug            |   6 --
 arch/mips/Kconfig                        |  28 -------
 arch/mips/Kconfig.debug                  |   5 --
 arch/nds32/Kconfig                       |  21 -----
 arch/nds32/Kconfig.debug                 |   1 +
 arch/nios2/Kconfig                       |  32 +------
 arch/nios2/Kconfig.debug                 |   5 --
 arch/openrisc/Kconfig                    |  30 -------
 arch/openrisc/Kconfig.debug              |   1 +
 arch/parisc/Kconfig                      |  27 ------
 arch/parisc/Kconfig.debug                |   5 --
 arch/powerpc/Kconfig                     |  22 -----
 arch/powerpc/Kconfig.debug               |   5 --
 arch/riscv/Kconfig                       |  71 ----------------
 arch/riscv/Kconfig.debug                 |  37 ++++++++
 arch/s390/Kconfig                        |  28 -------
 arch/s390/Kconfig.debug                  |   5 --
 arch/sh/Kconfig                          |  26 ------
 arch/sh/Kconfig.debug                    |   5 --
 arch/sh/mm/Kconfig                       |   2 -
 arch/sparc/Kconfig                       |  28 -------
 arch/sparc/Kconfig.debug                 |   5 --
 arch/um/{Kconfig.um => Kconfig}          |  74 +++++++++++++++-
 arch/um/Kconfig.char                     | 124 ---------------------------
 arch/um/Kconfig.common                   |  60 -------------
 arch/um/Kconfig.debug                    |   5 --
 arch/um/Kconfig.rest                     |  22 -----
 arch/um/Makefile                         |   4 +-
 arch/um/{Kconfig.net => drivers/Kconfig} | 125 +++++++++++++++++++++++++++-
 arch/unicore32/Kconfig                   |  28 -------
 arch/unicore32/Kconfig.debug             |   5 --
 arch/x86/Kconfig                         |  26 +-----
 arch/x86/Kconfig.debug                   |   5 --
 arch/x86/um/Kconfig                      |  15 ----
 arch/xtensa/Kconfig                      |  29 -------
 arch/xtensa/Kconfig.debug                |   5 --
 fs/Kconfig.binfmt                        |   5 ++
 init/Kconfig                             |  14 +++-
 kernel/Kconfig.preempt                   |   2 +
 lib/Kconfig.debug                        |   7 ++
 mm/Kconfig                               |   5 ++
 62 files changed, 316 insertions(+), 996 deletions(-)
 create mode 100644 arch/c6x/Kconfig.debug
 create mode 100644 arch/h8300/Kconfig.debug
 create mode 100644 arch/hexagon/Kconfig.debug
 create mode 100644 arch/nds32/Kconfig.debug
 create mode 100644 arch/openrisc/Kconfig.debug
 create mode 100644 arch/riscv/Kconfig.debug
 rename arch/um/{Kconfig.um => Kconfig} (82%)
 delete mode 100644 arch/um/Kconfig.char
 delete mode 100644 arch/um/Kconfig.common
 delete mode 100644 arch/um/Kconfig.rest
 rename arch/um/{Kconfig.net => drivers/Kconfig} (66%)



-- 
Best Regards
Masahiro Yamada
