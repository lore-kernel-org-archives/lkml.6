Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbeDBNfM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 09:35:12 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:57756 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeDBNfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 09:35:10 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [git pull] m68k updates for 4.17
Date: Mon,  2 Apr 2018 15:35:06 +0200
Message-Id: <1522676106-24280-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v4.17-tag1

for you to fetch changes up to ecd685580c8feb9a91c758257a66355a673594d9:

  m68k/mac: Remove bogus "FIXME" comment (2018-03-26 14:10:22 +0200)

----------------------------------------------------------------
m68k updates for 4.17

  - Macintosh enhancements and fixes,
  - Remove useless memory layout printing using hashed pointers,
  - Add missing Amiga Zorro bus DMA mask,
  - Small fixes and cleanups,
  - Defconfig updates.

Note that this is based on v4.16-rc5 not -rc1 due to -rc5 triggering a
defconfig refresh.

Thanks for pulling!

----------------------------------------------------------------
Alexandre Belloni (1):
      m68k/time: Stop validating rtc_time in .read_time

Finn Thain (6):
      m68k/mac: Enable PDMA support for PowerBook 190
      m68k/mac: Fix apparent race condition in Baboon interrupt dispatch
      macintosh/via-pmu68k: Initialize PMU driver with setup_arch and arch_initcall
      m68k/mac: Clean up whitespace and remove redundant parentheses
      m68k/mac: Enable RTC for 100-series PowerBooks
      m68k/mac: Remove bogus "FIXME" comment

Geert Uytterhoeven (2):
      m68k/mm: Stop printing the virtual memory layout
      m68k/defconfig: Update defconfigs for v4.16-rc5

Michael Schmitz (1):
      zorro: Set up z->dev.dma_mask for the DMA API

 arch/m68k/configs/amiga_defconfig    |  12 +++-
 arch/m68k/configs/apollo_defconfig   |  12 +++-
 arch/m68k/configs/atari_defconfig    |  12 +++-
 arch/m68k/configs/bvme6000_defconfig |  12 +++-
 arch/m68k/configs/hp300_defconfig    |  12 +++-
 arch/m68k/configs/mac_defconfig      |  12 +++-
 arch/m68k/configs/multi_defconfig    |  12 +++-
 arch/m68k/configs/mvme147_defconfig  |  12 +++-
 arch/m68k/configs/mvme16x_defconfig  |  12 +++-
 arch/m68k/configs/q40_defconfig      |  12 +++-
 arch/m68k/configs/sun3_defconfig     |  12 +++-
 arch/m68k/configs/sun3x_defconfig    |  12 +++-
 arch/m68k/kernel/time.c              |   2 +-
 arch/m68k/mac/baboon.c               |  27 +++----
 arch/m68k/mac/config.c               |  10 +--
 arch/m68k/mac/misc.c                 | 134 ++++++++++++++++++++---------------
 arch/m68k/mm/init.c                  |  27 -------
 drivers/macintosh/via-pmu68k.c       |  89 +++++++++++++++--------
 drivers/zorro/zorro.c                |  12 ++++
 19 files changed, 296 insertions(+), 149 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
