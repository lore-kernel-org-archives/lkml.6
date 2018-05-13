Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeEMPnS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 11:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751882AbeEMPnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 11:43:14 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/5] ARM: dts: exynos: Stuff for v4.18
Date: Sun, 13 May 2018 17:42:36 +0200
Message-Id: <20180513154238.22508-4-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180513154238.22508-1-krzk@kernel.org>
References: <20180513154238.22508-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.18

for you to fetch changes up to 83cb529b2ef4f3446e60e75522d76fdaaea4724c:

  ARM: dts: exynos: Update x and y properties for mms114 touchscreen (2018-05-13 15:15:49 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v4.18

1. Add support for USB OTG port on Origen board.
2. Allow earlycon on Rinato board.
3. Cleanup from obsolete properties.
4. Fix DTC warnings.
5. Remove Exynos5440 entirely.
6. Add mem-2-mem Scaler devices.

----------------------------------------------------------------
Andi Shyti (1):
      ARM: dts: exynos: Update x and y properties for mms114 touchscreen

Andrzej Pietrasiewicz (1):
      ARM: dts: exynos: Add mem-2-mem Scaler devices

Krzysztof Kozlowski (11):
      ARM: dts: exynos: Move syscon poweroff and restart nodes under the PMU
      ARM: dts: exynos: Fix invalid node referenced by i2c20 alias in Peach Pit and Pi
      ARM: dts: exynos: Remove unnecessary address/size properties in Midas boards
      ARM: dts: exynos: Remove unnecessary address/size properties in Origen
      ARM: dts: exynos: Remove regulators node container in Origen and N710x
      ARM: dts: exynos: Bring order in fixed-regulators naming in Midas boards
      ARM: dts: exynos: Remove unnecessary address/size properties in dp-controller of Exynos5
      ARM: dts: exynos: Remove Exynos5440
      ARM: dts: s3c24xx: Remove skeleton.dtsi and fix DTC warning for /memory
      ARM: dts: s3c24xx: Fix unnecessary address/size cells DTC warnings
      ARM: dts: s3c64xx: Remove skeleton.dtsi and fix DTC warnings for /memory

Marek Szyprowski (3):
      ARM: dts: exynos: Add support for USB OTG port on Origen board
      ARM: dts: exynos: Add serial path for Rinato board to get earlycon support
      ARM: dts: exynos: Remove obsolete clock properties from power domains

Mathieu Malaterre (1):
      ARM: dts: exynos/s3c: Remove leading 0x and 0s from bindings notation

 .../bindings/arm/samsung/samsung-boards.txt        |   2 -
 arch/arm/boot/dts/Makefile                         |   2 -
 arch/arm/boot/dts/exynos-syscon-restart.dtsi       |  28 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |   4 +
 arch/arm/boot/dts/exynos3250.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   3 +-
 arch/arm/boot/dts/exynos4210-origen.dts            |  34 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |   4 +-
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi        |  36 +--
 arch/arm/boot/dts/exynos4412-midas.dtsi            |  86 +++--
 arch/arm/boot/dts/exynos4412-n710x.dts             |  16 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |   2 +-
 arch/arm/boot/dts/exynos4412.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5.dtsi                     |   3 -
 arch/arm/boot/dts/exynos5250.dtsi                  |   7 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   1 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   4 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |  87 +++--
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |   2 +-
 arch/arm/boot/dts/exynos5440-sd5v1.dts             |  42 ---
 arch/arm/boot/dts/exynos5440-ssdk5440.dts          |  81 -----
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |  20 --
 arch/arm/boot/dts/exynos5440-trip-points.dtsi      |  21 --
 arch/arm/boot/dts/exynos5440.dtsi                  | 355 ---------------------
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   4 +-
 arch/arm/boot/dts/s3c2416-smdk2416.dts             |   5 +-
 arch/arm/boot/dts/s3c2416.dtsi                     |  11 +-
 arch/arm/boot/dts/s3c24xx.dtsi                     |   4 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts             |   3 +-
 arch/arm/boot/dts/s3c6410-smdk6410.dts             |   3 +-
 arch/arm/boot/dts/s3c64xx.dtsi                     |   4 +-
 31 files changed, 183 insertions(+), 695 deletions(-)
 delete mode 100644 arch/arm/boot/dts/exynos5440-sd5v1.dts
 delete mode 100644 arch/arm/boot/dts/exynos5440-ssdk5440.dts
 delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440.dtsi
