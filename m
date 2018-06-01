Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeFAIZ1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:25:27 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33174 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeFAIX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:23:26 -0400
X-Google-Smtp-Source: ADUXVKJf0352wXvag0GPVH6zDG2offojF9Oz+mkeKnzM7+TM+NEVHu1Pkh8woqszWE+21yDmZtNtMA==
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 2/8] dt-bindings: add generic gnss binding
Date: Fri,  1 Jun 2018 10:22:53 +0200
Message-Id: <20180601082259.17563-3-johan@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180601082259.17563-1-johan@kernel.org>
References: <20180601082259.17563-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe generic properties for GNSS receivers.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 .../devicetree/bindings/gnss/gnss.txt         | 36 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/gnss.txt

diff --git a/Documentation/devicetree/bindings/gnss/gnss.txt b/Documentation/devicetree/bindings/gnss/gnss.txt
new file mode 100644
index 000000000000..f1e4a2ff47c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/gnss.txt
@@ -0,0 +1,36 @@
+GNSS Receiver DT binding
+
+This documents the binding structure and common properties for GNSS receiver
+devices.
+
+A GNSS receiver node is a node named "gnss" and typically resides on a serial
+bus (e.g. UART, I2C or SPI).
+
+Please refer to the following documents for generic properties:
+
+	Documentation/devicetree/bindings/serial/slave-device.txt
+	Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Required properties:
+
+- compatible	: A string reflecting the vendor and specific device the node
+		  represents
+
+Optional properties:
+- enable-gpios	: GPIO used to enable the device
+- timepulse-gpios	: Time pulse GPIO
+
+Example:
+
+serial@1234 {
+	compatible = "ns16550a";
+
+	gnss {
+		compatible = "u-blox,neo-8";
+
+		vcc-supply = <&gnss_reg>;
+		timepulse-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+
+		current-speed = <4800>;
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index dc3df211c1a7..fa219e80a1f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5965,6 +5965,7 @@ F:	include/uapi/linux/gigaset_dev.h
 GNSS SUBSYSTEM
 M:	Johan Hovold <johan@kernel.org>
 S:	Maintained
+F:	Documentation/devicetree/bindings/gnss/
 F:	drivers/gnss/
 F:	include/linux/gnss.h
 
-- 
2.17.1
