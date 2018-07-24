Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1050C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6B420856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="J6b0gqXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6B420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbeGXOAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:00:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37041 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388541AbeGXN7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so4033875wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/rp3bMyXkG2xPIOiTfDd3jyMLzA2kAUSoPeSZfYVFoQ=;
        b=J6b0gqXLFsEAfW0RbYAfK5M02Wbda8Y68anfcBwnxIqIVXBZY21hE+cFPk83vHvpjG
         hPlKAoGRfzh5SDj5VISXgFIpJrzl50zre4z/HBATZ+t9Ya7Gj+0UIK93nZ9Dnv+3QxjA
         t8bA1fwvRnhmrJ5xiwrRJT6KoxBGXwq7frXJvQU38l5dwwOhRlAQvbXL1FY//Plj0tYi
         OAJAKOBCs9pqOvVLiv3xRuf22tXx3/cFFBLvC3DXSmhXvYmqFdJMoMS03mQyKAornWLZ
         aKW1lODaJcX2ixPONyaZNJs8i31JpJ064+qfeCwrnHMP2RZzuQIQP0W1gCpEuo5WkR0X
         YBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/rp3bMyXkG2xPIOiTfDd3jyMLzA2kAUSoPeSZfYVFoQ=;
        b=S6nKHCfH23nf0/wH6QthFkb1iyFI1uexIEbA1aS6nEAu2t+mf5g0ZFM8CUsJx94o33
         jcp2epwxS82hZMdHxpXOdnT426O7Kt+JQpMLCyAxIrz25gTIRA4a/HF2IAXk3ZkAfVlf
         rW5vROdBHsNjmiHQc9+XuHX+FynDIrFypbKoGR5F8g64rODT3djamMDPiHEN4S5w9Zv0
         jX9VCLxPlvUsDbdP3lHXIS04gbTKKOoejxxxd8TeHxfOvSVblf+nvzHE1sl7DQbJX33g
         OV4uoLWUMC9ctxNlCOi+AdUbtEBbPuauXaY8lrUXGMa2BkLAtMmpGi/qZXZEJ1CzZreu
         p1MA==
X-Gm-Message-State: AOUpUlGj0RBeYV/ZabIyCNp8g5r0zWeuwUaekkIcGnPGq7yljvFBeFrT
        yCdOhzTaqet7jWrCxsNy3x/cSQ==
X-Google-Smtp-Source: AAOMgpeQshHTlE39lMexHymelT6UiKYDbGp+buT7shfTjI2wCxC5INFvXHDabk4C0HW2pxseufcMMQ==
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr11390735wrp.161.1532436779566;
        Tue, 24 Jul 2018 05:52:59 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:52:59 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] arm64: dts: meson-axg: add tdmout formatters
Date:   Tue, 24 Jul 2018 14:52:32 +0200
Message-Id: <20180724125238.14567-9-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the tdm devices responsible for serializing audio samples
for i2s/tdm interfaces

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 55e4ac734023..67b6d4ec980e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -330,6 +330,48 @@
 				clock-names = "pclk", "mclk";
 				status = "disabled";
 			};
+
+			tdmout_a: audio-controller@500 {
+				compatible = "amlogic,axg-tdmout";
+				reg = <0x0 0x500 0x0 0x40>;
+				sound-name-prefix = "TDMOUT_A";
+				clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			tdmout_b: audio-controller@540 {
+				compatible = "amlogic,axg-tdmout";
+				reg = <0x0 0x540 0x0 0x40>;
+				sound-name-prefix = "TDMOUT_B";
+				clocks = <&clkc_audio AUD_CLKID_TDMOUT_B>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
+
+			tdmout_c: audio-controller@580 {
+				compatible = "amlogic,axg-tdmout";
+				reg = <0x0 0x580 0x0 0x40>;
+				sound-name-prefix = "TDMOUT_C";
+				clocks = <&clkc_audio AUD_CLKID_TDMOUT_C>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK_SEL>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>,
+					 <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>;
+				clock-names = "pclk", "sclk", "sclk_sel",
+					      "lrclk", "lrclk_sel";
+				status = "disabled";
+			};
 		};
 
 		cbus: bus@ffd00000 {
-- 
2.17.1

