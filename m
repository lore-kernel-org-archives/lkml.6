Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932119AbeEWHmx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:42:53 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36415 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932102AbeEWHms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:42:48 -0400
X-Google-Smtp-Source: AB8JxZoGbv5ziMppXtOdoa0zzp6KZN6p4dh618+FThdJ2Fknp5mygZImHV/GLfCXjvLUTa3hOHzFvQ==
From: Lin Huang <hl@rock-chips.com>
To: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com,
        kishon@ti.com
Cc: dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        daniel.vetter@intel.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        Lin Huang <hl@rock-chips.com>
Subject: [PATCH v7 2/5] Documentation: dt-bindings: phy: add phy_config for Rockchip USB Type-C PHY
Date: Wed, 23 May 2018 15:42:30 +0800
Message-Id: <1527061353-16902-2-git-send-email-hl@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527061353-16902-1-git-send-email-hl@rock-chips.com>
References: <1527061353-16902-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If want to do training outside DP Firmware, need phy voltage swing
and pre_emphasis value.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
- None 
Changes in v3:
- modify property description and add this property to Example
Changes in v4:
- None
Changes in v5:
- None
Changes in v6:
- change rockchip,phy_config to rockchip,phy-config and descript it in detail.
Changes in v7:
- None

 .../devicetree/bindings/phy/phy-rockchip-typec.txt | 36 +++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
index 960da7f..40d5e7a 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
@@ -17,7 +17,11 @@ Required properties:
 
 Optional properties:
  - extcon : extcon specifier for the Power Delivery
-
+ - rockchip,phy-config : A list of voltage swing(mV) and pre-emphasis
+			(dB) pairs. They are 3 blocks of 4 entries and
+			correspond to s0p0 ~ s0p3, s1p0 ~ s1p3,
+			s2p0 ~ s2p3, s3p0 ~ s2p3 swing and pre-emphasis
+			values.
 Required nodes : a sub-node is required for each port the phy provides.
 		 The sub-node name is used to identify dp or usb3 port,
 		 and shall be the following entries:
@@ -50,6 +54,21 @@ Example:
 			 <&cru SRST_P_UPHY0_TCPHY>;
 		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
 
+		rockchip,phy-config = <0x2a 0x00>,
+			<0x1f 0x15>,
+			<0x14 0x22>,
+			<0x02 0x2b>,
+
+			<0x21 0x00>,
+			<0x12 0x15>,
+			<0x02 0x22>,
+			<0 0>,
+
+			<0x15 0x00>,
+			<0x00 0x15>,
+			<0 0>,
+			<0 0>;
+
 		tcphy0_dp: dp-port {
 			#phy-cells = <0>;
 		};
@@ -74,6 +93,21 @@ Example:
 			 <&cru SRST_P_UPHY1_TCPHY>;
 		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
 
+		rockchip,phy-config = <0x2a 0x00>,
+			<0x1f 0x15>,
+			<0x14 0x22>,
+			<0x02 0x2b>,
+
+			<0x21 0x00>,
+			<0x12 0x15>,
+			<0x02 0x22>,
+			<0 0>,
+
+			<0x15 0x00>,
+			<0x00 0x15>,
+			<0 0>,
+			<0 0>;
+
 		tcphy1_dp: dp-port {
 			#phy-cells = <0>;
 		};
-- 
2.7.4
