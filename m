Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E45C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E79C2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivg3KzMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E79C2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeKHQQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:16:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45090 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeKHQQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:16:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id p17-v6so8489425pfj.12;
        Wed, 07 Nov 2018 22:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFpEB9CEr1UB9Nmru4Fp2MdF0TIr5Q8Z9m7VBF3PKN8=;
        b=Ivg3KzMoraWtGvDD2r0p3w5HSfuQitLpJWx9MmkjFJ0pyrmt02OaHejwP5MqcFRxa7
         FuUSxQUK2FA8OriCw3ukjMUGqF7avic6LCXiRY3y/dnRSfYn9q3WON59yazUPWkZB7PX
         Kaf61oxIDP1DN4xv0j6APOs+P29TrRWPbCAMQzkWkCoHEbe8W+rEgVLjGiC/O6XcGmQC
         KYvJfhsGk5/BRlF4fkHYtZgEgksVqx6xMtM2gjZeV6/FLE+nETCWBZSBokER3IPtGKIg
         9HUTc1AC9n1h1M4ykk8/kCfxCiAZcBqmWQsGrnoqxMm/7HyCYZdmraCWa12kUzKfP3G1
         mAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFpEB9CEr1UB9Nmru4Fp2MdF0TIr5Q8Z9m7VBF3PKN8=;
        b=nd55Wba+MVoHLrp9kqXoMYt5zXPqhVNLoaxYcuNrraurOIxNR2BuroB50xViS3TqAx
         A4W1VYAkRCfwbfwDun/ypnCmH6obKhXk1uzTPmcSnBzqzgUgAw707Sk2O1d6LCzEpJyq
         s4zBrCQ9bKXmBL6+xttnsOfn0XI77dgVgvaBHcjAwD93142SwwNhk2erCqLM9yEW94f3
         VWwOWCrmY/iFA7rxqR30hXdqNG8MkTe+zQdBUcFqzmNxgghyyHppQGFrwaMWrx8aKEHZ
         qjO+G4Hw5cAcjDOR4Nk8S2zkMFvZj+G4clNZPVz6H0ckV6arZqULgKN4TC369W2JtCCI
         lZqw==
X-Gm-Message-State: AGRZ1gKAF7wYNA5yv29G4DeFK4Kdw4VlvU8+/h5ln27UbXncfsFRsLy8
        W0e7j7B3jmK5jZKiaxxr5SM=
X-Google-Smtp-Source: AJdET5fwMieBmMI+fU1tjiLL6lmp0uc3l+noV4h19lmzcWpvmKoBTrqfWu1p/K2jDtkyfHRI7VotNQ==
X-Received: by 2002:a63:f844:: with SMTP id v4mr2834960pgj.82.1541659323642;
        Wed, 07 Nov 2018 22:42:03 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id t26-v6sm3647203pfa.158.2018.11.07.22.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 22:42:03 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v6 3/3] arm64: dts: allwinner: a64: enable sound on Pinebook
Date:   Wed,  7 Nov 2018 22:39:29 -0800
Message-Id: <20181108063929.29720-4-anarsoul@gmail.com>
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
Pinebook

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 77fac84797e9..73f171f4ba9b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -64,6 +64,23 @@
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
+
+	speaker_amp: speaker_amp {
+		compatible = "simple-audio-amplifier";
+		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
+	};
+};
+
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
 };
 
 &ehci0 {
@@ -267,6 +284,31 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	status = "okay";
+	simple-audio-card,widgets = "Microphone", "Internal Microphone Left",
+				    "Microphone", "Internal Microphone Right",
+				    "Headphone", "Headphone Jack",
+				    "Speaker", "Internal Speaker";
+	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"INL", "LINEOUT",
+			"INR", "LINEOUT",
+			"Internal Speaker", "OUTL",
+			"Internal Speaker", "OUTR",
+			"Headphone Jack", "HP",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Left ADC", "ADC",
+			"Right ADC", "ADC",
+			"Internal Microphone Left", "MBIAS",
+			"MIC1", "Internal Microphone Left",
+			"Internal Microphone Right", "HBIAS",
+			"MIC2", "Internal Microphone Right";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.19.1

