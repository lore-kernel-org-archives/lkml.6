Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeC1CHD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 22:07:03 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44619 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbeC1CHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 22:07:02 -0400
X-Google-Smtp-Source: AIpwx48VQwEm5BcRtShCQddCnvgHobrnaFcyoV4AW0h2+tuEESt2zg2bsxFFVqGbt3c2Bx4yGFYqfA==
From: Rob Herring <robh@kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] microblaze: remove early_printk
Date: Tue, 27 Mar 2018 21:06:57 -0500
Message-Id: <20180328020700.17050-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This started with removing 'linux,stdout-path' which dtc now warns
about, but I noticed the early_printk support only supports that. The
early_printk support is redundant with earlycon support since the 2
Xilinx UARTs support earlycon now.

I got this to kind of work in QEMU. QEMU hangs sometime around timer 
setup, but earlycon is up and working before that point.

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
 arch/microblaze/include/asm/setup.h   |   5 -
 arch/microblaze/kernel/Makefile       |   1 -
 arch/microblaze/kernel/early_printk.c | 184 ----------------------------------
 arch/microblaze/kernel/misc.S         |  35 -------
 arch/microblaze/kernel/platform.c     |   1 -
 arch/microblaze/kernel/prom.c         |  82 ---------------
 arch/microblaze/kernel/setup.c        |  17 +---
 arch/microblaze/pci/indirect_pci.c    |   1 -
 13 files changed, 6 insertions(+), 360 deletions(-)
 delete mode 100644 arch/microblaze/include/asm/prom.h
 delete mode 100644 arch/microblaze/kernel/early_printk.c

-- 
2.14.1
