Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932770AbeEaD2u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:28:50 -0400
Received: from regular1.263xmail.com ([211.150.99.136]:44747 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932721AbeEaD2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:28:45 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 183.57.25.242
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <e0946f25687eca6800e612c185896912>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
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
Subject: [PATCH v3 3/5] arm64: dts: rockchip: Add GPIO_MUTE pin support to rk3328
Date: Thu, 31 May 2018 11:27:51 +0800
Message-Id: <1527737273-8387-4-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527737273-8387-1-git-send-email-djw@t-chip.com.cn>
References: <1527737273-8387-1-git-send-email-djw@t-chip.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

Adding a new gpio controller named "gpio_mute" to rk3328, providing
access to the GPIO_MUTE pin, which is manupulated by the GRF_SOC_CON10
register.

The GPIO_MUTE pin is referred to as <&gpio_mute 0>.

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v3:
- Use dedicated "rockchip,rk3328-gpio-mute" driver

Changes in v2:
- Rename gpio_syscon10 to gpio_mute in rk3328.dtsi

Changes in v1:
- Split from V0 and add to rk3328.dtsi for general use.

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index be2bfbc..2ee0fa3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -309,6 +309,13 @@
 			mode-loader = <BOOT_BL_DOWNLOAD>;
 		};
 
+		/* Use <&gpio_mute 0> to refer to GPIO_MUTE pin */
+		gpio_mute: gpio-mute {
+			compatible = "rockchip,rk3328-gpio-mute";
+			gpio-controller;
+			#gpio-cells = <2>;
+			status = "disabled";
+		};
 	};
 
 	uart0: serial@ff110000 {
-- 
2.7.4
