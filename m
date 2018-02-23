Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeBWPo2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:44:28 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:24453 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBWPoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:44:25 -0500
From: Dave Gerlach <d-gerlach@ti.com>
To: Tony Lindgren <tony@atomide.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: [PATCH v5 0/4] ARM: OMAP2+: AM33XX/AM43XX: Add suspend-resume support
Date: Fri, 23 Feb 2018 09:43:53 -0600
Message-ID: <20180223154357.23504-1-d-gerlach@ti.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a minor update to previous series sent here [1] to switch to
SPDX license headers. Because update is so minor I have included original
cover letter below unmodified with the exception of updated links.

This series contains the remaining code to enable suspend to mem and standby
on am335x and am437x platforms. All dependencies have been merged and this
is just a rebase on v4.16-rc1. For this to work on am437x-gp-evm this
bug fix patch [2] is required but suspend works fine on am335x platforms
without it. V3 of this series can be found here [3].

This code also depends on firmware for the wkup_m3 that is available here [4]
that can either be placed in /lib/firmware or built in to the kernel.

For testing the drivers required are:

CONFIG_MAILBOX
CONFIG_OMAP2PLUS_MBOX
CONFIG_WKUP_M3_RPROC
CONFIG_SOC_TI
CONFIG_WKUP_M3_IPC
CONFIG_TI_EMIF_SRAM
CONFIG_AMX3_PM

There is a device tree patch series to follow immediately after this that will
completely enable suspend, all patches pushed here [5] for convenience
including the aforementioned [2] regulator bug fix if anyone is testing.

Regards,
Dave

[1] https://www.spinics.net/lists/linux-omap/msg141652.html
[2] https://www.spinics.net/lists/linux-omap/msg141626.html
[3] https://www.spinics.net/lists/arm-kernel/msg595931.html
[4] https://git.ti.com/processor-firmware/ti-amx3-cm3-pm-firmware/blobs/7eb9c0856a9e8b3b42bf64f761da135852b8eea7/bin/am335x-pm-firmware.elf
[5] https://github.com/dgerlach/linux-pm/tree/upstream/v4.16/amx3-suspend-v5

Dave Gerlach (4):
  ARM: OMAP2+: Introduce low-level suspend code for AM33XX
  ARM: OMAP2+: Introduce low-level suspend code for AM43XX
  ARM: OMAP2+: pm33xx-core: Add platform code needed for PM
  soc: ti: Add pm33xx driver for basic suspend support

 Documentation/devicetree/bindings/arm/omap/mpu.txt |  16 +
 arch/arm/mach-omap2/Kconfig                        |   1 +
 arch/arm/mach-omap2/Makefile                       |  16 +
 arch/arm/mach-omap2/common.h                       |   7 +
 arch/arm/mach-omap2/io.c                           |   2 +
 arch/arm/mach-omap2/pm-asm-offsets.c               |  31 ++
 arch/arm/mach-omap2/pm.h                           |   3 +
 arch/arm/mach-omap2/pm33xx-core.c                  | 189 ++++++++++
 arch/arm/mach-omap2/sleep33xx.S                    | 214 ++++++++++++
 arch/arm/mach-omap2/sleep43xx.S                    | 387 +++++++++++++++++++++
 drivers/soc/ti/Kconfig                             |   9 +
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/pm33xx.c                            | 349 +++++++++++++++++++
 include/linux/platform_data/pm33xx.h               |  42 +++
 14 files changed, 1267 insertions(+)
 create mode 100644 arch/arm/mach-omap2/pm-asm-offsets.c
 create mode 100644 arch/arm/mach-omap2/pm33xx-core.c
 create mode 100644 arch/arm/mach-omap2/sleep33xx.S
 create mode 100644 arch/arm/mach-omap2/sleep43xx.S
 create mode 100644 drivers/soc/ti/pm33xx.c
 create mode 100644 include/linux/platform_data/pm33xx.h

-- 
2.16.1
