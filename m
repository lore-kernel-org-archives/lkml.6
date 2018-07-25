Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADC7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D8B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D8B20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeGYILT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:11:19 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.174]:23983 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbeGYIJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:09:34 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0pB1ZSLA74="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6P6x8d5V
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 25 Jul 2018 08:59:08 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 08/32] ARM: dts: omap3-gta04: add pinmux for bmp085 EOC interrupt
Date:   Wed, 25 Jul 2018 08:58:40 +0200
Message-Id: <c6a48a56e2275e6a1f0639d1e28b0c244db5fb7f.1532501910.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index c5549d528437..65f77a0b5dd4 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -284,6 +284,12 @@
 		>;
 	};
 
+	bmp085_pins: pinmux_bmp085_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2136, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio113 */
+		>;
+	};
+
 	bma180_pins: pinmux_bma180_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x213a, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio115 */
@@ -373,6 +379,8 @@
 	bmp085@77 {
 		compatible = "bosch,bmp085";
 		reg = <0x77>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bmp085_pins>;
 		interrupt-parent = <&gpio4>;
 		interrupts = <17 IRQ_TYPE_EDGE_RISING>; /* GPIO_113 */
 	};
-- 
2.12.2

