Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDA8C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FC425C87
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FC425C87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030228AbeGBKcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:32:45 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36356 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965174AbeGBKcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:32:43 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jul 2018 06:32:42 EDT
Received: from wd0142.dip.tu-dresden.de ([141.76.108.142] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fZw8O-0004Go-0d; Mon, 02 Jul 2018 12:32:40 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     thierry.reding@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        briannorris@chromium.org, hl@rock-chips.com,
        nickey.yang@rock-chips.com, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 2/3] dt-bindings: Add KINGDISPLAY KD097D04 panel bindings
Date:   Mon,  2 Jul 2018 12:32:28 +0200
Message-Id: <20180702103229.3952-3-heiko@sntech.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180702103229.3952-1-heiko@sntech.de>
References: <20180702103229.3952-1-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nickey Yang <nickey.yang@rock-chips.com>

The KINGDISPLAY KD097D04 is a 9.7" panel with a 1536x2048
resolution and connected to DSI using 8 lanes.

Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../display/panel/kingdisplay,kd097d04.txt    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt

diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt
new file mode 100644
index 000000000000..164a5fa236da
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt
@@ -0,0 +1,22 @@
+Kingdisplay KD097D04 9.7" 1536x2048 TFT LCD panel
+
+Required properties:
+- compatible: should be "kingdisplay,kd097d04"
+- reg: DSI virtual channel of the peripheral
+- power-supply: phandle of the regulator that provides the supply voltage
+- enable-gpios: panel enable gpio
+
+Optional properties:
+- backlight: phandle of the backlight device attached to the panel
+
+Example:
+
+	&mipi_dsi {
+		panel {
+			compatible = "kingdisplay,kd097d04";
+			reg = <0>;
+			power-supply = <...>;
+			backlight = <&backlight>;
+			enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+		};
+	};
-- 
2.17.0

