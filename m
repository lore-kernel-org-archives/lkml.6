Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C594FC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8945420870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Qd8Lutf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8945420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbeLMOgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:36:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55679 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbeLMOgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:36:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so2556588wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 06:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LDYQT4F7qXvGWqvCs7Js1wTvrjLPyoPq0KJKGY64nE=;
        b=Qd8Lutf9Ism6TNlten1CU1PFaR3DMHrkd5ixR1rQNsuhbmK43zot3f4oR1Iqk+qXTr
         MQnK7z270bX+hfqaAm6eskA9hE+knB9o3GFDrQPe0tQ32uc0emqYIM3hoTVR+2cXT2Bh
         sfeCZrhlFX4eOlZ8Sa+egDli+yJbDRPrw7isu+0u9Y8IJH4eqo7kYeOQNKbjkD/1TuFz
         kyyW5olHk+4cSCEHtPL6BxDIHpAH0pi8z+zA1oaYdRPSUe3rYx8coNxzR5BCWTA3tB6z
         Kbk7G6RY1hSDU8FwDQ+O+LgTQhXLR6J7u1hCzEzFwoYYSzhtzCE319YKnny8cf2AoMKI
         8CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LDYQT4F7qXvGWqvCs7Js1wTvrjLPyoPq0KJKGY64nE=;
        b=XsXupM0gWGtS2WUucFVOta5v46k5BfftnnHOudJX9TeSK7ox1+JyDWgo9/GVgpozq4
         VoaFO8AKXCSKNnCMZkvkTdFbPHBDyZJNUg2XBhqn1w3f/78PbFOTdGS20LhENKpXC4dN
         9IfaNOQBiHpk2xz073vRYZ+pS7tNTSIr4YmNtQsYxMM0HYqE3A21Cps1C9TMqR/s1tzc
         HuH4d6ysSrQ+GnF1K6jyBQ2VMVysf1zRCJNgonlOWw5Uu1S4iESt7O3G5lUZn/L7sxP7
         UIGEU1Jl4lb5uoXPgUc9rskcdNUCzowpSc+hSSUPJMZX0dz157BrAnyfDyNbUvglOlUk
         fwGQ==
X-Gm-Message-State: AA+aEWa0rDniI/LRPcAu0Ij6erK5jigBTUaFf0cIvHkeC9EhTqDbNtv+
        ZnZWZpOFOh3NhqTDsFWUHKgrbw==
X-Google-Smtp-Source: AFSGD/VjQtBgbWoJhsI9qizZMKzRkv1YdNxQa0zY5A6WZSJZwKg5EAJ/PPd7wxOY/mJyoT7sIQwMQQ==
X-Received: by 2002:a1c:da0c:: with SMTP id r12mr10118590wmg.54.1544711800882;
        Thu, 13 Dec 2018 06:36:40 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id e12sm4929930wmf.22.2018.12.13.06.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 06:36:40 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: meson-axg: add spdifin
Date:   Thu, 13 Dec 2018 15:36:29 +0100
Message-Id: <20181213143631.19218-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213143631.19218-1-jbrunet@baylibre.com>
References: <20181213143631.19218-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SPDIF input device of the axg audio subsystem

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index fffd55787981..781632bd60ed 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1260,6 +1260,18 @@
 				status = "disabled";
 			};
 
+			spdifin: audio-controller@400 {
+				compatible = "amlogic,axg-spdifin";
+				reg = <0x0 0x400 0x0 0x30>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "SPDIFIN";
+				interrupts = <GIC_SPI 87 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
+					 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
+				clock-names = "pclk", "refclk";
+				status = "disabled";
+			};
+
 			spdifout: audio-controller@480 {
 				compatible = "amlogic,axg-spdifout";
 				reg = <0x0 0x480 0x0 0x50>;
-- 
2.19.2

