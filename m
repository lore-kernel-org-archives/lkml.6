Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956AAC282DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DA7214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfBDASy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 19:18:54 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:51304 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfBDASx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 19:18:53 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id BE8FA3A4AF6;
        Mon,  4 Feb 2019 01:14:50 +0100 (CET)
Received: from pc.localdomain (unknown [91.192.165.7])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8479C200003;
        Mon,  4 Feb 2019 00:14:47 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 1/3] dt-bindings: iio/adc: Add docs for Ingenic JZ47xx SoCs ADC.
Date:   Mon,  4 Feb 2019 01:15:12 +0100
Message-Id: <20190204001514.29891-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the ADC controller on JZ47xx SoCs,
used by the ingenic-adc driver.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---

 Changes:

 v2: change a typo ',' into ';' in battery example

 .../bindings/iio/adc/ingenic,adc.txt          | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
new file mode 100644
index 000000000000..f01159f20d87
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
@@ -0,0 +1,48 @@
+* Ingenic JZ47xx ADC controller IIO bindings
+
+Required properties:
+
+- compatible: Should be one of:
+  * ingenic,jz4725b-adc
+  * ingenic,jz4740-adc
+- reg: ADC controller registers location and length.
+- clocks: phandle to the SoC's ADC clock.
+- clock-names: Must be set to "adc".
+- #io-channel-cells: Must be set to <1> to indicate channels are selected
+  by index.
+
+ADC clients must use the format described in iio-bindings.txt, giving
+a phandle and IIO specifier pair ("io-channels") to the ADC controller.
+
+Example:
+
+#include <dt-bindings/iio/adc/ingenic,adc.h>
+
+adc: adc@10070000 {
+	compatible = "ingenic,jz4740-adc";
+	#io-channel-cells = <1>;
+
+	reg = <0x10070000 0x30>;
+
+	clocks = <&cgu JZ4740_CLK_ADC>;
+	clock-names = "adc";
+
+	interrupt-parent = <&intc>;
+	interrupts = <18>;
+};
+
+adc-keys {
+	...
+	compatible = "adc-keys";
+	io-channels = <&adc INGENIC_ADC_AUX>;
+	io-channel-names = "buttons";
+	...
+};
+
+battery {
+	...
+	compatible = "ingenic,jz4740-battery";
+	io-channels = <&adc INGENIC_ADC_BATTERY>;
+	io-channel-names = "battery";
+	...
+};
-- 
2.20.1

