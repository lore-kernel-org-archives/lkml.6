Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeEAFaR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 01:30:17 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42925 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751928AbeEAFaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 01:30:13 -0400
X-Google-Smtp-Source: AB8JxZpumEy5Ablh/TWCK2uoVWw6WDYvb4tjTXF5zx6FJqBdrEJMyxsuMPkAPDv1NUFX4XteFIultA==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: nvmem: Add binding for RAVE SP EEPROM driver
Date: Mon, 30 Apr 2018 22:29:51 -0700
Message-Id: <20180501052952.26765-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180501052952.26765-1-andrew.smirnov@gmail.com>
References: <20180501052952.26765-1-andrew.smirnov@gmail.com>
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
 .../bindings/nvmem/zii,rave-sp-eeprom.txt          | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt

diff --git a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
new file mode 100644
index 000000000000..d5e22fc67d66
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
@@ -0,0 +1,40 @@
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
+Optional properties:
+
+- zii,eeprom-name: Unique EEPROM identifier describing its function in the
+  system. Will be used as created NVMEM deivce's name.
+
+Data cells:
+
+Data cells are child nodes of eerpom node, bindings for which are
+documented in Documentation/bindings/nvmem/nvmem.txt
+
+Example:
+
+	rave-sp {
+		compatible = "zii,rave-sp-rdu1";
+		current-speed = <38400>;
+
+		eeprom@a4 {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xa4 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			zii,eeprom-name = "main-eeprom";
+
+			wdt_timeout: wdt-timeout@81 {
+				reg = <0x81 2>;
+			};
+		};
+	}
-- 
2.14.3
