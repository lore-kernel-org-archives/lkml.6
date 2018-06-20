Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331B4C1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E6820872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E6820872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754922AbeFTJbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:31:14 -0400
Received: from mx2.freebsd.org ([8.8.178.116]:24915 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754925AbeFTJbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:31:10 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id E480C745EF;
        Wed, 20 Jun 2018 09:31:09 +0000 (UTC)
        (envelope-from manu@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id A519F7300F;
        Wed, 20 Jun 2018 09:31:08 +0000 (UTC)
        (envelope-from manu@freebsd.org)
Received: from skull.home.blih.net (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: manu)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 8EA6624394;
        Wed, 20 Jun 2018 09:31:07 +0000 (UTC)
        (envelope-from manu@freebsd.org)
From:   Emmanuel Vadot <manu@freebsd.org>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH] arm64: allwinner: a64-sopine: Add cd-gpios to mmc0 node
Date:   Wed, 20 Jun 2018 11:30:55 +0200
Message-Id: <20180620093055.10928-1-manu@freebsd.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The card detect GPIO for Sopine and Pine64-LTS is PF6.
Add this to the dts.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index 43418bd881d8..3dfc0c55eb96 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -45,6 +45,8 @@
 
 #include "sun50i-a64.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -52,6 +54,7 @@
 	non-removable;
 	disable-wp;
 	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
-- 
2.17.0

