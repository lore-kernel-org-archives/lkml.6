Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DA5C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA6B2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTMfNESt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA6B2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeKHQQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:16:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45089 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeKHQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:16:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id p17-v6so8489401pfj.12;
        Wed, 07 Nov 2018 22:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+dD4RIlCf8EU5KXY6Sx8gIBjZCKrBXrCAq/WEPSpBCg=;
        b=GTMfNEStg95lmbxY4bl+KeJy1hdAL16mASj1QLSf/bB+b2Q7+jDB+PQh2yyQcHtx18
         sMMRf6ogcNdsRJGNNqHadMcglYc2+jrYdRwdeYMOmirK8a/viZHf2QKMAwQLmt6+KC69
         2f5eUwhKy1OBwzxtHK3DIkrFhSBa06xX22N/rEHPnVBhlEW/biBM+0IGbQ1B0jD7Z2LS
         TYt8c+zLe5s7PbZvJvK4hfRs9FvGQoPjOt8O/e6ac+ziF+5a82cRY4MsrOzy837iaEdQ
         vBz+Y6l09uTrzGHdptMAg2XbmZCbLe0KpPX6rK7r+mJvQkq5oixrBFcKFY8Gq/ddrRbZ
         QGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dD4RIlCf8EU5KXY6Sx8gIBjZCKrBXrCAq/WEPSpBCg=;
        b=fkWngKrHHUUSQa4en/GQ0UxUiCEdUj9rEd3KdXAkoFHcpWlk3F707xxTAPZEQyeQd/
         8bdZHZUvr8jjFBEInO6HayWU1o6pxGq3efS6oVmjIiBm4+uQZ0bS6R864cyZhKHL7ASi
         2iX/4iNd7naOMA0iDxLUJ+GXiTILon/v+d1RAcSALDbddC0weTS638DeAi5SNhSdPIkb
         rbV4cjjFBADvbQHXSwwfsh90UVDk2IZu3X+UeRa3SgVpyrfU2kf24sQoEokHi+jDh7kP
         YdUxHy24JANUGxKuY9rCBkd2g+Haf6vlvrI2fVdO125gEUDDr5Ga4AWjtY8Pdi/oCn6X
         utfQ==
X-Gm-Message-State: AGRZ1gKucHFcP5zdTL+JSwzQizhZB1dsxrb0lPjD7pSS4iyGnWTMptCu
        dToZ4ZRVDDtItbl7zBZ+Dng=
X-Google-Smtp-Source: AJdET5cOMhR/OOpySNAaIYwySeCHRETmJ8GTE6xTwDDHzYsSh+CTNMf7Ws0dTzmm52cjnS7Qg+xRjw==
X-Received: by 2002:a63:77ce:: with SMTP id s197mr2830395pgc.89.1541659322371;
        Wed, 07 Nov 2018 22:42:02 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id t26-v6sm3647203pfa.158.2018.11.07.22.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 22:42:01 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v6 2/3] arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine
Date:   Wed,  7 Nov 2018 22:39:28 -0800
Message-Id: <20181108063929.29720-3-anarsoul@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108063929.29720-1-anarsoul@gmail.com>
References: <20181108063929.29720-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables I2S, digital and analog parts of audiocodec on
Pine64 and SoPine boards.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 28 +++++++++++++++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts | 28 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index c077b6c1f458..ff352bdfbb93 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -75,6 +75,18 @@
 	};
 };
 
+&codec {
+	status = "okay";
+};
+
+&codec_analog {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
 &de {
 	status = "okay";
 };
@@ -264,6 +276,22 @@
 	status = "disabled";
 };
 
+&sound {
+	status = "okay";
+	simple-audio-card,widgets = "Microphone", "Microphone Jack",
+				    "Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"Headphone Jack", "HP",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Left ADC", "ADC",
+			"Right ADC", "ADC",
+			"Microphone Jack", "HBIAS",
+			"MIC2", "Microphone Jack";
+};
+
 /* On Exp and Euler connectors */
 &uart0 {
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 53fcc9098df3..25d732df37c4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -80,6 +80,18 @@
 	};
 };
 
+&codec {
+	status = "okay";
+};
+
+&codec_analog {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
 &de {
 	status = "okay";
 };
@@ -164,6 +176,22 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	status = "okay";
+	simple-audio-card,widgets = "Microphone", "Microphone Jack",
+				    "Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"Headphone Jack", "HP",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Left ADC", "ADC",
+			"Right ADC", "ADC",
+			"Microphone Jack", "HBIAS",
+			"MIC2", "Microphone Jack";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.19.1

