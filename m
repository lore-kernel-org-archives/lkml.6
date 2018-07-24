Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C81C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3540120856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fuH8dCAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3540120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388671AbeGXN7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53280 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388609AbeGXN73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so2422076wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=njyBULs9PWdQsY4lJgbDOmtKYIvdlYmmdmZvKuVltz0=;
        b=fuH8dCAK5dL4DEvbRZ5B/31dsANpfszp+xtD4biMJrnlEEZRSJu9nU4xbWWZtqV9NC
         mDAFkg/bJhouqSWOxlozENSPswvaTA/r/gxfbKs1mdPXpQhhmarI/NkbkxaGHolFXgou
         YCUM0NiiVPQZLokGV9n6xv69Rzsq1REHNjlogOCb/E1Yn4x6+dAcv43WpjzU69QUHv7M
         gFYohocDFGz0QPj0jJN3Rpy6PmdCRHgPB642R8GeOYw0XmZVACAGV/Oz6TAxUMG6cx0H
         jUolWLUC1FYSgfACdfZuH3Af59TKgVBzL+xbBuOqJp17wfcKbtr6b4O/N/6/J6JvgdFI
         golg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=njyBULs9PWdQsY4lJgbDOmtKYIvdlYmmdmZvKuVltz0=;
        b=SLmCgAMWANXTrUzrTkKwiM9dr3/rMhz8PESHexeEySxLe7zAuKdAa3ao5kr5B7iXKL
         cN9TlYCIE1/Un6rz9cprtzXFEu2WaECPeQAC4/KeGirkn31TB2q3pJ0ZdJ8gWLzTghVs
         H4di5hTB58F8EfYDxFji33GU/XDmdvVK1Q8CYLbmwNZfkyKPD2vF+v7bmY1VpQtdKEnA
         7M3dHqXwhH+AnL4IU42Eu/mlllre5tHidqzWWCuDXj+1J0258GjEdLaal1bVQxc9CdRP
         bbjMDJ1dlhlXO3yTxEGGBaGWicCUOl8GB87yn6xCOLUDHeUMijv4dZ20AfxeVkCChZG+
         ATTQ==
X-Gm-Message-State: AOUpUlErGhmXJBr76TK9K+pjM5YLuwr+c9ZBfDTIzG1G1kv4OOQuapYz
        t04PYwc70nbSWx2caOYC61am0g==
X-Google-Smtp-Source: AAOMgpc+v8Ky9ij1yBrHiITaTzlGJQSHFky+JAwFsVsDNKEUtrqSYcz5aGeQOnuqtV2/G35OX/vWag==
X-Received: by 2002:a1c:1802:: with SMTP id 2-v6mr1824985wmy.81.1532436786436;
        Tue, 24 Jul 2018 05:53:06 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:53:05 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] arm64: dts: meson-axg: add s400 sound card
Date:   Tue, 24 Jul 2018 14:52:38 +0200
Message-Id: <20180724125238.14567-15-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the sound card of the s400. With it the following interface
should be working:
 * Lineout
 * Daugther card speaker 1 (same output as lineout)
 * Linein
 * SPDIF output

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Compared to what is actually available on the platform, the following
 is not provided ATM:
 * SPDIF input: WIP.
 * PDM DMICs: WIP.
 * TDM A - BT Codec: missing BT codec.
 * TDM B - Speaker analog loopback: missing tlv320adc codec.

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 9f5d81c3ee29..1b89c2cc5414 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -204,6 +204,113 @@
 		status = "okay";
 		sound-name-prefix = "DIT";
 	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		amlogic,name = "AXG-S400";
+		amlogic,aux-devs = <&tdmin_a>, <&tdmin_b>,  <&tdmin_c>,
+				   <&tdmin_lb>, <&tdmout_c>;
+		amlogic,widgets = "Line", "Lineout",
+				  "Line", "Linein",
+				  "Speaker", "Speaker1 Left",
+				  "Speaker", "Speaker1 Right";
+		amlogic,routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
+				  "SPDIFOUT IN 0", "FRDDR_A OUT 3",
+				  "TDMOUT_C IN 1", "FRDDR_B OUT 2",
+				  "SPDIFOUT IN 1", "FRDDR_B OUT 3",
+				  "TDMOUT_C IN 2", "FRDDR_C OUT 2",
+				  "SPDIFOUT IN 2", "FRDDR_C OUT 3",
+				  "TDM_C Playback", "TDMOUT_C OUT",
+				  "TDMIN_A IN 2", "TDM_C Capture",
+				  "TDMIN_A IN 5", "TDM_C Loopback",
+				  "TDMIN_B IN 2", "TDM_C Capture",
+				  "TDMIN_B IN 5", "TDM_C Loopback",
+				  "TDMIN_C IN 2", "TDM_C Capture",
+				  "TDMIN_C IN 5", "TDM_C Loopback",
+				  "TDMIN_LB IN 2", "TDM_C Loopback",
+				  "TDMIN_LB IN 5", "TDM_C Capture",
+				  "TODDR_A IN 0", "TDMIN_A OUT",
+				  "TODDR_B IN 0", "TDMIN_A OUT",
+				  "TODDR_C IN 0", "TDMIN_A OUT",
+				  "TODDR_A IN 1", "TDMIN_B OUT",
+				  "TODDR_B IN 1", "TDMIN_B OUT",
+				  "TODDR_C IN 1", "TDMIN_B OUT",
+				  "TODDR_A IN 2", "TDMIN_C OUT",
+				  "TODDR_B IN 2", "TDMIN_C OUT",
+				  "TODDR_C IN 2", "TDMIN_C OUT",
+				  "TODDR_A IN 6", "TDMIN_LB OUT",
+				  "TODDR_B IN 6", "TDMIN_LB OUT",
+				  "TODDR_C IN 6", "TDMIN_LB OUT",
+				  "Lineout", "Lineout AOUTL",
+				  "Lineout", "Lineout AOUTR",
+				  "Speaker1 Left", "SPK1 OUT_A",
+				  "Speaker1 Left", "SPK1 OUT_B",
+				  "Speaker1 Right", "SPK1 OUT_C",
+				  "Speaker1 Right", "SPK1 OUT_D",
+				  "Linein AINL", "Linein",
+				  "Linein AINR", "Linein";
+		assigned-clocks = <&clkc CLKID_HIFI_PLL>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <589824000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		amlogic,dai-link@0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		amlogic,dai-link@1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		amlogic,dai-link@2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		amlogic,dai-link@3 {
+			sound-dai = <&toddr_a>;
+		};
+
+		amlogic,dai-link@4 {
+			sound-dai = <&toddr_b>;
+		};
+
+		amlogic,dai-link@5 {
+			sound-dai = <&toddr_c>;
+		};
+
+		amlogic,dai-link@6 {
+			sound-dai = <&tdmif_c>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-rx-mask-1 = <1 1>;
+			mclk-fs = <256>;
+
+			codec@0 {
+				sound-dai = <&lineout>;
+			};
+
+			codec@1 {
+				sound-dai = <&speaker_amp1>;
+			};
+
+			codec@2 {
+				sound-dai = <&linein>;
+			};
+
+		};
+
+		amlogic,dai-link@7 {
+			sound-dai = <&spdifout>;
+
+			codec {
+				sound-dai = <&spdif_dit>;
+			};
+		};
+	};
 };
 
 &ethmac {
@@ -272,6 +379,7 @@
 		PVDD_B-supply = <&main_12v>;
 		PVDD_C-supply = <&main_12v>;
 		PVDD_D-supply = <&main_12v>;
+		sound-name-prefix = "SPK1";
 	};
 };
 
-- 
2.17.1

