Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757090AbeEJJSA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 05:18:00 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:56851 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757076AbeEJJR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 05:17:57 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 59.33.101.82
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <beb4b7268cc63c2455ea2428b48eb1ea>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 7
From: djw@t-chip.com.cn
To: linux-rockchip@lists.infradead.org
Cc: Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        David Wu <david.wu@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        William Wu <william.wu@rock-chips.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Joseph Chen <chenjh@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 4/5] arm64: dts: rockchip: Add io-domain to roc-rk3328-cc
Date: Thu, 10 May 2018 17:16:39 +0800
Message-Id: <1525943800-14095-5-git-send-email-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>

It is necessary for the io domain setting of the SoC to match
the voltage supplied by the regulators.

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v1:
- Split from V0.

 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index 246c317..b983abd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -208,6 +208,18 @@
 	};
 };
 
+&io_domains {
+	status = "okay";
+
+	vccio1-supply = <&vcc_io>;
+	vccio2-supply = <&vcc18_emmc>;
+	vccio3-supply = <&vcc_io>;
+	vccio4-supply = <&vcc_18>;
+	vccio5-supply = <&vcc_io>;
+	vccio6-supply = <&vcc_io>;
+	pmuio-supply = <&vcc_io>;
+};
+
 &pinctrl {
 	pmic {
 		pmic_int_l: pmic-int-l {
-- 
2.7.4
