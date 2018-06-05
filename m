Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeFEE4y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 00:56:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36928 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeFEE4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 00:56:52 -0400
X-Google-Smtp-Source: ADUXVKJsyZtOZkjK3LCrcYInSdiBrQsuTV9RQffR9QWlCL8K4jyPw61CVebcufNTFisOfBBA60cfxg==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] arm: dts: sun8i-h3: Add missing cooling device properties for CPUs
Date: Tue,  5 Jun 2018 10:17:48 +0530
Message-Id: <d894f425b7c32bce4dc4a982db8f4dface2db31d.1528173943.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <20180601151701.sshwfdbflic6mybv@flea>
References: <20180601151701.sshwfdbflic6mybv@flea>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Fix other missing properties (clocks, clock-names) as well to make it all
work.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2: Separated patch for h3.

 arch/arm/boot/dts/sun8i-h3.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 41d57c76f290..9dff6887923c 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -84,21 +84,30 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
+			clocks = <&ccu CLK_CPUX>;
+			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <2>;
+			clocks = <&ccu CLK_CPUX>;
+			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <3>;
+			clocks = <&ccu CLK_CPUX>;
+			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.15.0.194.g9af6a3dea062
