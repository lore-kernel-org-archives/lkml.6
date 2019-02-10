Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE9FC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B126E2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfBJUtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:49:02 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:58246 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725971AbfBJUtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:49:01 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x1AKHsa5009187;
        Sun, 10 Feb 2019 22:17:54 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 8C38A62DA4; Sun, 10 Feb 2019 22:47:51 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     gregkh@linuxfoundation.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, yuenn@google.com, venture@google.com,
        brendanhiggins@google.com, avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-iio@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/1] dt-binding: iio: remove rst node from NPCM ADC document
Date:   Sun, 10 Feb 2019 22:47:49 +0200
Message-Id: <20190210204749.381445-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove NPCM7xx rst node for preparing the NPCM ADC
document to describe ADC reset binding.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt          | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
index 1b8132cd9060..eb939fe77836 100644
--- a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
@@ -14,11 +14,6 @@ Optional properties:
 			   vref-supply is not added the ADC will use internal voltage
 			   reference.
 
-Required Node in the NPCM7xx BMC:
-An additional register is present in the NPCM7xx SOC which is
-assumed to be in the same device tree, with and marked as
-compatible with "nuvoton,npcm750-rst".
-
 Example:
 
 adc: adc@f000c000 {
@@ -27,9 +22,3 @@ adc: adc@f000c000 {
 	interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 	clocks = <&clk NPCM7XX_CLK_ADC>;
 };
-
-rst: rst@f0801000 {
-	compatible = "nuvoton,npcm750-rst", "syscon",
-	"simple-mfd";
-	reg = <0xf0801000 0x6C>;
-};
-- 
2.14.1

