Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AG47ELtdQEPMRX9elUiJ0vsrSAfFQsOtS9c+TsemXdRsDVHWOtxYSxCDWO5sKwKKCrOps3C0+4d5
ARC-Seal: i=1; a=rsa-sha256; t=1521802841; cv=none;
        d=google.com; s=arc-20160816;
        b=L+abqKV0HEpefrcMS4GfmAKG+qEuF54HFxVKqUrGD2KVZmGZXBwS5s95Sb6GZ7qMX2
         rugGDYU0en41tix8de3HPBNnrwBRSWC61ysNgdX3Zle0J6XtqfNTlLeSgfBi4Ru6gYLW
         OgbczTbYJSc+Dq03eqrlq1jxPf7nhSiMQeb4jAw4JxnBwnmw/mwrS2N/o/+oX72EE+yr
         ZKQb7KBRYrVeLRlnYKxm0eVwkGJ+stgbiKusKyc0BrkZL44wI6cU0lrdxnsV08Gw695n
         Qykv9wlV3XBsfQgVg5IyNGvj8BrFIQOr1pCcpuEi1hdOU8ge3nhXf5WucvpsJjzZy495
         UL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=gkgdTDR+m/wLpBsG3M/rleTTlEnk5IAv8pE8acAsJ8k=;
        b=HeDEoy9C0BigS5M0RmlhjBhpZ3Yqo3xd1CNYwpAsLr8pTcEnBZb+5O4VsiKvrgjICS
         bEgunhVtTWDi3X9f0+Saa6MWmH9vzwefAC9WTdQmaKFgPQPgk6M0kJkk7vAJ+eo5Cvbe
         S9qAkjiQLanm5GeEZkE3lQX7IqUHxm2+fnPsQQkMim8QSgS3+x6sxXB/bANno0fWAnoa
         u7FntdUWJMVItEV2JC74U03FFLYA+KyG4ojsVCe2f4ORH6+VC52J0wcWuRbdtqgawz69
         Scg61/n0n9VpcOL+yltzraF+diOFadIAXcHcJXr7X/frZyhp5b9vzdFTRAWpsB0O+Paj
         kN4Q==
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
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
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
Subject: [PATCH v3 11/11] dt-bindings: gpio: Add bindings for Cadence I3C gpio expander
Date: Fri, 23 Mar 2018 12:00:20 +0100
Message-Id: <20180323110020.19080-12-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180323110020.19080-1-boris.brezillon@bootlin.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725936015625601?=
X-GMAIL-MSGID: =?utf-8?q?1595725936015625601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Document the Cadence I3C gpio expander bindings.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 .../devicetree/bindings/gpio/gpio-cdns-i3c.txt     | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
new file mode 100644
index 000000000000..634b1f268215
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
@@ -0,0 +1,38 @@
+* Cadence I3C GPIO expander
+
+The Cadence I3C GPIO expander provides 8 GPIOs controllable over I3C.
+This GPIOs can be configured in output or input mode and if they are in input
+mode they can generate IBIs (In Band Interrupts).
+
+Required properties for GPIO node:
+- reg : 3 cells encoding the I3C static address (none in our case) and the I3C
+	Provisional ID. See Documentation/devicetree/bindings/i3c/i3c.txt for
+	more details.
+	Should be <0x0 0x392 0x0>.
+- gpio-controller : Marks the device node as a gpio controller.
+- #gpio-cells : Should be two. The first cell is the pin number and
+  the second cell is used to specify the gpio polarity:
+      0 = active high
+      1 = active low
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells : Should be 2.  The first cell is the GPIO number.
+  The second cell bits[3:0] is used to specify trigger type and level flags:
+      1 = low-to-high edge triggered.
+      2 = high-to-low edge triggered.
+      3 = triggered on both edges.
+      4 = active high level-sensitive.
+      8 = active low level-sensitive.
+
+Example:
+
+	i3c-master@xxx {
+		...
+		i3c_gpio_expander: gpio@0,1c9,0 {
+			reg = <0 0x392 0x0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+		...
+	};
-- 
2.14.1
