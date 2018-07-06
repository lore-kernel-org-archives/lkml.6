Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879BCC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C44A2147E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C44A2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934500AbeGFRzf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:55:35 -0400
Received: from mailoutvs58.siol.net ([185.57.226.249]:41599 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933961AbeGFRxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:53:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id CFFDC520EC6;
        Fri,  6 Jul 2018 19:53:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vKXqPu_EFRtk; Fri,  6 Jul 2018 19:53:41 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 463D352099D;
        Fri,  6 Jul 2018 19:53:41 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id B776B5211E0;
        Fri,  6 Jul 2018 19:53:38 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 14/17] ARM: dts: sun8i: r40: Add missing TCON-TOP - TCON connections
Date:   Fri,  6 Jul 2018 19:51:10 +0200
Message-Id: <20180706175113.26698-15-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706175113.26698-1-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current R40 is missing some graph connections between TCON TOP and
TCONs.

Add them.

Fixes: 05a43a262d03 ("ARM: dts: sun8i: r40: Add HDMI pipeline")

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 20 ---------
 arch/arm/boot/dts/sun8i-r40.dtsi              | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 4f3d583183dc..737cf01b1acd 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -251,26 +251,6 @@
 	regulator-name = "vcc-wifi";
 };
 
-&tcon_top_hdmi_in_tcon_tv0 {
-	remote-endpoint = <&tcon_tv0_out_tcon_top>;
-};
-
-&tcon_top_mixer0_out_tcon_tv0 {
-	remote-endpoint = <&tcon_tv0_in_tcon_top>;
-};
-
-&tcon_tv0_in {
-	tcon_tv0_in_tcon_top: endpoint {
-		remote-endpoint = <&tcon_top_mixer0_out_tcon_tv0>;
-	};
-};
-
-&tcon_tv0_out {
-	tcon_tv0_out_tcon_top: endpoint {
-		remote-endpoint = <&tcon_top_hdmi_in_tcon_tv0>;
-	};
-};
-
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 6b4fe8eeee99..e5c7e4804384 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -601,10 +601,12 @@
 
 					tcon_top_mixer0_out_tcon_tv0: endpoint@2 {
 						reg = <2>;
+						remote-endpoint = <&tcon_tv0_in_tcon_top_mixer0>;
 					};
 
 					tcon_top_mixer0_out_tcon_tv1: endpoint@3 {
 						reg = <3>;
+						remote-endpoint = <&tcon_tv1_in_tcon_top_mixer0>;
 					};
 				};
 
@@ -634,10 +636,12 @@
 
 					tcon_top_mixer1_out_tcon_tv0: endpoint@2 {
 						reg = <2>;
+						remote-endpoint = <&tcon_tv0_in_tcon_top_mixer1>;
 					};
 
 					tcon_top_mixer1_out_tcon_tv1: endpoint@3 {
 						reg = <3>;
+						remote-endpoint = <&tcon_tv1_in_tcon_top_mixer1>;
 					};
 				};
 
@@ -648,10 +652,12 @@
 
 					tcon_top_hdmi_in_tcon_tv0: endpoint@0 {
 						reg = <0>;
+						remote-endpoint = <&tcon_tv0_out_tcon_top>;
 					};
 
 					tcon_top_hdmi_in_tcon_tv1: endpoint@1 {
 						reg = <1>;
+						remote-endpoint = <&tcon_tv1_out_tcon_top>;
 					};
 				};
 
@@ -679,11 +685,30 @@
 				#size-cells = <0>;
 
 				tcon_tv0_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <0>;
+
+					tcon_tv0_in_tcon_top_mixer0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon_top_mixer0_out_tcon_tv0>;
+					};
+
+					tcon_tv0_in_tcon_top_mixer1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&tcon_top_mixer1_out_tcon_tv0>;
+					};
 				};
 
 				tcon_tv0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <1>;
+
+					tcon_tv0_out_tcon_top: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&tcon_top_hdmi_in_tcon_tv0>;
+					};
 				};
 			};
 		};
@@ -702,11 +727,30 @@
 				#size-cells = <0>;
 
 				tcon_tv1_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <0>;
+
+					tcon_tv1_in_tcon_top_mixer0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon_top_mixer0_out_tcon_tv1>;
+					};
+
+					tcon_tv1_in_tcon_top_mixer1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&tcon_top_mixer1_out_tcon_tv1>;
+					};
 				};
 
 				tcon_tv1_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <1>;
+
+					tcon_tv1_out_tcon_top: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&tcon_top_hdmi_in_tcon_tv1>;
+					};
 				};
 			};
 		};
-- 
2.18.0

