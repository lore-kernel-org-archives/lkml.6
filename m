Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbeCFSCA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:02:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753986AbeCFSB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:01:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5F7217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/4] ARM: dts: exynos: DTS for v4.17
Date: Tue,  6 Mar 2018 19:01:22 +0100
Message-Id: <20180306180124.8987-3-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180306180124.8987-1-krzk@kernel.org>
References: <20180306180124.8987-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.17

for you to fetch changes up to 6f4870753f29edf7dc39444246f9e39987b8b158:

  ARM: dts: exynos: Fix IOMMU support for GScaler devices on Exynos5250 (2018-03-05 19:11:40 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v4.17

1. Add WiFi to Artik 5 board.
2. Remove unused samsung_k3pe0e000b memory DTSI.
3. Add few remaining SPDX license identifiers.
4. Refactor Exynos4 by using labels for overriding/extending nodes and
   moving respective nodes under the 'soc' node.
5. Add three new Exynos4412-based boards: GT-I9300 (Samsung Galaxy S3),
   GT-I9305 (Samsung Galaxy S3 LTE) and GT-N7100/N7105 (Samsung Note 2).
   They are based heavily on existing Trats2 board.
6. Fix PMIC interrupts on Trats board.
7. Fix IOMMU for GScaler devices on Exynos5250.
8. Minor fixes in unit addresses pointed by DTC.
9. Minor cleanups from unused properties and duplicated code.

----------------------------------------------------------------
Krzysztof Kozlowski (6):
      ARM: dts: samsung: Remove unused samsung_k3pe0e000b
      ARM: dts: exynos: Add SPDX license identifiers
      ARM: dts: exynos: Remove duplicated inclusion of syscon restart nodes on Exynos5410
      ARM: dts: exynos: Fix address of PPMU ACP on Exynos4210
      ARM: dts: exynos: Fix unit addresses of PDMA nodes in Exynos5410
      ARM: dts: exynos: Remove unused bypass-smu property from Xyref5260

Maciej Purski (14):
      ARM: dts: exynos: Use pinctrl labels in exynos4210-pinctrl
      ARM: dts: exynos: Use pinctrl labels in exynos4412-pinctrl
      ARM: dts: exynos: Use labels instead of full paths in exynos4210
      ARM: dts: exynos: Use labels instead of full paths in exynos4210-trats
      ARM: dts: exynos: Use labels instead of full paths in exynos4210-universal_c210
      ARM: dts: exynos: Use label instead of full path in exynos4412
      ARM: dts: exynos: Use label instead of full path in exynos4412-odroid-common
      ARM: dts: exynos: Use labels instead of full paths in exynos4412-trats2
      ARM: dts: exynos: Use label instead of full path in exynos4412-itop-elite
      ARM: dts: exynos: Use pmu label in exynos4412
      ARM: dts: exynos: Add soc node to exynos5440
      ARM: dts: exynos: Add soc node to exynos4
      ARM: dts: exynos: Add soc node to exynos4210
      ARM: dts: exynos: Add soc node to exynos4412

Marek Szyprowski (3):
      ARM: dts: exynos: Cleanup power domain nodes in exynos3250.dtsi
      ARM: dts: exynos: Add missing interrupts property to PMIC on Trats board
      ARM: dts: exynos: Fix IOMMU support for GScaler devices on Exynos5250

Michael Lyle (1):
      ARM: dts: exynos: Add support for wlan to Artik 5

Simon Shields (4):
      dt-bindings: samsung: Document bindings for Midas family boards
      ARM: dts: exynos: Split Trats2 DTS in preparation for Midas boards
      ARM: dts: exynos: Add Samsung's Exynos4412-based Midas boards
      ARM: dts: exynos: Add touchscreen node to Exynos4412 N710x

Viresh Kumar (1):
      ARM: dts: exynos: Remove "cooling-{min|max}-level" for CPU nodes

 .../bindings/arm/samsung/samsung-boards.txt        |    4 +
 MAINTAINERS                                        |    1 -
 arch/arm/boot/dts/Makefile                         |    3 +
 arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi  |    5 +-
 arch/arm/boot/dts/exynos-syscon-restart.dtsi       |    5 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi           |   36 +
 arch/arm/boot/dts/exynos3250.dtsi                  |   15 +-
 arch/arm/boot/dts/exynos4.dtsi                     | 1719 +++++++++---------
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          | 1680 +++++++++--------
 arch/arm/boot/dts/exynos4210-trats.dts             |   74 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  115 +-
 arch/arm/boot/dts/exynos4210.dtsi                  |  610 +++----
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi        |  140 ++
 arch/arm/boot/dts/exynos4412-i9300.dts             |   22 +
 arch/arm/boot/dts/exynos4412-i9305.dts             |   20 +
 arch/arm/boot/dts/exynos4412-itop-elite.dts        |   16 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi            | 1308 +++++++++++++
 arch/arm/boot/dts/exynos4412-n710x.dts             |   77 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   12 +-
 arch/arm/boot/dts/exynos4412-pinctrl.dtsi          | 1914 ++++++++++----------
 arch/arm/boot/dts/exynos4412-tiny4412.dts          |    7 +-
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi  |    6 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            | 1396 +-------------
 arch/arm/boot/dts/exynos4412.dtsi                  |  868 ++++-----
 arch/arm/boot/dts/exynos5250.dtsi                  |   10 +-
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |    1 -
 arch/arm/boot/dts/exynos5410.dtsi                  |    9 +-
 arch/arm/boot/dts/exynos5420-cpus.dtsi             |   16 -
 arch/arm/boot/dts/exynos5422-cpus.dtsi             |   16 -
 arch/arm/boot/dts/exynos5440.dtsi                  |  514 +++---
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |    5 +-
 arch/arm/boot/dts/exynos5800.dtsi                  |    5 +-
 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi          |   68 -
 33 files changed, 5416 insertions(+), 5281 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4412-i9300.dts
 create mode 100644 arch/arm/boot/dts/exynos4412-i9305.dts
 create mode 100644 arch/arm/boot/dts/exynos4412-midas.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4412-n710x.dts
 delete mode 100644 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi
