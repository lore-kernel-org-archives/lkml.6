Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422974AbeCBIbo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:31:44 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53028 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422957AbeCBIbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:31:38 -0500
X-Google-Smtp-Source: AG47ELtBiZjp8vJM4YnroCZyh0V+7sFZ2qEHNqcWZkv6xWeddokTsqxddPmA/YzmE3FHky2Cl7QSrw==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jassisinghbrar@gmail.com, andy.shevchenko@gmail.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: i2c: add binding for Socionext SynQuacer I2C
Date: Fri,  2 Mar 2018 08:31:22 +0000
Message-Id: <20180302083123.7259-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180302083123.7259-1-ard.biesheuvel@linaro.org>
References: <20180302083123.7259-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the I2C controller that can be found in the Socionext
SynQuacer SoC.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt b/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
new file mode 100644
index 000000000000..72f4a2f0fedc
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
@@ -0,0 +1,29 @@
+Socionext SynQuacer I2C
+
+Required properties:
+- compatible      : Must be "socionext,synquacer-i2c"
+- reg             : Offset and length of the register set for the device
+- interrupts      : A single interrupt specifier
+- #address-cells  : Must be <1>;
+- #size-cells     : Must be <0>;
+- clock-names     : Must contain "pclk".
+- clocks          : Must contain an entry for each name in clock-names.
+                    (See the common clock bindings.)
+
+Optional properties:
+- clock-frequency : Desired I2C bus clock frequency in Hz. As only Normal and
+                    Fast modes are supported, possible values are 100000 and
+                    400000.
+
+Example :
+
+    i2c@51210000 {
+        compatible = "socionext,synquacer-i2c";
+        reg = <0x51210000 0x1000>;
+        interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clock-names = "pclk";
+        clocks = <&clk_i2c>;
+        clock-frequency = <400000>;
+    };
-- 
2.11.0
