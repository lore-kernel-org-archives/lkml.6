Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE4DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755BD2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755BD2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeJ3GOe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:14:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40682 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJ3GOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:14:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id f18-v6so5939585qkm.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ap8bm7uIYI9n+LixZynr2ZHjfWLFhLQ4fvjxo7wB//k=;
        b=r5aWPf8W3X+XObr9cNq6Z9EJuTlLJnB0qSCmfYjaQ7xmDUtMsCMtQ/c8gXUOwBvt/J
         Pm7iK9R+Bt4boCHvtz+5JlS6sq3iErV0xbaF6PQfauRWC7S7f+SarC5NJxxZ60wd83yi
         3sVeI1c/y2hfGkOnc7RBqXfeKJa3x/m7rCKXI2ADQ4IqXaZgJdCrbIkGUgPlgMtvzdwM
         f+/LDwiZeZEzY5UHw4wEOjDZe98r98/VRH5n8nEdfWWSyKZ1xto0O9zMQBUHD727kne3
         Pv41NZQLykcNrrdYAOnPXVPL5wz3VjqGzXKMh8HtRGMceJK6hUjg6Yx9cdkZXRYSM+3G
         x5Bw==
X-Gm-Message-State: AGRZ1gIl6hPPZ5HMD7phI2i8CzNDncsMIOWouYLDHPn+4UfeGcKJf/nO
        ATMupgTv9ZrNmRmm/lrV/0toBf4UCadoyS31PUuOqVaf
X-Google-Smtp-Source: AJdET5engVyavQjrcyxH90ufQPbzzE5y82mWFE0svPIqlZm85YgDexd9BmaXbQWOU31okuQITeE2Cpls/4EWJ8zWZGE=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr1595845qkf.330.1540848244442;
 Mon, 29 Oct 2018 14:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0RbZiHCF+krpmPpmH=4yy5G57NoTDpOKE=xz1wbgy78A@mail.gmail.com>
In-Reply-To: <CAK8P3a0RbZiHCF+krpmPpmH=4yy5G57NoTDpOKE=xz1wbgy78A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Oct 2018 22:23:48 +0100
Message-ID: <CAK8P3a2B+P+LSr+D3VBatUm8oHipXALAP0F3aC=-z7YxaOTxGg@mail.gmail.com>
Subject: [GIT PULL 3/4] ARM: SoC driver updates for 4.17
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5a1eb8b9542884592a018829bb1ff20c9695d925:

  soc: fsl: qman_portals: defer probe after qman's probe (2018-10-01
17:47:43 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-drivers

for you to fetch changes up to c1a92909dbc2090753ff6224971d9b8ae5f93c97:

  Merge tag 'tegra-for-4.20-firmware-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into
next/drivers (2018-10-11 15:26:18 +0200)

----------------------------------------------------------------
ARM: SoC driver updates for 4.17

The most noteworthy SoC driver changes this time include:

- The TEE subsystem gains an in-kernel interface to access the TEE
  from device drivers.

- The reset controller subsystem gains a driver for the Qualcomm
  Snapdragon 845 Power Domain Controller.

- The Xilinx Zynq platform now has a firmware interface for its
  platform management unit. This contains a firmware "ioctl" interface
  that was a little controversial at first, but the version we merged
  solved that by not exposing arbitrary firmware calls to user space.

- The Amlogic Meson platform gains a "canvas" driver that is used
  for video processing and shared between different high-level drivers.

The rest is more of the usual, mostly related to SoC specific power
management support and core drivers in drivers/soc:

- Several Renesas SoCs (RZ/G1N, RZ/G2M, R-Car V3M, RZ/A2M) gain new
  features related to power and reset control.

- The Mediatek mt8183 and mt6765 SoC platforms gain support for
  their respective power management chips.

- A new driver for NXP i.MX8, which need a firmware interface for
  power management.

- The SCPI firmware interface now contains support estimating power
  usage of performance states

- The NVIDIA Tegra "pmc" driver gains a few new features, in particular
  a pinctrl interface for configuring the pads.

- Lots of small changes for Qualcomm, in particular the "smem"
  device driver.

- Some cleanups for the TI OMAP series related to their sysc
  controller.

Additional cleanups and bugfixes in SoC specific drivers include the
Meson, Keystone, NXP, AT91, Sunxi, Actions, and Tegra platforms.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Aapo Vienamo (7):
      dt-bindings: Add Tegra PMC pad configuration bindings
      soc/tegra: pmc: Fix pad voltage configuration for Tegra186
      soc/tegra: pmc: Factor out DPD register bit calculation
      soc/tegra: pmc: Implement tegra_io_pad_is_powered()
      soc/tegra: pmc: Use X macro to generate IO pad tables
      soc/tegra: pmc: Remove public pad voltage APIs
      soc/tegra: pmc: Implement pad configuration via pinctrl

Alex Elder (12):
      soc: qcom: smem: rename variable in qcom_smem_get_global()
      soc: qcom: smem: initialize region struct only when successful
      soc: qcom: smem: always ignore partitions with 0 offset or size
      soc: qcom: smem: small refactor in qcom_smem_enumerate_partitions()
      soc: qcom: smem: verify both host ids in partition header
      soc: qcom: smem: require order of host ids to match
      soc: qcom: smem: introduce qcom_smem_partition_header()
      soc: qcom: smem: verify partition header size
      soc: qcom: smem: verify partition offset_free_uncached
      soc: qcom: smem: small change in global entry loop
      soc: qcom: smem: verify partition host ids match
      soc: qcom: smem: a few last cleanups

Andreas Färber (3):
      soc: actions: Convert to SPDX license identifiers
      soc: actions: Update SPS help text for S700
      Merge branch 'v4.20/s900-sps-bindings' into v4.20/drivers+s900-sps

Andy Gross (2):
      Merge tag 'qcom-geni-immutable-for-mark-brown' into drivers-for-4.20-final
      Merge branch 'drivers-for-4.20' into drivers-for-4.20-final

Anson Huang (2):
      soc: imx: gpcv2: use A_CORE instread of A7 for more i.MX platforms
      soc: imx: gpcv2: make pgc driver more generic for other i.MX platforms

Ard Biesheuvel (1):
      tee: optee: take DT status property into account

Argus Lin (3):
      dt-bindings: pwrap: mediatek: add pwrap support for MT6765
      soc: mediatek: pwrap: add pwrap driver for mt6765 SoCs
      soc: mediatek: pwrap: add mt6357 driver for mt6765 SoCs

Arnd Bergmann (14):
      Merge tag 'zynqmp-soc-for-v4.20-v2' of
https://github.com/Xilinx/linux-xlnx into next/drivers
      Merge tag 'tegra-for-4.20-soc' of
git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'renesas-drivers-for-v4.20' of
git://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'sunxi-drivers-for-4.20' of
git://git.kernel.org/.../sunxi/linux into next/drivers
      Merge tag 'v4.19-next-soc' of
git://git.kernel.org/.../matthias.bgg/linux into next/drivers
      Merge tag 'actions-drivers+s900-sps-for-4.20' of
git://git.kernel.org/.../afaerber/linux-actions into next/drivers
      Merge tag 'qcom-drivers-for-4.20' of
git://git.kernel.org/.../agross/linux into next/drivers
      Merge tag 'imx-drivers-4.20' of
git://git.kernel.org/.../shawnguo/linux into next/drivers
      Merge tag 'omap-for-v4.20/ti-sysc-take2-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/drivers
      Merge tag 'soc-fsl-next-v4.20-2' of
git://git.kernel.org/.../leo/linux into next/drivers
      Merge tag 'imx-drivers-4.20-2' of
git://git.kernel.org/.../shawnguo/linux into next/drivers
      Merge tag 'reset-for-4.20' of
git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'zynqmp-soc-clk-for-v4.20' of
https://github.com/Xilinx/linux-xlnx into next/drivers
      Merge tag 'tegra-for-4.20-firmware-2' of
git://git.kernel.org/.../tegra/linux into next/drivers

Biju Das (10):
      soc: renesas: Identify RZ/G2M
      dt-bindings: power: Add r8a774a1 SYSC power domain definitions
      soc: renesas: rcar-sysc: Add r8a774a1 support
      soc: renesas: rcar-rst: Add support for RZ/G2M
      dt-bindings: power: rcar-sysc: Document r8a7744 SYSC binding
      dt-bindings: power: rcar-sysc: Add r8a7744 power domain index macros
      soc: renesas: rcar-sysc: Add r8a7744 support
      dt-bindings: reset: rcar-rst: Document r8a7744 reset module
      soc: renesas: rcar-rst: Add support for RZ/G1N
      dt-bindings: apmu: Document r8a7744 support

Bjorn Andersson (4):
      soc: qcom: rmtfs-mem: Validate that scm is available
      dt-bindings: firmware: scm: Refactor compatibles and clocks
      firmware: qcom: scm: Refactor clock handling
      dt-bindings: firmware: scm: Add MSM8998 and SDM845

Channagoud Kadabi (1):
      drivers: edac: Add EDAC driver support for QCOM SoCs

Chris Brandt (2):
      ARM: shmobile: Add basic RZ/A2 SoC support
      soc: renesas: identify RZ/A2

Colin Ian King (2):
      soc: fsl: dpio: remove redundant pointer 'priv'
      soc: qcom: apr: fix spelling mistake: "paket" -> "packet"

Colin King (1):
      soc: ti: fix spelling mistake "instace" -> "instance"

Dong Aisheng (4):
      dt-bindings: arm: fsl: add scu binding doc
      firmware: imx: add SCU firmware driver support
      firmware: imx: add misc svc support
      MAINTAINERS: imx: include drivers/firmware/imx path

Douglas Anderson (2):
      soc: qcom: geni: Don't ignore clk_round_rate() errors in
geni_se_clk_tbl_get()
      soc: qcom: geni: geni_se_clk_freq_match() should always accept multiples

Fabio Estevam (2):
      soc: imx: gpc: Switch to SPDX identifier
      soc: imx: gpcv2: Switch to SPDX identifier

Fabrizio Castro (7):
      soc: renesas: Identify RZ/G2E
      dt-bindings: power: Add r8a774c0 SYSC power domain definitions
      dt-bindings: power: rcar-sysc: Document r8a774c0 sysc
      soc: renesas: rcar-sysc: Add r8a774c0 support
      dt-bindings: reset: rcar-rst: Document r8a774c0 rst
      soc: renesas: rcar-rst: Add support for RZ/G2E
      dt-bindings: apmu: Document r8a77470 support

Felix Fietkau (1):
      soc: qcom: spm: add SCM probe dependency

Geert Uytterhoeven (2):
      reset: Grammar s/more then once/more than once/
      reset: Fix potential use-after-free in __of_reset_control_get()

Gustavo A. R. Silva (2):
      memory: atmel-ebi: Use struct_size() in devm_kzalloc()
      soc: mediatek: pwrap: use true and false for boolean values

Hsin-Hsiung Wang (3):
      dt-bindings: mediatek: add compatible for mt8183 pwrap
      soc: mediatek: pwrap: use group of bits for pwrap capability
      soc: mediatek: add mt8183 pwrap support

Icenowy Zheng (1):
      dt-bindings: sunxi-sram: add binding for Allwinner H6 SRAM C

Jens Wiklander (1):
      tee: add kernel internal client interface

Johan Hovold (1):
      soc/tegra: pmc: Fix child-node lookup

Jolly Shah (1):
      drivers: clk: Add ZynqMP clock driver

Kuninori Morimoto (1):
      soc: renesas: convert to SPDX identifiers

Laurentiu Tudor (1):
      soc: fsl: bman_portals: defer probe after bman's probe

Li Yang (1):
      Merge tag 'soc-fsl-fix-v4.19-2' into HEAD

Lina Iyer (1):
      drivers: qcom: rpmh-rsc: clear wait_for_compl after use

Madalin Bucur (2):
      soc: fsl: qbman: replace CPU 0 with any online CPU in hotplug handlers
      soc: fsl: qbman: add interrupt coalesce changing APIs

Manivannan Sadhasivam (2):
      dt-bindings: power: Add Actions Semi S900 SPS
      soc: actions: sps: Add S900 power domains

Matthias Brugger (1):
      soc: mediatek: pwrap: order SoCs and PMICs ascending

Maxime Jourdan (2):
      dt-bindings: soc: amlogic: add meson-canvas documentation
      soc: amlogic: add meson-canvas driver

Neil Armstrong (1):
      firmware: meson_sm: Add serial number sysfs entry

Niklas Cassel (9):
      soc: qcom: smem: Add missing include of sizes.h
      soc: qcom: llcc-slice: Add missing include of sizes.h
      soc: qcom: smp2p: Add select IRQ_DOMAIN
      soc: qcom: smsm: Add select IRQ_DOMAIN
      soc: qcom: Remove bogus depends on OF from QCOM_SMD_RPM
      soc: qcom: Remove depends on OF from QCOM_RPMH
      soc: qcom: wcnss_ctrl: Avoid string overflow
      soc: qcom: apr: Avoid string overflow
      soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs

Nishanth Menon (2):
      Documentation: dt: keystone: ti-sci: Add optional host-id parameter
      firmware: ti_sci: Provide host-id as an optional dt parameter

Olof Johansson (7):
      Merge tag 'tee-drv-for-4.20' of
git://git.linaro.org/people/jens.wiklander/linux-tee into next/drivers
      Merge tag 'amlogic-drivers' of
https://git.kernel.org/.../khilman/linux-amlogic into next/drivers
      Merge tag 'v4.19-rc3' into next/drivers
      Merge tag 'scmi-updates-4.20' of
git://git.kernel.org/.../sudeep.holla/linux into next/drivers
      Merge tag 'drivers_soc_for_4.20' of
git://git.kernel.org/.../ssantosh/linux-keystone into next/drivers
      Merge tag 'soc-fsl-next-v4.20' of
git://git.kernel.org/.../leo/linux into next/drivers
      Merge tag 'at91-4.20-drivers' of
git://git.kernel.org/.../at91/linux into next/drivers

Paul Kocialkowski (1):
      drivers: soc: Allow building the sunxi driver without ARCH_SUNXI

Quentin Perret (1):
      firmware: arm_scmi: add a getter for power of performance states

Rajan Vaja (9):
      dt-bindings: firmware: Add bindings for ZynqMP firmware
      firmware: xilinx: Add Zynqmp firmware driver
      firmware: xilinx: Add query data API
      firmware: xilinx: Add clock APIs
      firmware: xilinx: Add debugfs interface
      firmware: xilinx: Add debugfs for query data API
      Documentation: xilinx: Add documentation for eemi APIs
      firmware: xilinx: Add zynqmp IOCTL API for device control
      dt-bindings: clock: Add bindings for ZynqMP clock driver

Rob Herring (2):
      soc: fsl/qe: Use of_get_child_by_name helper
      bus: imx-weim: drop unnecessary DT node name NULL check

Roy Pledge (3):
      soc: fsl: qbman: Check if CPU is offline when initializing portals
      soc: fsl: qbman: Add 64 bit DMA addressing requirement to QBMan
      soc: fsl: qbman: Use last response to determine valid bit

Sergei Shtylyov (1):
      dt-bindings: timer: renesas: tmu: document R8A779{7|8}0 bindings

Sibi Sankar (2):
      dt-bindings: reset: Add PDC Global binding for SDM845 SoCs
      reset: qcom: PDC Global (Power Domain Controller) reset controller

Stephen Boyd (1):
      soc: qcom: geni: Make version macros simpler

Sudeep Holla (1):
      firmware: arm_scmi: use strlcpy to ensure NULL-terminated strings

Sven Schmitt (2):
      soc: imx: gpc: fix PDN delay
      soc: imx: gpc: use GPC_PGC_DOMAIN_* indexes

Thierry Reding (2):
      Merge branch 'for-4.20/dt-bindings' into for-4.20/soc
      firmware: tegra: bpmp: Implement suspend/resume support

Tony Lindgren (9):
      bus: ti-sysc: Defer suspend as needed
      bus: ti-sysc: Update revision masks to support am437x
      bus: ti-sysc: Detect more devices on am473x for debugging
      bus: ti-sysc: Detect devices on am335x when DEBUG is enabled
      Merge commit '4f3530f4a41d49c41015020cd9a5ed5c95b5d2db' into
omap-for-v4.20/ti-sysc
      bus: ti-sysc: Detect timer and gpio on dra7
      bus: ti-sysc: Detect devices for debug on dra7
      bus: ti-sysc: Make some warnings debug only
      bus: ti-sysc: Just use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS

Venkata Narendra Kumar Gutta (3):
      soc: qcom: Add broadcast base for Last Level Cache Controller (LLCC)
      soc: qcom: Add support to register LLCC EDAC driver
      dt-bindings: msm: Update documentation of qcom,llcc

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 183 ++++++
 .../devicetree/bindings/arm/keystone/ti,sci.txt    |   4 +
 .../devicetree/bindings/arm/msm/qcom,llcc.txt      |  19 +-
 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  93 +++
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 103 +++
 .../devicetree/bindings/firmware/qcom,scm.txt      |  33 +-
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  82 +++
 .../devicetree/bindings/power/actions,owl-sps.txt  |   2 +
 .../devicetree/bindings/power/renesas,apmu.txt     |   2 +
 .../bindings/power/renesas,rcar-sysc.txt           |   3 +
 .../devicetree/bindings/reset/qcom,pdc-global.txt  |  52 ++
 .../devicetree/bindings/reset/renesas,rst.txt      |   3 +
 .../bindings/soc/amlogic/amlogic,canvas.txt        |  29 +
 .../devicetree/bindings/soc/mediatek/pwrap.txt     |   2 +
 .../devicetree/bindings/sram/sunxi-sram.txt        |   4 +
 .../devicetree/bindings/timer/renesas,tmu.txt      |   2 +
 Documentation/xilinx/eemi.txt                      |  67 ++
 MAINTAINERS                                        |  12 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts          |   2 +
 arch/arm/boot/dts/bcm63138.dtsi                    |  14 +-
 arch/arm/boot/dts/sun8i-r40.dtsi                   |   3 +-
 arch/arm/mach-shmobile/Kconfig                     |   6 +
 arch/arm/mach-shmobile/Makefile                    |   1 +
 arch/arm/mach-shmobile/setup-r7s9210.c             |  27 +
 arch/arm64/Kconfig.platforms                       |   1 +
 drivers/bus/imx-weim.c                             |   3 -
 drivers/bus/ti-sysc.c                              | 171 ++---
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zynqmp/Kconfig                         |  10 +
 drivers/clk/zynqmp/Makefile                        |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 144 +++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 141 ++++
 drivers/clk/zynqmp/clk-zynqmp.h                    |  68 ++
 drivers/clk/zynqmp/clkc.c                          | 716 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 217 +++++++
 drivers/clk/zynqmp/pll.c                           | 335 ++++++++++
 drivers/edac/Kconfig                               |  14 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/qcom_edac.c                           | 414 ++++++++++++
 drivers/firmware/Kconfig                           |   2 +
 drivers/firmware/Makefile                          |   2 +
 drivers/firmware/arm_scmi/base.c                   |   2 +-
 drivers/firmware/arm_scmi/clock.c                  |   2 +-
 drivers/firmware/arm_scmi/perf.c                   |  30 +-
 drivers/firmware/arm_scmi/power.c                  |   2 +-
 drivers/firmware/arm_scmi/sensors.c                |   2 +-
 drivers/firmware/imx/Kconfig                       |  11 +
 drivers/firmware/imx/Makefile                      |   2 +
 drivers/firmware/imx/imx-scu.c                     | 270 ++++++++
 drivers/firmware/imx/misc.c                        |  99 +++
 drivers/firmware/meson/meson_sm.c                  |  56 ++
 drivers/firmware/qcom_scm.c                        |  74 ++-
 drivers/firmware/tegra/bpmp.c                      |  19 +
 drivers/firmware/ti_sci.c                          |  24 +-
 drivers/firmware/xilinx/Kconfig                    |  23 +
 drivers/firmware/xilinx/Makefile                   |   5 +
 drivers/firmware/xilinx/zynqmp-debug.c             | 250 +++++++
 drivers/firmware/xilinx/zynqmp-debug.h             |  24 +
 drivers/firmware/xilinx/zynqmp.c                   | 565 ++++++++++++++++
 drivers/memory/atmel-ebi.c                         |   3 +-
 drivers/reset/Kconfig                              |   9 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/core.c                               |  15 +-
 drivers/reset/reset-qcom-pdc.c                     | 124 ++++
 drivers/soc/Makefile                               |   2 +-
 drivers/soc/actions/Kconfig                        |   2 +-
 drivers/soc/actions/Makefile                       |   2 +
 drivers/soc/actions/owl-sps-helper.c               |   6 +-
 drivers/soc/actions/owl-sps.c                      |  64 +-
 drivers/soc/amlogic/Kconfig                        |   7 +
 drivers/soc/amlogic/Makefile                       |   1 +
 drivers/soc/amlogic/meson-canvas.c                 | 185 ++++++
 drivers/soc/fsl/dpio/dpio-driver.c                 |   3 -
 drivers/soc/fsl/qbman/Kconfig                      |   2 +-
 drivers/soc/fsl/qbman/bman.c                       |   6 +-
 drivers/soc/fsl/qbman/bman_ccsr.c                  |  11 +
 drivers/soc/fsl/qbman/bman_portal.c                |  14 +-
 drivers/soc/fsl/qbman/dpaa_sys.h                   |  20 +
 drivers/soc/fsl/qbman/qman.c                       |  56 +-
 drivers/soc/fsl/qbman/qman_ccsr.c                  |  11 +
 drivers/soc/fsl/qbman/qman_portal.c                |  14 +-
 drivers/soc/fsl/qe/qe.c                            |   6 +-
 drivers/soc/fsl/qe/ucc.c                           |   2 +-
 drivers/soc/imx/gpc.c                              |  26 +-
 drivers/soc/imx/gpcv2.c                            | 100 +--
 drivers/soc/mediatek/mtk-pmic-wrap.c               | 519 +++++++++++----
 drivers/soc/qcom/Kconfig                           |  21 +-
 drivers/soc/qcom/apr.c                             |   6 +-
 drivers/soc/qcom/llcc-slice.c                      |  74 ++-
 drivers/soc/qcom/qcom-geni-se.c                    |  41 +-
 drivers/soc/qcom/rmtfs_mem.c                       |   5 +
 drivers/soc/qcom/rpmh-rsc.c                        |   2 +
 drivers/soc/qcom/smem.c                            | 174 +++--
 drivers/soc/qcom/spm.c                             |   3 +
 drivers/soc/qcom/wcnss_ctrl.c                      |   2 +-
 drivers/soc/renesas/Kconfig                        |  19 +-
 drivers/soc/renesas/Makefile                       |   2 +
 drivers/soc/renesas/r8a7743-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a7745-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a774a1-sysc.c                |  45 ++
 drivers/soc/renesas/r8a774c0-sysc.c                |  68 ++
 drivers/soc/renesas/r8a7779-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a7790-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a7791-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a7792-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a7794-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a7795-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a7796-sysc.c                 |   5 +-
 drivers/soc/renesas/r8a77970-sysc.c                |   5 +-
 drivers/soc/renesas/r8a77995-sysc.c                |   5 +-
 drivers/soc/renesas/rcar-rst.c                     |  11 +-
 drivers/soc/renesas/rcar-sysc.c                    |  13 +-
 drivers/soc/renesas/rcar-sysc.h                    |   9 +-
 drivers/soc/renesas/renesas-soc.c                  | 100 ++-
 drivers/soc/tegra/pmc.c                            | 513 +++++++++++----
 drivers/soc/ti/knav_dma.c                          |   4 +-
 drivers/soc/ti/knav_qmss.h                         |   6 +-
 drivers/tee/optee/core.c                           |   2 +-
 drivers/tee/tee_core.c                             | 113 +++-
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |  18 +
 include/dt-bindings/power/owl-s900-powergate.h     |  23 +
 include/dt-bindings/power/r8a7744-sysc.h           |  24 +
 include/dt-bindings/power/r8a774a1-sysc.h          |  31 +
 include/dt-bindings/power/r8a774c0-sysc.h          |  25 +
 include/dt-bindings/reset/qcom,sdm845-pdc.h        |  20 +
 include/linux/firmware/imx/ipc.h                   |  59 ++
 include/linux/firmware/imx/sci.h                   |  17 +
 include/linux/firmware/imx/svc/misc.h              |  55 ++
 include/linux/firmware/imx/types.h                 | 617 ++++++++++++++++++
 include/linux/firmware/meson/meson_sm.h            |   1 +
 include/linux/firmware/xlnx-zynqmp.h               | 116 ++++
 include/linux/platform_data/ti-sysc.h              |   1 -
 include/linux/qcom-geni-se.h                       |  13 +-
 include/linux/reset.h                              |   2 +-
 include/linux/scmi_protocol.h                      |   4 +
 include/linux/soc/amlogic/meson-canvas.h           |  65 ++
 include/linux/soc/qcom/llcc-qcom.h                 |  30 +-
 include/linux/tee_drv.h                            |  73 +++
 include/soc/fsl/bman.h                             |   8 +
 include/soc/fsl/qman.h                             |  36 ++
 include/soc/tegra/pmc.h                            |  20 +-
 143 files changed, 7504 insertions(+), 822 deletions(-)
