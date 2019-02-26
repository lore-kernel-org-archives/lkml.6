Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BDDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126372173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="os8exHFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfBZOPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:15:30 -0500
Received: from plaes.org ([188.166.43.21]:54502 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfBZOP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:15:29 -0500
Received: from localhost (unknown [193.40.103.250])
        by plaes.org (Postfix) with ESMTPSA id B8667411A9;
        Tue, 26 Feb 2019 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1551190527; bh=FMKmMZa79gVq+T7Nmx2rAHozElSXaYYN0uJOOYlLSvo=;
        h=From:To:Cc:Subject:Date:From;
        b=os8exHFWwyTF4YQW6HsICNL4ouezid2RYKhdSqGatfz9Qk3zNsG+ugJCVDCDo/MXl
         uZQnAY9t7CKO2QE/oW659agDSpNktqNWOy81HCjlVMfK2nQA4YmwDwt7zhMiUbSc1A
         T3w2wPiHQMhJFFMfi92xbYye+ZMwxYpvY40ui8OMsVPE08/g+2G4fG1tNDZFhi+hNb
         xYHtqIU7Q7v5Bdfw24tFlFjXhfwL+yjQw/OQy/D+FlWXqbAsnNCRExNL6UrVg/R9ef
         TjTfNVJVhXvjcgCtg/cPbhHWtYd4t37Cplms7776eUIqxCAjUDdYUJQA5jwhC5ReBh
         Ce21VLaluchtg==
From:   Priit Laes <plaes@plaes.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, Priit Laes <priit.laes@paf.com>
Subject: [PATCH] ARM: dts: sun7i: olimex-lime2: Add regulators for GPIO banks
Date:   Tue, 26 Feb 2019 16:15:25 +0200
Message-Id: <20190226141525.1039-1-plaes@plaes.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Priit Laes <priit.laes@paf.com>

Make sure that A20 Olimex Lime2 pin bank regulators are
properly represented.

While pin banks A, B and F are connected to 3.3V static
regulator, pin banks E and G tied with LDO3 and LDO4 regulators
with 2.8V reference.

Signed-off-by: Priit Laes <priit.laes@paf.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 4e1c590eb098..3de479bfa4cf 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -174,6 +174,12 @@
 };
 
 &pio {
+	vcc-pa-supply = <&reg_vcc3v3>;
+	vcc-pc-supply = <&reg_vcc3v3>;
+	vcc-pe-supply = <&reg_ldo3>;
+	vcc-pf-supply = <&reg_vcc3v3>;
+	vcc-pg-supply = <&reg_ldo4>;
+
 	led_pins_olinuxinolime: led-pins {
 		pins = "PH2";
 		function = "gpio_out";
-- 
2.11.0

