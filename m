Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757072AbeEJJRw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 05:17:52 -0400
Received: from regular1.263xmail.com ([211.150.99.141]:49416 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757055AbeEJJRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 05:17:49 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 59.33.101.82
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <53f0ecd6fc30089b177a4a54f11b0bfa>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 7
From: djw@t-chip.com.cn
To: linux-rockchip@lists.infradead.org
Cc: Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        David Wu <david.wu@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        William Wu <william.wu@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 3/5] arm64: dts: rockchip: Add gpio-syscon10 to rk3328
Date: Thu, 10 May 2018 17:16:38 +0800
Message-Id: <1525943800-14095-4-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

Adding a new gpio controller named "gpio-syscon10" to rk3328, providing
access to the pins defined in the syscon GRF_SOC_CON10.

Boards using these special pins to control regulators or LEDs, can now
utilize existing drivers like gpio-regulator and leds-gpio.

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v1:
- Split from V0 and add to rk3328.dtsi for general use.

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index b8e9da1..73a822d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -309,6 +309,12 @@
 			mode-loader = <BOOT_BL_DOWNLOAD>;
 		};
 
+		gpio_syscon10: gpio-syscon10 {
+			compatible = "rockchip,gpio-syscon";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <0 0x0428 0>;
+		};
 	};
 
 	uart0: serial@ff110000 {
-- 
2.7.4
