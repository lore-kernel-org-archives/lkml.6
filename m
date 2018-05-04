Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeEDPY1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:24:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36117 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751411AbeEDPXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:23:37 -0400
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: panel: Add the Ilitek ILI9881c panel documentation
Date: Fri,  4 May 2018 17:23:30 +0200
Message-Id: <c43fc92fb85f9568ee09de6c7c1a46745e012355.1525447375.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.0c9a2cb0b38deb7304c60c507f45cf50352b752a.1525447375.git-series.maxime.ripard@bootlin.com>
References: <cover.0c9a2cb0b38deb7304c60c507f45cf50352b752a.1525447375.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.0c9a2cb0b38deb7304c60c507f45cf50352b752a.1525447375.git-series.maxime.ripard@bootlin.com>
References: <cover.0c9a2cb0b38deb7304c60c507f45cf50352b752a.1525447375.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LHR050H41 from BananaPi is a 1280x700 4-lanes DSI panel based on the
ILI9881c from Ilitek.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
new file mode 100644
index 000000000000..df05e8bb4851
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
@@ -0,0 +1,20 @@
+Ilitek ILI9881c based MIPI-DSI panels
+
+Required properties:
+  - compatible: must be "ilitek,ili9881c" and one of:
+    * "bananapi,lhr050h41"
+  - reg: DSI virtual channel used by that screen
+  - power-gpios: a GPIO phandle for the power pin
+  - reset-gpios: a GPIO phandle for the reset pin
+
+Optional properties:
+  - backlight: phandle to the backlight used
+
+Example:
+panel@0 {
+	compatible = "bananapi,lhr050h41", "ilitek,ili9881c";
+	reg = <0>;
+	power-gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* PB07 */
+	reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
+	backlight = <&pwm_bl>;
+};
-- 
git-series 0.9.1
