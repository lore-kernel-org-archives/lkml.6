Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47335C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14FE21783
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Ak33XhEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeLaVq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:46:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36094 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbeLaVq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:46:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so13580325pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 13:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jj6XdwEJtAnO2Gkmj0ob+Z9ZSB/vn/KMcLaoPuXWHYI=;
        b=Ak33XhEj1Hqy8WzbJthYCsKjzAqEbguVSUOyw9X23qw29FgiqPFiHM3aFa4XrSJoc1
         4CJe9IQ224Fg8I9SF+nf8GQtovUAOHb+wjXq61LkkHnWl4bKwmqVYmcP599HzZ++tpED
         koGBd9fs1Cp/lTC6HeG/IbpbIaakqXzGdh467mABKlKaV1KNAO12zIPsXGRjqKAtI4r7
         E58dpPsiRxWZlP/EsrdNF+zEvI47Ekm2eiIQe1ogqJaq/O9wuo7liRILlWNpoxomuw/x
         6UZxDl7YAcb88SjJDH6DmpHoM/yhQ7aaZH0E7jwpXZ5IwhVlG4UhvBzg2tfZYk/L8DNH
         FAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jj6XdwEJtAnO2Gkmj0ob+Z9ZSB/vn/KMcLaoPuXWHYI=;
        b=lPu8CbhAjdF2ZnVkrzh7TuHs7UlVIFwd8VT2mfw1N+F1Oga/eS77foxlutZb+Im4SM
         n3zCkTRbyCoim9mPHYt+GiFooEKyCP7JMMJ6cLUi116zr26df20m56VcV9nBIQZqXKj3
         F0hLFHAOHa5YNKXZJvqmupZu8XkZNUmRn7ILKRzWi064K5pJd7ew9zdJV7+pS+Bnbp8b
         jQgS+cgT5MCSRBN9thApelRZcVID1BkMslXRnovoc+O2si+ALunpkDma9tmUctGR36NN
         iIMwnqZyGSB6rfpeXxbfVrJwCXDWQvuOnCpFkshrguSN8dTniVuME9xw+wAGuUWLNxHj
         U3mg==
X-Gm-Message-State: AJcUukcQ+8WyVt3Z8KL0lbMU8JPRvxAWScfx8hvA1uCfmDU65w4D8o29
        gfVCVb1h5J4aXuRhQlYrrj7DvrvkkGDvGQ==
X-Google-Smtp-Source: ALg8bN482ur0l5AoOPy4pFqe2jLhQhsiiaykxxNyUYP6y0BicHm1mnumhLgQlWkYXqISOOXGEZk1ig==
X-Received: by 2002:a63:c748:: with SMTP id v8mr8882640pgg.108.1546292815688;
        Mon, 31 Dec 2018 13:46:55 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id u126sm96477085pgb.2.2018.12.31.13.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 13:46:53 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 2/4] ARM: SoC driver updates
Date:   Mon, 31 Dec 2018 13:46:38 -0800
Message-Id: <20181231214640.17015-3-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181231214640.17015-1-olof@lixom.net>
References: <20181231214640.17015-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Misc driver updates for platforms, many of them power related.

- Rockchip adds power domain support for rk3066 and rk3188
- Amlogic adds a power measurement driver
- Allwinner adds SRAM support for three platforms (F1C100, H5, A64 C1)
- Wakeup and ti-sysc (platform bus) fixes for OMAP/DRA7
- Broadcom fixes suspend/resume with Thumb2 kernels, and improves
  stability of a handful of firmware/platform interfaces
- PXA completes their conversion to dmaengine framework
- Renesas does a bunch of PM cleanups across many platforms
- Tegra adds support for suspend/resume on T186/T194, which includes
  some driver cleanups and addition of wake events
- Tegra also adds a driver for memory controller (EMC) on Tegra2
- i.MX tweaks power domain bindings, and adds support for i.MX8MQ in GPC
- Atmel adds identifiers and LPDDR2 support for a new SoC, SAM9X60

+ misc cleanups across several platforms

----------------------------------------------------------------

The following changes since commit b0e8b6ef5408a5b97c4fa8c835599e67ff4a0e3d:

  Merge tag 'armsoc-soc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to a6f119a06960ef1dc30570401e43b71f9ebdd2c2:

  Merge tag 'omap-for-v4.21/driver-part2-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into next/drivers

----------------------------------------------------------------

A.s. Dong (1):
      firmware: imx: add SCU power domain driver

Alok Chauhan (1):
      soc: qcom: Add irq clear handling during SE init

Arnd Bergmann (1):
      soc: qcom/llcc: add MODULE_LICENSE tag

Arun Kumar Neelakantam (1):
      soc: qcom: qmi_interface: Limit txn ids to U16_MAX

Bjorn Andersson (1):
      soc: qcom: smd-rpm: Add QCS404 compatible

Bo Yan (1):
      soc/tegra: fuse: Remove duplicated function declaration

Corentin Labbe (1):
      soc: amlogic: meson-clk-measure: Add missing REGMAP_MMIO dependency

Dmitry Osipenko (2):
      memory: tegra: Introduce Tegra20 EMC driver
      soc/tegra: pmc: Drop locking from tegra_powergate_is_powered()

Florian Fainelli (2):
      soc: bcm: brcmstb: Fix re-entry point with a THUMB2_KERNEL
      Merge tag 'tags/bcm2835-drivers-next-2018-11-27' into drivers/next

Geert Uytterhoeven (9):
      soc: renesas: r8a77965-sysc: Remove non-existent A3IR power domain
      soc: renesas: r8a77970-sysc: Remove non-existent CR7 power domain
      soc: renesas: r8a77970-sysc: Correct names of A2DP/A2CN power domains
      soc: renesas: r8a77980-sysc: Correct names of A2DP[01] power domains
      soc: renesas: r8a77980-sysc: Correct A3VIP[012] power domain hierarchy
      soc: renesas: r8a77990-sysc: Fix initialization order of 3DG-{A,B}
      soc: renesas: rcar-sysc: Remove rcar_sysc_power_{down,up}() helpers
      soc: renesas: rcar-sysc: Merge PM Domain registration and linking
      soc: renesas: rcar-sysc: Fix power domain control after system resume

Heiko Stuebner (6):
      dt-bindings: add power-domain header for RK3188 SoCs
      dt-bindings: add power-domain header for RK3066 SoCs
      dt-bindings: add compatibles for rk3066/rk3188 power controllers
      Merge branch 'v4.21-shared/pdids' into v4.21-armsoc/drivers
      soc: rockchip: power-domain: add rk3188 powerdomains
      soc: rockchip: power-domain: add rk3066 powerdomains

Houlong Wei (1):
      soc: mediatek: Add Mediatek CMDQ helper

James Hughes (1):
      firmware: raspberrypi: Fix firmware calls with large buffers

Jon Hunter (1):
      soc/tegra: pmc: Don't power-up XUSB power-domains

Jordan Crouse (1):
      soc: qcom: llcc-slice: Add error checks for API functions

Keerthy (1):
      soc: ti: wkup_m3: Add PRCM int16 as the wake up source

Leonard Crestez (1):
      soc: imx: gpc: Increase GPC_CLK_MAX to 7

Lucas Stach (3):
      soc: imx: gpcv2: prefix i.MX7 specific defines
      soc: imx: gpcv2: move register access table to domain data
      soc: imx: gpcv2: add support for i.MX8MQ SoC

Maxime Jourdan (1):
      drivers: soc: Allow building the amlogic drivers without ARCH_MESON

Mesih Kilinc (1):
      dt-bindings: sram: Add Allwinner suniv F1C100s

Neil Armstrong (2):
      dt-bindings: amlogic: Add Internal Clock Measurer bindings
      soc: amlogic: Add Meson Clock Measure driver

Nicolas Ferre (1):
      ARM: at91: add support in soc driver for LPDDR2 SiP

Niklas Cassel (1):
      soc: qcom: Drop help text for QCOM_QMI_HELPERS

Olof Johansson (16):
      Merge tag 'v4.21-rockchip-drivers-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/drivers
      Merge tag 'amlogic-drivers' of https://git.kernel.org/.../khilman/linux-amlogic into next/drivers
      Merge tag 'omap-for-v4.21/driver-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/drivers
      Merge tag 'arm-soc/for-4.21/drivers' of https://github.com/Broadcom/stblinux into next/drivers
      Merge tag 'qcom-drivers-for-4.21' of git://git.kernel.org/.../agross/linux into next/drivers
      Merge tag 'pxa-for-4.21' of https://github.com/rjarzmik/linux into next/drivers
      Merge tag 'renesas-drivers-for-v4.21' of https://git.kernel.org/.../horms/renesas into next/drivers
      Merge tag 'tegra-for-4.21-soc' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.21-firmware' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'sunxi-drivers-for-4.21' of https://git.kernel.org/.../sunxi/linux into next/drivers
      Merge tag 'v4.20-next-soc' of https://git.kernel.org/.../matthias.bgg/linux into next/drivers
      Merge tag 'imx-drivers-4.21' of git://git.kernel.org/.../shawnguo/linux into next/drivers
      Merge tag 'amlogic-drivers-2' of https://git.kernel.org/.../khilman/linux-amlogic into next/drivers
      Merge tag 'at91-4.21-soc' of git://git.kernel.org/.../at91/linux into next/drivers
      Merge tag 'tegra-for-4.21-memory' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'omap-for-v4.21/driver-part2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/drivers

Paul Kocialkowski (4):
      soc: sunxi: sram: Enable EMAC clock access for H3 variant
      soc: sunxi: sram: Add support for the H5 SoC system control
      dt-bindings: sram: sunxi: Add bindings for the H5 with SRAM C1
      dt-bindings: sram: sunxi: Add compatible for the A64 SRAM C1

Rob Herring (1):
      memory: omap-gpmc: Use of_node_name_eq for node name comparisons

Robert Jarzmik (1):
      dmaengine: pxa: make the filter function internal

Sandeep Sheriker Mallikarjun (1):
      ARM: at91: add support in soc driver for new SAM9X60

Sandipan Patra (1):
      soc/tegra: pmc: Add sysfs entries for reset info

Stefan Wahren (3):
      firmware: raspberrypi: Define timeout for transactions
      soc: bcm: Switch raspberrypi-power to SPDX identifier
      firmware: raspberrypi: Switch to SPDX identifier

Stephen Boyd (3):
      soc: qcom: cmd-db: Remove memcpy()ing from cmd_db_get_header()
      soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()
      drm: msm: Check cmd_db_read_aux_data() for failure

Thierry Reding (4):
      soc/tegra: pmc: Add Tegra194 support
      soc/tegra: pmc: Add wake event support
      soc/tegra: pmc: Add initial Tegra186 wake events
      soc/tegra: pmc: Add initial Tegra194 wake events

Timo Alho (5):
      firmware: tegra: Add helper to check for supported MRQs
      firmware: tegra: Switch to global mrq_is_supported()
      firmware: tegra: Print version tag at full
      soc/tegra: bpmp: Update ABI header
      firmware: tegra: Use in-band messages for firmware version query

Tony Lindgren (7):
      bus: ti-sysc: Fix getting optional clocks in clock_roles
      bus: ti-sysc: Add mcasp optional clocks flag
      bus: ti-sysc: Detect devices for debug on omap5
      Merge branch 'omap-for-v4.21/ti-sysc' into omap-for-v4.21/driver
      ARM: OMAP2+: Check also the first dts child for hwmod flags
      bus: ti-sysc: Check for no-reset and no-idle flags at the child level
      Merge branch 'omap-for-v4.21/ti-sysc' into omap-for-v4.21/driver

Wolfram Sang (1):
      bus: brcmstb_gisb: simplify getting .driver_data

Yangtao Li (4):
      soc/tegra: Don't leak device tree node reference
      soc/tegra: pmc: Change to use DEFINE_SHOW_ATTRIBUTE macro
      soc: sunxi: Change to use DEFINE_SHOW_ATTRIBUTE macro
      soc: bcm: brcmstb: Don't leak device tree node reference

YueHaibing (1):
      soc: qcom: llcc-slice: Remove duplicated include from llcc-slice.c


 .../devicetree/bindings/bus/ti-sysc.txt         |    1 +
 .../devicetree/bindings/power/fsl,imx-gpcv2.txt |    7 +-
 .../bindings/soc/amlogic/clk-measure.txt        |   18 +
 .../bindings/soc/qcom/qcom,smd-rpm.txt          |    1 +
 .../bindings/soc/rockchip/power_domain.txt      |    4 +
 .../devicetree/bindings/sram/sunxi-sram.txt     |    9 +
 arch/arm/mach-omap2/omap_hwmod.c                |   23 +-
 drivers/bus/brcmstb_gisb.c                      |   12 +-
 drivers/bus/ti-sysc.c                           |   55 +-
 drivers/dma/pxa_dma.c                           |    5 +-
 drivers/firmware/imx/Kconfig                    |    6 +
 drivers/firmware/imx/Makefile                   |    3 +-
 drivers/firmware/imx/scu-pd.c                   |  339 +++++
 drivers/firmware/raspberrypi.c                  |   48 +-
 drivers/firmware/tegra/bpmp-debugfs.c           |   29 +-
 drivers/firmware/tegra/bpmp.c                   |   77 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c           |   59 +-
 drivers/memory/omap-gpmc.c                      |    8 +-
 drivers/memory/tegra/Kconfig                    |   10 +
 drivers/memory/tegra/Makefile                   |    1 +
 drivers/memory/tegra/tegra20-emc.c              |  591 +++++++++
 drivers/soc/Makefile                            |    2 +-
 drivers/soc/amlogic/Kconfig                     |    9 +
 drivers/soc/amlogic/Makefile                    |    1 +
 drivers/soc/amlogic/meson-clk-measure.c         |  350 ++++++
 drivers/soc/atmel/soc.c                         |   10 +
 drivers/soc/atmel/soc.h                         |    7 +
 drivers/soc/bcm/brcmstb/common.c                |    6 +-
 drivers/soc/bcm/brcmstb/pm/pm-arm.c             |    2 +-
 drivers/soc/bcm/raspberrypi-power.c             |    5 +-
 drivers/soc/imx/Kconfig                         |    6 +-
 drivers/soc/imx/Makefile                        |    2 +-
 drivers/soc/imx/gpc.c                           |    2 +-
 drivers/soc/imx/gpcv2.c                         |  296 ++++-
 drivers/soc/mediatek/Kconfig                    |   12 +
 drivers/soc/mediatek/Makefile                   |    1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c          |  300 +++++
 drivers/soc/qcom/Kconfig                        |    5 -
 drivers/soc/qcom/cmd-db.c                       |   93 +-
 drivers/soc/qcom/llcc-slice.c                   |   17 +-
 drivers/soc/qcom/qcom-geni-se.c                 |   25 +-
 drivers/soc/qcom/qmi_interface.c                |    2 +-
 drivers/soc/qcom/smd-rpm.c                      |    1 +
 drivers/soc/renesas/r8a77965-sysc.c             |    1 -
 drivers/soc/renesas/r8a77970-sysc.c             |    5 +-
 drivers/soc/renesas/r8a77980-sysc.c             |   10 +-
 drivers/soc/renesas/r8a77990-sysc.c             |   23 +-
 drivers/soc/renesas/rcar-sysc.c                 |   65 +-
 drivers/soc/rockchip/pm_domains.c               |   48 +
 drivers/soc/sunxi/sunxi_sram.c                  |   22 +-
 drivers/soc/tegra/common.c                      |    6 +-
 drivers/soc/tegra/pmc.c                         |  472 ++++++-
 drivers/soc/ti/wkup_m3_ipc.c                    |    1 +
 include/dt-bindings/power/imx8mq-power.h        |   21 +
 include/dt-bindings/power/r8a77970-sysc.h       |    7 +-
 include/dt-bindings/power/r8a77980-sysc.h       |    6 +-
 include/dt-bindings/power/raspberrypi-power.h   |    5 +-
 include/dt-bindings/power/rk3066-power.h        |   22 +
 include/dt-bindings/power/rk3188-power.h        |   24 +
 include/linux/dma/pxa-dma.h                     |   11 -
 include/linux/soc/mediatek/mtk-cmdq.h           |  133 ++
 include/linux/soc/qcom/qmi.h                    |    2 +-
 include/soc/bcm2835/raspberrypi-firmware.h      |    5 +-
 include/soc/qcom/cmd-db.h                       |   12 +-
 include/soc/tegra/bpmp-abi.h                    | 1188 ++++++++++++++----
 include/soc/tegra/bpmp.h                        |    7 +
 include/soc/tegra/fuse.h                        |    1 -
 include/soc/tegra/pmc.h                         |   21 +
 68 files changed, 3910 insertions(+), 668 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
 create mode 100644 drivers/firmware/imx/scu-pd.c
 create mode 100644 drivers/memory/tegra/tegra20-emc.c
 create mode 100644 drivers/soc/amlogic/meson-clk-measure.c
 create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
 create mode 100644 include/dt-bindings/power/imx8mq-power.h
 create mode 100644 include/dt-bindings/power/rk3066-power.h
 create mode 100644 include/dt-bindings/power/rk3188-power.h
 create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h
