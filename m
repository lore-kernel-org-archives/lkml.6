Return-Path: <leo.wen@rock-chips.com>
X-Google-Smtp-Source: AG47ELuy5nMH5whQFDOTrRKeCBSkoQ1r1fFPmABvEfFQUmjmWo+ifB2epZewJ1F+1V2Fh9CuecGk
ARC-Seal: i=1; a=rsa-sha256; t=1520491135; cv=none;
        d=google.com; s=arc-20160816;
        b=KtkXsKvq84wxt/4KOm8XiST5DMGyaMbEtHX4g11RhHKDU+/r9yQLVN6p5oaRHa5huJ
         W6XGaVR8cRxlwogF8sKdxMDfqufo6w9sMiK7FA8OpiK5LBv0TNMLdRFJGCHuzpL59HLK
         H85ejjhnyPIdSqIqRBLsaGkLkThDGfWVPJyI1fCQ7S1vbxSK/7w9l3FajDC2PwT8tA8a
         BP1cVQ8Jb2dUK2ARkM7+6HIrfu3HHaGCdjn0PklwOE635O0FhYguIY3qFiAMONrZCaQU
         uTWbmlxyN3cwNYdPapb7aTgGsMLMGFMf7KZnqA7B3EXwigZU5/OijO2pGMm/0rYyb2XG
         QAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=itQyiu6bHOh8yNLaRX5nk/+zCCWRmhxWkIKCMTQk58g=;
        b=quC0dn5O/ZSxVN4GSUKPaTodU5egaN8SluGYS8cfEeXAD7xRRA+j08laSMZ+5PFPca
         fQRWTOlaoLkL9AJCsMWl1JnwoAXOdDbcQ+Fw/YgFy1RFMbeoANYXbzT3i/mT3rMPVcyw
         kPOwMkOzKNQCY5P3L46ckAo4GsIjKXVu2Rvqjq0kwMAVvTvELgt8kppSJHSPnCmKqpxs
         LYVh5Nmdku+JlRM9QZ3hMF3QsfsXyHyXaprgYLZStWZP0fuxmmDRyJRMvcRcCNKy6kp7
         pGLnwU5d7H+k+07tZLcrMSrtYiCL/JtddJE1lYeY9VyG2vLqZZA+f09X6eIrjkP+c6IR
         0VoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of leo.wen@rock-chips.com designates 211.150.99.133 as permitted sender) smtp.mailfrom=leo.wen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of leo.wen@rock-chips.com designates 211.150.99.133 as permitted sender) smtp.mailfrom=leo.wen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: leo.wen@rock-chips.com
X-FST-TO: mchehab@kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: leo.wen@rock-chips.com
X-UNIQUE-TAG: <d67ac6d1ebc92104109bf4ba7ecdb5e0>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Wen Nuan <leo.wen@rock-chips.com>
To: mchehab@kernel.org,
	davem@davemloft.net,
	gregkh@linuxfoundation.org,
	linus.walleij@linaro.org,
	rdunlap@infradead.org,
	jacob2.chen@rock-chips.com
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	eddie.cai@rock-chips.com,
	Leo Wen <leo.wen@rock-chips.com>
Subject: [PATCH v4 2/2] dt-bindings: Document the Rockchip RK1608 bindings
Date: Thu,  8 Mar 2018 14:38:42 +0800
Message-Id: <1520491122-5629-3-git-send-email-leo.wen@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520491122-5629-1-git-send-email-leo.wen@rock-chips.com>
References: <1520491122-5629-1-git-send-email-leo.wen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593451230041702429?=
X-GMAIL-MSGID: =?utf-8?q?1594350512697866071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leo Wen <leo.wen@rock-chips.com>

Add DT bindings documentation for Rockchip RK1608.

Changes V4:
- Revise the comment of node.
- Revise the comment of 'endpoint@1'.

Signed-off-by: Leo Wen <leo.wen@rock-chips.com>
---
 Documentation/devicetree/bindings/media/rk1608.txt | 95 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rk1608.txt

diff --git a/Documentation/devicetree/bindings/media/rk1608.txt b/Documentation/devicetree/bindings/media/rk1608.txt
new file mode 100644
index 0000000..ea23d2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/rk1608.txt
@@ -0,0 +1,95 @@
+Rockchip RK1608 as a PreISP to link on Soc
+------------------------------------------
+
+Required properties:
+
+- compatible		: "rockchip,rk1608";
+- reg			: SPI slave address of the rk1608;
+- clocks		: Must contain an entry for each entry in clock-names;
+- clock-names		: Must contain "mclk" for the device's master clock;
+- reset-gpios		: GPIO connected to reset pin;
+- irq-gpios		: GPIO connected to irq pin;
+- sleepst-gpios		: GPIO connected to sleepst pin;
+- wakeup-gpios		: GPIO connected to wakeup pin;
+- powerdown-gpios	: GPIO connected to powerdown pin;
+- pinctrl-names		: Should contain only one value - "default";
+- pinctrl-0		: Pin control group to be used for this controller;
+
+Optional properties:
+
+- spi-max-frequency	: Maximum SPI clocking speed of the device;
+
+The device node should contain one or two port child nodes with child
+'endpoint' node. There are two ports then port@0 must
+describe the output and port@1 input channels. Please refer to the
+bindings defined in
+Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+endpoint node
+-------------
+
+- data-lanes : (optional) specifies MIPI CSI-2 data lanes as covered in
+	       video-interfaces.txt. If present it should be <1> - the device
+	       supports only one data lane without re-mapping.
+
+Note1: Since no data is generated in RK1608，so this is meaningful that you need
+a extra sensor (such as a camera) mounted on RK1608. You need to use endpoint@x
+to match these sensors.
+
+Note2:You must set the current value of the spi pins to be 8mA, if they are not.
+
+Example:
+&spi0 {
+	status = "okay";
+	spi_rk1608@00 {
+		compatible =  "rockchip,rk1608";
+		status = "okay";
+		reg = <0>;
+		spi-max-frequency = <24000000>;
+		link-freqs = /bits/ 64 <LINK_FREQ>;
+		clocks = <&cru SCLK_SPI0>, <&cru SCLK_VIP_OUT>,
+		<&cru DCLK_VOP0>, <&cru ACLK_VIP>, <&cru HCLK_VIP>,
+		<&cru PCLK_ISP_IN>, <&cru PCLK_ISP_IN>,
+		<&cru PCLK_ISP_IN>, <&cru SCLK_MIPIDSI_24M>,
+		<&cru PCLK_MIPI_CSI>;
+		clock-names = "mclk", "mipi_clk",  "pd_cif", "aclk_cif",
+			"hclk_cif", "cif0_in", "g_pclkin_cif",
+			"cif0_out", "clk_mipi_24m", "hclk_mipiphy";
+		reset-gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>;
+		irq-gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;
+		sleepst-gpios = <&gpio6 1 GPIO_ACTIVE_HIGH>;
+		wakeup-gpios = <&gpio6 4 GPIO_ACTIVE_HIGH>;
+		powerdown-gpios = <&gpio8 0 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&rk1608_irq_gpios &rk1608_wake_gpios
+			     &rk1608_sleep_gpios>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port@0 {
+				mipi_dphy_out0: endpoint@0 {
+					remote-endpoint = <&mipi_dphy_in0>;
+					clock-lanes = <0>;
+					data-lanes = <1 2 3 4>;
+					clock-noncontinuous;
+					link-frequencies =
+						/bits/ 64 <LINK_FREQ>;
+				};
+			};
+
+			port@1 {
+				sensor_in0: endpoint@0 {
+					remote-endpoint = <&sensor_out0>;
+				};
+				/* If you have a second sensor,
+				 * add the 'endpoint@1' node here.
+				 */
+				sensor_in1: endpoint@1 {
+					remote-endpoint = <&sensor_out1>;
+				};
+			};
+		};
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index b2a98e3..04d227b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -141,6 +141,7 @@ M:	Leo Wen <leo.wen@rock-chips.com>
 S:	Maintained
 F:	drivers/media/spi/rk1608.c
 F:	drivers/media/spi/rk1608.h
+F:	Documentation/devicetree/bindings/media/rk1608.txt
 
 3C59X NETWORK DRIVER
 M:	Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
-- 
2.7.4
