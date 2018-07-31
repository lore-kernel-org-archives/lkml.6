Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AB1C46463
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC037208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="ObAke1B2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC037208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbeGaIun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:50:43 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.123]:18986 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbeGaIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021109;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=hpOUSft9bo84WR07azHqwrnuYwpXzk3Q2igmWmr8U0M=;
        b=ObAke1B2zytX+seYmCxG8Ef2fY364Q+oyBfIwnSIJmVom6xEUWh8BfBP3+XHZbXOlm
        pHGENlnRoXnwEDY4Q3gC5vrUI9JeWzm3AnuU9Vr0HUgWxLMpIuSxaKzy+ZX1Ro4Ua2MY
        tTLZPn6nkMHZ2qmo8F/4zQA+o+Y7thKRjOlSBTIH/DRlWrwVoE0dzbqW3Kh+TRx+IXU4
        aSk2W34rJBLWEiDyNkNl9w+t8ZWvIVAM3ZbfCsKl02IkHsiBzZPbUhgTFPqzNWXFaoWs
        7RVLNhyAT76RvSXcCsAbKXkw340W8zTaeWSqT5S3/ALavssxNfRcdaZ2kxBbNCQOL5mA
        PDeA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BhwOh
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:43 +0200 (CEST)
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
Subject: [PATCH v2 16/32] ARM: dts: omap3-gta04: map antenna detect GPIO to SW_LINEIN_INSERT key event
Date:   Tue, 31 Jul 2018 09:11:19 +0200
Message-Id: <73dd352a21292200b6669a1cf4f48697239e6cca.1533021093.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GTA04 can detect presence/absence or plug-in of an external
GPS antenna through a gpio. The best match for an event code
is SW_LINEIN_INSERT.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 98f31f1814d0..28e041ec4e98 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -50,6 +50,21 @@
 		};
 	};
 
+	antenna-detect {
+		compatible = "gpio-keys";
+
+		gps_antenna_button: gps-antenna-button {
+			label = "GPS_EXT_ANT";
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LINEIN_INSERT>;
+			gpios = <&gpio5 16 GPIO_ACTIVE_HIGH>; /* GPIO144 */
+			interrupt-parent = <&gpio5>;
+			interrupts = <16 IRQ_TYPE_EDGE_BOTH>;
+			debounce-interval = <10>;
+			wakeup-source;
+		};
+	};
+
 	sound {
 		compatible = "ti,omap-twl4030";
 		ti,model = "gta04";
-- 
2.12.2

