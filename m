Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423855AbeCBPdp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:33:45 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49242 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1423376AbeCBPdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:33:03 -0500
From: Philippe Cornu <philippe.cornu@st.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Andrzej Hajda <a.hajda@samsung.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Benjamin Gaignard" <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH v2 1/2] dt-bindings/display/panel: Add support for Raydium rm68200 dsi panel
Date: Fri, 2 Mar 2018 16:32:21 +0100
Message-ID: <20180302153222.4377-2-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180302153222.4377-1-philippe.cornu@st.com>
References: <20180302153222.4377-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Raydium Semiconductor Corporation RM68200 is a 5.5" 720x1280
TFT LCD panel connected using a MIPI-DSI video interface.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 .../bindings/display/panel/raydium,rm68200.txt     | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt b/Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
new file mode 100644
index 000000000000..cbb79ef3bfc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
@@ -0,0 +1,25 @@
+Raydium Semiconductor Corporation RM68200 5.5" 720p MIPI-DSI TFT LCD panel
+
+The Raydium Semiconductor Corporation RM68200 is a 5.5" 720x1280 TFT LCD
+panel connected using a MIPI-DSI video interface.
+
+Required properties:
+  - compatible: "raydium,rm68200"
+  - reg: the virtual channel number of a DSI peripheral
+
+Optional properties:
+  - reset-gpios: a GPIO spec for the reset pin (active low).
+  - power-supply: phandle of the regulator that provides the supply voltage.
+  - backlight: phandle of the backlight device attached to the panel.
+
+Example:
+&dsi {
+	...
+	panel@0 {
+		compatible = "raydium,rm68200";
+		reg = <0>;
+		reset-gpios = <&gpiof 15 GPIO_ACTIVE_LOW>;
+		power-supply = <&v1v8>;
+		backlight = <&pwm_backlight>;
+	};
+};
-- 
2.15.1
