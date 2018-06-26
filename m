Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24157C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D754221777
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D754221777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeFZHQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:16:18 -0400
Received: from regular1.263xmail.com ([211.150.99.140]:49561 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeFZHQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:16:16 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.76])
        by regular1.263xmail.com (Postfix) with ESMTP id 6265E4A6E;
        Tue, 26 Jun 2018 15:16:08 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 12D8D39A;
        Tue, 26 Jun 2018 15:16:05 +0800 (CST)
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <5fab89b86e7e88b84bc1ac679f3f0128>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 2568OG7VBV;
        Tue, 26 Jun 2018 15:16:08 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     seanpaul@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] devicetree/bindings: display: Add document for rockchip RGB output
Date:   Tue, 26 Jun 2018 15:15:39 +0800
Message-Id: <1529997340-156879-2-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529997340-156879-1-git-send-email-hjc@rock-chips.com>
References: <1529997340-156879-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This path add support rv1108 and px30 rgb output interface driver.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1509522765-118759-1-git-send-email-hjc@rock-chips.com
---

Changes in v4: Add support px30
Changes in v3: None
Changes in v2: None

.../bindings/display/rockchip/rockchip-rgb.txt     | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
new file mode 100644
index 0000000..077b9ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
@@ -0,0 +1,73 @@
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
+rgb-mode nodes described by:
+	Documentation/devicetree/bindings/display/panel/panel-rgb.txt
+Panel other required properties:
+- ports for remote rgb output.
+
+Example:
+
+panel: panel {
+	compatible = "auo,b101ean01";
+	enable-gpios = <&gpio7 21 GPIO_ACTIVE_HIGH>;
+	rgb-mode = "p888";
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


