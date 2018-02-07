Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753823AbeBGJKs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:10:48 -0500
Received: from mx.socionext.com ([202.248.49.38]:3341 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753773AbeBGJKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:10:43 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [RESEND PATCH v2 9/9] arm64: dts: uniphier: add compress audio out for UniPhier LD11/LD20
Date: Wed,  7 Feb 2018 18:10:49 +0900
Message-Id: <20180207091049.24700-10-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180207091049.24700-1-suzuki.katsuhiro@socionext.com>
References: <20180207091049.24700-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds compress audio node for S/PDIF on UniPhier LD11/20
global boards. And adds settings of AIO for it.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 .../boot/dts/socionext/uniphier-ld11-global.dts    | 30 +++++++++++++++++++++-
 .../boot/dts/socionext/uniphier-ld20-global.dts    | 30 +++++++++++++++++++++-
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index ca09251a3eab..51cb717e5e56 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -48,7 +48,8 @@
 			dais = <&i2s_port2
 				&i2s_port3
 				&i2s_port4
-				&spdif_port0>;
+				&spdif_port0
+				&comp_spdif_port0>;
 		};
 
 		spdif-out {
@@ -61,6 +62,17 @@
 				};
 			};
 		};
+
+		comp-spdif-out {
+			compatible = "linux,spdif-dit";
+			#sound-dai-cells = <0>;
+
+			port@0 {
+				comp_spdif_tx: endpoint {
+					remote-endpoint = <&comp_spdif_hiecout1>;
+				};
+			};
+		};
 	};
 };
 
@@ -149,6 +161,22 @@
 			remote-endpoint = <&spdif_tx>;
 		};
 	};
+
+	src_port0: port@6 {
+		i2s_epcmout2: endpoint {
+		};
+	};
+
+	src_port1: port@7 {
+		i2s_epcmout3: endpoint {
+		};
+	};
+
+	comp_spdif_port0: port@8 {
+		comp_spdif_hiecout1: endpoint {
+			remote-endpoint = <&comp_spdif_tx>;
+		};
+	};
 };
 
 &evea {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index 0728832ce552..0bda5c1382bc 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -48,7 +48,8 @@
 			dais = <&i2s_port2
 				&i2s_port3
 				&i2s_port4
-				&spdif_port0>;
+				&spdif_port0
+				&comp_spdif_port0>;
 		};
 
 		spdif-out {
@@ -61,6 +62,17 @@
 				};
 			};
 		};
+
+		comp-spdif-out {
+			compatible = "linux,spdif-dit";
+			#sound-dai-cells = <0>;
+
+			port@0 {
+				comp_spdif_tx: endpoint {
+					remote-endpoint = <&comp_spdif_hiecout1>;
+				};
+			};
+		};
 	};
 };
 
@@ -131,6 +143,22 @@
 			remote-endpoint = <&spdif_tx>;
 		};
 	};
+
+	src_port0: port@6 {
+		i2s_epcmout2: endpoint {
+		};
+	};
+
+	src_port1: port@7 {
+		i2s_epcmout3: endpoint {
+		};
+	};
+
+	comp_spdif_port0: port@8 {
+		comp_spdif_hiecout1: endpoint {
+			remote-endpoint = <&comp_spdif_tx>;
+		};
+	};
 };
 
 &evea {
-- 
2.15.0
