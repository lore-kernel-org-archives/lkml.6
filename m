Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 290E0C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE09208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE09208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965357AbeFOCRK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:17:10 -0400
Received: from regular1.263xmail.com ([211.150.99.135]:47497 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936083AbeFOCRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:17:08 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.205])
        by regular1.263xmail.com (Postfix) with ESMTP id 44CEB1E377;
        Fri, 15 Jun 2018 10:17:03 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 6D8AC345;
        Fri, 15 Jun 2018 10:16:55 +0800 (CST)
X-RL-SENDER: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: zhangqing@rock-chips.com
X-UNIQUE-TAG: <df6bb58db74b610a65042e7ea833c114>
X-ATTACHMENT-NUM: 0
X-SENDER: zhangqing@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 1616213MJI2;
        Fri, 15 Jun 2018 10:16:59 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 1/4] dt-bindings: add bindings for px30 clock controller
Date:   Fri, 15 Jun 2018 10:16:48 +0800
Message-Id: <1529029011-15021-2-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
References: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for Rockchip cru which found on
Rockchip SoCs.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../bindings/clock/rockchip,px30-cru.txt           | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt

diff --git a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
new file mode 100644
index 000000000000..1077692d6489
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
@@ -0,0 +1,66 @@
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
+	pmucru: clock-controller@ff2bc000 {
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
+	};
+
-- 
1.9.1


