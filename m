Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbeCMQpP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:45:15 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45254 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933331AbeCMQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:45:10 -0400
X-Google-Smtp-Source: AG47ELt1f7w38g5djGrkRb3ziX3svvZ4ZcNnSBRzi7WNvMeVf1Z/mAlOlR2Wd4qHQS6UyXU+rKx8fg==
From: Thierry Escande <thierry.escande@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: net: bluetooth: Add qualcomm-bluetooth
Date: Tue, 13 Mar 2018 17:44:43 +0100
Message-Id: <20180313164444.19881-3-thierry.escande@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180313164444.19881-1-thierry.escande@linaro.org>
References: <20180313164444.19881-1-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for serial bluetooth chips using Qualcomm protocol.

Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
---
 .../devicetree/bindings/net/qualcomm-bluetooth.txt | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
new file mode 100644
index 000000000000..288cf062e906
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -0,0 +1,34 @@
+Qualcomm Bluetooth Chips
+---------------------
+
+This documents the binding structure and common properties for serial
+attached Qualcomm devices.
+
+Serial attached Qualcomm devices shall be a child node of the host UART
+device the slave device is attached to.
+
+Required properties:
+
+ - compatible: should contain one of the following:
+   * "qcom,qca6174-bt"
+
+Optional properties:
+
+ - bt-disable-n-gpios: GPIO specifier, used to enable chip during probe
+
+Example:
+
+serial@7570000 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp1_uart1_default>;
+	pinctrl-1 = <&blsp1_uart1_sleep>;
+
+	bluetooth {
+		compatible = "qcom,qca6174-bt";
+
+		bt-disable-n-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en_pin_a>, <&divclk4_pin_a>;
+	};
+};
-- 
2.14.1
