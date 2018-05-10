Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757016AbeEJJRk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 05:17:40 -0400
Received: from regular1.263xmail.com ([211.150.99.140]:43897 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756872AbeEJJRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 05:17:30 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 59.33.101.82
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <0b9114c7d88862bba9b8ecc2d7d6ffca>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 7
From: djw@t-chip.com.cn
To: linux-rockchip@lists.infradead.org
Cc: Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        David Wu <david.wu@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Liang Chen <cl@rock-chips.com>, William Wu <william.wu@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sugar Zhang <sugar.zhang@rock-chips.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>, Joseph Chen <chenjh@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/5] Add sdmmc UHS support to ROC-RK3328-CC board.
Date: Thu, 10 May 2018 17:16:35 +0800
Message-Id: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

Hi all, this is an attemp to add sdmmc UHS support to the
ROC-RK3328-CC board.

This patch series adds a new compatible `rockchip,gpio-syscon` to
the gpio-syscon driver for general Rockchip SoC usage..

A new gpio controller named `gpio_syscon10` is defined in
rk3328.dtsi so that all rk3328 boards has access to it.

The ROC-RK3328-CC board use the new gpio <&gpio_syscon10 1> in
gpio-regulator to control the signal voltage of the sdmmc.
It is essential for UHS support which requires 1.8V signal voltage.

Many thanks to Heiko's great advice!

Changes in v1:
- Refactured for general gpio-syscon usage for Rockchip SoCs.
- Add doc rockchip,gpio-syscon.txt .
- Split into small patches.
- Add gpio-syscon10 to rk3328 for general use.
- Sort dts properties in sdmmc node.

Heiko Stuebner (1):
  gpio: syscon: allow fetching syscon from parent node

Levin Du (4):
  gpio: syscon: Add gpio-syscon for rockchip
  arm64: dts: rockchip: Add gpio-syscon10 to rk3328
  arm64: dts: rockchip: Add io-domain to roc-rk3328-cc
  arm64: dts: rockchip: Add sdmmc UHS support for roc-rk3328-cc

 .../bindings/gpio/rockchip,gpio-syscon.txt         | 41 ++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     | 30 ++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  6 ++++
 drivers/gpio/gpio-syscon.c                         | 32 +++++++++++++++++
 4 files changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt

-- 
2.7.4
