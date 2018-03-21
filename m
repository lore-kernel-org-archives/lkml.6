Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeCUNr6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 09:47:58 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34368 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeCUNrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 09:47:31 -0400
X-Google-Smtp-Source: AG47ELt0T/8CQtZvYVCnScnWPoHR6ZfehC6McS59ebQJZ4AUTQ3uTcZfCgZ+aImIIdSEbAolH095wQ==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: nvmem: Add binding for RAVE SP EEPROM driver
Date: Wed, 21 Mar 2018 06:47:09 -0700
Message-Id: <20180321134710.29757-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321134710.29757-1-andrew.smirnov@gmail.com>
References: <20180321134710.29757-1-andrew.smirnov@gmail.com>
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
 .../bindings/nvmem/zii,rave-sp-eeprom.txt          | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt

diff --git a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
new file mode 100644
index 000000000000..556abfa70524
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
@@ -0,0 +1,23 @@
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
+		dds-eeprom {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xA3 0x2000>;
+		};
+	}
-- 
2.14.3
