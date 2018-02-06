Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeBFH2M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 02:28:12 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6206 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbeBFH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 02:28:04 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 05 Feb 2018 23:28:03 -0800
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <talho@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 0/7] Initial support for NVIDIA Tegra194
Date: Tue, 6 Feb 2018 09:22:30 +0200
Message-ID: <1517901757-15353-1-git-send-email-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.1.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

this series adds initial support for the NVIDIA Tegra194 "Xavier"
system-on-chip. Initially UART, I2C, SDMMC, as well as the PMIC
are supported, allowing booting to a console.

The changes consist almost completely of the new device trees,
however some fixes are required in the BPMP driver to support the
new channel layout in Tegra194.

The series has been tested on Tegra186 (Jetson TX2) and Tegra194
(P2972).

Cheers,
Mikko

Mikko Perttunen (7):
  firmware: tegra: Simplify channel management
  soc/tegra: Add Tegra194 SoC configuration option
  soc/tegra: pmc: Add Tegra194 compatibility string
  dt-bindings: tegra: Add missing chips and NVIDIA boards
  dt-bindings: tegra: Add documentation for nvidia,tegra194-pmc
  arm64: tegra: Add Tegra194 chip device tree
  arm64: tegra: Add device tree for the Tegra194 P2972-0000 board

 Documentation/devicetree/bindings/arm/tegra.txt    |  16 +
 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |   2 +
 arch/arm64/boot/dts/nvidia/Makefile                |   1 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     | 248 ++++++++
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts |  16 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           | 342 +++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/firmware/tegra/bpmp.c                      | 142 ++---
 drivers/soc/tegra/Kconfig                          |  10 +
 drivers/soc/tegra/pmc.c                            |   1 +
 include/dt-bindings/clock/tegra194-clock.h         | 664 +++++++++++++++++++++
 include/dt-bindings/gpio/tegra194-gpio.h           |  59 ++
 include/dt-bindings/power/tegra194-powergate.h     |  49 ++
 include/dt-bindings/reset/tegra194-reset.h         | 166 ++++++
 include/soc/tegra/bpmp.h                           |   4 +-
 15 files changed, 1641 insertions(+), 80 deletions(-)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra194.dtsi
 create mode 100644 include/dt-bindings/clock/tegra194-clock.h
 create mode 100644 include/dt-bindings/gpio/tegra194-gpio.h
 create mode 100644 include/dt-bindings/power/tegra194-powergate.h
 create mode 100644 include/dt-bindings/reset/tegra194-reset.h

-- 
2.1.4
