Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C01C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2EB20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ilGaf19N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2EB20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbeLMOgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:36:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53999 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729063AbeLMOgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:36:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so2574831wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 06:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7K7iELG0a2tVDLk15ROsV+hZvPYF3VLaoJgK29DOxho=;
        b=ilGaf19Nu7tlQLV4OQA7w1uDuHvZimVvkJ/t3sxGQBQCSucMAJnGFWy1ED33ex2rKv
         n5yoti8eezGiuxKZMnxUkdiGhrVrLzopRcm63zTeo+K0xXmIauE2Gch+lFBw3bOcZYD4
         1+RcfBjwUgaN/TwaOP9tUl2dlC/OlLokE43BmkM9TzeSs1HijJJSIaiKFc0bUrb8Q+Gt
         l1DyD9RMYM0nMvP8TraspvrBgWobCuOl+kHwsC8BwkVO1W0Kpl5twfTWJVI2ltji7mKc
         2ws+HZlCNSqVe5SN/CLBXIjqkQQRwY4DEqYsBrX2PDiiCjAThMdDIaN71PKYBpvdRoiW
         StrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7K7iELG0a2tVDLk15ROsV+hZvPYF3VLaoJgK29DOxho=;
        b=rLTUYNfehqm7sHNE48zMI2LaDyo6/zj4lBmhyrnUZ4YtLLZ0X4f022OQw2+4irxplL
         SCUyPajVHBTK7eQsQwe6bUGKvwKvV5MekpaKXEbVQMxj3BNuo6c2zoR5Pp9CyK4oq5OK
         mr+93kMVovImDBXEs+T20jmzzOzty1iqz2sCGSNVB0W6P4H1XrC1vjIyLN/LHDlTL2Si
         OmLmnp/YFME9rfnlWRkt2JDzkFF84xMPZCDPZnlSuhDkH97dceMXTALtoXViTzWGoVda
         v0b1ZnNQoosqwHU0S8tC/5E/yWeL9c9zxMiuZl6jGn9+c6CYa7r4fpoLI8IfrGSw08RV
         jfgw==
X-Gm-Message-State: AA+aEWbhfbCrsdu+iUsfTn+jyii4aWDocsHPfbcSBAwdsch5r4pLttwO
        oo7KjS1nUOR7FN0xUlr9KszeGw==
X-Google-Smtp-Source: AFSGD/Wq8TmdArWt+zEIO67LePsnCA/8WZZUshPb6x+qK77eFcIlnixs1Vjm09fqpZku6aSAHBz07Q==
X-Received: by 2002:a1c:848c:: with SMTP id g134mr9782244wmd.93.1544711804076;
        Thu, 13 Dec 2018 06:36:44 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id e12sm4929930wmf.22.2018.12.13.06.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 06:36:43 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: meson-axg: s400: add spdifin to the sound card
Date:   Thu, 13 Dec 2018 15:36:31 +0100
Message-Id: <20181213143631.19218-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213143631.19218-1-jbrunet@baylibre.com>
References: <20181213143631.19218-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable spdif input device on the S400 and add it to the card

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 2f622a0b599a..c8b531ce5c63 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -256,6 +256,9 @@
 				"TODDR_A IN 2", "TDMIN_C OUT",
 				"TODDR_B IN 2", "TDMIN_C OUT",
 				"TODDR_C IN 2", "TDMIN_C OUT",
+				"TODDR_A IN 3", "SPDIFIN Capture",
+				"TODDR_B IN 3", "SPDIFIN Capture",
+				"TODDR_C IN 3", "SPDIFIN Capture",
 				"TODDR_A IN 4", "PDM Capture",
 				"TODDR_B IN 4", "PDM Capture",
 				"TODDR_C IN 4", "PDM Capture",
@@ -333,6 +336,14 @@
 		};
 
 		dai-link-8 {
+			sound-dai = <&spdifin>;
+
+			codec {
+				sound-dai = <&spdif_dir>;
+			};
+		};
+
+		dai-link-9 {
 			sound-dai = <&pdm>;
 
 			codec {
@@ -489,6 +500,12 @@
 	vqmmc-supply = <&vddio_boot>;
 };
 
+&spdifin {
+	pinctrl-0 = <&spdif_in_a19_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &spdifout {
 	pinctrl-0 = <&spdif_out_a20_pins>;
 	pinctrl-names = "default";
-- 
2.19.2

