Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeDFBSU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 21:18:20 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58609 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751360AbeDFBRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 21:17:38 -0400
X-ME-Sender: <xms:ssrGWvbMnV8vQRB7S4g7M3Y05k5W0v5AMuA8A9FmjqB2vryI2vGlsw>
From: Mark Greer <mgreer@animalcreek.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Remi Machet <rmachet@nvidia.com>,
        Dale Farnsworth <dale@farnsworth.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>
Subject: [PATCH 0/5] powerpc: Remove support for Marvell mv64x60 hostbridges
Date: Thu,  5 Apr 2018 18:17:15 -0700
Message-Id: <20180406011720.7728-1-mgreer@animalcreek.com>
X-Mailer: git-send-email 2.16.2
Organization: Animal Creek Technologies, Inc.
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

As far as I can tell, the c2k platform is abandoned so it should be
removed.  Once it is removed, there are no more platforms that use
the mv64x60 hostbridge so remove that code too (and related drivers).

If and when this series of patches is accepted, I will submit patches
to the appropriate maintainers to remote drivers/tty/serial/mpsc.c and
drivers/watchdog/mv64x60_wdt.c.  The i2c and ethernet drivers are used
by ARM SoCs/platforms so they will be left alone.

Based on git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux,
'merge' branch which is currently 6c5c24035003 (Automatic merge of
branches 'master', 'next' and 'fixes' into merge)

Thanks,

Mark
--

Mark Greer (5):
  powerpc/embedded6xx: Remove C2K board support
  powerpc/boot: Remove support for Marvell MPSC serial controller
  powerpc/boot: Remove support for Marvell mv64x60 i2c controller
  powerpc/boot: Remove core support for Marvell mv64x60 hostbridges
  powerpc: Remove core support for Marvell mv64x60 hostbridges

 Documentation/devicetree/bindings/marvell.txt | 516 -----------------------
 arch/powerpc/boot/Makefile                    |   7 +-
 arch/powerpc/boot/cuboot-c2k.c                | 189 ---------
 arch/powerpc/boot/dts/c2k.dts                 | 366 ----------------
 arch/powerpc/boot/mpsc.c                      | 169 --------
 arch/powerpc/boot/mv64x60.c                   | 581 --------------------------
 arch/powerpc/boot/mv64x60.h                   |  70 ----
 arch/powerpc/boot/mv64x60_i2c.c               | 204 ---------
 arch/powerpc/boot/ops.h                       |   1 -
 arch/powerpc/boot/serial.c                    |   4 -
 arch/powerpc/configs/c2k_defconfig            | 390 -----------------
 arch/powerpc/platforms/embedded6xx/Kconfig    |  10 -
 arch/powerpc/platforms/embedded6xx/Makefile   |   1 -
 arch/powerpc/platforms/embedded6xx/c2k.c      | 148 -------
 arch/powerpc/sysdev/Makefile                  |   3 -
 arch/powerpc/sysdev/mv64x60.h                 |  13 -
 arch/powerpc/sysdev/mv64x60_dev.c             | 535 ------------------------
 arch/powerpc/sysdev/mv64x60_pci.c             | 171 --------
 arch/powerpc/sysdev/mv64x60_pic.c             | 297 -------------
 arch/powerpc/sysdev/mv64x60_udbg.c            | 152 -------
 20 files changed, 3 insertions(+), 3824 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/marvell.txt
 delete mode 100644 arch/powerpc/boot/cuboot-c2k.c
 delete mode 100644 arch/powerpc/boot/dts/c2k.dts
 delete mode 100644 arch/powerpc/boot/mpsc.c
 delete mode 100644 arch/powerpc/boot/mv64x60.c
 delete mode 100644 arch/powerpc/boot/mv64x60.h
 delete mode 100644 arch/powerpc/boot/mv64x60_i2c.c
 delete mode 100644 arch/powerpc/configs/c2k_defconfig
 delete mode 100644 arch/powerpc/platforms/embedded6xx/c2k.c
 delete mode 100644 arch/powerpc/sysdev/mv64x60.h
 delete mode 100644 arch/powerpc/sysdev/mv64x60_dev.c
 delete mode 100644 arch/powerpc/sysdev/mv64x60_pci.c
 delete mode 100644 arch/powerpc/sysdev/mv64x60_pic.c
 delete mode 100644 arch/powerpc/sysdev/mv64x60_udbg.c

-- 
2.16.2
