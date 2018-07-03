Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B25C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7203323D48
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qM5M7mwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7203323D48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeGCNWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:22:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38954 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbeGCNV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:21:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so2253589wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 06:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z1MBPzq687TZ45vWr5g5VLuLwW8uFAvxlyH0sWqBv/U=;
        b=qM5M7mwDwfupUE4x+sq8tnMq3qbUoyqGl8vmm8N6QOzhaqVP7SiYPuP5ELf1cnQqnR
         FimYdCJTCnTt04ZHwV7nAGnxJBACqyWKyYjqRWt95htzXXTfnomZz7UVMyRfS9PcOTGw
         XhtgrjfbcRSlpzCtImMAt3cfC95SdwhbbWlqsjlfLVOcibV4DbI0Ln/f87n3Q9arGr2q
         Ms/8qCzT717MVARqhKOclu0PPispHWTAKkZwl9UPCKNuVSy4v6HtpKJJm0fUbsDyIrPT
         plMH3gdKABzjRZ8j7gbbdciJRGmR09wUtKemVjqbreivZ4U8zSVDoybyXWEl5AXJX74X
         mAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z1MBPzq687TZ45vWr5g5VLuLwW8uFAvxlyH0sWqBv/U=;
        b=IKuX6jKB5KXZD9sknmQphASbC/dvWSbjPC81CFQi4jCZGKG7/tHAYdQ7PYvt3n6/no
         +seQECqwptKXz50lHywOn3plOgvUAqIBsV+Pqd7A+DH74XM7PRt5FU/sDr/eFbiNHgot
         dmYMi58r7wEYG8vLflY0xYTuZbTKI1NSkbmcaLcFkhfna3P6az0YdJD1YiC16IdakmX1
         VSljdIbxelBg5NBT1Yp4W7vP372efOf4Td71DaXZXhMtfUPvIYyIDf2jf8NyVpmfG0Vy
         KBKGTvT4wE5sahQd3dR2JXxvU9r2TX1fSUCTnACx8aGvCAl7EtAiiJSwnKbSgls0HxK/
         rd+w==
X-Gm-Message-State: APt69E1oTdk68FwYKk5EMsOK2Um7lkEnMTiLfdb7Lbmfq7bSEBzYbf8a
        wto9P5iQg42BZFpU9R0jHHmdGw==
X-Google-Smtp-Source: AAOMgpdoI6L2QMF7E25fSrJuUtZVEEsaxa1NkeDEJ3FRDNo6IvO0y3TauxeOJaMSJI3814Z/gRv1qg==
X-Received: by 2002:a1c:9290:: with SMTP id u138-v6mr4852174wmd.52.1530624116005;
        Tue, 03 Jul 2018 06:21:56 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l17-v6sm2019844wrh.45.2018.07.03.06.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jul 2018 06:21:55 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM64: dts: meson-gx: Add Internal Clock Measurer node
Date:   Tue,  3 Jul 2018 15:21:50 +0200
Message-Id: <1530624110-4687-4-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
clock paths frequencies.
This patch adds the node in the top-level meson-gx dtsi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index b8dc4db..7767cab 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -262,6 +262,11 @@
 				status = "disabled";
 			};
 
+			clock-measure@8758 {
+				compatible = "amlogic,meson-gx-clk-measure";
+				reg = <0x0 0x8758 0x0 0x10>;
+			};
+
 			i2c_B: i2c@87c0 {
 				compatible = "amlogic,meson-gx-i2c", "amlogic,meson-gxbb-i2c";
 				reg = <0x0 0x087c0 0x0 0x20>;
-- 
2.7.4

