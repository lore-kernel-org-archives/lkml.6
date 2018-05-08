Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753978AbeEHCtY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:49:24 -0400
Received: from regular1.263xmail.com ([211.150.99.141]:36568 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753780AbeEHCtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:49:21 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 59.33.107.187
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <6fbff3d9f1e6c6c76352005b04fb91ae>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 7
From: djw@t-chip.com.cn
To: linux-rockchip@lists.infradead.org
Cc: Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        devicetree@vger.kernel.org, David Wu <david.wu@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, Liang Chen <cl@rock-chips.com>,
        William Wu <william.wu@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>, Joseph Chen <chenjh@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v0 0/2] Add sdmmc UHS support to ROC-RK3328-CC board
Date: Tue,  8 May 2018 10:48:22 +0800
Message-Id: <1525747704-8537-1-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

Hi all,

This is an attemp to add sdmmc UHS support to the ROC-RK3328-CC board.

It adds a new compatible `rockchip,rk3328-gpio-syscon10` to the gpio-syscon
driver,  so that a new gpio controller named `gpio_syscon10` can be defined
and used in the regulator-gpio. This regulator controls the signal voltage of the
sdmmc. It is essential for UHS support which requires 1.8V signal voltage.


Levin Du (2):
  gpio: syscon: Add gpio-syscon for rk3328
  arm64: dts: rockchip: Add sdmmc UHS support for roc-rk3328-cc

 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 36 ++++++++++++++++++++++++++
 drivers/gpio/gpio-syscon.c                     | 32 +++++++++++++++++++++++
 2 files changed, 68 insertions(+)

-- 
2.7.4
