Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753354AbeFDNTE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:19:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43595 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753279AbeFDNTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:19:02 -0400
X-Google-Smtp-Source: ADUXVKIY7+a5uT8i0Bz0LSwWpwYUMtKnC9ZbRGaNXze18108OQ2q56sDHcgR28CHzgP0I4m9LCjbvQ==
Date: Mon, 4 Jun 2018 16:18:53 +0300
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v5 3/4] clk: bd71837: Devicetree bindings for ROHM BD71837
 PMIC
Message-ID: <da121dede6d79460c5653a5bc360d413cb988c74.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree bindings for ROHM BD71837 PMIC clock output.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../bindings/clock/rohm,bd71837-clock.txt          | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt b/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
new file mode 100644
index 000000000000..771acfe34114
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
@@ -0,0 +1,38 @@
+ROHM BD71837 Power Management Integrated Circuit clock bindings
+
+This is a part of device tree bindings of ROHM BD71837 multi-function
+device. See generic BD71837 MFD bindings at:
+	Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
+
+BD71837 contains one 32,768 KHz clock output which can be enabled and
+disabled via i2c.
+
+Following properties should be present in main device node of the MFD chip.
+
+Required properties:
+- clock-frequency	: Should be 32768
+- #clock-cells		: Should be 0
+
+Optional properties:
+- clock-output-names	: Should contain name for output clock.
+
+Example:
+
+/* MFD node */
+
+pmic: pmic@4b {
+	compatible = "rohm,bd71837";
+	/* ... */
+	#clock-cells = <0>;
+	clock-frequency  = <32768>;
+	/* ... */
+};
+
+/* Clock consumer node */
+
+foo@0 {
+	compatible = "bar,foo";
+	/* ... */
+	clock-names = "my-clock";
+	clocks = <&pmic>;
+};
-- 
2.14.3
