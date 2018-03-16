Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753018AbeCPHIU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:08:20 -0400
Received: from mx.socionext.com ([202.248.49.38]:27541 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751561AbeCPHIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:08:18 -0400
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH 1/2] ASoC: uniphier: add syscon property to binding document
Date: Fri, 16 Mar 2018 16:08:12 +0900
Message-Id: <20180316070813.17969-2-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316070813.17969-1-suzuki.katsuhiro@socionext.com>
References: <20180316070813.17969-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds syscon property for specifying soc-glue core into
DT binding documentation.

Currently, soc-glue core is used for changing the state of S/PDIF
signal output pin to signal output state or Hi-Z state. If you don't
need to use features on soc-glue described above you can ommit this
property.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 Documentation/devicetree/bindings/sound/uniphier,aio.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/uniphier,aio.txt b/Documentation/devicetree/bindings/sound/uniphier,aio.txt
index 65d71cf6ef0f..4ce68ed6f2f2 100644
--- a/Documentation/devicetree/bindings/sound/uniphier,aio.txt
+++ b/Documentation/devicetree/bindings/sound/uniphier,aio.txt
@@ -22,6 +22,12 @@ Required properties:
                     entry in reset-names.
 - #sound-dai-cells: should be 1.
 
+Optional properties:
+- socionext,syscon: a phandle, should contain soc-glue.
+                    The soc-glue is used for changing mode of S/PDIF signal pin
+                    to Output from Hi-Z. This property is optional if you use
+                    I2S signal pins only.
+
 Example:
 	audio {
 		compatible = "socionext,uniphier-ld20-aio";
@@ -34,4 +40,6 @@ Example:
 		reset-names = "aio";
 		resets = <&sys_rst 40>;
 		#sound-dai-cells = <1>;
+
+		socionext,syscon = <&sg>;
 	};
-- 
2.16.2
