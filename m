Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeENJyZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:54:25 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38654 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeENJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:54:20 -0400
X-Google-Smtp-Source: AB8JxZrV1zcigHrG2RemV5LnuD3Nvd2qDe1CrRUhnBqUoczXDJmcVs2A/i3Wwa2zNnOsaEmzq1ZUHQ==
From: Lin Huang <hl@rock-chips.com>
To: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com
Cc: dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Lin Huang <hl@rock-chips.com>
Subject: [PATCH v3 2/4] Documentation: bindings: add phy_config for Rockchip USB Type-C PHY
Date: Mon, 14 May 2018 17:53:53 +0800
Message-Id: <1526291635-31122-2-git-send-email-hl@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526291635-31122-1-git-send-email-hl@rock-chips.com>
References: <1526291635-31122-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If want to do training outside DP Firmware, need phy voltage swing
and pre_emphasis value.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v2:
- rebase
Changes in v3:
- modify property description and add this property to example

 .../devicetree/bindings/phy/phy-rockchip-typec.txt | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
index 960da7f..af298f2 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
@@ -17,7 +17,8 @@ Required properties:
 
 Optional properties:
  - extcon : extcon specifier for the Power Delivery
-
+ - rockchip,phy_config : A list of voltage swing(mv) and pre-emphasis
+			(dB) pairs.
 Required nodes : a sub-node is required for each port the phy provides.
 		 The sub-node name is used to identify dp or usb3 port,
 		 and shall be the following entries:
@@ -50,6 +51,19 @@ Example:
 			 <&cru SRST_P_UPHY0_TCPHY>;
 		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
 
+		rockchip,phy_config =<0x2a 0x00
+			0x1f 0x15
+			0x14 0x22
+			0x02 0x2b
+			0x21 0x00
+			0x12 0x15
+			0x02 0x22
+			0 0
+			0x15 0x00
+			0x00 0x15
+			0 0
+			0 0>;
+
 		tcphy0_dp: dp-port {
 			#phy-cells = <0>;
 		};
@@ -74,6 +88,19 @@ Example:
 			 <&cru SRST_P_UPHY1_TCPHY>;
 		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
 
+		rockchip,phy_config =<0x2a 0x00
+			0x1f 0x15
+			0x14 0x22
+			0x02 0x2b
+			0x21 0x00
+			0x12 0x15
+			0x02 0x22
+			0 0
+			0x15 0x00
+			0x00 0x15
+			0 0
+			0 0>;
+
 		tcphy1_dp: dp-port {
 			#phy-cells = <0>;
 		};
-- 
2.7.4
