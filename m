Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524588644; cv=none;
        d=google.com; s=arc-20160816;
        b=WX8/cYZe0dHZjBR5RsFIWGI5lMO9kXpOTqokzU/HokFjIMoGQ9zu5fHSAmbO6yK6h3
         t23YwE6XkxURG4t9mJSZRlH97xyCFllVpgQitq7DcrH/EfBqbV+HjFELxiH64+C/mKdS
         rQjVVj1F9CIG+WQMXX9CtjDlUQbSBKpeD1vZWSZhM5Ag2GZIliw5m3NIK90IJJhZNTBC
         hL9IcvL5HB2hP0Ii5WcCYnvaZlkHL0ceaSBkBUYRvsfbQ2iOjkxLY2Mf/sKpCzbi07oE
         wkddOfFGVHTPisA0bZ0CRRZl8S5UloqzpFNX4IAgOyOhmkw/isIZcNpU+889x5Hmf4kF
         wuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=7pTFqTc57nEwulcoP0Y7x2MFaR1RmAijgmDh7fcRcEc=;
        b=AB2XlLRVOppFJ/YT1p1Ah+86pRLoVg2xGfx494iQrHtHtMzJ03+m3glQqENXYpboP0
         1rA404dVvGLw4+eEH+RH/U3fQ+DTQSzji06N95C5P/Jzv26205K5tlTGIaTXn0d2Bacx
         1OFR9tmLLpsipm3Dt4NKnisBRf6DDpUR/NUSWTDCDyVQXn4QM+CXgU1MZNBPeV0ZNrqG
         M/OROpPMQH/PnkMyjBgg4v7OcAOz9gVo8tc4qImOkpSHgEQCSMvWaNYXYU+PvkmV8v+P
         6Mc0eWu3qETMNp+tAcJu2CJvmEb6l5zH2mCdRE7uL1c52UgdFfaygq9dsiUf0DY1L5tn
         VECg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ogpLmZ0P;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ogpLmZ0P;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AB8JxZpTJ1+9UW/2HOWkaYEA8jEYkOe7E3Z522CUWkDU2C1gGmgacf2w8mHF2YQtZFH+J9Wi5fX24Q==
Sender: Johan Hovold <jhovold@gmail.com>
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/7] dt-bindings: add generic gnss binding
Date: Tue, 24 Apr 2018 18:34:53 +0200
Message-Id: <20180424163458.11947-3-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424163458.11947-1-johan@kernel.org>
References: <20180424163458.11947-1-johan@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647062942889326?=
X-GMAIL-MSGID: =?utf-8?q?1598647062942889326?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Describe generic properties for GNSS receivers.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 .../devicetree/bindings/gnss/gnss.txt         | 36 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/gnss.txt

diff --git a/Documentation/devicetree/bindings/gnss/gnss.txt b/Documentation/devicetree/bindings/gnss/gnss.txt
new file mode 100644
index 000000000000..bcdaca043eaa
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
+Required Properties:
+
+- compatible 	: A string reflecting the vendor and specific device the node
+		  represents
+
+Optional Properties:
+- enable-gpios	: GPIO used to power on (or off) the device
+- timepulse-gpios	: Timepulse (e.g. 1PPS) GPIO
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
2.17.0
