Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161096AbeBPQrV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:47:21 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34041 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161063AbeBPQrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:47:19 -0500
X-Google-Smtp-Source: AH8x224YkpaAH0zW4CBVYVnCYe7cUjNvyclBG6/nCZ174oee+XyIe+kRkZTAsxt9B65mVgBmkY5ObQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/6] ARM: davinci: remove the mach-specific aemif driver - part 1
Date: Fri, 16 Feb 2018 17:47:06 +0100
Message-Id: <20180216164712.25898-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Sekhar,

while waiting for David's updated series I prepared the first part of
changes required to remove duplicate aemif support from mach-davinci.

I actually noticed that one of my previous changes from 2017 broke nand
in legacy mode - the clock lookup no longer works. This series addresses
it as well.

The first two patches fix the issue introduced in commit d8e22fb4ccac
("ARM: da850: add the nand dev_id to the clock lookup table").

Next two add support for board files to the aemif driver.

Last two add nand support to da850-lcdk in legacy mode and make
da850-evm use the platform driver instead of the mach-specific one.

If this series gets accepted, I'll prepere a follow-up moving all
other boards to the new platform driver.

Bartosz Golaszewski (6):
  nand: davinci: rename the platform driver
  ARM: davinci: update the nand driver names
  memory: aemif: don't rely on kbuild for driver's name
  memory: aemif: add support for board files
  ARM: davinci: add aemif & nand support to da850-lcdk in legacy mode
  ARM: davinci: use aemif platform driver in legacy mode for da850-evm

 arch/arm/mach-davinci/board-da830-evm.c     |   2 +-
 arch/arm/mach-davinci/board-da850-evm.c     |  93 +++++++++++---------
 arch/arm/mach-davinci/board-dm355-evm.c     |   2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |   2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |   2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    |   2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    |   2 +-
 arch/arm/mach-davinci/board-mityomapl138.c  |   2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c   |   2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c | 132 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/board-sffsdr.c        |   2 +-
 drivers/memory/ti-aemif.c                   |  59 ++++++++-----
 drivers/mtd/nand/davinci_nand.c             |   2 +-
 include/linux/platform_data/ti-aemif.h      |   9 ++
 14 files changed, 240 insertions(+), 73 deletions(-)

-- 
2.16.1
