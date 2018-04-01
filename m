Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbeDABlJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 21:41:09 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47304 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeDABlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 21:41:07 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <cover.1522546571.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 00/12] SWIM driver fixes
Date: Sat, 31 Mar 2018 21:41:04 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series has fixes for bugs in the SWIM floppy disk controller
driver, including an oops and a soft lockup.

There are also patches to add support for SWIM devices connected to IOPs.

Geert, would you please take this series through the m68k tree once the
necessary "acked-by" tags arrive?

Jens, I've Cc'd you too because there's no official maintainer for
drivers/block/swim.c and none for the drivers/block/ directory either.

The series could be separated into m68k patches and block driver patches
and sent through different trees if that's preferred.

I did not do so because "acked-by" tags would still be needed and because
separating patches 4 and 5 didn't make much sense.


Finn Thain (12):
  m68k/mac: Revisit floppy disc controller base addresses
  m68k/mac: Fix SWIM memory resource end address
  m68k/mac: Don't remap SWIM MMIO region
  m68k/mac: Place ISM IOP in bypass mode
  block/swim: Use HEDSEL bit in ISM mode register
  block/swim: Fix array bounds check
  block/swim: Remove extra put_disk() call from error path
  block/swim: Don't log an error message for an invalid ioctl
  block/swim: Rename macros to avoid inconsistent inverted logic
  block/swim: Check drive type
  block/swim: Fix IO error at end of medium
  block/swim: Select appropriate drive on device open

 arch/m68k/include/asm/macintosh.h |  10 +--
 arch/m68k/mac/config.c            | 126 ++++++++++++++++++++------------------
 arch/m68k/mac/iop.c               |   8 ++-
 drivers/block/swim.c              |  69 +++++++++++----------
 drivers/block/swim3.c             |   6 +-
 5 files changed, 118 insertions(+), 101 deletions(-)

-- 
2.16.1
