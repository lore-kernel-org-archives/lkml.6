Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B16EC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32475208FC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="f4gor37G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32475208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeHWIBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:01:02 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:36549 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbeHWIBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:01:02 -0400
Received: by mail-pg1-f176.google.com with SMTP id h17-v6so1937265pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 21:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IC8nv2lzLzJnoC7uhWGsz+OeJVr7Bu9/MiYrsm8cNYY=;
        b=f4gor37GbQHBe6AXGwDexjEa1tUvsHBKpzp00tjEOIAoguXA8tl8DBYEKSUvt6Cnd9
         ivgrJJM9H3NakZIafih5i0MGrO6v8xChpIlEv+o72ER8eSX6di37JYUJlyTIGwthsj2b
         6RgfbdZbCfqt3MxIi917oQ8VsYiRwtwKxzKgXYFzN3hAzSlL+kaUT/oxUI9whr+nWMcV
         HGPRj891AK1pq1ZMqoAD1Z7wj0kqlVTRclBLdYEpCKLObTOM4a8BwW/OEHN95usCRmsX
         uqKevsmJZDF5LURkMxRiu0BF8qfiZc3lQn2f3knt6mqG/oqCGHsZkReygZnRT4+qL/vv
         YCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IC8nv2lzLzJnoC7uhWGsz+OeJVr7Bu9/MiYrsm8cNYY=;
        b=bgm3MxGXQttrsD8FPMFjUkb7RaiXPimgfEmHySBe4ztaaf7hDRWMq5zNUufJnzIDha
         cua6XInQvYUB6W3aIm5YW98/ETCt9XtXIZd9x3NHhTpGqUICthqWGbhexecuEVNmofjP
         2tZWJaV5KTsMB815CnZHzYWaNfw5qWOmPYfyooqFRGH7HNhG0meueFIQXbKSYSPHyVcv
         T1oXbEuOrdBRdV1VRtaeTqMlj1TdfRVqnf3BWjgrVZyibYEPzeITSs5f8iuI0wmkIGYG
         7ZMK2AGsZK+Fb/NRcJTJdNrbhZq8zzsvocaldWqkJsOyasj5vjBD8jP4vmw36esQX5L9
         4l7Q==
X-Gm-Message-State: AOUpUlHn9jgIDRp8zZYS4dcR0/3eN3fAg19IT864SZ0pcyL79fTR7WLo
        gZeweXJRFk+3CHb9e2SCxlyJv+KTICQZ9g==
X-Google-Smtp-Source: AA+uWPwx9y2WdprIUYdMpGMPsLbmhcY4qnlVYqgTwWa8nZQcTA+hVmjyhGpEM1gQsEn/T259t2P3mg==
X-Received: by 2002:a63:fb07:: with SMTP id o7-v6mr24595343pgh.333.1534998797395;
        Wed, 22 Aug 2018 21:33:17 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id 70-v6sm4859947pfz.27.2018.08.22.21.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 21:33:14 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 2/4] ARM: SoC driver updates
Date:   Wed, 22 Aug 2018 21:32:55 -0700
Message-Id: <20180823043257.18582-3-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180823043257.18582-1-olof@lixom.net>
References: <20180823043257.18582-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the larger changes this merge window:
- Removal of drivers for Exynos5440, a Samsung SoC that never saw
widespread use.
- Uniphier support for USB3 and SPI reset handling
- Syste control and SRAM drivers and bindings for Allwinner platforms
- Qualcomm AOSS (Always-on subsystem) reset controller drivers
- Raspberry Pi hwmon driver for voltage
- Mediatek pwrap (pmic) support for MT6797 SoC

----------------------------------------------------------------

The following changes since commit 8928c21c542a61c7cf7e33794a84e774040fb718:

  Merge tag 'armsoc-soc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to 29ed45fff05899f6f39d05fe1c32b1bc51f8926b:

  Merge tag 'v4.18-next-soc' of https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into next/drivers

----------------------------------------------------------------

Argus Lin (4):
      dt-bindings: pwrap: mediatek: add pwrap support for MT6797
      soc: mediatek: pwrap: fix cipher init setting error
      soc: mediatek: pwrap: add pwrap driver for mt6797 SoCs
      soc: mediatek: pwrap: add mt6351 driver for mt6797 SoCs

Arnd Bergmann (2):
      tee: replace getnstimeofday64() with ktime_get_real_ts64()
      soc: ti: wkup_m3_ipc: mark PM functions as __maybe_unused

Chen-Yu Tsai (2):
      dt-bindings: sram: Rename A64 SRAM controller compatible
      soc: sunxi: sram: Add updated compatible string for A64 system control

Dan Carpenter (1):
      firmware: arm_scmi: remove some unnecessary checks

Dave Gerlach (2):
      memory: ti-emif-sram: Add resume function to recopy sram code
      soc: ti: wkup_m3_ipc: Add wkup_m3_request_wake_src

Dmitry Osipenko (1):
      memory: tegra: Correct driver probe order

Doug Berger (1):
      soc: bcm: brcmstb: pm: Add support for newer rev B3.0 controllers

Faiz Abbas (3):
      clk: ti: dra7: Add clkctrl clock data for the mcan clocks
      bus: ti-sysc: Add support for using ti-sysc for MCAN on dra76x
      bus: ti-sysc: Add support for software reset

Florian Fainelli (2):
      soc: bcm: brcmstb: Add missing DDR MEMC compatible strings
      Merge tag 'bcm2835-drivers-next-2018-07-03' into drivers/next

Horia Geantă (1):
      staging: fsl-dpaa2: eth: move generic FD defines to DPIO

Icenowy Zheng (3):
      soc: sunxi: export a regmap for EMAC clock reg on A64
      dt-bindings: add binding for the Allwinner A64 DE2 bus
      bus: add bus driver for accessing Allwinner A64 DE2

Joakim Tjernlund (1):
      soc: fsl: qe: gpio: Add qe_gpio_set_multiple

Keerthy (1):
      soc: ti: wkup_m3_ipc: Add rtc_only with ddr in self refresh mode support

Kees Cook (1):
      firmware: raspberrypi: Remove VLA usage

Krzysztof Kozlowski (4):
      ata: ahci-platform: Remove support for Exynos5440
      cpufreq: exynos: Remove support for Exynos5440
      clk: samsung: Remove support for Exynos5440
      usb: host: exynos: Remove support for Exynos5440

Kunihiko Hayashi (4):
      reset: simple: export reset_simple_ops to be referred from modules
      dt-bindings: reset: uniphier: add USB3 core reset support
      reset: uniphier: add USB3 core reset control
      reset: uniphier: add reset control support for SPI

Leonard Crestez (2):
      soc: imx: gpc: Disable 6sl display power gating for ERR006287
      soc: imx6qp: Use GENPD_FLAG_ALWAYS_ON for PU errata

Li Yang (1):
      soc: fsl: cleanup Kconfig menu

Maxime Ripard (2):
      drivers: soc: sunxi: Add support for the C1 SRAM region
      soc: sunxi: Add the A13, A23 and H3 system control compatibles

Olof Johansson (14):
      Merge tag 'tee-drv-for-4.18' of git://git.linaro.org/people/jens.wiklander/linux-tee into next/drivers
      Merge tag 'soc_drivers_for_4.19' of git://git.kernel.org/.../ssantosh/linux-keystone into next/drivers
      Merge tag 'arm-soc/for-4.19/drivers' of https://github.com/Broadcom/stblinux into next/drivers
      Merge tag 'omap-for-v4.19/ti-sysc-v2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/drivers
      Merge tag 'tegra-for-4.19-memory' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'scmi-update-4.19' of git://git.kernel.org/.../sudeep.holla/linux into next/drivers
      Merge tag 'vexpress-update-4.19' of git://git.kernel.org/.../sudeep.holla/linux into next/drivers
      Merge tag 'reset-for-4.19' of git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge tag 'imx-drivers-4.19' of git://git.kernel.org/.../shawnguo/linux into next/drivers
      Merge tag 'qcom-drivers-for-4.19' of git://git.kernel.org/.../agross/linux into next/drivers
      Merge tag 'sunxi-drivers-for-4.19' of https://git.kernel.org/.../sunxi/linux into next/drivers
      Merge tag 'soc-fsl-for-4.19' of git://git.kernel.org/.../leo/linux into next/drivers
      Merge tag 'samsung-drivers-exynos5440-4.19' of https://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'v4.18-next-soc' of https://git.kernel.org/.../matthias.bgg/linux into next/drivers

Paul Kocialkowski (4):
      dt-bindings: sram: sunxi: Introduce new A10 binding for system-control
      soc: sunxi: sram: Add dt match for the A10 system-control compatible
      dt-bindings: sram: sunxi: Add A13, A20, A23 and H3 dedicated bindings
      dt-bindings: sram: sunxi: Populate valid sections compatibles

Roy Pledge (3):
      staging: fsl-mc: Move DPIO from staging to drivers/soc/fsl
      staging: fsl-mc: Remove remaining files
      soc: fsl: dpio: Convert DPIO documentation to .rst

Sahil Malhotra (1):
      tee: optee: making OPTEE_SHM_NUM_PRIV_PAGES configurable via Kconfig

Sibi Sankar (2):
      dt-bindings: reset: Add AOSS reset bindings for SDM845 SoCs
      reset: qcom: AOSS (always on subsystem) reset controller

Stefan Wahren (3):
      ARM: bcm2835: Add GET_THROTTLED firmware property
      hwmon: Add support for RPi voltage sensor
      firmware: raspberrypi: Register hwmon driver

Sudeep Holla (2):
      misc: vexpress/syscfg: Use devm_ioremap_resource() to map memory
      drivers/firmware: psci_checker: stash and use topology_core_cpumask for hotplug tests


 .../bindings/arm/bcm/brcm,brcmstb.txt           |   4 +
 .../devicetree/bindings/ata/ahci-platform.txt   |   1 -
 .../devicetree/bindings/bus/sun50i-de2-bus.txt  |  37 ++
 .../devicetree/bindings/bus/ti-sysc.txt         |   1 +
 .../bindings/clock/exynos5440-clock.txt         |  28 --
 .../bindings/cpufreq/cpufreq-exynos5440.txt     |  28 --
 .../bindings/reset/qcom,aoss-reset.txt          |  52 +++
 .../bindings/reset/uniphier-reset.txt           |  56 +++
 .../devicetree/bindings/soc/mediatek/pwrap.txt  |   1 +
 .../devicetree/bindings/sram/sunxi-sram.txt     |  31 +-
 Documentation/hwmon/raspberrypi-hwmon           |  22 +
 .../networking/dpaa2/dpio-driver.rst            |  29 +-
 Documentation/networking/dpaa2/index.rst        |   1 +
 MAINTAINERS                                     |   2 +-
 drivers/ata/ahci_platform.c                     |   1 -
 drivers/bus/Kconfig                             |  10 +
 drivers/bus/Makefile                            |   1 +
 drivers/bus/sun50i-de2.c                        |  48 ++
 drivers/bus/ti-sysc.c                           |  64 +++
 drivers/clk/samsung/Makefile                    |   1 -
 drivers/clk/samsung/clk-exynos5440.c            | 167 -------
 drivers/clk/ti/clk-7xx.c                        |   1 +
 drivers/cpufreq/Kconfig.arm                     |  14 -
 drivers/cpufreq/Makefile                        |   1 -
 drivers/cpufreq/exynos5440-cpufreq.c            | 452 -------------------
 drivers/crypto/caam/sg_sw_qm2.h                 |   2 +-
 drivers/crypto/caam/sg_sw_sec4.h                |   2 +-
 drivers/firmware/arm_scmi/perf.c                |   5 -
 drivers/firmware/psci_checker.c                 |  83 ++--
 drivers/firmware/raspberrypi.c                  |  29 +-
 drivers/hwmon/Kconfig                           |  10 +
 drivers/hwmon/Makefile                          |   1 +
 drivers/hwmon/raspberrypi-hwmon.c               | 166 +++++++
 drivers/memory/tegra/mc.c                       |  16 +-
 drivers/memory/ti-emif-pm.c                     |  33 ++
 drivers/reset/Kconfig                           |  19 +
 drivers/reset/Makefile                          |   2 +
 drivers/reset/reset-qcom-aoss.c                 | 133 ++++++
 drivers/reset/reset-simple.c                    |   1 +
 drivers/reset/reset-uniphier-usb3.c             | 171 +++++++
 drivers/reset/reset-uniphier.c                  |   9 +
 drivers/soc/bcm/brcmstb/pm/pm-arm.c             |  16 +
 drivers/soc/fsl/Kconfig                         |  15 +-
 drivers/soc/fsl/Makefile                        |   1 +
 .../fsl-mc/bus => soc/fsl}/dpio/Makefile        |   0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h      |   0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c   |   2 +-
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-service.c  |   2 +-
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c |   0
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h |   0
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c  |   2 +-
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h  |   2 +-
 drivers/soc/fsl/qbman/Kconfig                   |   2 +-
 drivers/soc/fsl/qe/Kconfig                      |   2 +-
 drivers/soc/fsl/qe/gpio.c                       |  28 ++
 drivers/soc/imx/gpc.c                           |  18 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c            |  81 +++-
 drivers/soc/sunxi/sunxi_sram.c                  |  87 +++-
 drivers/soc/ti/wkup_m3_ipc.c                    |  76 ++++
 drivers/staging/Kconfig                         |   2 -
 drivers/staging/Makefile                        |   1 -
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c  |   4 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h  |  22 +-
 drivers/staging/fsl-mc/Kconfig                  |   2 -
 drivers/staging/fsl-mc/Makefile                 |   3 -
 drivers/staging/fsl-mc/bus/Kconfig              |  16 -
 drivers/staging/fsl-mc/bus/Makefile             |   9 -
 drivers/tee/optee/Kconfig                       |   8 +
 drivers/tee/optee/core.c                        |   2 +-
 drivers/tee/optee/rpc.c                         |   2 +-
 drivers/usb/host/ehci-exynos.c                  |   7 -
 drivers/usb/host/ohci-exynos.c                  |   6 -
 include/dt-bindings/bus/ti-sysc.h               |   2 +
 include/dt-bindings/clock/dra7.h                |   1 +
 include/dt-bindings/clock/exynos5440.h          |  44 --
 include/dt-bindings/reset/qcom,sdm845-aoss.h    |  17 +
 include/linux/platform_data/ti-sysc.h           |   1 +
 include/linux/wkup_m3_ipc.h                     |   9 +
 include/soc/bcm2835/raspberrypi-firmware.h      |   1 +
 .../include => include/soc/fsl}/dpaa2-fd.h      |  12 +
 .../include => include/soc/fsl}/dpaa2-global.h  |   0
 .../include => include/soc/fsl}/dpaa2-io.h      |   0
 82 files changed, 1360 insertions(+), 880 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5440-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt
 create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
 create mode 100644 Documentation/hwmon/raspberrypi-hwmon
 rename drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt => Documentation/networking/dpaa2/dpio-driver.rst (95%)
 create mode 100644 drivers/bus/sun50i-de2.c
 delete mode 100644 drivers/clk/samsung/clk-exynos5440.c
 delete mode 100644 drivers/cpufreq/exynos5440-cpufreq.c
 create mode 100644 drivers/hwmon/raspberrypi-hwmon.c
 create mode 100644 drivers/reset/reset-qcom-aoss.c
 create mode 100644 drivers/reset/reset-uniphier-usb3.c
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
 delete mode 100644 drivers/staging/fsl-mc/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/bus/Makefile
 delete mode 100644 include/dt-bindings/clock/exynos5440.h
 create mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (97%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (100%)
