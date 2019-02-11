Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F316CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C205A2229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="K+WnJ+DM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfBKRhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:37:03 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:45612 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfBKRhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BJIx0QhegZMfLoeZsgrRV55XMY3PMYKql4QBv+z5gLk=; b=K+WnJ+DM+hbRhWZPtWOSMaX7Hv
        PyHFRH5asxzvyTEoqOjhrlfoqXG4HqCQj4bQjxSRTdkDg7XNpfFODuQMHhwo66NWVnbOFUnFXrDu/
        qOsH95MZPi8ZpJxmoxmTaDewxPHvjracAu9iB6FCaYk/NS5JLQwikgtxVWtprCPoVXVU=;
Received: from p200300ccfbce50007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbce:5000:7ee9:d3ff:fe1f:a246] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gtFVl-00069x-Fk; Mon, 11 Feb 2019 18:36:53 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gtEJo-000462-19; Mon, 11 Feb 2019 17:20:28 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: omap3-gta04: declare backlight in lcd node
Date:   Mon, 11 Feb 2019 17:20:07 +0100
Message-Id: <20190211162007.15626-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lcd display of the gta04 has a backlight but the backlight
was not referenced in the lcd node, so screen blanking did
not turn off the backlight. Fix that.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
the backlight property for the driver was accepted here:
https://lore.kernel.org/lkml/a54e7427-ff84-d105-aab7-c5eab42e6df9@ti.com/

 arch/arm/boot/dts/omap3-gta04.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 8c55d33ff694..3b88eb5f1a72 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -142,6 +142,7 @@
 			spi-cpol;
 			spi-cpha;
 
+			backlight= <&backlight>;
 			label = "lcd";
 			port {
 				lcd_in: endpoint {
@@ -151,7 +152,7 @@
 		};
 	};
 
-	backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm11 0 12000000 0>;
 		pwm-names = "backlight";
-- 
2.11.0

