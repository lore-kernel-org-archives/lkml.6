Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF4EC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FDF20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kawqURSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FDF20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeKHQQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:16:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36164 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeKHQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:15:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id d13-v6so1699038pfo.3;
        Wed, 07 Nov 2018 22:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74M2ySK/9iSISh6sYWbiRwMTV7imjXkWZvmYe9Rb48k=;
        b=kawqURSgfPB+xWfy/svWZb0ZqqpetjjtGkoHjQPTS+ppv0B3iGPwKXJdPcHlXbCOh7
         2kza8V+Eht/VgO6Cglw3Qt65lk9oVjffH230mC3rI6VUzzz4M7ZFtbLf+EMnV7bakRO+
         CTwrMypgcHmQefoXxbxoyGeQqNZBWG3HBNWFXXBxC9e/5k/tNQwx9nPxlU6ZT9yHfdsD
         rNRebiJA/NpvAhUOBANRQE3y0/NqlUfGTpzHUsxGzEyjZe2QIfn+E7UsXgB2BiQLXJe4
         rnuyUjUJ9YXPM2N8SYThXyFsblu7MWvv3VWtl2UXLw56VryaElt94i8FTeGTFBPbHUrH
         myqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74M2ySK/9iSISh6sYWbiRwMTV7imjXkWZvmYe9Rb48k=;
        b=MKW8fDBX3y0GCYpPBy7xzggoakEgag7VUvik/Q0f9ZA/LjshKWybQMrDkXymy9NClc
         BnCQF7Z5/68l8cPh48PFz1giKI2WbwxIwq/eb0+58ub8uvBcUQUPD97wFcSRQmPglHZU
         WM5ahir/PFBbjpIGp6TvZktbYPid4jM3stZyzDajwZhiZAp3uJWB2o6cpWYrKojRYpkR
         IKRCUARX4D9QY9pRFwUDELJBG+qvDs3pjafhP4ogrRe02ZNCwIbRHVrHlj3YwkGl6Dfz
         ipEXKZRajSg1PER7z3wO9gCY3wMTUEo6c/Vhuu9r+34rjXpX+GllqMGoXcn3gACOy5tn
         LbaA==
X-Gm-Message-State: AGRZ1gKYTk+diHkFvb62x9sFBzaNhxrHWzsVTl83mDsRVPNZNUfkwqZP
        WPR9dwjWW7D7AgKhtzKmWnY=
X-Google-Smtp-Source: AJdET5f3+GqotIDHlQ9fDIVL/TpMtB2IKgVrGK/S9xWvBvF1XsNrYcuUKXc4F+ONLesrCAd6hatMxA==
X-Received: by 2002:a63:ca44:: with SMTP id o4mr2882492pgi.258.1541659320957;
        Wed, 07 Nov 2018 22:42:00 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id t26-v6sm3647203pfa.158.2018.11.07.22.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 22:42:00 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v6 1/3] arm64: dts: allwinner: a64: add nodes necessary for analog sound support
Date:   Wed,  7 Nov 2018 22:39:27 -0800
Message-Id: <20181108063929.29720-2-anarsoul@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108063929.29720-1-anarsoul@gmail.com>
References: <20181108063929.29720-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for i2s, digital and analog parts of audiocodec on A64

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index f3a66f888205..53796a3e6bf3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -173,6 +173,34 @@
 		compatible = "linux,spdif-dit";
 	};
 
+	sound: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sun50i-a64-audio";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&cpudai>;
+		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,mclk-fs = <512>;
+		simple-audio-card,aux-devs = <&codec_analog>;
+		simple-audio-card,routing =
+				"Left DAC", "AIF1 Slot 0 Left",
+				"Right DAC", "AIF1 Slot 0 Right",
+				"AIF1 Slot 0 Left ADC", "Left ADC",
+				"AIF1 Slot 0 Right ADC", "Right ADC",
+				"Left ADC", "ADC",
+				"Right ADC", "ADC",
+				"MIC1", "Mic",
+				"MIC2", "Headset Mic";
+		status = "disabled";
+
+		cpudai: simple-audio-card,cpu {
+			sound-dai = <&dai>;
+		};
+
+		link_codec: simple-audio-card,codec {
+			sound-dai = <&codec>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
@@ -665,6 +693,30 @@
 			status = "disabled";
 		};
 
+		dai: dai@1c22c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-a64-codec-i2s";
+			reg = <0x01c22c00 0x200>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_CODEC>;
+			reset-names = "rst";
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		codec: codec@1c22e00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-a33-codec";
+			reg = <0x01c22e00 0x600>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "bus", "mod";
+			status = "disabled";
+		};
+
 		uart0: serial@1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
@@ -902,6 +954,12 @@
 			#reset-cells = <1>;
 		};
 
+		codec_analog: codec-analog@1f015c0 {
+			compatible = "allwinner,sun50i-a64-codec-analog";
+			reg = <0x01f015c0 0x4>;
+			status = "disabled";
+		};
+
 		r_i2c: i2c@1f02400 {
 			compatible = "allwinner,sun50i-a64-i2c",
 				     "allwinner,sun6i-a31-i2c";
-- 
2.19.1

