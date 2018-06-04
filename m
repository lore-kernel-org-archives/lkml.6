Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeFDIMw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:12:52 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:49172 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbeFDIMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:12:48 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [git pull] m68k updates for 4.18
Date: Mon,  4 Jun 2018 10:12:39 +0200
Message-Id: <1528099959-20005-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v4.18-tag1

for you to fetch changes up to b12c8a70643ffe2598c572cd206e4f68c524eb6f:

  m68k: Set default dma mask for platform devices (2018-05-31 09:02:21 +0200)

----------------------------------------------------------------
m68k updates for 4.18

  - A few time-related fixes:
      - off-by-one calendar month on some classes of machines,
      - Y2038 preparation,
  - Build fix for ndelay() being called with a 64-bit type,
  - Revive 64-bit get_user(), which is used by some Android code,
  - Defconfig updates,
  - Fix for a long-standing fatal bug in iounmap() on '020/030, which
    was actually fixed in 2.4.23, but never in 2.5.x and later,
  - Default DMA mask to avoid warning splats,
  - Minor fixes and cleanups.

Notes:
  - This is based on v4.17-rc3 not -rc1 due to -rc3 triggering a defconfig
    refresh,
  - The tag is signed with my new Nitro-powered subkey.

Thanks for pulling!

----------------------------------------------------------------
Arnd Bergmann (1):
      m68k: Use read_persistent_clock64() consistently

Boris Brezillon (1):
      m68k: Implement ndelay() as an inline function to force type checking/casting

Finn Thain (3):
      m68k/mac: Fix SWIM memory resource end address
      m68k: Fix off-by-one calendar month
      m68k: Set default dma mask for platform devices

Geert Uytterhoeven (3):
      m68k: Fix style, spelling, and grammar in siginfo_build_tests()
      m68k/uaccess: Revive 64-bit get_user()
      m68k/defconfig: Update defconfigs for v4.17-rc3

Jacob (1):
      zorro: Add a blank line after declarations

Michael Schmitz (1):
      m68k/mm: Adjust VM area to be unmapped by gap size for __iounmap()

 arch/m68k/68000/timers.c             |  4 +++-
 arch/m68k/apollo/config.c            |  8 +++++---
 arch/m68k/configs/amiga_defconfig    | 20 ++++++++++++--------
 arch/m68k/configs/apollo_defconfig   | 20 ++++++++++++--------
 arch/m68k/configs/atari_defconfig    | 20 ++++++++++++--------
 arch/m68k/configs/bvme6000_defconfig | 20 ++++++++++++--------
 arch/m68k/configs/hp300_defconfig    | 20 ++++++++++++--------
 arch/m68k/configs/mac_defconfig      | 20 ++++++++++++--------
 arch/m68k/configs/multi_defconfig    | 20 ++++++++++++--------
 arch/m68k/configs/mvme147_defconfig  | 20 ++++++++++++--------
 arch/m68k/configs/mvme16x_defconfig  | 20 ++++++++++++--------
 arch/m68k/configs/q40_defconfig      | 20 ++++++++++++--------
 arch/m68k/configs/sun3_defconfig     | 20 ++++++++++++--------
 arch/m68k/configs/sun3x_defconfig    | 20 ++++++++++++--------
 arch/m68k/include/asm/delay.h        | 11 ++++++++---
 arch/m68k/include/asm/uaccess_mm.h   | 16 +++++++++-------
 arch/m68k/kernel/dma.c               | 10 ++++++++++
 arch/m68k/kernel/signal.c            | 23 ++++++++++++-----------
 arch/m68k/kernel/time.c              | 25 ++++++++++++++-----------
 arch/m68k/mac/config.c               |  2 +-
 arch/m68k/mm/kmap.c                  |  3 ++-
 arch/m68k/mvme147/config.c           |  4 +++-
 arch/m68k/mvme16x/config.c           |  4 +++-
 arch/m68k/sun3/intersil.c            |  8 +++++---
 arch/m68k/sun3x/time.c               |  8 +++++---
 drivers/zorro/zorro.c                |  3 +++
 26 files changed, 227 insertions(+), 142 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
