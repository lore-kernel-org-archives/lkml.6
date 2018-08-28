Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C646C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25E320846
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25E320846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeH1MDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:03:30 -0400
Received: from regular1.263xmail.com ([211.150.99.133]:48776 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeH1MDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:03:30 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.239])
        by regular1.263xmail.com (Postfix) with ESMTP id 365673B0;
        Tue, 28 Aug 2018 16:12:55 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 5A85C3B2;
        Tue, 28 Aug 2018 16:12:52 +0800 (CST)
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <6a8a681dae9e2ea87aa3202d454b1d60>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 46428VFAD7;
        Tue, 28 Aug 2018 16:12:54 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     hjc@rock-chips.com, heiko@sntech.de, robh@kernel.org,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] devicetree/bindings: display: Add document for rockchip RGB output
Date:   Tue, 28 Aug 2018 16:12:33 +0800
Message-Id: <1535443954-38806-2-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535443954-38806-1-git-send-email-hjc@rock-chips.com>
References: <1535443954-38806-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This path add support rv1108 and px30 rgb output interface driver.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1509522765-118759-1-git-send-email-hjc@rock-chips.com
---
 .../bindings/display/rockchip/rockchip-rgb.txt     | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
new file mode 100644
index 0000000..1f4909c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
@@ -0,0 +1,70 @@
+Rockchip RV1108 RGB interface
+================================
+
+Required properties:
+- compatible: matching the soc type:
+	- "rockchip,px30-rgb";
+	- "rockchip,rv1108-rgb";
+
+Optional properties:
+- pinctrl-names: should be a "lcdc" entry or a "default" entry.
+- pinctrl-0: pin control group to be used for this interface.
+
+The rgb has two video ports described by:
+	Documentation/devicetree/bindings/media/video-interfaces.txt
+Their connections are modeled using the OF graph bindings specified in
+	Documentation/devicetree/bindings/graph.txt.
+
+- video port 0 for the VOP input, the remote endpoint maybe vopb/vopl/vop
+- video port 1 for either a panel or subsequent encoder
+
+the panel described by:
+	Documentation/devicetree/bindings/display/panel/simple-panel.txt
+Panel other required properties:
+- ports for remote rgb output.
+
+Example:
+
+panel: panel {
+	compatible = "auo,b101ean01";
+	enable-gpios = <&gpio7 21 GPIO_ACTIVE_HIGH>;
+
+	ports {
+		panel_in_rgb: endpoint {
+			remote-endpoint = <&rgb_out_panel>;
+		};
+	};
+};
+
+For Rockchip RV1108:
+
+	rgb: rgb {
+		compatible = "rockchip,rv1108-rgb";
+		pinctrl-names = "lcdc";
+		pinctrl-0 = <&lcdc_ctl>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rgb_in: port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				rgb_in_vop: endpoint {
+					remote-endpoint = <&vop_out_rgb>;
+				};
+			};
+
+			rgb_out: port@1 {
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				rgb_out_panel: endpoint {
+					remote-endpoint = <&panel_in_rgb>;
+				};
+			};
+		};
+	};
-- 
2.7.4


