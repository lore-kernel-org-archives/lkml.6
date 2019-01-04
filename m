Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3A6C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75552173B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="X1PU8KsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfADWvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 17:51:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39987 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfADWvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 17:51:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so26432576lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 14:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=yn+Vwugo+7tGMWoXuDezr+r9XD7XKmVUROF32R3gMkQ=;
        b=X1PU8KsBgykY5expaDJx6NjrPlmGcOQ+iM7qfRVB783wnnQD+WQ0dYNMgDoH8dBPvj
         bbUndw+grAfkb0+6NX0zlG1Yo3A6ot/MCplemKjSEWrm3FDppIhGcBiYUPOZoqxV2x86
         pWTgs2KCTpbeSevfnwFpvCLHgaq+l42YPgJ+Z6YZ/K5hITo7HX0+5qONK62YC+RjfmAq
         IDrXwyKUgaxt7hrGaqx9qkS6HgdJFsQCazPdVhz6FuqbSjNx8Jxdi8dWLO39EV5fH2nG
         mN+H4OiYqW2J/4HMnJJDFWO9RMrdbGVmDGhBWqlZBa8ZadDl3f7iykpthPpZQKUKdR6s
         H/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=yn+Vwugo+7tGMWoXuDezr+r9XD7XKmVUROF32R3gMkQ=;
        b=LFjHc8XOdxOkgCRlI4Fr5JB1W4EPLS14HGUCEdeDg0B8sBGVROc2SJOqWy8AybxLhP
         4uY79ARLoqdTlwyuNf2ZuYMOXUssrk5rRSYKCf2Szw9IskGJN3wEaC+/MDhOCm26H93e
         CV1q24Ttf67dqCL+6aZArEo0kSxYv+PlTs5TPV3OFrgPrEf6IkVrt83KIggKQu3nJ3mx
         ncGGFww8YdMn38I50XnOubwl8EODJuwDL46NzCAozCxSPGRZoxZDhQVVTH/bPv2bmzEa
         TUMS8vV4suMurAcMCbmW9VBmB6j6JrAT88IauHhHxCH6C8wZDJpwJApnpE1ivxXCgwih
         HQGA==
X-Gm-Message-State: AA+aEWYI3r0N72pupP8x+5J8RwM2L5IK/8EgygoZ8h2o9jnLf1huNZH2
        CBBdo7xWDbGNvpE+zVjgNFgn7NsiZOJyVQ==
X-Google-Smtp-Source: AFSGD/VwJYMvhHvF8bRmn9KqyErVdzGk9jJ49FAVYgiEhSA7fAil56ywNo4hku0V2uGuStcsYDcWgA==
X-Received: by 2002:a19:5ad0:: with SMTP id y77mr28301810lfk.109.1546642279911;
        Fri, 04 Jan 2019 14:51:19 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id y81-v6sm12743856lje.30.2019.01.04.14.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 14:51:18 -0800 (PST)
Date:   Fri, 4 Jan 2019 14:51:07 -0800
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC late updates
Message-ID: <20190104225107.hkl2nzdfdewg3lbu@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As mentioned with the regular pull requests, here's a bit more material for
this merge window. See below for details. 


Thanks!

-Olof


A few updates that we merged late but are low risk for regressions for
other platforms (and a few other straggling patches):

- I mis-tagged the 'drivers' branch, and missed 3 patches. Merged in
  here. They're for a driver for the PL353 SRAM controller and a build
  fix for the qualcomm scm driver.
- A new platform, RDA Micro RDA8810PL (Cortex-A5 w/ integrated Vivante
  GPU, 256MB RAM, Wifi). This includes some acked platform-specific
  drivers (serial, etc). This also include DTs for two boards with this
  SoC, OrangePi 2G and OrangePi i86.
- i.MX8 is another new platform (NXP, 4x Cortex-A53 + Cortex-M4, 4K
  video playback offload). This is the first i.MX 64-bit SoC.
- Some minor updates to Samsung boards (adding a few peripherals in DTs).
- Small rework for SMP bootup on STi platforms.
- A couple of TEE driver fixes.
- A couple of new config options (bcm2835 thermal, Uniphier MDMAC)
  enabled in defconfigs.

----------------------------------------------------------------

The following changes since commit 0b2c8f8b6b0c7530e2866c95862546d0da2057b0:

  i915: fix missing user_access_end() in page fault exception case

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-late

for you to fetch changes up to 00f8ccd0c95f4e604297057a5bccec86c0903d14:

  Merge branch 'next/drivers' into next/late

----------------------------------------------------------------

Andreas Färber (4):
      dt-bindings: Add RDA Micro vendor prefix
      dt-bindings: arm: Document RDA8810PL and reference boards
      ARM: Prepare RDA8810PL SoC
      dt-bindings: serial: Document RDA Micro UART

Arnd Bergmann (2):
      Merge tag 'zynq-soc-for-v5.0' of https://github.com/Xilinx/linux-xlnx into next/drivers
      Merge tag 'qcom-drivers-for-4.21-2' of git://git.kernel.org/.../agross/linux into next/drivers

Baruch Siach (2):
      arm64: dts: imx8mq: add watchdog devices
      arm64: dts: imx8mq-evk: enable watchdog

Jonathan Marek (1):
      firmware: qcom: scm: fix compilation error when disabled

Kamil Konieczny (1):
      arm64: dts: exynos: Add IMEM clock controller to Exynos5433

Lucas Stach (4):
      arm64: add basic Kconfig symbols for i.MX8
      arm64: add basic DTS for i.MX8MQ
      arm64: add support for i.MX8M EVK board
      MAINTAINERS: add i.MX8 DT path to i.MX architecture

Manivannan Sadhasivam (7):
      ARM: dts: Add devicetree for RDA8810PL SoC
      ARM: dts: Add devicetree for OrangePi 2G IoT board
      ARM: dts: Add devicetree for OrangePi i96 board
      ARM: dts: rda8810pl: Add timer support
      ARM: dts: rda8810pl: Add interrupt support for UART
      tty: serial: Add RDA8810PL UART driver
      MAINTAINERS: Add entry for RDA Micro SoC architecture

Marek Szyprowski (1):
      arm64: dts: exynos: Add Bluetooth chip to TM2(e) boards

Masahiro Yamada (1):
      ARM: multi_v7_defconfig: enable CONFIG_UNIPHIER_MDMAC

Naga Sureshkumar Relli (2):
      dt-bindings: memory: Add pl353 smc controller devicetree binding information
      memory: pl353: Add driver for arm pl353 static memory controller

Olof Johansson (7):
      Merge tag 'tee-subsys-fix-for-4.21' of https://git.linaro.org/people/jens.wiklander/linux-tee into next/late
      Merge tag 'tee-subsys-optee-for-4.21' of https://git.linaro.org/people/jens.wiklander/linux-tee into next/late
      Merge tag 'imx8mq-4.21' of git://git.kernel.org/.../shawnguo/linux into next/late
      Merge tag 'samsung-dt-4.21-2' of https://git.kernel.org/.../krzk/linux into next/late
      Merge tag 'samsung-dt64-4.21-2' of https://git.kernel.org/.../krzk/linux into next/late
      Merge tag 'sti-soc-for-v4.21-round1' of git://git.kernel.org/.../pchotard/sti into next/late
      Merge branch 'next/drivers' into next/late

Patrice Chotard (1):
      ARM: sti: remove pen_release and boot_lock

Shawn Guo (1):
      Merge commit '1cf3817bf1f52e57b3f5eb0413ee0d7f0c2e9829' into imx8mq/dt

Stefan Wahren (1):
      arm64: defconfig: Re-enable bcm2835-thermal driver

Victor Chong (1):
      tee: optee: log message if dynamic shm is enabled

Zhizhou Zhang (1):
      tee: optee: avoid possible double list_del()


 Documentation/admin-guide/kernel-parameters.txt |   6 +
 Documentation/devicetree/bindings/arm/rda.txt   |  17 +
 .../bindings/memory-controllers/pl353-smc.txt   |  47 ++
 .../bindings/serial/rda,8810pl-uart.txt         |  17 +
 .../devicetree/bindings/vendor-prefixes.txt     |   1 +
 MAINTAINERS                                     |  15 +
 arch/arm/Kconfig                                |   2 +
 arch/arm/Makefile                               |   1 +
 arch/arm/boot/dts/Makefile                      |   3 +
 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts |  50 ++
 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts    |  50 ++
 arch/arm/boot/dts/rda8810pl.dtsi                |  99 +++
 arch/arm/configs/multi_v7_defconfig             |   1 +
 arch/arm/mach-rda/Kconfig                       |   7 +
 arch/arm/mach-rda/Makefile                      |   1 +
 arch/arm/mach-sti/Makefile                      |   2 +-
 arch/arm/mach-sti/headsmp.S                     |  43 -
 arch/arm/mach-sti/platsmp.c                     |  88 +-
 arch/arm64/Kconfig.platforms                    |   8 +
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi  |  14 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi      |  15 +
 arch/arm64/boot/dts/freescale/Makefile          |   2 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts    | 303 +++++++
 arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h  | 623 ++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi       | 416 ++++++++++
 arch/arm64/configs/defconfig                    |   1 +
 drivers/memory/Kconfig                          |   9 +
 drivers/memory/Makefile                         |   1 +
 drivers/memory/pl353-smc.c                      | 463 +++++++++++
 drivers/tee/optee/core.c                        |   3 +
 drivers/tee/optee/supp.c                        |  13 +-
 drivers/tty/serial/Kconfig                      |  19 +
 drivers/tty/serial/Makefile                     |   1 +
 drivers/tty/serial/rda-uart.c                   | 831 +++++++++++++++++++
 include/linux/pl353-smc.h                       |  30 +
 include/linux/qcom_scm.h                        |   3 +
 include/uapi/linux/serial_core.h                |   3 +
 37 files changed, 3084 insertions(+), 124 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/rda.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
 create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts
 create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi
 create mode 100644 arch/arm/mach-rda/Kconfig
 create mode 100644 arch/arm/mach-rda/Makefile
 delete mode 100644 arch/arm/mach-sti/headsmp.S
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq.dtsi
 create mode 100644 drivers/memory/pl353-smc.c
 create mode 100644 drivers/tty/serial/rda-uart.c
 create mode 100644 include/linux/pl353-smc.h
