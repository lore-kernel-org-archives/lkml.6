Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754357AbeBGNrL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:47:11 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44212 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754187AbeBGNqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:46:11 -0500
X-Google-Smtp-Source: AH8x22401POKZfBXR4uG/6BE4IU11YRUTQO2HF5mws/l/UyOnbk83j9G5in0nlXcA1qGgvkjkXhbKA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/7] ARM: dts: da850: add power controller nodes
Date: Wed,  7 Feb 2018 14:45:50 +0100
Message-Id: <20180207134553.13510-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180207134553.13510-1-brgl@bgdev.pl>
References: <20180207134553.13510-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add two power controller nodes corresponding with the two PSC modules
present on the da850 SoC.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 3a1f2ced05ca..ac2eef4e6b7c 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -24,6 +24,11 @@
 		};
 	};
 
+	aliases {
+		pwc0 = &pwc0;
+		pwc1 = &pwc1;
+	};
+
 	opp_table: opp-table {
 		compatible = "operating-points-v2";
 
@@ -141,6 +146,10 @@
 				      "pll0_sysclk4", "pll0_sysclk6",
 				      "async1";
 		};
+		pwc0: power-controller@10000 {
+			compatible = "ti,davinci-pm-domains";
+			#power-domain-cells = <0>;
+		};
 		pll0: clock-controller@11000 {
 			compatible = "ti,da850-pll0";
 			reg = <0x11000 0x1000>;
@@ -757,6 +766,10 @@
 				 <&async3_clk>;
 			clock-names = "pll0_sysclk2", "pll0_sysclk4", "async3";
 		};
+		pwc1: power-controller@227000 {
+			compatible = "ti,davinci-pm-domains";
+			#power-domain-cells = <0>;
+		};
 		pinconf: pin-controller@22c00c {
 			compatible = "ti,da850-pupd";
 			reg = <0x22c00c 0x8>;
-- 
2.16.1
