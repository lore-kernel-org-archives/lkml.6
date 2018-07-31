Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1092FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1420208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="brLmXFI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1420208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbeGaIum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:50:42 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.103]:12718 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbeGaIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021106;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=3G8lFOd9BxVHQWeHcg0ztQBwBgvWlKcZB1mmcQdd8lc=;
        b=brLmXFI5JELDAbUMFSSCwDuLlb686LGw292yh+dUQf38xcRWOpSoFJC4IS8FXh72UK
        99LWXiYu983B5cPyIF9VyP2UOebWyHVEUvr43vVxOEphUXMDuzy8J4P+ycjRT+Y1i6zG
        F8s18JOUckSSTAsG9shYeD6mS68b6cnp/x3SpjeeseoZ/TlTIgq7CIFHa9IGsL6FnuaR
        39ucEImxy72yGo/aVdLrA7KqX7ea8Sj19ga7haqAzccFkzqz9TGKoX8tuM04E/Xnmszw
        1yweVh8AtkvKHMCekJNVp1VIktIP6S9pezPbTnG7s3AKu6+GwR6qpisjOdNwCW2Dcxwf
        jtDA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BewOZ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:40 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     ladis@linux-mips.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 08/32] ARM: dts: omap3-gta04: add pinmux for bmp085 EOC interrupt
Date:   Tue, 31 Jul 2018 09:11:11 +0200
Message-Id: <727ba4aafda8f19b13119415c28d340efb7d31c4.1533021093.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index ca818d35a5d9..b22e35959c29 100644
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

