Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932182AbeBUJVS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:21:18 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:54549 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932133AbeBUJVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:21:10 -0500
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 07/10] dt-bindings: panel: Add Huarui LHR050H41 panel documentation
Date: Wed, 21 Feb 2018 10:20:31 +0100
Message-Id: <25495bb5034ae6a00442e10eb08254c26c213dda.1519204731.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
References: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
References: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The LHR050H41 is a 1280x700 4-lanes DSI panel.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/panel/huarui,lhr050h41.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/huarui,lhr050h41.txt

diff --git a/Documentation/devicetree/bindings/display/panel/huarui,lhr050h41.txt b/Documentation/devicetree/bindings/display/panel/huarui,lhr050h41.txt
new file mode 100644
index 000000000000..b254db4d29c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/huarui,lhr050h41.txt
@@ -0,0 +1,19 @@
+Huarui LHR050H41 MIPI-DSI panel
+
+Required properties:
+  - compatible: "huarui,lhr050h41"
+  - reg: DSI virtual channel used by that screen
+  - power-gpios: a GPIO phandle for the power pin
+  - reset-gpios: a GPIO phandle for the reset pin
+
+Optional properties:
+  - backlight: phandle to the backlight used
+
+Example:
+panel@0 {
+	compatible = "huarui,lhr050h41";
+	reg = <0>;
+	power-gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* PB07 */
+	reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
+	backlight = <&pwm_bl>;
+};
-- 
git-series 0.9.1
