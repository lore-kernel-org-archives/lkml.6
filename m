Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D511FC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8422A258A0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8422A258A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933903AbeFYMGB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:06:01 -0400
Received: from mailoutvs39.siol.net ([185.57.226.230]:48359 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755357AbeFYMFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:05:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 5A3055208ED;
        Mon, 25 Jun 2018 14:05:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cEo5PybEwojp; Mon, 25 Jun 2018 14:05:50 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id DD5905202EC;
        Mon, 25 Jun 2018 14:05:50 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 66DCA520901;
        Mon, 25 Jun 2018 14:05:48 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 24/24] ARM: dts: sun8i: r40: Enable HDMI output on BananaPi M2 Ultra
Date:   Mon, 25 Jun 2018 14:03:04 +0200
Message-Id: <20180625120304.7543-25-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since HDMI can be considered as main output, most capable mixer is
connected to it (mixer0).

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 27d9ccd0ef2f..0ebc2f9a980e 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -58,6 +58,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -93,6 +104,10 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -101,6 +116,16 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -195,6 +220,26 @@
 	status = "okay";
 };
 
+&tcon_top_hdmi_in_tcon_tv0 {
+	remote-endpoint = <&tcon_tv0_out_tcon_top>;
+};
+
+&tcon_top_mixer0_out_tcon_tv0 {
+	remote-endpoint = <&tcon_tv0_in_tcon_top>;
+};
+
+&tcon_tv0_in {
+	tcon_tv0_in_tcon_top: endpoint {
+		remote-endpoint = <&tcon_top_mixer0_out_tcon_tv0>;
+	};
+};
+
+&tcon_tv0_out {
+	tcon_tv0_out_tcon_top: endpoint {
+		remote-endpoint = <&tcon_top_hdmi_in_tcon_tv0>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.18.0

