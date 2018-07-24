Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1476ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5280A20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SQGKMIbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5280A20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbeGXN7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53143 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388538AbeGXN7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so2406532wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AfflJ7sTzSXjdDWe8mDFPGxn4/rB/PCdlz5W+5rI7J0=;
        b=SQGKMIbvWjGSEm97Z/ei354+XxEzXGU/FnE3l4+cxX7zixUqVlS2oROYkTrXAs/PWP
         XABO5H4uxF8EZ5p18502ZPAh/7EVE6SymU+NdPEmbfgdqx6zuGNbVPXmJCq0tpkk1Au3
         GZn6DnJ6PrVkEX+UpvL9ozsVmRXtTp/uTC0un0CuccTlubfqR8d7fYMnjApsetKyR4Ai
         J0EsCchELXNyb7X+rs9xC+BgfAr5zYqGM73hnZilIY1Z3oU5pd5crIMF33nFgdkNZM2p
         HJCAsLY5JJvmfTDdSfAU02QWi4TLjEkWxgAEcaqkls2aRyOqw9M8xGPCb6MCLYE6h6G7
         ZiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AfflJ7sTzSXjdDWe8mDFPGxn4/rB/PCdlz5W+5rI7J0=;
        b=QlHbthJU75a4nFm+tWccQKuE1nQtcgelhT2A0nROQ5bvu2aWN1wnIx+f6F7KcMUFQ+
         MKjri0tq8+owulmXZLtLpYFKle4M3BZOLpxwaJTffxG+YzJp7nzFmxs2rd87+ETv/IkO
         GSdN+HuR27RNGbGq61kJ1afVvZLcBwBFJeEZiR7/lXhR/Wi9HEaVde3FxjMlW/ETVolq
         ddaCvOoJN335pIw0uVqb+SGeeLynNeId2qprspglmWaiX1vI5MRgEttVIKP6n4Wh1xhN
         klS99wit5zPmXHBBlMAyBpVaEv+OznNpx63DRHveJKXB+i7vMfjY97k9hne1mH8yxNrh
         OEqg==
X-Gm-Message-State: AOUpUlGnIER8Y2qjGCTAh1z5nPeZjK8l4Rv1HBayTZkE9EvWVnug/lc1
        5jnRTAQbqXWjPkfbcc/LhsQViw==
X-Google-Smtp-Source: AAOMgpfK/HjxiTu5QSBE+DwqArhznMsqB5hcG9jEbkb8ZT+fJ7eplXW29hYFRKA6cmBvUcRvzkfFhA==
X-Received: by 2002:a1c:b213:: with SMTP id b19-v6mr1801639wmf.141.1532436778437;
        Tue, 24 Jul 2018 05:52:58 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:52:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] arm64: dts: meson-axg: add tdmin formatters
Date:   Tue, 24 Jul 2018 14:52:31 +0200
Message-Id: <20180724125238.14567-8-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the tdm devices responsible for decoding the data provided
through audio serial interface.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index c56016a48cc4..55e4ac734023 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -264,6 +264,62 @@
 				clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
 			};
 
+			tdmin_a: audio-controller@300 {
+				compatible = "amlogic,axg-tdmin";
+				reg = <0x0 0x300 0x0 0x40>;
+				sound-name-prefix = "TDMIN_A";
+				clocks = <&clkc_audio AUD_CLKID_TDMIN_A>,
+					 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			tdmin_b: audio-controller@340 {
+				compatible = "amlogic,axg-tdmin";
+				reg = <0x0 0x340 0x0 0x40>;
+				sound-name-prefix = "TDMIN_B";
+				clocks = <&clkc_audio AUD_CLKID_TDMIN_B>,
+					 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			tdmin_c: audio-controller@380 {
+				compatible = "amlogic,axg-tdmin";
+				reg = <0x0 0x380 0x0 0x40>;
+				sound-name-prefix = "TDMIN_C";
+				clocks = <&clkc_audio AUD_CLKID_TDMIN_C>,
+					 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			tdmin_lb: audio-controller@3c0 {
+				compatible = "amlogic,axg-tdmin";
+				reg = <0x0 0x3c0 0x0 0x40>;
+				sound-name-prefix = "TDMIN_LB";
+				clocks = <&clkc_audio AUD_CLKID_TDMIN_LB>,
+					 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
 			spdifout: audio-controller@480 {
 				compatible = "amlogic,axg-spdifout";
 				reg = <0x0 0x480 0x0 0x50>;
-- 
2.17.1

