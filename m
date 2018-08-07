Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DACC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F0021990
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F0021990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeHHARE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:17:04 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:49600 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeHHARD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:17:03 -0400
Received: from localhost.localdomain ([81.67.76.113])
        by mwinf5d58 with ME
        id LN0T1y0022Sg6Vd03N0bXE; Wed, 08 Aug 2018 00:00:35 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Wed, 08 Aug 2018 00:00:35 +0200
X-ME-IP: 81.67.76.113
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: soc: amlogic: add meson-canvas documentation
Date:   Wed,  8 Aug 2018 00:00:09 +0200
Message-Id: <20180807220011.24436-3-maxi.jourdan@wanadoo.fr>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
References: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings doc for amlogic,meson-canvas

Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
---
 .../soc/amlogic/amlogic,meson-canvas.txt      | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
new file mode 100644
index 000000000000..5f0351717bee
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
@@ -0,0 +1,36 @@
+Amlogic Canvas
+================================
+
+A canvas is a collection of metadata that describes a pixel buffer.
+Those metadata include: width, height, phyaddr, wrapping, block mode
+and endianness.
+
+Many IPs within Amlogic SoCs rely on canvas indexes to read/write pixel data
+rather than use the phy addresses directly. For instance, this is the case for
+the video decoders and the display.
+
+Amlogic SoCs have 256 canvas.
+
+Device Tree Bindings:
+---------------------
+
+Canvas Provider
+--------------------------
+
+Required properties:
+- compatible: "amlogic,canvas"
+
+Parent node should have the following properties :
+- compatible: "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd"
+- reg: base address and size of the DMC system control register space.
+
+Example:
+
+sysctrl_DMC: system-controller@0 {
+	compatible = "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd";
+	reg = <0x0 0x0 0x0 0x1000>;
+
+	canvas: canvas-provider@0 {
+		compatible = "amlogic,canvas";
+	};
+};
-- 
2.18.0

