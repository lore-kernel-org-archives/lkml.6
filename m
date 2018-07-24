Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD893ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9608F20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="x6wXADcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9608F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbeGXN7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45022 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388508AbeGXN7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so4004758wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JK6vHUBSN9Dquv+tZySFrVXf7/cu/PG0T3aNQQ/LBrw=;
        b=x6wXADcd5xHQs1tystvdnC5EQrQkF+WyqJg0o3E3sR6hlyn+MrYmzKlpa7QtWezpGf
         QGsVbnxrFgQVigsA3QJXtNyTwjXxOCd+PRfStuExE30EETvL8c2gaVlgeWc++u/oGhX3
         /8jNFThihFOMzKuD40Vtr9riskG/FvGnat89xJ3rhNpjlnmnk3lE56ZkaojheaRNwTTb
         V5Fl6Jt3jarCp4PTUfs/llpbADjxpGYjhaddNYc5jSoth54xMyGoyfBgPwCcAklHwhbq
         SRkF0wpa6wDgdDKhgLvU7uC5TvuMCOqGqqmsy1rB+iNwSbfChSCLDMBf3Ag9JVrF/8FI
         mCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JK6vHUBSN9Dquv+tZySFrVXf7/cu/PG0T3aNQQ/LBrw=;
        b=hLDWHle8ZkFM6ceeJhDY+7Unss81GFihVnfHfOj3d6rBU/XNXopvVQb5Dhya+Xgtna
         ECCooboM6Bi6nWSQbDfJSzBJHLUMkHnEjMRbVLuYuQuzgeGr1MeZHcA6yxVkPQGW6zGL
         i/t/5J1/EuIXX6IH1uSLCfkdgpy97sLY3HvlHDZ2P0dPVyp3BVk+gNaSVEJGcVaD+iAs
         tzUU8z8y3Ge7Jr9NuowOOMjQfUDP4wjm/j+7fYNUm1g6f7OqiO0hMfB7DV/voMsMIIwL
         s3J14uyGXn4NQ7Ai3PmH6bNg8OjGF5mGKWFoMNHCiy+AoQF5ZJKkU5LvPOgxuscqpagB
         BAjA==
X-Gm-Message-State: AOUpUlEc1hWB44KGC4Pki6KT8fRgXeI/YuO0z9THn+dbfl6JipiOaGgF
        G0n375o2V9Iq2lpl1DdeogtdhQ==
X-Google-Smtp-Source: AAOMgpdZhwUzlA3QC/SYOaXT9C58tyCHHxgl/OvHnFervt0YTlyR/Nunx7aJzFUyc+rXKAN9nWu27w==
X-Received: by 2002:adf:aadb:: with SMTP id i27-v6mr11413837wrc.149.1532436777313;
        Tue, 24 Jul 2018 05:52:57 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:52:56 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] arm64: dts: meson-axg: add spdifout
Date:   Tue, 24 Jul 2018 14:52:30 +0200
Message-Id: <20180724125238.14567-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SPDIF output device of the axg audio subsystem

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index a20189844d92..c56016a48cc4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -263,6 +263,17 @@
 				#reset-cells = <1>;
 				clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
 			};
+
+			spdifout: audio-controller@480 {
+				compatible = "amlogic,axg-spdifout";
+				reg = <0x0 0x480 0x0 0x50>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "SPDIFOUT";
+				clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
+					 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
+				clock-names = "pclk", "mclk";
+				status = "disabled";
+			};
 		};
 
 		cbus: bus@ffd00000 {
-- 
2.17.1

