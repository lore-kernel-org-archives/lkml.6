Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EBCC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE34205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394343AbfAPQtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:49:52 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:57535 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387470AbfAPQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:49:51 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x0GGIxbc013486;
        Wed, 16 Jan 2019 18:18:59 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 1F73A62DA6; Wed, 16 Jan 2019 18:48:57 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-iio@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 1/2] dt-binding: iio: add NPCM ADC documentation
Date:   Wed, 16 Jan 2019 18:48:54 +0200
Message-Id: <20190116164855.200357-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190116164855.200357-1-tmaimon77@gmail.com>
References: <20190116164855.200357-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM Analog-to-Digital Converter(ADC).

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/adc/nuvoton,npcm-adc.txt          | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
new file mode 100644
index 000000000000..1b8132cd9060
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
@@ -0,0 +1,35 @@
+Nuvoton NPCM Analog to Digital Converter (ADC)
+
+The NPCM ADC is a 10-bit converter for eight channel inputs.
+
+Required properties:
+- compatible: "nuvoton,npcm750-adc" for the NPCM7XX BMC.
+- reg: specifies physical base address and size of the registers.
+- interrupts: Contain the ADC interrupt with flags for falling edge.
+
+Optional properties:
+- clocks: phandle of ADC reference clock, in case the clock is not
+		  added the ADC will use the default ADC sample rate.
+- vref-supply: The regulator supply ADC reference voltage, in case the
+			   vref-supply is not added the ADC will use internal voltage
+			   reference.
+
+Required Node in the NPCM7xx BMC:
+An additional register is present in the NPCM7xx SOC which is
+assumed to be in the same device tree, with and marked as
+compatible with "nuvoton,npcm750-rst".
+
+Example:
+
+adc: adc@f000c000 {
+	compatible = "nuvoton,npcm750-adc";
+	reg = <0xf000c000 0x8>;
+	interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clk NPCM7XX_CLK_ADC>;
+};
+
+rst: rst@f0801000 {
+	compatible = "nuvoton,npcm750-rst", "syscon",
+	"simple-mfd";
+	reg = <0xf0801000 0x6C>;
+};
-- 
2.14.1

