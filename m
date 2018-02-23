Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeBWBRZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 20:17:25 -0500
Received: from mx.socionext.com ([202.248.49.38]:37504 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751265AbeBWBRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 20:17:22 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v2 1/2] ASoC: add DT bindings documentation for ROHM BD28623 codec
Date: Fri, 23 Feb 2018 10:17:16 +0900
Message-Id: <20180223011717.2799-2-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180223011717.2799-1-suzuki.katsuhiro@socionext.com>
References: <20180223011717.2799-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT bindings documentation for ROHM BD28623MUV
class D speaker amplifier.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes in v2:
  - Change gpio properties to optional
  - Change VCCA, VCCP-supply to mandatory
---
 .../devicetree/bindings/sound/rohm,bd28623.txt     | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.txt

diff --git a/Documentation/devicetree/bindings/sound/rohm,bd28623.txt b/Documentation/devicetree/bindings/sound/rohm,bd28623.txt
new file mode 100644
index 000000000000..d84557c2686e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rohm,bd28623.txt
@@ -0,0 +1,29 @@
+ROHM BD28623MUV Class D speaker amplifier for digital input
+
+This codec does not have any control buses such as I2C, it detect format and
+rate of I2S signal automatically. It has two signals that can be connected
+to GPIOs: reset and mute.
+
+Required properties:
+- compatible      : should be "rohm,bd28623"
+- #sound-dai-cells: should be 0.
+- VCCA-supply     : regulator phandle for the VCCA supply
+- VCCP1-supply    : regulator phandle for the VCCP1 supply
+- VCCP2-supply    : regulator phandle for the VCCP2 supply
+
+Optional properties:
+- reset-gpios     : GPIO specifier for the active low reset line
+- mute-gpios      : GPIO specifier for the active low mute line
+
+Example:
+
+	codec {
+		compatible = "rohm,bd28623";
+		#sound-dai-cells = <0>;
+
+		VCCA-supply = <&vcc_reg>;
+		VCCP1-supply = <&vcc_reg>;
+		VCCP2-supply = <&vcc_reg>;
+		reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
+		mute-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+	};
-- 
2.16.1
