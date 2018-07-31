Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD38C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9923F208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="koxQH/A/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9923F208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbeGaIuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:50:40 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:36454 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbeGaIuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021105;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=pZ97G2h9His6vpX63xgWrToacBlbj6k6mz5uYy2d8QE=;
        b=koxQH/A/NnddmwLjVimK02Sy8xDyZWENBowCUNveqWkggd9+iu2YoWaopbNtDe3K5V
        /HBKXxcty9h4QOUzR28b2TJ1mPeJevNbJfU0eSmhtzkVuefCxpUa7z+HWvd1qJOqd/dn
        IiZ1IBCTt0snNxwWg1gh+fTkhV4L+V95ld7db7A5H6MKK27fHKcwGkdo3bgoZ2SkyiTp
        4w+ME78RKLrVqBYnSmU5UjbhKQYXsUi94UKX2COl4Hb1AKu9c5Da5ZmZ3DzIvsdxiw++
        2VGn8ZSr/LM6TqSbZhOCcC49K2ASa+MvZa33S0HMVcsXnusoKgfuY+PZx4dwI3TicLvb
        OUxQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BcwOS
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:38 +0200 (CEST)
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
Subject: [PATCH v2 01/32] ARM: dts: omap3-gta04: fix typo in backlight pins node name
Date:   Tue, 31 Jul 2018 09:11:04 +0200
Message-Id: <d4e0796eacdecf9ca23b361107e26620b357881b.1533021093.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mn -> nm for backlight_pins

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index ac830b917776..9ad9cc62128e 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -220,7 +220,7 @@
 		>;
 	};
 
-	backlight_pins: backlight_pins_pimnux {
+	backlight_pins: backlight_pins_pinmux {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x20ba, MUX_MODE3)		/* gpt11/gpio57 */
 		>;
-- 
2.12.2

