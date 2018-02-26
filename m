Return-Path: <leo.wen@rock-chips.com>
X-Google-Smtp-Source: AH8x224Qzi9+p/hVuioCtpH0Eaq/GxzPlXLb9rCHU7ISArl8vxLW4c5Kzw/62cdL2UCx50d+YRFC
ARC-Seal: i=1; a=rsa-sha256; t=1519633512; cv=none;
        d=google.com; s=arc-20160816;
        b=qPa/kg4y4EWO4jl6ZzBKyHdjxAUBRpk3YqhSmEuI9ftakom/i3EWDyUF8613IdNn09
         BvMZgi1PxvxJtg3Np/VNsVGFVYht9Yn7aCxuJB5Jo/lXDQ7sj3gpMAvJCuU/3E5h/72M
         sokxJ6zZudFIf9s3ngAsgii4zYvD71OFANGzKnycjulxLBKzlJtcqHzwhrLFO9jabl1O
         7975juNObikm6mMZ8gqVqNnZ2gi6ZExY7yJl0ji1vAMuk5SUsI7B8rjS9xGF8qx/SM1k
         bJ0dDQGYeYaRnIqp0/dlcopobXla2WFpfoAii3rA9c+UjohoA8Hy8Bz0eGPyNb/WaPuZ
         rcrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=RDUqpXhm5QFO47W1q+dGoiZzL+IchWFlq76uhApI05A=;
        b=zqzX1OXKWPT0WZpTKHQp6UhocvQekIgcuiOuOFpP79rsPJo5Z4/5dblpGpL4L0j7Ad
         AiaMLf75un4xRq8bEGn2ecinRmcUA0jiDFIuNtP7Si7b9/8yc1BYoo5/yfeRlYOh6rpm
         D2aRdkM51gTpFAn54ksKSTB/44amTd/M3MMclL4UwMHJ4lSzNf+KyYkfXzC4whCviH/v
         uh/aUnk3vcsBBZdf3mygwI2Rhtei/AXpgqujlTlDlRGARrOq6ODRtakDbEL/yyFrEsXd
         woFnGqtYbRqXtS+suFp9vliZKDkmmyvAIIIgiIgPnGqV8S0RVHOAmrglOg98cC+hJJ72
         eNaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of leo.wen@rock-chips.com designates 211.150.99.132 as permitted sender) smtp.mailfrom=leo.wen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of leo.wen@rock-chips.com designates 211.150.99.132 as permitted sender) smtp.mailfrom=leo.wen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: leo.wen@rock-chips.com
X-FST-TO: mchehab@kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: leo.wen@rock-chips.com
X-UNIQUE-TAG: <d1b618614a62fdc4d451b526b27ea714>
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
Subject: [PATCH V2 2/2] dt-bindings: Document the Rockchip RK1608 bindings
Date: Mon, 26 Feb 2018 16:25:04 +0800
Message-Id: <1519633504-64357-1-git-send-email-leo.wen@rock-chips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593451230041702429?=
X-GMAIL-MSGID: =?utf-8?q?1593451230041702429?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leo Wen <leo.wen@rock-chips.com>

Add DT bindings documentation for Rockchip RK1608.

Changes V2:
- Delete spi-min-frequency property.
- Add the external sensor's control pin and clock properties.
- Delete the '&pinctrl' node.

Signed-off-by: Leo Wen <leo.wen@rock-chips.com>
---
 Documentation/devicetree/bindings/media/rk1608.txt | 97 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rk1608.txt

diff --git a/Documentation/devicetree/bindings/media/rk1608.txt b/Documentation/devicetree/bindings/media/rk1608.txt
new file mode 100644
index 0000000..a9721a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/rk1608.txt
@@ -0,0 +1,97 @@
+Rockchip RK1608 as a PreISP to link on Soc
+------------------------------------------
+
+Required properties:
+
+- compatible		: "rockchip,rk1608";
+- reg			: SPI slave address of the rk1608;
+- clocks		: Must contain an entry for each entry in clock-names;
+- clock-names		: Must contain "mclk" for the device's master clock;
+- reset-gpio		: GPIO connected to reset pin;
+- irq-gpio		: GPIO connected to irq pin;
+- sleepst-gpio		: GPIO connected to sleepst pin;
+- wakeup-gpio		: GPIO connected to wakeup pin;
+- powerdown-gpio	: GPIO connected to powerdown pin;
+- rockchip,powerdown0	: GPIO connected to the sensor0's powerdown pin;
+- rockchip,reset0	: GPIO connected to the sensor0's reset pin;
+- rockchip,powerdown1	: GPIO connected to the sensor1's powerdown pin;
+- rockchip,reset1	: GPIO connected to the sensor1's reset pin;
+- pinctrl-names		: Should contain only one value - "default";
+- pinctrl-0		: Pin control group to be used for this controller;
+
+Optional properties:
+
+- spi-max-frequency	: Maximum SPI clocking speed of the device;
+
+The device node should contain one 'port' child node with one child 'endpoint'
+node, according to the bindings defined in Documentation/devicetree/bindings/
+media/video-interfaces.txt. The following are properties specific to those
+nodes.
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
+		link-freqs = /bits/ 64 <400000000>;
+		clocks = <&cru SCLK_SPI0>, <&cru SCLK_VIP_OUT>,
+		<&cru DCLK_VOP0>, <&cru ACLK_VIP>, <&cru HCLK_VIP>,
+		<&cru PCLK_ISP_IN>, <&cru PCLK_ISP_IN>,
+		<&cru PCLK_ISP_IN>, <&cru SCLK_MIPIDSI_24M>,
+		<&cru PCLK_MIPI_CSI>;
+		clock-names = "mclk", "mipi_clk",  "pd_cif", "aclk_cif",
+			"hclk_cif", "cif0_in", "g_pclkin_cif",
+			"cif0_out", "clk_mipi_24m", "hclk_mipiphy";
+		reset-gpio = <&gpio6 0 GPIO_ACTIVE_HIGH>;
+		irq-gpio = <&gpio6 2 GPIO_ACTIVE_HIGH>;
+		sleepst-gpio = <&gpio6 1 GPIO_ACTIVE_HIGH>;
+		wakeup-gpio = <&gpio6 4 GPIO_ACTIVE_HIGH>;
+		powerdown-gpio = <&gpio8 0 GPIO_ACTIVE_HIGH>;
+
+		rockchip,powerdown1 = <&gpio5 9 GPIO_ACTIVE_HIGH>;
+		rockchip,reset1 = <&gpio6 8 GPIO_ACTIVE_HIGH>;
+
+		rockchip,powerdown0 = <&gpio5 8 GPIO_ACTIVE_HIGH>;
+		rockchip,reset0 = <&gpio6 7 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&rk1608_irq_gpios &rk1608_wake_gpios
+			     &rk1608_sleep_gpios>;
+
+		port@0 {
+			mipi_dphy_out: endpoint {
+				remote-endpoint = <&mipi_dphy_in>;
+				clock-lanes = <0>;
+				data-lanes = <1 2 3 4>;
+				clock-noncontinuous;
+				link-frequencies =
+					/bits/ 64 <400000000>;
+			};
+		};
+		/* Example: we have two cameras */
+		port@1 {
+			sensor_in0: endpoint@0 {
+				remote-endpoint = <&sensor_out0>;
+			};
+			sensor_in1: endpoint@1 {
+				remote-endpoint = <&sensor_out1>;
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
