Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8907BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C9A2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kiIAwiTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfBHKOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:14:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40684 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfBHKOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:14:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so2766504wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 02:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRXDa+0TVxZcYoEC45CBTpx7rG6dgcS0Dc6O77EV4hs=;
        b=kiIAwiTqinORRZqbH7rVzo72b8E9f7tv8pZtF5tGQwUsd7Gijie4pObU2AcxROrqGE
         ah92UYjSBCvCLCkMCRk2pyWnIF2j/UPQXrVIo5qKlmJ1OOIzJNrVP9DVEX3khfojqWOh
         WqCoxR/OalA32yXCo0MB15dZ0sAID+kKoiHVI+QPoRiEQNWTQdURZ0bN0UjRoIyR5sjP
         +nSRRqR9RBa7PP1NBYMkheF7/DuIHATa9yEVHCa8+2AdM29qKF3xWjv+QibzF0aWu275
         YW/v96Td7G81c/eHQuxSHeQBSUgfQYY43/EQWrVRRI0/UIRN7Y7RZ7237tX6XARSl8vJ
         R7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRXDa+0TVxZcYoEC45CBTpx7rG6dgcS0Dc6O77EV4hs=;
        b=fjsQtlH+wZwe7ndOYxmmtXQndW5AwNirO5ylvPUTPjT//TNmuJitGHfg/bEyJeZ1X5
         hhUp+j+rLJQuoQDld2v2Jmu+btxnd/bBLmOdJAF51TQYcBWtyksqEad9JzLPU7a5oag4
         wJHhw62YDSk4ieDcL3Ao5s6sStzStyrajDdskCNFMfgbrOzb/mO/iUm08rLPOG82ZpY4
         cr8Ur8G+C7LzPvwT8JnK1xcZW3fCKuRASiZ9wLFdSFTr8QT+0YL2ecvYZWAeF6BoXvn6
         knfBuzgPhFy09XLqDhzmHEp2FFwGmqHoYe90ejJMMK4Rvfta4GIuo0C965ky4oFew4XR
         Rm+A==
X-Gm-Message-State: AHQUAuasqk6vETzBIbDB7g7LPBuPnkjuabDmGxitKeiraQWtaOsf1IeP
        UXSb1MSg79DJSO715XJlSj/xCA==
X-Google-Smtp-Source: AHgI3IaDcp0Kd3lbpFEdo8o04UwImuCBn8esuyWNfU5kXFZuDRopItxxaBfWAXrGzLFLj5E4UjFe0w==
X-Received: by 2002:a1c:c282:: with SMTP id s124mr10748554wmf.105.1549620857288;
        Fri, 08 Feb 2019 02:14:17 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e35:2e9a:6060:2ed3:c463:803b:b085])
        by smtp.googlemail.com with ESMTPSA id a62sm1901634wmf.47.2019.02.08.02.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 02:14:16 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] arm64: dts: meson: g12a: add peripheral clock controller
Date:   Fri,  8 Feb 2019 11:14:05 +0100
Message-Id: <20190208101405.25699-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208101405.25699-1-jbrunet@baylibre.com>
References: <20190208101405.25699-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the peripheral clock controller to the g12a SoC DT

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 05ea750b8c16..701a02244e04 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -121,6 +121,19 @@
 				#address-cells = <2>;
 				#size-cells = <2>;
 				ranges = <0x0 0x0 0x0 0x3c000 0x0 0x1400>;
+
+				hhi: system-controller@0 {
+					compatible = "amlogic,meson-gx-hhi-sysctrl",
+						     "simple-mfd", "syscon";
+					reg = <0 0 0 0x400>;
+
+					clkc: clock-controller {
+						compatible = "amlogic,g12a-clkc";
+						#clock-cells = <1>;
+						clocks = <&xtal>;
+						clock-names = "xtal";
+					};
+				};
 			};
 		};
 
-- 
2.20.1

