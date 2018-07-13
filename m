Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E64ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E0A208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="W8Ou93yB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E0A208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbeGMMEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:04:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53492 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeGMMEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:04:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so1227365wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=AHfxIiHDsdaEN+xi0h+sJUMJbOJhD8mWunWDSgpqnng=;
        b=W8Ou93yBpIABKkbhDP62fjsF6DdRkTBjwZUTG3uOuxerrePsvdPxijQjgF/KA0Kq+a
         5Kwxpweavf9J6J6wQ66cEjaBah9yC3oSlNI0vjDj4EKN6LSI3QObTEVo9q4RoEW4rx76
         03sNAZCi1fzqvWvOREx94onWFKSW7ASb3zmPwnLDM0KnkXRV8IuWp0cTmq/cKSIAgwRi
         7Dp/jpVWntaoLoMRpJ26bdnSwk/DfwCUy8+FjDMpMqbCuk+jmGkeRmjBornN3A7adYzC
         TMAJvy4kKZQGlwSf0ufuBH0en7Z97IS+nbvZccOlJam2jdOPkE+BdDwnW39DMMz6m3zI
         6bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AHfxIiHDsdaEN+xi0h+sJUMJbOJhD8mWunWDSgpqnng=;
        b=rF71npur9OyopvRNSespVUi28j7lZ0kpCJwsLlTC3xYcJU9X3rox3W98ZrYXMn8FaV
         cpZo+i6u8R/KD39N0tAWOEDajn7w0fsOYzwgS/2qZApbLHk9ayhuvqELoO7ruYTMXrp+
         I6TItYLqfDe4d7IJFgHx6sTMyxgb07+qRzIE0E0ZVn/ndNSUriaXHsL0Y8vpHTZWotps
         Z4FwrH5O8vTb2uI8M0XZkw3BfLgTqnj/0cmIibL+cacbMTwuK3Vdz2URIASEIbR60CG+
         kKtcpo45QaCUAKM9wDoNUlPFBUs04bj0WbbNRqH8kcG2ImuUzfP5ZSFEkTfSj28KguhL
         MnSw==
X-Gm-Message-State: AOUpUlHUHDLnO+m/scGo1nVn/yhbg6TgeTsuJ1Vm75Izwf3lHtahBtuj
        F5ak8mBKsrgo7c6yLDSiZC9nFQ==
X-Google-Smtp-Source: AAOMgpfL1Kr5ShaLu8mBtvivAH8BS0GO8db+VorzH1HHAiHVGmQNmBJI2PA9ijZykoMXvEsNecqKew==
X-Received: by 2002:a1c:790b:: with SMTP id l11-v6mr3601072wme.66.1531482602203;
        Fri, 13 Jul 2018 04:50:02 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n8-v6sm35285869wrt.56.2018.07.13.04.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 04:50:01 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-axg: remove vddio_ao18 from SoC dtsi
Date:   Fri, 13 Jul 2018 13:49:57 +0200
Message-Id: <20180713114957.32361-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator should not be defined inside the SoC dtsi file.
vddio_ao18 is already defined in the S400 board dts anyway.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Kevin,

This patch fixes a problem in a patch [0] you have applied recently.
I did not put a Fixes tag because the branch on which you've applied it
is not public yet (unknown sha1)

If you decide to pick this patch, could you please add the Fixes tag?
You could also squash the two patches together, if you prefer.

Cheers
Jerome

[0] https://lkml.kernel.org/r/7hmuv0nkss.fsf@baylibre.com

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index a936d6535ce7..d4dc87ae72a4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -92,13 +92,6 @@
 		method = "smc";
 	};
 
-	vddio_ao18: regulator-vddio_ao18 {
-		compatible = "regulator-fixed";
-		regulator-name = "VDDIO_AO18";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.14.4

