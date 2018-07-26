Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88011C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448542088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Eq5OUJP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448542088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbeGZOCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:02:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46903 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbeGZOCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:02:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id h14-v6so1582833wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oYFISBtgclTnoaHc+EU4FaMncw/3kCdI1LZml71Zj98=;
        b=Eq5OUJP1mn4iJSVAowybKbUeXe6Sq19Ax9K4sAIhbDMNQDK8QrsmkYYxET8R4Zokxy
         fCeuAhT3jXpNQu9TgV72m/2qGX7LT1vN/Pdfbn7nNawbnBlvmua95QfpUmCP8QieanAe
         kMJ+wJTIDjgH0cB99kvaEAALYVninOLCoJLulcNmQPHKDgSFOcbaNawk8Qc8t8jQ4j+Y
         3qmR18CXKXpLSIMGzJLjNWtMflvn/wWKtL39q3lYX2JWRU1XBy8Xs/Z313DJ19Vja0Fe
         xjDBzTBzrls03y3voiDsFIfsd95UszqOC+L9L4To25kbn26+BcGSO2MXedLF+0Qa5uq/
         iRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oYFISBtgclTnoaHc+EU4FaMncw/3kCdI1LZml71Zj98=;
        b=ev4W+0uwJENRBa4gf4UItmDi3YAVOCqI53LiuyM1vyGJs3e3zOOLFeLClrQQhM/mIw
         jDmE0mBkiGRmN6MP8GyWnoCau1vbphfGTb8+ugYWwHa0UU5cv8lCKrxk/AYjKVxL0qIL
         v77TeOKeSsW4jy+Vs3h2PdYYOh4OrEXtxxb/m9AJelOTNzqN/M0OzvxaXrAialWUaY1X
         kLkWilM8tmt5hmp6gaSD5UfW+XFx6KgJSkaSckrJgrhepnPNZWoBfx/0WzmfIzWiGBpZ
         ni3JaRycdKUYrSCbOYX96xx6VnPzdPMbSI/uhhbS/KkLpwfXDjW8PG7PlY2ctU0nuLI8
         46lw==
X-Gm-Message-State: AOUpUlGlK37Ph4x1KVfW55nILhjEWOQVReQZ4TdlLLTa0MQXlS27GB77
        Nmb5fiU5H6fCg6MsxVRxOqog9ZKcjtc=
X-Google-Smtp-Source: AAOMgpcgkKKhaDXPiasJ9ATL7tOuCGk1qLqntD5atPbyop6Lpc7l/uqe4NC6Ay6TklKknHh2YQKYlQ==
X-Received: by 2002:adf:8ec2:: with SMTP id q60-v6mr1422848wrb.275.1532609151713;
        Thu, 26 Jul 2018 05:45:51 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id m207-v6sm1867744wma.31.2018.07.26.05.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 05:45:51 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 2/3] ASoC: meson: update axg sound card bindings
Date:   Thu, 26 Jul 2018 14:45:43 +0200
Message-Id: <20180726124544.14740-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726124544.14740-1-jbrunet@baylibre.com>
References: <20180726124544.14740-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the amlogic prefix in front of the generic properties and change
the card 'name' property to 'model'

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-sound-card.txt | 68 +++++++++----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
index 39e005da0407..80b411296480 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
@@ -3,19 +3,19 @@ Amlogic AXG sound card:
 Required properties:
 
 - compatible: "amlogic,axg-sound-card"
-- amlogic,name : User specified audio sound card name, one string
+- model : User specified audio sound card name, one string
 
 Optional properties:
 
-- amlogic,aux-devs : List of phandles pointing to auxiliary devices
-- amlogic,widgets : Please refer to widgets.txt.
-- amlogic,routing : A list of the connections between audio components.
+- audio-aux-devs : List of phandles pointing to auxiliary devices
+- audio-widgets : Please refer to widgets.txt.
+- audio-routing : A list of the connections between audio components.
 
 Subnodes:
 
-- amlogic,dai-link: Container for dai-link level properties and the
-		    CODEC sub-nodes. There should be at least one (and
-		    probably) subnode of this type.
+- dai-link: Container for dai-link level properties and the CODEC
+	    sub-nodes. There should be at least one (and probably more)
+	    subnode of this type.
 
 Required dai-link properties:
 
@@ -57,38 +57,38 @@ Example:
 
 sound {
 	compatible = "amlogic,axg-sound-card";
-	amlogic,name = "AXG-S420";
-	amlogic,aux-devs = <&tdmin_a>, <&tdmout_c>;
-	amlogic,widgets = "Line", "Lineout",
-			  "Line", "Linein",
-			  "Speaker", "Speaker1 Left",
-			  "Speaker", "Speaker1 Right";
-			  "Speaker", "Speaker2 Left",
-			  "Speaker", "Speaker2 Right";
-	amlogic,routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
-			  "SPDIFOUT IN 0", "FRDDR_A OUT 3",
-			  "TDM_C Playback", "TDMOUT_C OUT",
-			  "TDMIN_A IN 2", "TDM_C Capture",
-			  "TDMIN_A IN 5", "TDM_C Loopback",
-			  "TODDR_A IN 0", "TDMIN_A OUT",
-			  "Lineout", "Lineout AOUTL",
-			  "Lineout", "Lineout AOUTR",
-			  "Speaker1 Left", "SPK1 OUT_A",
-			  "Speaker2 Left", "SPK2 OUT_A",
-			  "Speaker1 Right", "SPK1 OUT_B",
-			  "Speaker2 Right", "SPK2 OUT_B",
-			  "Linein AINL", "Linein",
-			  "Linein AINR", "Linein";
-
-	amlogic,dai-link@0 {
+	model = "AXG-S420";
+	audio-aux-devs = <&tdmin_a>, <&tdmout_c>;
+	audio-widgets = "Line", "Lineout",
+			"Line", "Linein",
+			"Speaker", "Speaker1 Left",
+			"Speaker", "Speaker1 Right";
+			"Speaker", "Speaker2 Left",
+			"Speaker", "Speaker2 Right";
+	audio-routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
+			"SPDIFOUT IN 0", "FRDDR_A OUT 3",
+			"TDM_C Playback", "TDMOUT_C OUT",
+			"TDMIN_A IN 2", "TDM_C Capture",
+			"TDMIN_A IN 5", "TDM_C Loopback",
+			"TODDR_A IN 0", "TDMIN_A OUT",
+			"Lineout", "Lineout AOUTL",
+			"Lineout", "Lineout AOUTR",
+			"Speaker1 Left", "SPK1 OUT_A",
+			"Speaker2 Left", "SPK2 OUT_A",
+			"Speaker1 Right", "SPK1 OUT_B",
+			"Speaker2 Right", "SPK2 OUT_B",
+			"Linein AINL", "Linein",
+			"Linein AINR", "Linein";
+
+	dai-link@0 {
 		sound-dai = <&frddr_a>;
 	};
 
-	amlogic,dai-link@1 {
+	dai-link@1 {
 		sound-dai = <&toddr_a>;
 	};
 
-	amlogic,dai-link@2 {
+	dai-link@2 {
 		sound-dai = <&tdmif_c>;
 		dai-format = "i2s";
 		dai-tdm-slot-tx-mask-2 = <1 1>;
@@ -114,7 +114,7 @@ sound {
 
 	};
 
-	amlogic,dai-link@4 {
+	dai-link@3 {
 		sound-dai = <&spdifout>;
 
 		codec {
-- 
2.17.1

