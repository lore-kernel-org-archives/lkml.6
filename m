Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeBAXZr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:25:47 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36094 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBAXZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:25:39 -0500
X-Google-Smtp-Source: AH8x224SHqQ77wrp4J+x3A77ppZSucHNrRw8n+bSrLF2qT8qq+zswcgzCN+5NdSD1zORY3Pvpp3BO4rRXEZNljk5UXc=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Feb 2018 00:25:38 +0100
X-Google-Sender-Auth: L9SVQceK2t5nmpXyNr0yGEbjahQ
Message-ID: <CAK8P3a10e11bn-_xARa2A+Mc2k4ffE2q5Q64yhqg_ZCEC_b5sg@mail.gmail.com>
Subject: [GIT PULL 3/3] ARM: SoC driver updates for 4.16
To: Linus Torvalds <torvalds@linux-foundation.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w11NPqKE010786

The following changes since commit 1291a0d5049dbc06baaaf66a9ff3f53db493b19b:

  Linux 4.15-rc4 (2017-12-17 18:59:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-drivers

for you to fetch changes up to 796543a64ebffdb638a22f428c4dadd037e34866:

  Merge tag 'omap-for-v4.16/ti-sysc-fix-signed' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap
into next/drivers (2018-01-26 17:35:16 +0100)

----------------------------------------------------------------
ARM: SoC driver updates for 4.16

A number of new drivers get added this time, along with many low-priority
bugfixes. The most interesting changes by subsystem are:

bus drivers:
  - Updates to the Broadcom bus interface driver to support newer SoC types
  - The TI OMAP sysc driver now supports updated DT bindings

memory controllers:
  - A new driver for Tegra186 gets added
  - A new driver for the ti-emif sram, to allow relocating
    suspend/resume handlers there

SoC specific:
  - A new driver for Qualcomm QMI, the interface to the modem on MSM SoCs
  - A new driver for power domains on the actions S700 SoC
  - A driver for the Xilinx Zynq VCU logicoreIP

reset controllers:
  - A new driver for Amlogic Meson-AGX
  - various bug fixes

tee subsystem:
  - A new user interface got added to enable asynchronous communication
    with the TEE supplicant.
  - A new method of using user space memory for communication with
    the TEE is added

----------------------------------------------------------------
Andreas Färber (1):
      soc: actions: sps: Add S700

Arnd Bergmann (15):
      firmware: raspberrypi: print time using time64_t
      memory: ti-emif-sram: remove unused variable
      Merge tag 'tee-drv-async-supplicant-for-v4.16' of
https://git.linaro.org/people/jens.wiklander/linux-tee into
next/drivers
      Merge tag 'gpmc-omap-for-v4.16-immutable' of
https://github.com/rogerq/linux into next/drivers
      Merge tag 'tee-drv-dynamic-shm-for-v4.16' of
https://git.linaro.org/people/jens.wiklander/linux-tee into
next/drivers
      Merge tag 'tegra-for-4.16-memory' of
ssh://gitolite.kernel.org/.../tegra/linux into next/drivers
      tee: optee: fix header dependencies
      Merge tag 'qcom-drivers-for-4.16' of
ssh://gitolite.kernel.org/.../agross/linux into next/drivers
      Merge tag 'reset-for-4.16' of
git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'imx-drivers-4.16' of
ssh://gitolite.kernel.org/.../shawnguo/linux into next/drivers
      bus: omap: add MODULE_LICENSE tags
      psci: add CPU_IDLE dependency
      Merge tag 'soc-fsl-for-4.16' of
ssh://gitolite.kernel.org/.../leo/linux into next/drivers
      Merge tag 'zynqmp-soc-fixes-for-4.16' of
https://github.com/Xilinx/linux-xlnx into next/drivers
      Merge tag 'omap-for-v4.16/ti-sysc-fix-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/drivers

Bjorn Andersson (3):
      soc: qcom: smp2p: Access APCS as mailbox client
      soc: qcom: Introduce QMI encoder/decoder
      soc: qcom: Introduce QMI helpers

Colin Ian King (2):
      tee: shm: make function __tee_shm_alloc static
      tee: shm: don't put_page on null shm->pages

Dan Carpenter (1):
      tee: shm: Potential NULL dereference calling tee_shm_register()

Dave Gerlach (2):
      Documentation: dt: Update ti,emif bindings
      memory: ti-emif-sram: introduce relocatable suspend/resume handlers

Dhaval Shah (3):
      dt-bindings: soc: xilinx: Add DT bindings to xlnx_vcu driver
      soc: xilinx: xlnx_vcu: Add Xilinx ZYNQMP VCU logicoreIP init driver
      soc: xilinx: xlnx_vcu: Depends on HAS_IOMEM for xlnx_vcu

Fabio Estevam (2):
      soc: imx: gpc: Add i.MX6SX PCI power domain
      soc: fsl: guts: Add a NULL check for devm_kasprintf()

Florian Fainelli (10):
      Merge tag 'bcm2835-drivers-next-2017-12-19' into drivers/next
      dt-bindings: arm: Add entry for Broadcom Brahma-B53
      dt-bindings: arm: brcmstb: Correct BIUCTRL node documentation
      soc: brcmstb: Make CPU credit offset more parameterized
      soc: brcmstb: Correct CPU_CREDIT_REG offset for Brahma-B53 CPUs
      soc: brcmstb: biuctrl: Prepare for saving/restoring other registers
      soc: brcmstb: biuctrl: Wire-up new registers
      soc: brcmstb: biuctrl: Fine tune B53 MCP interface settings
      soc: brcmstb: Split initialization
      soc: brcmstb: biuctrl: Move to early_initcall

Gustavo A. R. Silva (1):
      soc: xilinx: xlnx_vcu: Use bitwise & rather than logical && on clkoutdiv

Jens Wiklander (7):
      tee: add tee_param_is_memref() for driver use
      tee: add TEE_IOCTL_PARAM_ATTR_META
      optee: support asynchronous supplicant requests
      tee: flexible shared memory pool creation
      tee: add register user memory
      tee: add start argument to shm_register callback
      tee: optee: check type of registered shared memory

Jesse Chan (1):
      soc: qcom: rmtfs_mem: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Johan Hovold (1):
      soc: qcom: smsm: fix child-node lookup

Jordan Crouse (1):
      firmware: qcom_scm: Add dependent headers to qcom_scm.h

Krzysztof Kozlowski (1):
      soc: samsung: Add SPDX license identifiers

Ladislav Michl (1):
      memory: omap-gpmc: Make 'bank-width' property optional

Ma Shimiao (1):
      soc: ti: fix max dup length for kstrndup

Markus Elfring (1):
      soc: qcom: smp2p: Use common error handling code in qcom_smp2p_probe()

Masahiro Yamada (4):
      reset: make device_reset_optional() really optional
      reset: remove remaining WARN_ON() in <linux/reset.h>
      reset: minimize the number of headers included from <linux/reset.h>
      reset: remove reset_control_get(_optional)

Michal Simek (2):
      soc: xilinx: Create folder structure for soc specific drivers
      soc: xilinx: Fix Kconfig alignment

Nishanth Menon (1):
      firmware: ti_sci: Use %zu for size_t print format

Olof Johansson (9):
      Merge tag 'arm-soc/for-4.16/drivers' of
http://github.com/Broadcom/stblinux into next/drivers
      Merge tag 'actions-drivers-for-4.16' of
git://git.kernel.org/.../afaerber/linux-actions into next/drivers
      Merge tag 'omap-for-v4.16/ti-sysc-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/drivers
      Merge tag 'keystone_driver_soc_for_4.16' of
git://git.kernel.org/.../ssantosh/linux-keystone into next/drivers
      Merge tag 'at91-ab-4.16-drivers' of
git://git.kernel.org/.../abelloni/linux into next/drivers
      Merge tag 'samsung-drivers-4.16-2' of
https://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'tee-drv-dynamic-shm+fixes-for-v4.16' of
https://git.linaro.org/people/jens.wiklander/linux-tee into
next/drivers
      Merge tag 'zynqmp-soc-for-4.16' of
https://github.com/Xilinx/linux-xlnx into next/drivers
      Revert "soc: brcmstb: Only register SoC device on STB platforms"

Sudeep Holla (4):
      firmware: qcom_scm: drop redandant of_platform_populate
      of: platform: populate /firmware/ node from
of_platform_default_populate_init()
      soc: brcmstb: biuctrl: exit without warning on non brcmstb platforms
      of: platform: fix OF node refcount leak

Thierry Reding (8):
      dt-bindings: misc: Add Tegra186 MISC registers bindings
      dt-bindings: memory: Add Tegra186 support
      Merge branch 'for-4.16/dt-bindings' into for-4.16/memory
      memory: tegra: Add Tegra186 support
      memory: tegra: Create SMMU display groups
      iommu/tegra: Allow devices to be grouped
      soc: brcmstb: Only register SoC device on STB platforms
      soc: bcm: brcmstb: Be multi-platform compatible

Tony Lindgren (9):
      dt-bindings: ti-sysc: Update binding for timers and capabilities
      ARM: dts: Add generic ti,sysc compatible in addition to the custom ones
      ARM: OMAP2+: Move all omap_hwmod_sysc_fields to omap_hwmod_common_data.c
      bus: ti-sysc: Make omap_hwmod_sysc_fields into sysc_regbits platform data
      bus: ti-sysc: Add register bits for interconnect target modules
      bus: ti-sysc: Detect i2c interconnect target module based on
register layout
      bus: ti-sysc: Handle module quirks based dts configuration
      bus: ti-sysc: Add parsing of module capabilities
      bus: ti-sysc: Fix smartreflex sysc mask

Vasyl Gomonovych (1):
      pcmcia: at91_cf: Use PTR_ERR_OR_ZERO()

Volodymyr Babchuk (12):
      tee: shm: add accessors for buffer size and page offset
      tee: shm: add page accessor functions
      tee: optee: Update protocol definitions
      tee: optee: add page list manipulation functions
      tee: optee: add shared buffer registration functions
      tee: optee: add registered shared parameters handling
      tee: optee: add registered buffers handling into RPC calls
      tee: optee: store OP-TEE capabilities in private data
      tee: optee: add optee-specific shared pool implementation
      tee: optee: enable dynamic SHM support
      tee: use reference counting for tee_context
      tee: shm: inline tee_shm_get_id()

Wei Yongjun (1):
      iommu/tegra-smmu: Fix return value check in tegra_smmu_group_get()

Yixun Lan (2):
      dt-bindings: reset: Add bindings for the Meson-AXG SoC Reset Controller
      reset: meson-axg: add compatible string for Meson-AXG SoC

yangbo lu (1):
      soc: fsl: support GUTS driver for ls1012a/ls1046a

 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   |  22 +-
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 Documentation/devicetree/bindings/bus/ti-sysc.txt  |  37 +
 .../memory-controllers/nvidia,tegra30-mc.txt       |   2 +
 .../bindings/memory-controllers/ti/emif.txt        |  17 +-
 .../bindings/misc/nvidia,tegra186-misc.txt         |  12 +
 .../devicetree/bindings/power/fsl,imx-gpc.txt      |   3 +
 .../bindings/reset/amlogic,meson-reset.txt         |   3 +-
 .../devicetree/bindings/soc/qcom/qcom,smp2p.txt    |   8 +-
 .../devicetree/bindings/soc/xilinx/xlnx,vcu.txt    |  31 +
 arch/arm/boot/dts/dra7.dtsi                        |   4 +-
 arch/arm/boot/dts/omap4.dtsi                       |  20 +-
 arch/arm/mach-bcm/brcmstb.c                        |   2 -
 arch/arm/mach-omap2/omap_hwmod.c                   |   2 +
 arch/arm/mach-omap2/omap_hwmod.h                   |  34 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  21 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  17 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   7 +-
 arch/arm/mach-omap2/omap_hwmod_common_data.c       |  40 +-
 drivers/bus/omap_l3_noc.c                          |   5 +
 drivers/bus/omap_l3_smx.c                          |   6 +
 drivers/bus/ti-sysc.c                              | 485 +++++++++++-
 drivers/firmware/Kconfig                           |   2 +-
 drivers/firmware/qcom_scm.c                        |  24 -
 drivers/firmware/raspberrypi.c                     |   2 +-
 drivers/firmware/ti_sci.c                          |   4 +-
 drivers/iommu/tegra-smmu.c                         | 124 ++-
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |   8 +
 drivers/memory/Makefile.asm-offsets                |   5 +
 drivers/memory/emif-asm-offsets.c                  |  92 +++
 drivers/memory/emif.h                              |  17 +
 drivers/memory/omap-gpmc.c                         |   5 +-
 drivers/memory/tegra/Makefile                      |   1 +
 drivers/memory/tegra/tegra114.c                    |  15 +
 drivers/memory/tegra/tegra124.c                    |  17 +
 drivers/memory/tegra/tegra186.c                    | 600 +++++++++++++++
 drivers/memory/tegra/tegra210.c                    |  15 +
 drivers/memory/tegra/tegra30.c                     |  15 +
 drivers/memory/ti-emif-pm.c                        | 324 ++++++++
 drivers/memory/ti-emif-sram-pm.S                   | 334 ++++++++
 drivers/of/platform.c                              |   6 +
 drivers/pcmcia/at91_cf.c                           |   4 +-
 drivers/reset/core.c                               |   9 +-
 drivers/reset/reset-meson.c                        |   2 +
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/actions/owl-sps.c                      |  42 +
 drivers/soc/bcm/brcmstb/biuctrl.c                  | 192 ++++-
 drivers/soc/bcm/brcmstb/common.c                   |  43 +-
 drivers/soc/fsl/guts.c                             |   8 +
 drivers/soc/imx/gpc.c                              |  16 +-
 drivers/soc/qcom/Kconfig                           |  10 +
 drivers/soc/qcom/Makefile                          |   2 +
 drivers/soc/qcom/qmi_encdec.c                      | 816 ++++++++++++++++++++
 drivers/soc/qcom/qmi_interface.c                   | 848 +++++++++++++++++++++
 drivers/soc/qcom/rmtfs_mem.c                       |   4 +
 drivers/soc/qcom/smp2p.c                           |  55 +-
 drivers/soc/qcom/smsm.c                            |   6 +-
 drivers/soc/samsung/Kconfig                        |   1 +
 drivers/soc/samsung/Makefile                       |   1 +
 drivers/soc/samsung/exynos-pmu.c                   |  16 +-
 drivers/soc/samsung/exynos-pmu.h                   |   5 +-
 drivers/soc/samsung/exynos3250-pmu.c               |  16 +-
 drivers/soc/samsung/exynos4-pmu.c                  |  16 +-
 drivers/soc/samsung/exynos5250-pmu.c               |  16 +-
 drivers/soc/samsung/exynos5420-pmu.c               |  16 +-
 drivers/soc/samsung/pm_domains.c                   |  24 +-
 drivers/soc/ti/knav_qmss_queue.c                   |   4 +-
 drivers/soc/xilinx/Kconfig                         |  20 +
 drivers/soc/xilinx/Makefile                        |   2 +
 drivers/soc/xilinx/xlnx_vcu.c                      | 630 +++++++++++++++
 drivers/tee/optee/Makefile                         |   1 +
 drivers/tee/optee/call.c                           | 220 +++++-
 drivers/tee/optee/core.c                           | 163 +++-
 drivers/tee/optee/optee_msg.h                      |  38 +-
 drivers/tee/optee/optee_private.h                  |  72 +-
 drivers/tee/optee/optee_smc.h                      |   7 +
 drivers/tee/optee/rpc.c                            |  81 +-
 drivers/tee/optee/shm_pool.c                       |  75 ++
 drivers/tee/optee/shm_pool.h                       |  23 +
 drivers/tee/optee/supp.c                           | 375 +++++----
 drivers/tee/tee_core.c                             | 113 ++-
 drivers/tee/tee_private.h                          |  60 +-
 drivers/tee/tee_shm.c                              | 230 +++++-
 drivers/tee/tee_shm_pool.c                         | 165 ++--
 include/dt-bindings/bus/ti-sysc.h                  |  22 +
 include/dt-bindings/memory/tegra186-mc.h           | 111 +++
 .../dt-bindings/reset/amlogic,meson-axg-reset.h    | 124 +++
 include/linux/platform_data/ti-sysc.h              |  86 +++
 include/linux/qcom_scm.h                           |   3 +
 include/linux/reset.h                              |  50 +-
 include/linux/soc/brcmstb/brcmstb.h                |   6 -
 include/linux/soc/qcom/qmi.h                       | 271 +++++++
 include/linux/tee_drv.h                            | 196 ++++-
 include/linux/ti-emif-sram.h                       |  69 ++
 include/soc/tegra/mc.h                             |   9 +
 include/uapi/linux/tee.h                           |  37 +
 98 files changed, 7095 insertions(+), 737 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/misc/nvidia,tegra186-misc.txt
 create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,vcu.txt
 create mode 100644 drivers/memory/Makefile.asm-offsets
 create mode 100644 drivers/memory/emif-asm-offsets.c
 create mode 100644 drivers/memory/tegra/tegra186.c
 create mode 100644 drivers/memory/ti-emif-pm.c
 create mode 100644 drivers/memory/ti-emif-sram-pm.S
 create mode 100644 drivers/soc/qcom/qmi_encdec.c
 create mode 100644 drivers/soc/qcom/qmi_interface.c
 create mode 100644 drivers/soc/xilinx/Kconfig
 create mode 100644 drivers/soc/xilinx/Makefile
 create mode 100644 drivers/soc/xilinx/xlnx_vcu.c
 create mode 100644 drivers/tee/optee/shm_pool.c
 create mode 100644 drivers/tee/optee/shm_pool.h
 create mode 100644 include/dt-bindings/bus/ti-sysc.h
 create mode 100644 include/dt-bindings/memory/tegra186-mc.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson-axg-reset.h
 create mode 100644 include/linux/platform_data/ti-sysc.h
 create mode 100644 include/linux/soc/qcom/qmi.h
 create mode 100644 include/linux/ti-emif-sram.h
