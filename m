Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7562C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED22208E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED22208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeHHPxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:53:18 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:33800 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeHHPxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:53:17 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id LdZY1y00i3XaVaC06dZYHG; Wed, 08 Aug 2018 15:33:33 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fnOai-00027X-Pm; Wed, 08 Aug 2018 15:33:32 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fnOai-0006rD-NZ; Wed, 08 Aug 2018 15:33:32 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [git pull] m68k updates for 4.19
Date:   Wed,  8 Aug 2018 15:33:19 +0200
Message-Id: <20180808133319.26298-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit d72e90f33aa4709ebecc5005562f52335e106a60:

  Linux 4.18-rc6 (2018-07-22 14:12:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git m68k-for-v4.19-tag1

for you to fetch changes up to 71a896687b851477bfe2e7022cd4b597ab4f900d:

  m68k/defconfig: Update defconfigs for v4.18-rc6 (2018-07-29 10:55:53 +0200)

----------------------------------------------------------------
m68k updates for 4.19

  - Enable mac_scsi PDMA on PowerBook 500,
  - Generic dma_noncoherent_ops conversion,
  - Time handling improvements,
  - I/O accessor improvements,
  - Conversion to MEMBLOCK and NO_BOOTMEM, to bring m68k in line with
    other mainstream architectures,
  - Miscellaneous fixes and cleanups,
  - Defconfig updates.

Notes:
  - This is based on v4.18-rc6 not -rc1 due to -rc6 triggering a defconfig
    refresh,
  - There is a minor conflict with the powerpc tree in arch/m68k/mac/misc.c,
    cfr.
    https://lore.kernel.org/lkml/20180802094154.6d88f03c@canb.auug.org.au/,
  - The net and input changes have been acked by the respective maintainers.

Thanks for pulling!

----------------------------------------------------------------
Arnd Bergmann (2):
      m68k: mac: Use time64_t in RTC handling
      m68k: Remove unused set_clock_mmss() helpers

Christoph Hellwig (1):
      m68k: Use generic dma_noncoherent_ops

Finn Thain (2):
      m68k/mac: Enable PDMA for PowerBook 500 series
      nubus: Set default dma mask for nubus_board devices

Geert Uytterhoeven (6):
      m68k/io: Add missing ioremap define guards, fix typo
      net: mac8390: Use standard memcpy_{from,to}io()
      Input: hilkbd - Add casts to HP9000/300 I/O accessors
      m68k/io: Move mem*io define guards to <asm/kmap.h>
      m68k/io: Switch mmu variant to <asm-generic/io.h>
      m68k/defconfig: Update defconfigs for v4.18-rc6

Mike Rapoport (3):
      m68k/bitops: convert __ffs to match generic declaration
      m68k/page_no.h: force __va argument to be unsigned long
      m68k: switch to MEMBLOCK + NO_BOOTMEM

 arch/m68k/Kconfig                    |  5 +++
 arch/m68k/apollo/config.c            |  8 ----
 arch/m68k/atari/config.c             |  5 ---
 arch/m68k/atari/time.c               | 63 ----------------------------
 arch/m68k/bvme6000/config.c          | 45 --------------------
 arch/m68k/configs/amiga_defconfig    | 32 +++++++++------
 arch/m68k/configs/apollo_defconfig   | 30 ++++++++------
 arch/m68k/configs/atari_defconfig    | 29 +++++++------
 arch/m68k/configs/bvme6000_defconfig | 30 ++++++++------
 arch/m68k/configs/hp300_defconfig    | 30 ++++++++------
 arch/m68k/configs/mac_defconfig      | 30 ++++++++------
 arch/m68k/configs/multi_defconfig    | 32 +++++++++------
 arch/m68k/configs/mvme147_defconfig  | 30 ++++++++------
 arch/m68k/configs/mvme16x_defconfig  | 30 ++++++++------
 arch/m68k/configs/q40_defconfig      | 30 ++++++++------
 arch/m68k/configs/sun3_defconfig     | 28 ++++++++-----
 arch/m68k/configs/sun3x_defconfig    | 30 ++++++++------
 arch/m68k/include/asm/Kbuild         |  1 +
 arch/m68k/include/asm/bitops.h       |  8 +++-
 arch/m68k/include/asm/dma-mapping.h  | 12 ------
 arch/m68k/include/asm/io.h           |  7 ++++
 arch/m68k/include/asm/io_mm.h        | 42 ++-----------------
 arch/m68k/include/asm/io_no.h        | 12 ------
 arch/m68k/include/asm/kmap.h         |  9 +++-
 arch/m68k/include/asm/machdep.h      |  1 -
 arch/m68k/include/asm/macintosh.h    |  1 -
 arch/m68k/include/asm/page_no.h      |  2 +-
 arch/m68k/kernel/dma.c               | 68 ++++--------------------------
 arch/m68k/kernel/setup_mm.c          | 15 ++-----
 arch/m68k/kernel/setup_no.c          | 21 ++--------
 arch/m68k/mac/config.c               | 21 +---------
 arch/m68k/mac/misc.c                 | 80 ++++++++++++++++--------------------
 arch/m68k/mm/init.c                  |  1 -
 arch/m68k/mm/mcfmmu.c                | 13 +++---
 arch/m68k/mm/motorola.c              | 35 +++++-----------
 arch/m68k/mvme147/config.c           |  7 ----
 arch/m68k/mvme16x/config.c           |  8 ----
 arch/m68k/q40/config.c               | 30 --------------
 arch/m68k/sun3/config.c              |  4 --
 drivers/input/keyboard/hilkbd.c      |  4 +-
 drivers/net/ethernet/8390/mac8390.c  | 20 ++++-----
 drivers/nubus/bus.c                  |  3 ++
 42 files changed, 335 insertions(+), 577 deletions(-)
 delete mode 100644 arch/m68k/include/asm/dma-mapping.h

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
