Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeEOBob (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 21:44:31 -0400
Received: from vern.gendns.com ([206.190.152.46]:58178 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752170AbeEOBoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 21:44:25 -0400
From: David Lechner <david@lechnology.com>
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        limor@ladyada.net, Nitin Patil <nitin@mindsensors.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: new binding for Ilitek ILI9341 display panels
Date: Mon, 14 May 2018 20:43:48 -0500
Message-Id: <20180515014349.26226-3-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515014349.26226-1-david@lechnology.com>
References: <20180515014349.26226-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new binding for Ilitek ILI9341 display panels. It includes
a compatible string for one display (more can be added in the future).

The vendor prefix "noname" is used because the vendor is not known.
The YX240QV29-T panel[1] is found, for example, in an Adafruit breakout
board[2] and in Mindsensors' PiStorms[3].

[1]: https://cdn-learn.adafruit.com/assets/assets/000/046/879/original/SPEC-YX240QV29-T_Rev.A__1_.pdf
[2]: https://www.adafruit.com/product/2478
[3]: http://www.mindsensors.com/stem-with-robotics/13-pistorms-v2-base-kit-raspberry-pi-brain-for-lego-robot

Signed-off-by: David Lechner <david@lechnology.com>
---
 .../bindings/display/ilitek,ili9341.txt       | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9341.txt

diff --git a/Documentation/devicetree/bindings/display/ilitek,ili9341.txt b/Documentation/devicetree/bindings/display/ilitek,ili9341.txt
new file mode 100644
index 000000000000..0fc90b2dd732
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ilitek,ili9341.txt
@@ -0,0 +1,27 @@
+Ilitek ILI9341 display panels
+
+This binding is for display panels using an Ilitek ILI9341 controller in SPI
+mode.
+
+Required properties:
+- compatible:	"noname,yx240qv29", "ilitek,ili9341"
+- dc-gpios:	D/C pin
+- reset-gpios:	Reset pin
+
+The node for this driver must be a child node of a SPI controller, hence
+all mandatory properties described in ../spi/spi-bus.txt must be specified.
+
+Optional properties:
+- rotation:	panel rotation in degrees counter clockwise (0,90,180,270)
+- backlight:	phandle of the backlight device attached to the panel
+
+Example:
+	display@0{
+		compatible = "noname,yx240qv29", "ilitek,ili9341";
+		reg = <0>;
+		spi-max-frequency = <32000000>;
+		dc-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+		rotation = <270>;
+		backlight = <&backlight>;
+	};
-- 
2.17.0
