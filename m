Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D32EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E422086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OZcyTjE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E422086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbeKGUPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:15:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35317 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeKGUPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:15:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id z16-v6so16868668wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oDvrfbacJdsErfvUwczsXd6Iu3OXG1SVdyAW6rxRLeo=;
        b=OZcyTjE5tb8z5S2KEe54rXZvrK/9NmQQVN2AzLbMjk/y4P10T/KQ76lMHATp0yiBAd
         eCqMEbe47dbDHI/7t3t/7qZaBPtYXrhQSZ25ofQvcF1OBUObhYE8jpp1+AzW0JgSiu9g
         4HoxK6GlxqqQD97VAql0793PUslT6IaWAqbEq9icDX0131TUbtBzWOliLAPmsE9pWdn2
         W7mbZDpO4zCDhlYfxcwF5CPNu9Y3pGo9qq7krr8iq5jo+WhpaTjhmTwjcL3LuLK0eecz
         ffz2u+OS6hOjBGR2cSFc6f6i4ha8kTeN9GZy3mRVCR+hFinHqZt6nuzZcHgqSkCxF7Nt
         Ng9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oDvrfbacJdsErfvUwczsXd6Iu3OXG1SVdyAW6rxRLeo=;
        b=UQCsKo45+OYbMSAuMnodWF1xp4NuwqeETaynbH/Z0dLCo8m+StEqvbIXpfFJd6Kn7p
         DH2gyuynlqJUspDLgNyKi+vvOlKeSJu2YkDlPfezRJHtcGXCosS9ovs9+RA5Eg7WDA1u
         9u7/r68PsgIzMKyHWr5B33nYi3D/K5zfl8+Pdb7pSPSFnKdF8rwd2BpdEwTSCRwNJumo
         pbsvuVhdoiyrgGtaAEN0gHUKJE4aHCO67u52vSfnU/qe0cMfQ2DpJK2iM3yAFgfdWhBM
         B/E0P9jsgdqkeO9o00PXGc7RLLAisErVh84/53hipnc88OpJ6R+KvNJrgz0g8uvSLrzG
         PHAA==
X-Gm-Message-State: AGRZ1gLooQI6PHQfvHss+dI/zcSDZVcmAAkKamZlJYhp6xpzTEijUdjx
        UL1HHnauOBods5jiNMV8h2pnRA==
X-Google-Smtp-Source: AJdET5eRpeTh9U5gCZChtc4zXdgJUEGiCQiGNB+Q1pCZhID8gYt5hpmvnn6xjWNSJIRnGJ8c7sZ0rg==
X-Received: by 2002:adf:a78a:: with SMTP id j10-v6mr1450350wrc.286.1541587554585;
        Wed, 07 Nov 2018 02:45:54 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h125-v6sm314484wmf.48.2018.11.07.02.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 02:45:54 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: meson-gxbb-nanopi-k2: fix GPIO lines names
Date:   Wed,  7 Nov 2018 11:45:48 +0100
Message-Id: <1541587550-17842-3-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
References: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio line names were set in the pinctrl node instead of the gpio node,
at the time it was merged, it worked, but was obviously wrong.
This patch moves the properties to the gpio nodes.

Fixes: 12ada0513d7a ("ARM64: dts: meson-gxbb-nanopi-k2: Add GPIO lines names")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index cbe99bd..8cd50b7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -191,7 +191,7 @@
 	pinctrl-names = "default";
 };
 
-&pinctrl_aobus {
+&gpio_ao {
 	gpio-line-names = "UART TX", "UART RX", "Power Control", "Power Key In",
 			  "VCCK En", "CON1 Header Pin31",
 			  "I2S Header Pin6", "IR In", "I2S Header Pin7",
@@ -201,7 +201,7 @@
 			  "";
 };
 
-&pinctrl_periphs {
+&gpio {
 	gpio-line-names = /* Bank GPIOZ */
 			  "Eth MDIO", "Eth MDC", "Eth RGMII RX Clk",
 			  "Eth RX DV", "Eth RX D0", "Eth RX D1", "Eth RX D2",
-- 
2.7.4

