Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeCQKLI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 06:11:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37287 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeCQKLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 06:11:06 -0400
X-Google-Smtp-Source: AG47ELsVVSfHqfo7qik573VQhHjmrhyihIJ7NflzicPLuATaLh9vXj4AIBuU+wM7G1L9+Rb5CFZZmg==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mturquette@baylibre.com, sboyd@kernel.org, afaerber@suse.de,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        davem@davemloft.net, mchehab@kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, viresh.kumar@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 00/12] Add clock driver for Actions S900 SoC
Date: Sat, 17 Mar 2018 15:39:40 +0530
Message-Id: <20180317100952.28538-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds clock support for Actions Semi OWL series
S900 SoC with relevant clock bindings and device tree info.

Driver has been validated on Bubblegum-96 board.

Thanks,
Mani

Changes in V5:

* Changed I2C clocks to fixed factor clocks
* Fixed minor issue in S900 PLL clock names
* Fixed S900 Kconfig
* Rebased on top of 4.16-rc5

Changes in V4:

* Moved to SPDX license tag for dt-bindings
* Fixed a warning in owl-common.h
* Rebased on top of 4.16-rc3

Changes in V3:

* Completely refactored the clock driver based on sunxi-ng
  clock structure
* Removed all owl_ prefixed functions for registering the
  clock driver and used the registration functions directly
* Moved to SPDX based license tag
* Removed module dependencies from the driver
* Made I2C clocks as simple gate clocks due to the lack of
  information about factor rates
* Added Ack from Rob for DT bindings
* Sourced CMU clock for UART5

Changes in V2: (https://lkml.org/lkml/2017/11/6/840)

* Changed the directory structure to actions/ and used owl- prefix
  for sources.
* Fixed MAINTAINERS and added Andreas as Designated Reviewer (R:).
* Introduced new Kconfig for S900 code part (CONFIG_CLK_OWL_S900).
* Changed the license from GPLv2 to GPLv2+.
* Moved fixed clock sources to DT
* Changed clock-controller node name to cmu in DT
* Added clocks property to cmu node in DT
* Changed compatible property value to "actions,s900-cmu"
* Fixed example UART controller node in documentation
* Fixed tab vs space issue

Changes in V1: (https://lkml.org/lkml/2017/10/31/808)

* Addressed last year's review comments from Stephen
* https://patchwork.kernel.org/patch/9254471/

Manivannan Sadhasivam (12):
  dt-bindings: clock: Add Actions S900 clock bindings
  arm64: dts: actions: Add S900 clock management unit nodes
  arm64: dts: actions: Source CMU clock for UART5
  clk: actions: Add common clock driver support
  clk: actions: Add gate clock support
  clk: actions: Add mux clock support
  clk: actions: Add divider clock support
  clk: actions: Add factor clock support
  clk: actions: Add fixed factor clock support
  clk: actions: Add composite clock support
  clk: actions: Add pll clock support
  clk: actions: Add S900 SoC clock support

 .../devicetree/bindings/clock/actions,s900-cmu.txt |  47 ++
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  |   8 +-
 arch/arm64/boot/dts/actions/s900.dtsi              |  20 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/actions/Kconfig                        |  14 +
 drivers/clk/actions/Makefile                       |  13 +
 drivers/clk/actions/owl-common.c                   |  84 +++
 drivers/clk/actions/owl-common.h                   |  41 ++
 drivers/clk/actions/owl-composite.c                | 200 ++++++
 drivers/clk/actions/owl-composite.h                | 118 ++++
 drivers/clk/actions/owl-divider.c                  |  94 +++
 drivers/clk/actions/owl-divider.h                  |  75 +++
 drivers/clk/actions/owl-factor.c                   | 222 +++++++
 drivers/clk/actions/owl-factor.h                   |  83 +++
 drivers/clk/actions/owl-fixed-factor.c             |  81 +++
 drivers/clk/actions/owl-fixed-factor.h             |  62 ++
 drivers/clk/actions/owl-gate.c                     |  77 +++
 drivers/clk/actions/owl-gate.h                     |  73 +++
 drivers/clk/actions/owl-mux.c                      |  60 ++
 drivers/clk/actions/owl-mux.h                      |  61 ++
 drivers/clk/actions/owl-pll.c                      | 194 ++++++
 drivers/clk/actions/owl-pll.h                      |  92 +++
 drivers/clk/actions/owl-s900.c                     | 690 +++++++++++++++++++++
 drivers/clk/actions/owl-s900.h                     |  61 ++
 include/dt-bindings/clock/actions,s900-cmu.h       | 129 ++++
 26 files changed, 2594 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
 create mode 100644 drivers/clk/actions/Kconfig
 create mode 100644 drivers/clk/actions/Makefile
 create mode 100644 drivers/clk/actions/owl-common.c
 create mode 100644 drivers/clk/actions/owl-common.h
 create mode 100644 drivers/clk/actions/owl-composite.c
 create mode 100644 drivers/clk/actions/owl-composite.h
 create mode 100644 drivers/clk/actions/owl-divider.c
 create mode 100644 drivers/clk/actions/owl-divider.h
 create mode 100644 drivers/clk/actions/owl-factor.c
 create mode 100644 drivers/clk/actions/owl-factor.h
 create mode 100644 drivers/clk/actions/owl-fixed-factor.c
 create mode 100644 drivers/clk/actions/owl-fixed-factor.h
 create mode 100644 drivers/clk/actions/owl-gate.c
 create mode 100644 drivers/clk/actions/owl-gate.h
 create mode 100644 drivers/clk/actions/owl-mux.c
 create mode 100644 drivers/clk/actions/owl-mux.h
 create mode 100644 drivers/clk/actions/owl-pll.c
 create mode 100644 drivers/clk/actions/owl-pll.h
 create mode 100644 drivers/clk/actions/owl-s900.c
 create mode 100644 drivers/clk/actions/owl-s900.h
 create mode 100644 include/dt-bindings/clock/actions,s900-cmu.h

-- 
2.14.1
