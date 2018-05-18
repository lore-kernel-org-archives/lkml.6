Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeERDxa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 23:53:30 -0400
Received: from regular1.263xmail.com ([211.150.99.133]:34506 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbeERDwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 23:52:47 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 183.57.25.242
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <befce59daba9141af918f024adc73528>
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
Subject: [PATCH v2 3/5] arm64: dts: rockchip: Add gpio-mute to rk3328
Date: Fri, 18 May 2018 11:52:06 +0800
Message-Id: <1526615528-9707-3-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526615528-9707-1-git-send-email-djw@t-chip.com.cn>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn>
 <1526615528-9707-1-git-send-email-djw@t-chip.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

Adding a new gpio controller named "gpio-mute" to rk3328, providing
access to the GPIO_MUTE pin defined in the syscon GRF_SOC_CON10.

The GPIO_MUTE pin is referred to as <&gpio-mute 1>.

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v2:
- Rename gpio_syscon10 to gpio_mute in rk3328.dtsi

Changes in v1:
- Split from V0 and add to rk3328.dtsi for general use.

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index b8e9da1..5ba29d3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -309,6 +309,13 @@
 			mode-loader = <BOOT_BL_DOWNLOAD>;
 		};
 
+		/* The GPIO_MUTE pin is referred to as <&gpio-mute 1>.*/
+		gpio_mute: gpio-mute {
+			compatible = "rockchip,gpio-syscon";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <0 0x0428 0>;
+		};
 	};
 
 	uart0: serial@ff110000 {
-- 
2.7.4
