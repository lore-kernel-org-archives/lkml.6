Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeCOQTe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:19:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35770 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752218AbeCOQTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:19:30 -0400
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com,
        michael@amarulasolutions.com
Subject: [PATCH v3 2/2] ASoC: Add bindings for PCM1789
Date: Thu, 15 Mar 2018 17:18:25 +0100
Message-Id: <20180315161825.5524-3-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180315161825.5524-1-mylene.josserand@bootlin.com>
References: <20180315161825.5524-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device-tree binding for Texas Instrument's PCM1789 codec.
For the moment, only I2C bus is supported but SPI could be added
in future.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 .../devicetree/bindings/sound/pcm1789.txt          | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/pcm1789.txt

diff --git a/Documentation/devicetree/bindings/sound/pcm1789.txt b/Documentation/devicetree/bindings/sound/pcm1789.txt
new file mode 100644
index 000000000000..3c74ed220ac2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/pcm1789.txt
@@ -0,0 +1,22 @@
+Texas Instruments pcm1789 DT bindings
+
+PCM1789 is a simple audio codec that can be connected via
+I2C or SPI. Currently, only I2C bus is supported.
+
+Required properties:
+
+ - compatible: "ti,pcm1789"
+
+Required properties on I2C:
+
+ - reg: the I2C address
+ - reset-gpios: GPIO to control the RESET pin
+
+Examples:
+
+	audio-codec@4c {
+		compatible = "ti,pcm1789";
+		reg = <0x4c>;
+		reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+	};
-- 
2.11.0
