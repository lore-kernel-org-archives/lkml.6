Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeDMPjC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:39:02 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:45958 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeDMPjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:39:00 -0400
Date: Fri, 13 Apr 2018 11:38:58 -0400
From: Rich Felker <dalias@libc.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [GIT PULL] arch/sh updates for 4.17
Message-ID: <20180413153858.GA24377@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these changes for arch/sh. Some of them have been pending
(and in linux-next) for a long time and address longstanding issues.

Rich




The following changes since commit 0adb32858b0bddf4ada5f364a84ed60b196dbcda:

  Linux 4.16 (2018-04-01 14:20:27 -0700)

are available in the git repository at:

  git://git.libc.org/linux-sh tags/sh-for-4.17

for you to fetch changes up to bf9c7e3d7924f72225f8f9c28438b4a711192ad3:

  arch/sh: pcie-sh7786: handle non-zero DMA offset (2018-04-12 19:47:58 -0400)

----------------------------------------------------------------
Fixes for bugs in futex, device tree, and userspace breakpoint traps,
and for PCI issues on SH7786.

----------------------------------------------------------------
Aurelien Jarno (1):
      sh: fix futex FUTEX_OP_SET op on userspace addresses

Rich Felker (2):
      sh: fix memory corruption of unflattened device tree
      sh: fix debug trap failure to process signals before return to user

Thomas Petazzoni (8):
      arch/sh: add sh7786_mm_sel() function
      arch/sh: make the DMA mapping operations observe dev->dma_pfn_offset
      arch/sh: pci: don't use disabled resources
      arch/sh: pcie-sh7786: mark unavailable PCI resource as disabled
      arch/sh: pcie-sh7786: exclude unusable PCI MEM areas
      arch/sh: pcie-sh7786: adjust PCI MEM and IO regions
      arch/sh: pcie-sh7786: adjust the memory mapping
      arch/sh: pcie-sh7786: handle non-zero DMA offset

 arch/sh/boards/of-generic.c          |  6 ---
 arch/sh/drivers/pci/pci.c            |  5 +++
 arch/sh/drivers/pci/pcie-sh7786.c    | 78 +++++++++++++++++++++++++-----------
 arch/sh/include/asm/futex.h          |  5 +--
 arch/sh/include/cpu-sh4/cpu/sh7786.h |  7 ++++
 arch/sh/kernel/dma-nommu.c           |  7 +++-
 arch/sh/kernel/entry-common.S        |  2 +-
 arch/sh/kernel/setup.c               |  8 ++++
 arch/sh/mm/consistent.c              |  4 +-
 9 files changed, 84 insertions(+), 38 deletions(-)
