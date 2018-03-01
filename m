Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032030AbeCAPZ3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:25:29 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41030 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031844AbeCAPZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:25:27 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: kishon@ti.com, heiko@sntech.de
Cc: groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        vicencb@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/6] dt-bindings: phy-rockchip-typec: move extcon property to be optional.
Date: Thu,  1 Mar 2018 16:25:11 +0100
Message-Id: <20180301152515.20940-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180301152515.20940-1-enric.balletbo@collabora.com>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extcon property is used to detect the cable-state but some boards
just connect the type-c phy to a regular USB-A connector without any
power-delivery and thus no controller reporting the cable-state.
So the extcon property is not really a required property, move it to be
optional instead.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

Changes in v2:
- [2/6] Rewrite the justification as suggested by Heiko Stuebner.

 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
index 6ea867e3176f..a66f23a01129 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
@@ -14,6 +14,8 @@ Required properties:
  - resets : a list of phandle + reset specifier pairs
  - reset-names : string reset name, must be:
 		 "uphy", "uphy-pipe", "uphy-tcphy"
+
+Optional properties:
  - extcon : extcon specifier for the Power Delivery
 
 Note, there are 2 type-c phys for RK3399, and they are almost identical, except
-- 
2.16.1
