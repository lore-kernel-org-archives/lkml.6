Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELsYUtXUKBHdy8jN+es/wpkkecXU30kVHGcycfpDEXNQpWi9+YoKwRkutAtroS3tHrFflY1l
ARC-Seal: i=1; a=rsa-sha256; t=1520281693; cv=none;
        d=google.com; s=arc-20160816;
        b=KoHsBv2oX8ghhwTgT/pszQ2bLYc5d8Kqql9e4QtYGbNP0UOHsQSUOwAdFBtSUkm/I1
         kpD+x2Ubea62+9QFtoQF2dxcJxOY+jcpw39brYEMekAxNY7gGrfDTkLSDtNIwwXnHD1z
         hI4lxmo0GxFREtvFAzbefGsBu9VhjAb542umMl4gwzwh7IwC9hzxYSm1u8r5heQmQh1L
         wJahBTJCDDBntIbDcU7JfzgJ+nTqdMvJVlPXYzq/3nEQqYZhVfbR9JB5zc3oQPuWtR7n
         MBggbFzAWFcgwCwccvVNHqEjPV2ryxCPn15M3cyGj0sX1TMcKfV5SrCzukSIXtQyADXx
         igEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=nb6odEDyFVKUYOFjlYDIg8JEPdnsTQdMdwJFfOyp0ok=;
        b=UkGChX1cuO9vMA8yqHdRPrWp5WtU7p4L2667UleU7oH+QQkq+AVA3oteZ0xJwiBb6f
         hx3ad7wwZliVclj8sFbwSmgOOSeS4DIp2++EXmMxuZ4BDGZXvPnAwl7EFUgX0hAPXUik
         A9KtloboJzn5h0OXreOvP6XgXIfFDHT+f9JaUOx4O91KqJqEctJFD9s197Ch/IuWH992
         NFf62S55+z129pS/sFaP5jP6xLu/tIprR1Y3wz6V0MuBqMyOzX4ZP6zWYkjKZ7IranA3
         0det+t61wPViuBuybAldNuw+fa+7bu79iQI+DIOvYf8jNsc7JcflYRwffSvCOkTAs/Ve
         L9QQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH 3/5] dt-bindings: soc: Add a binding for the Broadcom VCHI services.
Date: Mon,  5 Mar 2018 12:28:04 -0800
Message-Id: <20180305202806.21219-4-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180305202806.21219-1-eric@anholt.net>
References: <20180305202806.21219-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594130897690298629?=
X-GMAIL-MSGID: =?utf-8?q?1594130897690298629?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The VCHI communication channel can be provided by BCM283x and Capri
SoCs, to communicate with the VPU-side OS services.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
new file mode 100644
index 000000000000..4055a8977f3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
@@ -0,0 +1,18 @@
+Broadcom VCHIQ firmware services
+
+Required properties:
+
+- compatible:	Should be "brcm,bcm2835-vchiq"
+- reg:		Physical base address and length of the doorbell register pair
+- interrupts:	The interrupt number
+		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+- firmware:	Reference to the RPi firmware device node
+
+Example:
+
+vchi@7e00b840 {
+	compatible = "brcm,bcm2835-vchiq";
+	reg = <0x7e00b840 0xf>;
+	interrupts = <0 2>;
+	firmware = <&firmware>;
+};
-- 
2.16.2
