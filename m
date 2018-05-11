Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeEKKAh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 06:00:37 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:56159 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752791AbeEKKAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 06:00:30 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com,
        horms@verge.net.au, geert@glider.be, magnus.damm@gmail.com,
        robh+dt@kernel.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: renesas: r8a77995: Add VIN4
Date: Fri, 11 May 2018 12:00:01 +0200
Message-Id: <1526032802-14376-3-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe VIN4 interface for R-Car D3 R8A77995 SoC.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 82aed7e..bdf7017 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -783,6 +783,17 @@
 				};
 			};
 		};
+
+		vin4: video@e6ef4000 {
+			compatible = "renesas,vin-r8a77995";
+			reg = <0 0xe6ef4000 0 0x1000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 807>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 807>;
+			renesas,id = <4>;
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.7.4
