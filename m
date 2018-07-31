Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DBEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9EA208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="esKnSe4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9EA208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbeGaIvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:51:15 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.177]:17190 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732164AbeGaIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021113;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=EliiLwTPmGSbDwWK741EpRrBcJZcBOCipR6lx4gtBgY=;
        b=esKnSe4T5j2PQZS/Uboe377uW8vj/UzGOvpxELR3ldA2Q8DP2ng6fMBEKxfy2y72jX
        +u+cQocHRwKcOYEUphLkQvctTdzsDTDmW//oJSlglM8cvlY/mdDbpbleBrBKsU2jrDtg
        VQqh4Tf/bF24Bwr1nHCmVU4Tc8SGuIqUaOSmJDBjwcdNCbmzHyIkz8xBoYk7cpzf8vGn
        rZRsWm/oMZ/1g7beKmbkcPsRNtfAvf44knkE7LnT9payqKQt/A3t5SqQeQ3zyI42a7kW
        c+lZVoKwurv9h2XZXMwl55J/7nBz5r+Vqz0gO5+ECA4+XLv2eDCdM9FUmzhc+BPvpzej
        Gi2g==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BlwOu
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:47 +0200 (CEST)
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
Subject: [PATCH v2 28/32] ARM: dts: omap3-gta04a5: disable IrDA receiver to save power
Date:   Tue, 31 Jul 2018 09:11:31 +0200
Message-Id: <ffec4dfe31b61e5feda6ed9da2595220f34b5c69.1533021094.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GTA04A5 has an improved IrDA circuit that can enable/disable
the receiver individually. We do not have an IrDA driver/subsystem
and hence the receiver should be actively turned off to save power,
especially in suspend.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a5.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index e3f9e0969065..e3352cc97c91 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -25,7 +25,21 @@
 
 };
 
+&gpio5 {
+	irda_en {
+		gpio-hog;
+		gpios = <(175-160) GPIO_ACTIVE_HIGH>;
+		output-high;	/* activate gpio_175 to disable IrDA receiver */
+	};
+};
+
 &omap3_pmx_core {
+	irda_pins: pinmux_irda {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21d0, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* mcspi1_cs1 = gpio175 */
+		>;
+	};
+
 	pps_pins: pinmux_pps_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x2138, PIN_INPUT | MUX_MODE4) /* gpin114 */
-- 
2.12.2

