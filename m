Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F66EC282C5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF301218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfAYDX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:23:56 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:59420 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbfAYDXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:23:20 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 6C7B25FDD9; Fri, 25 Jan 2019 11:23:15 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] ARM: dts: sun8i-a23: Add compatible strings to display pipeline device nodes
Date:   Fri, 25 Jan 2019 11:23:12 +0800
Message-Id: <20190125032314.20915-10-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125032314.20915-1-wens@csie.org>
References: <20190125032314.20915-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the compatible strings for the display pipeline on the A23 have
been added to the bindings, add the corresponding compatibles to the
device nodes already in the A23/A33 shared dtsi.

While the A23 has the TCON ch1 clock defined in the CCU, and the channel
1 registers are available, it does not have any means to use channel 1
due to a lack of downstream encoders, and the enable bit for channel 1 is
hard-wired to 0 (off). Hence the ch1 clock is left out.

As the MIPI DSI output device is not officially documented, and there
are no reference devices to test it, it is not covered by this patch.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index d00055e9eef5..a5e884a8b2ae 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -62,10 +62,26 @@
 	};
 };
 
+&be0 {
+	compatible = "allwinner,sun8i-a23-display-backend";
+};
+
 &ccu {
 	compatible = "allwinner,sun8i-a23-ccu";
 };
 
+&de {
+	compatible = "allwinner,sun8i-a23-display-engine";
+};
+
+&drc0 {
+	compatible = "allwinner,sun8i-a23-drc";
+};
+
+&fe0 {
+	compatible = "allwinner,sun8i-a23-display-frontend";
+};
+
 &pio {
 	compatible = "allwinner,sun8i-a23-pinctrl";
 	interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
@@ -73,6 +89,10 @@
 		     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&tcon0 {
+	compatible = "allwinner,sun8i-a23-tcon";
+};
+
 &usb_otg {
 	compatible = "allwinner,sun6i-a31-musb";
 };
-- 
2.20.1

