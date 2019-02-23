Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54548C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3F8206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfBWRkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 12:40:02 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:42372 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfBWRju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 12:39:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 19D39FB03;
        Sat, 23 Feb 2019 18:39:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P1htf7QqnMWB; Sat, 23 Feb 2019 18:39:47 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 2C6DF4149E; Sat, 23 Feb 2019 18:39:44 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/3] dt-bindings: Add Rocktech jh057n00900 panel bindings
Date:   Sat, 23 Feb 2019 18:39:43 +0100
Message-Id: <bc44793f9ec456f3147537e0ad4083e94df0294b.1550943220.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550943220.git.agx@sigxcpu.org>
References: <cover.1550943220.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rocktec jh057n00900 is a 5.5" MIPI DSI video mode panel with a
720x1440 resolution and a built in backlight.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../display/panel/rocktech,jh057n00900.txt     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
new file mode 100644
index 000000000000..32f4001d2d6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
@@ -0,0 +1,18 @@
+Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel
+
+Required properties:
+- compatible: should be "rocktech,jh057n00900"
+- reg: DSI virtual channel of the peripheral
+- reset-gpios: panel reset gpio
+- backlight: phandle of the backlight device attached to the panel
+
+Example:
+
+	&mipi_dsi {
+		panel {
+			compatible = "rocktech,jh057n00900";
+			reg = <0>;
+			backlight = <&backlight>;
+			reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
+		};
+	};
-- 
2.20.1

