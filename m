Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbeDKCAR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:00:17 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36155 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeDKCAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:00:14 -0400
X-Google-Smtp-Source: AIpwx4/y6C+9XusVwpS/8Vo3mgH2TVaFFqzo/QSZMSNReiWFHBWPo545Jnc6s+V0kGtezPtN+3vBtg==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: nvmem: Add binding for RAVE SP EEPROM driver
Date: Tue, 10 Apr 2018 18:59:47 -0700
Message-Id: <20180411015948.19562-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180411015948.19562-1-andrew.smirnov@gmail.com>
References: <20180411015948.19562-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Tree bindings for RAVE SP EEPROM driver - an MFD cell of
parent RAVE SP driver (documented in
Documentation/devicetree/bindings/mfd/zii,rave-sp.txt).

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Aleksander Morgado <aleksander@aleksander.es>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 .../bindings/nvmem/zii,rave-sp-eeprom.txt          | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt

diff --git a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
new file mode 100644
index 000000000000..a4e838c30b67
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
@@ -0,0 +1,29 @@
+Zodiac Inflight Innovations RAVE EEPROM Bindings
+
+RAVE SP EEPROM device is a "MFD cell" device exposing physical EEPROM
+attached to RAVE Supervisory Processor. It is expected that its Device
+Tree node is specified as a child of the node corresponding to the
+parent RAVE SP device (as documented in
+Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
+
+Required properties:
+
+- compatible: Should be "zii,rave-sp-eeprom"
+
+Example:
+
+	rave-sp {
+		compatible = "zii,rave-sp-rdu1";
+		current-speed = <38400>;
+
+		main-eeprom {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xA4 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			wdt_timeout: wdt-timeout@81 {
+				reg = <0x81 2>;
+			};
+		};
+	}
-- 
2.14.3
