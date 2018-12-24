Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B8DC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D287221850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbeLXQsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 11:48:54 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:56634 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725355AbeLXQsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 11:48:50 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id wBOGI0MB032448;
        Mon, 24 Dec 2018 18:18:00 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 3BB5662DA6; Mon, 24 Dec 2018 18:47:58 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-iio@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/2] dt-binding: iio: add NPCM ADC documentation
Date:   Mon, 24 Dec 2018 18:47:54 +0200
Message-Id: <20181224164755.286932-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181224164755.286932-1-tmaimon77@gmail.com>
References: <20181224164755.286932-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM Analog-to-Digital Converter(ADC).

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/iio/adc/nuvoton,npcm-adc.txt          | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
new file mode 100644
index 000000000000..6f0843d837cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
@@ -0,0 +1,35 @@
+Nuvoton NPCM Analog to Digital Converter (ADC)
+
+The NPCM ADC is a 10-bit converter for eight channel inputs.
+
+Required properties:
+- compatible	: "nuvoton,npcm750-adc" for the NPCM7XX BMC.
+- reg			: specifies physical base address and size of the registers.
+- interrupts	: Contain the ADC interrupt with flags for falling edge.
+
+Optional properties:
+- clocks		: phandle of ADC reference clock, in case the clock is not
+				  added the ADC will use the default ADC sample rate.
+- vref-supply	: The regulator supply ADC reference voltage, in case the
+				  vref-supply is not added the ADC will use internal voltage
+				  reference.
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

