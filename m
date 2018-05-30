Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeE3Kea (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:34:30 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35546 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbeE3KeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:34:11 -0400
X-Google-Smtp-Source: ADUXVKIVl2zhAZeqDz+f5qRHr6rLKiPYSZVPkvzWKzCNbDJki7tZOAPAz/tAza13kA6CzaFoEUHfqA==
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 4/8] dt-bindings: gnss: add u-blox binding
Date: Wed, 30 May 2018 12:32:38 +0200
Message-Id: <20180530103242.20773-5-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530103242.20773-1-johan@kernel.org>
References: <20180530103242.20773-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for u-blox GNSS receivers.

Note that the u-blox product names encodes form factor (e.g. "neo"),
chipset (e.g. "8") and variant (e.g. "q"), but that only formfactor and
chipset is used for the compatible strings (for now).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 .../devicetree/bindings/gnss/u-blox.txt       | 44 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/u-blox.txt

diff --git a/Documentation/devicetree/bindings/gnss/u-blox.txt b/Documentation/devicetree/bindings/gnss/u-blox.txt
new file mode 100644
index 000000000000..caef9ace0b0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/u-blox.txt
@@ -0,0 +1,44 @@
+u-blox GNSS Receiver DT binding
+
+The u-blox GNSS receivers can use UART, DDC (I2C), SPI and USB interfaces.
+
+Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
+properties.
+
+Required properties:
+
+- compatible 	: Must be one of
+
+			"u-blox,neo-8"
+			"u-blox,neo-m8"
+
+- vcc-supply	: Main voltage regulator
+
+Required properties (DDC):
+- reg		: DDC (I2C) slave address
+
+Required properties (SPI):
+- reg		: SPI chip select address
+
+Required properties (USB):
+- reg		: Number of the USB hub port or the USB host-controller port
+                  to which this device is attached
+
+Optional properties:
+
+- timepulse-gpios	: Time pulse GPIO
+- u-blox,extint-gpios	: External interrupt GPIO
+- v-bckp-supply	: Backup voltage regulator
+
+Example:
+
+serial@1234 {
+	compatible = "ns16550a";
+
+	gnss {
+		compatible = "u-blox,neo-8";
+
+		v-bckp-supply = <&gnss_v_bckp_reg>;
+		vcc-supply = <&gnss_vcc_reg>;
+	};
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index b5f978a4cac6..2128dfdf73f1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -374,6 +374,7 @@ tronsmart	Tronsmart
 truly	Truly Semiconductors Limited
 tsd	Theobroma Systems Design und Consulting GmbH
 tyan	Tyan Computer Corporation
+u-blox	u-blox
 ucrobotics	uCRobotics
 ubnt	Ubiquiti Networks
 udoo	Udoo
-- 
2.17.0
