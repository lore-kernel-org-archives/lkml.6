Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5CFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D1225C79
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D1225C79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965569AbeGBK1j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:27:39 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36172 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965366AbeGBK1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:27:36 -0400
Received: from wd0142.dip.tu-dresden.de ([141.76.108.142] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fZw3Q-0004Ek-L2; Mon, 02 Jul 2018 12:27:32 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     thierry.reding@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        briannorris@chromium.org, hl@rock-chips.com,
        emil.l.velikov@gmail.com, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 3/4] dt-bindings: Add Innolux P097PFG panel bindings
Date:   Mon,  2 Jul 2018 12:27:20 +0200
Message-Id: <20180702102721.3546-4-heiko@sntech.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180702102721.3546-1-heiko@sntech.de>
References: <20180702102721.3546-1-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huang lin <hl@rock-chips.com>

The Innolux P097PFG panel is 9.7" panel with 1536X2048
resolution, it reuse P079ZCA panel driver, so improve
p079ZCA dt-binding to support P097PFG.

Changes in v2:
- None
Changes in v3:
- None
Changes in v4:
- None
Changes in v5:
- use separate file for binding
- keep power supplies as required

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../display/panel/innolux,p097pfg.txt         | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt b/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt
new file mode 100644
index 000000000000..595d9dfeffd3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt
@@ -0,0 +1,24 @@
+Innolux P097PFG 9.7" 1536x2048 TFT LCD panel
+
+Required properties:
+- compatible: should be "innolux,p097pfg"
+- reg: DSI virtual channel of the peripheral
+- avdd-supply: phandle of the regulator that provides positive voltage
+- avee-supply: phandle of the regulator that provides negative voltage
+- enable-gpios: panel enable gpio
+
+Optional properties:
+- backlight: phandle of the backlight device attached to the panel
+
+Example:
+
+	&mipi_dsi {
+		panel {
+			compatible = "innolux,p079zca";
+			reg = <0>;
+			avdd-supply = <...>;
+			avee-supply = <...>;
+			backlight = <&backlight>;
+			enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+		};
+	};
-- 
2.17.0

