Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935478AbeB1Wjl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:39:41 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39080 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935364AbeB1Wjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:39:40 -0500
X-Google-Smtp-Source: AG47ELtqiBHYGuIN9bkED0F/elv1w+CRzSeP0GC2I/fdRwaeitpFTIEFYzcJtQkRzeqHuWlwEoIEoA==
From: Rob Herring <robh@kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] microblaze: remove early_printk
Date: Wed, 28 Feb 2018 16:39:34 -0600
Message-Id: <20180228223937.29196-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This started with removing 'linux,stdout-path' which dtc now warns 
about, but I noticed the early_printk support only supports that. The 
early_printk support is redundant with earlycon support since the 2 
Xilinx UARTs support earlycon now.

This is compile tested only. If earlycon support has already been 
tested, then this change should be harmless. AFAICT, the ioremap calls 
work early before paging is up. Otherwise, fixmap support is needed.

Rob

Rob Herring (3):
  microblaze: remove unnecessary prom.h includes
  microblaze: remove redundant early_printk support
  microblaze: dts: replace 'linux,stdout-path' with 'stdout-path'

 arch/microblaze/Kconfig.debug         |   8 --
 arch/microblaze/boot/dts/system.dts   |   2 +-
 arch/microblaze/include/asm/cpuinfo.h |   2 +-
 arch/microblaze/include/asm/pci.h     |   1 -
 arch/microblaze/include/asm/prom.h    |  27 -----
 arch/microblaze/kernel/Makefile       |   1 -
 arch/microblaze/kernel/early_printk.c | 184 ----------------------------------
 arch/microblaze/kernel/misc.S         |  35 -------
 arch/microblaze/kernel/platform.c     |   1 -
 arch/microblaze/kernel/prom.c         |  80 ---------------
 arch/microblaze/kernel/setup.c        |  12 +--
 arch/microblaze/pci/indirect_pci.c    |   1 -
 12 files changed, 3 insertions(+), 351 deletions(-)
 delete mode 100644 arch/microblaze/include/asm/prom.h
 delete mode 100644 arch/microblaze/kernel/early_printk.c

-- 
2.14.1
