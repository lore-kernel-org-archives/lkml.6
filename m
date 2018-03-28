Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753020AbeC1Tfo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:35:44 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41487 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbeC1Tfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:35:43 -0400
X-Google-Smtp-Source: AIpwx4/PhsBzyqrFs1Mv6OnL2EthtkhE53ECdje58MEIqq1nT+4j/q8bWMIMfzvPzNTnCYNSJWRm14k5v+01+RePziA=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Mar 2018 21:35:41 +0200
X-Google-Sender-Auth: 5pfkWqy1dwlq6Y_ZANV2bU2bjQM
Message-ID: <CAK8P3a1+PXOUYS_yEiSLMxEJPiGPbiJ7ngvvWEiD9YLaji2jtg@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC fixes for 4.16
To: Linus Torvalds <torvalds@linux-foundation.org>,
        arm-soc <arm@kernel.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>, Tony Lindgren <tony@atomide.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-fixes

for you to fetch changes up to bbad2093dfa76f4c3dcc8ab6b89249affe72f851:

  Merge tag 'sunxi-fixes-for-4.16' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into
fixes (2018-03-27 13:12:10 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 4.16

Here are are a couple of last-minute fixes for 4.16, mostly for
regressions. As usual, the majority are device tree changes:

- USB 3 support on rk3399 didn't work and is being reverted for now

- One fix for an old suspend/resume bug on rk3399

- A few regulator related fixes on Banana Pi M2, and on imx7d-sdb

- A boot regression fix for all Aspeed SoCs failing to find
  their memory

- One more dtc warning fix

The other changes are:

- A few updates to the MAINTAINERS file

- A revert for an incorrect orion5x cleanup

- Two power management fixes for OMAP

----------------------------------------------------------------
Arnd Bergmann (8):
      Merge tag 'imx-fixes-4.16-2' of
ssh://gitolite.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'davinci-fixes-for-v4.16' of
ssh://gitolite.kernel.org/.../nsekhar/linux-davinci into fixes
      Merge tag 'mvebu-fixes-4.16-2' of
git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'v4.16-rockchip-dts32fixes-2' of
ssh://gitolite.kernel.org/.../mmind/linux-rockchip into fixes
      Merge tag 'v4.16-rockchip-dts64fixes-2' of
ssh://gitolite.kernel.org/.../mmind/linux-rockchip into fixes
      Merge tag 'tegra-for-4.17-misc' of
ssh://gitolite.kernel.org/.../tegra/linux into fixes
      Merge tag 'omap-for-v4.16/sram-fix-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'sunxi-fixes-for-4.16' of
ssh://gitolite.kernel.org/.../sunxi/linux into fixes

Bartosz Golaszewski (1):
      ARM: davinci: fix the GPIO lookup for omapl138-hawk

Douglas Anderson (1):
      arm64: dts: rockchip: Fix rk3399-gru-* s2r (pinctrl hogs, wifi reset)

Gregory CLEMENT (1):
      mailmap: Update email address for Gregory CLEMENT

Heiko Stuebner (1):
      Revert "arm64: dts: rockchip: add usb3-phy otg-port support for rk3399"

Joel Stanley (1):
      ARM: dts: aspeed: Add default memory node

Jon Hunter (1):
      MAINTAINERS: Update Tegra IOMMU maintainer

Leonard Crestez (1):
      ARM: dts: imx7d-sdb: Fix regulator-usb-otg2-vbus node name

Linus Walleij (1):
      ARM: ux500: Fix PMU IRQ regression

Maxime Ripard (1):
      MAINTAINERS: update email address for Maxime Ripard

Philipp Rossak (2):
      ARM: dts: sun6i: a31s: bpi-m2: improve pmic properties
      ARM: dts: sun6i: a31s: bpi-m2: add missing regulators

Rob Herring (1):
      ARM: dts: rockchip: Add missing #sound-dai-cells on rk3288

Tony Lindgren (2):
      ARM: OMAP: Fix dmtimer init for omap1
      ARM: OMAP: Fix SRAM W+X mapping

 .mailmap                                         |  1 +
 MAINTAINERS                                      |  7 ++++---
 arch/arm/boot/dts/aspeed-g4.dtsi                 |  5 +++++
 arch/arm/boot/dts/aspeed-g5.dtsi                 |  5 +++++
 arch/arm/boot/dts/imx7d-sdb.dts                  |  2 +-
 arch/arm/boot/dts/rk3288.dtsi                    |  2 ++
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 63
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 arch/arm/mach-davinci/board-omapl138-hawk.c      |  4 ++--
 arch/arm/mach-ux500/cpu-db8500.c                 |  3 +++
 arch/arm/plat-omap/dmtimer.c                     |  7 ++-----
 arch/arm/plat-omap/include/plat/sram.h           | 11 +----------
 arch/arm/plat-omap/sram.c                        | 36
+++++++++++++++++++++++++++++++++++-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi     | 16 +++-------------
 arch/arm64/boot/dts/rockchip/rk3399.dtsi         |  8 ++++----
 14 files changed, 128 insertions(+), 42 deletions(-)
