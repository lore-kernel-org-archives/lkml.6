Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935965AbeCBFvE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 00:51:04 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35913 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935951AbeCBFu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 00:50:58 -0500
X-Google-Smtp-Source: AG47ELsyMaJ7umnMfGB+o7QMZc7r34I/vuJoF6pWtUp+iK+G28PsFUcPFJx3cgUej3mE7BjqIrbgsw==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mturquette@baylibre.com, sboyd@kernel.org, afaerber@suse.de,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        davem@davemloft.net, mchehab@kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 03/11] arm64: dts: actions: Source CMU clock for UART5
Date: Fri,  2 Mar 2018 11:18:52 +0530
Message-Id: <20180302054900.11275-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180302054900.11275-1-manivannan.sadhasivam@linaro.org>
References: <20180302054900.11275-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove fixed clock and source CMU (Clock Management Unit) clock for
UART5 driver in Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
index 21ca80f9941c..ff043c961d75 100644
--- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
@@ -24,12 +24,6 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
-
-	uart5_clk: uart5-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &timer {
@@ -38,5 +32,5 @@
 
 &uart5 {
 	status = "okay";
-	clocks = <&uart5_clk>;
+	clocks = <&cmu CLK_UART5>;
 };
-- 
2.14.1
