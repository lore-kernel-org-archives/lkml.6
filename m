Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 49ZuMqAgGlvSSQAAmS7hNA
	; Fri, 08 Jun 2018 06:26:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 173D1607E4; Fri,  8 Jun 2018 06:26:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6F65F608CF;
	Fri,  8 Jun 2018 06:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F65F608CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeFHG0Y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:26:24 -0400
Received: from regular1.263xmail.com ([211.150.99.140]:60335 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeFHG0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:26:21 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.157])
        by regular1.263xmail.com (Postfix) with ESMTP id A78F34B96;
        Fri,  8 Jun 2018 14:26:15 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id D2EC4412;
        Fri,  8 Jun 2018 14:26:05 +0800 (CST)
X-RL-SENDER: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: zhangqing@rock-chips.com
X-UNIQUE-TAG: <3f6f938933a6dddf59c7effdd130f069>
X-ATTACHMENT-NUM: 0
X-SENDER: zhangqing@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 19679Z2RU4D;
        Fri, 08 Jun 2018 14:26:11 +0800 (CST)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: heiko@sntech.de
Cc: sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 1/4] dt-bindings: add bindings for px30 clock controller
Date: Fri,  8 Jun 2018 14:31:56 +0800
Message-Id: <1528439519-30135-2-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528439519-30135-1-git-send-email-zhangqing@rock-chips.com>
References: <1528439519-30135-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for Rockchip cru which found on
Rockchip SoCs.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../bindings/clock/rockchip,px30-cru.txt           | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt

diff --git a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
new file mode 100644
index 000000000000..af5a45b680d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
@@ -0,0 +1,67 @@
+* Rockchip PX30 Clock and Reset Unit
+
+The PX30 clock controller generates and supplies clock to various
+controllers within the SoC and also implements a reset controller for SoC
+peripherals.
+
+Required Properties:
+
+- compatible: PMU for CRU should be "rockchip,px30-pmu-cru"
+- compatible: CRU should be "rockchip,px30-cru"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- #clock-cells: should be 1.
+- #reset-cells: should be 1.
+
+Optional Properties:
+
+- rockchip,grf: phandle to the syscon managing the "general register files"
+  If missing, pll rates are not changeable, due to the missing pll lock status.
+
+Each clock is assigned an identifier and client nodes can use this identifier
+to specify the clock which they consume. All available clocks are defined as
+preprocessor macros in the dt-bindings/clock/px30-cru.h headers and can be
+used in device tree sources. Similar macros exist for the reset sources in
+these files.
+
+External clocks:
+
+There are several clocks that are generated outside the SoC. It is expected
+that they are defined using standard clock bindings with following
+clock-output-names:
+ - "xin24m" - crystal input - required,
+ - "xin32k" - rtc clock - optional,
+ - "i2sx_clkin" - external I2S clock - optional,
+ - "gmac_clkin" - external GMAC clock - optional
+
+Example: Clock controller node:
+
+	pmucru: pmu-clock-controller@ff2bc000 {
+		compatible = "rockchip,px30-pmucru";
+		reg = <0x0 0xff2bc000 0x0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	cru: clock-controller@ff2b0000 {
+		compatible = "rockchip,px30-cru";
+		reg = <0x0 0xff2b0000 0x0 0x1000>;
+		rockchip,grf = <&grf>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+Example: UART controller node that consumes the clock generated by the clock
+  controller:
+
+	uart0: serial@ff030000 {
+		compatible = "rockchip,px30-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xff030000 0x0 0x100>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&pmucru SCLK_UART0_PMU>, <&pmucru PCLK_UART0_PMU>;
+		clock-names = "baudclk", "apb_pclk";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
-- 
1.9.1
