Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754402AbeCRRXQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 13:23:16 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43023 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeCRRWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 13:22:48 -0400
X-Google-Smtp-Source: AG47ELurx5MYc7llgaa1jQVbOZQWClrrbivE0z6+FqcQK2CsIYSi133tVOLmWwszfcgcPpe2ecEGXA==
From: Matt Porter <mporter@konsulko.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: add tda7419 audio processor binding
Date: Sun, 18 Mar 2018 13:22:37 -0400
Message-Id: <20180318172238.9795-2-mporter@konsulko.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180318172238.9795-1-mporter@konsulko.com>
References: <20180318172238.9795-1-mporter@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DeviceTree binding for the tda7419 audio processor.

Signed-off-by: Matt Porter <mporter@konsulko.com>
---
 .../devicetree/bindings/sound/tda7419.txt          | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda7419.txt

diff --git a/Documentation/devicetree/bindings/sound/tda7419.txt b/Documentation/devicetree/bindings/sound/tda7419.txt
new file mode 100644
index 000000000000..6b85ec38dd56
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tda7419.txt
@@ -0,0 +1,38 @@
+TDA7419 audio processor
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "st,tda7419"
+- reg : the I2C address of the device.
+- vdd-supply : a regulator spec for the common power supply (8-10V)
+
+Optional properties:
+
+- st,mute-gpios : a GPIO spec for the MUTE pin.
+
+Pins on the device (for linking into audio routes):
+
+  * SE3L
+  * SE3R
+  * SE2L
+  * SE2R
+  * SE1L
+  * SE1R
+  * DIFFL
+  * DIFFR
+  * MIX
+  * OUTLF
+  * OUTRF
+  * OUTLR
+  * OUTRR
+  * OUTSW
+
+Example:
+
+ap: tda7419@44 {
+	compatible = "st,tda7419";
+	reg = <0x44>;
+	vdd-supply = <&vdd_9v0_reg>;
+};
-- 
2.11.0
