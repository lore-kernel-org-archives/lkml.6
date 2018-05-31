Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932753AbeEaD2s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:28:48 -0400
Received: from regular1.263xmail.com ([211.150.99.130]:58855 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932643AbeEaD2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:28:35 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 183.57.25.242
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <f0213d186c9730ad87148b44456da18f>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: djw@t-chip.com.cn
To: linux-rockchip@lists.infradead.org
Cc: Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>,
        Liang Chen <cl@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Wu <david.wu@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        William Wu <william.wu@rock-chips.com>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>,
        Sugar Zhang <sugar.zhang@rock-chips.com>, linux-kernel@vger.kernel.org,
        Joseph Chen <chenjh@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 0/5] Add sdmmc UHS support to ROC-RK3328-CC board.
Date: Thu, 31 May 2018 11:27:48 +0800
Message-Id: <1527737273-8387-1-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>


Hi all, this is an attemp to add sdmmc UHS support to the
ROC-RK3328-CC board.

This patch series adds a new compatible `rockchip,rk3328-gpio-mute` to
the gpio-syscon driver for the access of the GPIO_MUTE pin in rk3328.

A new gpio controller named `gpio_mute` is defined in
rk3328.dtsi and so that all rk3328 boards has access to it.

The ROC-RK3328-CC board use the new gpio <&gpio_mute 0> in
gpio-regulator to control the signal voltage of the sdmmc.
It is essential for UHS support which requires 1.8V signal voltage.

Many thanks to the Linux people!

Changes in v3:
- Change from general gpio-syscon to specific rk3328-gpio-mute
- Use dedicated "rockchip,rk3328-gpio-mute" driver
- Use <&gpio_mute 0> instead of <&gpio_mute 1> to refer to the GPIO_MUTE pin.

Changes in v2:
- Rename gpio_syscon10 to gpio_mute in doc
- Rename gpio_syscon10 to gpio_mute in rk3328.dtsi
- Rename gpio_syscon10 to gpio_mute in rk3328-roc-cc.dts

Changes in v1:
- New: allow fetching syscon from parent node in gpio-syscon driver
- Refactured for general gpio-syscon usage for Rockchip SoCs.
- Add doc rockchip,gpio-syscon.txt
- Split from V0 and add to rk3328.dtsi for general use.
- Split from V0.
- Split into small patches
- Sort dts properties in sdmmc node

Heiko Stuebner (1):
  gpio: syscon: allow fetching syscon from parent node

Levin Du (4):
  gpio: syscon: rockchip: add GPIO_MUTE support for rk3328
  arm64: dts: rockchip: Add GPIO_MUTE pin support to rk3328
  arm64: dts: rockchip: Add io-domain to roc-rk3328-cc
  arm64: dts: rockchip: Add sdmmc UHS support for roc-rk3328-cc

 .../bindings/gpio/rockchip,rk3328-gpio-mute.txt    | 28 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     | 34 ++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  7 +++++
 drivers/gpio/gpio-syscon.c                         | 33 +++++++++++++++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt

-- 
2.7.4
