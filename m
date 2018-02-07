Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753776AbeBGJKm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:10:42 -0500
Received: from mx.socionext.com ([202.248.49.38]:3330 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753591AbeBGJKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:10:37 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [RESEND PATCH v2 1/9] ASoC: uniphier: add DT bindings documentation for UniPhier AIO
Date: Wed,  7 Feb 2018 18:10:41 +0900
Message-Id: <20180207091049.24700-2-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180207091049.24700-1-suzuki.katsuhiro@socionext.com>
References: <20180207091049.24700-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT binding documentation for UniPhier
AIO audio subsystem.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 .../devicetree/bindings/sound/uniphier,aio.txt     | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/uniphier,aio.txt

diff --git a/Documentation/devicetree/bindings/sound/uniphier,aio.txt b/Documentation/devicetree/bindings/sound/uniphier,aio.txt
new file mode 100644
index 000000000000..73f6c27ae4f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/uniphier,aio.txt
@@ -0,0 +1,36 @@
+Socionext UniPhier SoC audio driver
+
+The Socionext UniPhier audio subsystem consists of I2S and S/PDIF blocks in
+the same register space.
+
+Required properties:
+- compatible      : should be one of the following:
+		    "socionext,uniphier-ld11-aio"
+		    "socionext,uniphier-ld20-aio"
+- reg             : offset and length of the register set for the device.
+- interrupts      : should contain I2S or S/PDIF interrupt.
+- pinctrl-names   : should be "default".
+- pinctrl-0       : defined I2S signal pins for an external codec chip.
+- clock-names     : should include following entries:
+                    "aio"
+- clocks          : a list of phandle, should contain an entry for each
+                    entry in clock-names.
+- reset-names     : should include following entries:
+                    "aio"
+- resets          : a list of phandle, should contain an entry for each
+                    entry in reset-names.
+- #sound-dai-cells: should be 1.
+
+Example:
+	audio {
+		compatible = "socionext,uniphier-ld20-aio";
+		reg = <0x56000000 0x80000>;
+		interrupts = <0 144 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_aout>;
+		clock-names = "aio";
+		clocks = <&sys_clk 40>;
+		reset-names = "aio";
+		resets = <&sys_rst 40>;
+		#sound-dai-cells = <1>;
+	};
-- 
2.15.0
