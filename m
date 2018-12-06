Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C3CC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC0F20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC0F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeLFRQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:16:33 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51735 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbeLFRQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:16:07 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EBD8120C6F; Thu,  6 Dec 2018 18:16:03 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id C3C59206FF;
        Thu,  6 Dec 2018 18:16:03 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH v2 5/5] arm64: dts: marvell: Add cpu clock node on Armada 7K/8K
Date:   Thu,  6 Dec 2018 18:15:16 +0100
Message-Id: <20181206171516.15891-6-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206171516.15891-1-gregory.clement@bootlin.com>
References: <20181206171516.15891-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu clock node on AP

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi | 4 ++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
index 01ea662afba8..c2c81d4e2d38 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
@@ -20,24 +20,28 @@
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x000>;
 			enable-method = "psci";
+			clocks = <&cpu_clk 0>;
 		};
 		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x001>;
 			enable-method = "psci";
+			clocks = <&cpu_clk 0>;
 		};
 		cpu2: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x100>;
 			enable-method = "psci";
+			clocks = <&cpu_clk 1>;
 		};
 		cpu3: cpu@101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x101>;
 			enable-method = "psci";
+			clocks = <&cpu_clk 1>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 7d94c1fa592a..a430e884b1a3 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -263,6 +263,12 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 
+				cpu_clk: clock-cpu {
+					compatible = "marvell,ap806-cpu-clock";
+					clocks = <&ap_clk 0>, <&ap_clk 1>;
+					#clock-cells = <1>;
+				};
+
 				ap_thermal: thermal-sensor@80 {
 					compatible = "marvell,armada-ap806-thermal";
 					reg = <0x80 0x10>;
-- 
2.19.2

