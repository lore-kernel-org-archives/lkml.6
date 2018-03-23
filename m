Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AG47ELsPGWcOtBDhfMOrn0M7Av19nr+ECmcuo7pRqbTLtwY+oo0LlFW36XBlJZQIhAijVT9StSJP
ARC-Seal: i=1; a=rsa-sha256; t=1521802840; cv=none;
        d=google.com; s=arc-20160816;
        b=TE+0dFPMuqQNexCcFeTJK5PfTXUqSYPv3KtUIAJmw3CcAGEsKOBPFdNEGmFgbLoUw7
         ufQ8Ndksna+gJgyycl2i5Oi3U+0btaY2L6Z0e12lDopPJOzIXmltIRsWe20WdRe98A0S
         2b2DIEcmOat/rwNoB0xKIaGEYbg61dAq4/Z65G80qppYhibZHNEjDaYxaEpXRObC+RTk
         jMA94Fx9wWFjeENgIv3rYi+Y7dzJpVVXp8WLPAd79w54ir3cLnGc0XPMlTaCkvyMyyIX
         T1mxG/lFNBgyd2aNDomtrDKnDFUvdpKPuo4m7lCupTjWTEN+/P+3ckE8LtQGES1yabn5
         SLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=aI+wQgkKwCNOV+nG5mtsvcMRkgf9fE4AnYOboA9g0iw=;
        b=ymhUkEhJ6+WDwv4WtUF4YaL+JRi3TroN7BDosS/fcA61PoqPK0sHcW2hfEolvwJVCd
         /X0RmgUpHk6bCO7FfOr3S3vDjjvMSJRpUuXFzse8GUe4iABkajicUlezPpRhWg2TBJlF
         LCLCEoZOmQkRDcoH7+f6kmr0lO79oBkqN0MAaOA+Vi43jhz3KpOK+Ry3jJn3/+ehOu3T
         XlWZp5vC7Gzei/HC2JHAX30H4elg3+Xku0p0o+HUSDI28dL1un31WS7OtupPJqpRBOtZ
         Bu6nCfyiypUiib/Q95aLUOnKY5qNdrbT53kRKISnrYHPwWYKzk+QWHyzgn64eyrwS1yw
         ttpg==
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
	Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v3 09/11] dt-bindings: i3c: Document Cadence I3C master bindings
Date: Fri, 23 Mar 2018 12:00:18 +0100
Message-Id: <20180323110020.19080-10-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180323110020.19080-1-boris.brezillon@bootlin.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725934834963345?=
X-GMAIL-MSGID: =?utf-8?q?1595725934834963345?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Boris Brezillon <boris.brezillon@free-electrons.com>

Document Cadence I3C master DT bindings.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/i3c/cdns,i3c-master.txt    | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt

diff --git a/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
new file mode 100644
index 000000000000..f9e4af4ff1c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
@@ -0,0 +1,45 @@
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
+- i2c-scl-frequency
+- i3c-scl-frequency
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
+		i2c-scl-frequency = <100000>;
+
+		nunchuk: nunchuk@52 {
+			compatible = "nintendo,nunchuk";
+			reg = <0x52>;
+			i3c-lvr = <0x10>;
+		};
+	};
+
-- 
2.14.1
