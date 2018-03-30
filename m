Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AIpwx49DqgK9hU9mp6BxGJYnc8xhQ0Jw83gvjvziMYuGqbaOqCYTI9aZK9e3UzH0492yFCSPF0EV
ARC-Seal: i=1; a=rsa-sha256; t=1522396080; cv=none;
        d=google.com; s=arc-20160816;
        b=zlbBjlhEqni3nWuEC4O/2xMZ7D0hqdk8RDw9peICxkVkwEneWfltOclFDH9qPvTwUv
         l0lLlS3yTFSW4Uh1ZsD4ekq5T/9kuW6SMkEb5d32MeEe7OJ9dy+klM4rbmoxZd+TB8Gf
         /E9R0rZJjzTH12JZeBw3FOA573/kag3n2A3xBiKyS/KwLt8EXh+VHBIOZx7XYtVqw9AW
         Dhl+/xyxQLwCokUif3eJVbQKnfYocr/3li3kYnRT03XlR9rTMxAIzD0ldYe921Njeztu
         BVnrKyJ38n8tTVdvuNH+qHSxjtzcUnAQJ43ZHW1ppR/FA8JuVAZSobCFfx/VWmeKAg5o
         VUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3gPacNMAP65VMlsSouVp0U0ewgs5xKXZCapJ8YAxxm8=;
        b=0XCAQT2FHmOjBOfZGAy4ebkNiMWVN3ctdQNyIUOILnLkI586epSQYhNYwq0ko3u9Nm
         97gex8ZCySqUWqxY22csN5l7RapU+czEKxm+pEZ6iYliJabWZkH1KnJRv/4REt5jPAms
         Aj8fr7mpa1pu0ERuT8rPJtZIbaylU4wQHlzhQtnnZGE5a2d2cB7i0i4xrU9XAVSVHRF0
         tojzkkgAh926CfngIbPYHFVQ/kXlynSgyrWH9E9zrwRzRhtQosKB6OvPGM1ZRg9VlsRy
         fXWOoWKyWWv0kD57MbUviEy8TwaXnqQyqOLMAsVYPnliEXJzJQTlR/mxPOcVsb9u/Z4N
         3zfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Wolfram Sang <wsa@the-dreams.de>,
	linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>,
	Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>,
	Bartosz Folta <bfolta@cadence.com>,
	Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>,
	Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>,
	Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>,
	linux-gpio@vger.kernel.org,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v4 08/10] dt-bindings: i3c: Document Cadence I3C master bindings
Date: Fri, 30 Mar 2018 09:47:49 +0200
Message-Id: <20180330074751.25987-9-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180330074751.25987-1-boris.brezillon@bootlin.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347992501604184?=
X-GMAIL-MSGID: =?utf-8?q?1596347992501604184?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Document Cadence I3C master DT bindings.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v4:
- Fix example to match the new representation
---
 .../devicetree/bindings/i3c/cdns,i3c-master.txt    | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt

diff --git a/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
new file mode 100644
index 000000000000..0e2b8b8770bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
@@ -0,0 +1,44 @@
+Bindings for cadence I3C master block
+=====================================
+
+Required properties:
+--------------------
+- compatible: shall be "cdns,i3c-master"
+- clocks: shall reference the pclk and sysclk
+- clock-names: shall contain "pclk" and "sysclk"
+- interrupts: the interrupt line connected to this I3C master
+- reg: I3C master registers
+
+Mandatory properties defined by the generic binding (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+
+- #address-cells: shall be set to 1
+- #size-cells: shall be set to 0
+
+Optional properties defined by the generic binding (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+
+- i2c-scl-hz
+- i3c-scl-hz
+
+I3C device connected on the bus follow the generic description (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details).
+
+Example:
+
+	i3c-master@0d040000 {
+		compatible = "cdns,i3c-master";
+		clocks = <&coreclock>, <&i3csysclock>;
+		clock-names = "pclk", "sysclk";
+		interrupts = <3 0>;
+		reg = <0x0d040000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-scl-hz = <100000>;
+
+		nunchuk: nunchuk@52 {
+			compatible = "nintendo,nunchuk";
+			reg = <0x52 0x80000010 0>;
+		};
+	};
+
-- 
2.14.1
