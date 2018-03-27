Return-Path: <sebastian.reichel@collabora.co.uk>
X-Google-Smtp-Source: AG47ELtKoyitBlLjRpf7afoBJ6ZSGzxU+2Sm3tpCva8sL6mbpNPU2UmdRZLc0YjlaCcTp93fNuBb
ARC-Seal: i=1; a=rsa-sha256; t=1522158786; cv=none;
        d=google.com; s=arc-20160816;
        b=vLb0ljAnnf6jMcOOaDlzA3RWKfwFSivbFX3tPMxJKeQTmodzGSoPLB/bgsQ2uBGbx4
         4e34EUuVkHSNvvq4NcT5lKVyo0Lc4zEZTg+P9QSos0kFElhXT497rHradRNKY9qpTJk2
         TxV3iwOmvgQrJBDDAyMRF8add3Ho0sSeEAuMlvXpXlbwTEeT21MVjb5V1vT9NISV5v9Y
         +maE9f//9xRzlejkZmilGXGmoKp/kjpIdJwKhopE1HcHEGWUXvGb3BUeHaKG99DX2QlA
         ISvwlPXUUXgvGWGQ+SjUImmNkMn7YJTz7NZ6hVC5x3BHTPRAxde5Nd1rOtzu3YT2ZHDN
         zBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Y651I/TGDm4gdGyaIQtWun2zHsq11bmIJ036T2ttAKY=;
        b=pKXOiAOgiZ4mAGfjq545ZU+GpaC/JJh45s6jC2DuIq1h8ql+mKzHpJxaVTyb45TyR9
         6WZRDXFJZULximuj2cPS1iFVWErRpsCetQzpO8UgBOzZty8FlAI7LmM5OyRQqsXWL3L4
         TsfS1msipWLrvcHL0Mgm2j55uGnyFBnivmg/DxSk0U4OOZT4k7VBbGpEEdj4RGWzlGg/
         0K0WFnMWOsQSodeVHzGN1Q8MMctT29Gy6W+NRUeoiuAmxAXF/xaRfd7eleDPUYYPn3Bu
         U6e1KxxLl8J2YdFMps11yg/GubbjB/O7URudNVL7d1+VlsLcUJ99LUquN8kVWU0BUYzr
         mAiw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 2a00:1098:0:82:1000:25:2eeb:e3e3 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 2a00:1098:0:82:1000:25:2eeb:e3e3 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Nandor Han <nandor.han@ge.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 1/3] dt-bindings: misc: achc: Make ezport distinguishable
Date: Tue, 27 Mar 2018 15:52:57 +0200
Message-Id: <20180327135259.30890-2-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180327135259.30890-1-sebastian.reichel@collabora.co.uk>
References: <20180327135259.30890-1-sebastian.reichel@collabora.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596099171871027959?=
X-GMAIL-MSGID: =?utf-8?q?1596099171871027959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This updates the GE ACHC binding, so that different compatible
strings are used for the programming interface, which is the
ezport interface from NXP MK20FN1M0VMD12 and the microcontroller's
normal SPI interface.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 Documentation/devicetree/bindings/misc/ge-achc.txt | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/ge-achc.txt b/Documentation/devicetree/bindings/misc/ge-achc.txt
index 77df94d7a32f..6c6bd6568504 100644
--- a/Documentation/devicetree/bindings/misc/ge-achc.txt
+++ b/Documentation/devicetree/bindings/misc/ge-achc.txt
@@ -7,7 +7,13 @@ Note: This device does not expose the peripherals as USB devices.
 
 Required properties:
 
-- compatible : Should be "ge,achc"
+- compatible : Should be
+  "ge,achc" (normal interface)
+  "ge,achc-ezport" (flashing interface)
+
+Required properties (flashing interface only):
+
+- reset-gpios: GPIO Specifier for the reset GPIO
 
 Required SPI properties:
 
@@ -19,8 +25,15 @@ Required SPI properties:
 
 Example:
 
-spidev0: spi@0 {
-	compatible = "ge,achc";
+spidev1: spi@0 {
+	compatible = "ge,achc-ezport";
 	reg = <0>;
+	spi-max-frequency = <300000>;
+	reset-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+};
+
+spidev0: spi@1 {
+	compatible = "ge,achc";
+	reg = <1>;
 	spi-max-frequency = <1000000>;
 };
-- 
2.16.2
