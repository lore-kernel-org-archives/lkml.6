Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C60C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BDE2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BDE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJRPeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:34:01 -0400
Received: from hermes.aosc.io ([199.195.250.187]:49562 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbeJRPeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:34:00 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 121FE15D295;
        Thu, 18 Oct 2018 07:34:15 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 4/9] dt-bindings: Add ANX6345 DP/eDP transmitter binding
Date:   Thu, 18 Oct 2018 15:33:22 +0800
Message-Id: <20181018073327.64942-5-icenowy@aosc.io>
In-Reply-To: <20181018073327.64942-1-icenowy@aosc.io>
References: <20181018073327.64942-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ANX6345 is an ultra-low power DisplayPort/eDP transmitter designed
for portable devices.

Add a binding document for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../bindings/display/bridge/anx6345.txt       | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/anx6345.txt b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
new file mode 100644
index 000000000000..0689d4eb5f65
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
@@ -0,0 +1,39 @@
+Analogix ANX6345 eDP Transmitter
+--------------------------------
+
+The ANX6345 is an ultra-low power Full-HD eDP transmitter designed for
+portable devices.
+
+Required properties:
+
+ - compatible		: "analogix,anx6345"
+ - reg			: I2C address of the device
+ - reset-gpios		: Which GPIO to use for reset
+
+Optional properties:
+
+ - dvdd12-supply	: Regulator for 1.2V digital core power.
+ - dvdd25-supply	: Regulator for 2.5V digital core power.
+ - panel-supply		: Regulator for the power of the panel.
+ - edid			: verbatim EDID data block describing attached
+			  panel, only used when the panel has no EDID info.
+ - Video port for RGB input, using the DT bindings defined in [1].
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+
+anx6345: anx6345@38 {
+	compatible = "analogix,anx6345";
+	reg = <0x38>;
+	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+	panel-supply = <&reg_dc1sw>;
+	dvdd25-supply = <&reg_dldo2>;
+	dvdd12-supply = <&reg_fldo1>;
+
+	port {
+		anx6345_in: endpoint {
+			remote-endpoint = <&tcon0_out_anx6345>;
+		};
+	};
+};
-- 
2.18.1

