Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3486CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68362086D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fEIMBEKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68362086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbeGQQKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:10:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52822 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbeGQQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:10:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id o11-v6so1960812wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gf0R91kG2d7lDzaIoH7oyEyl99OABalSiO8tr5ySzv0=;
        b=fEIMBEKO2NmQ+VzmN6lPPq6zgOaL8BDCq0t7FKR550zQSX/s1c1B9HdXQyXL6gXBsz
         vwczuUhVVvq1Q74r7hGfbUV6f6/j3Kwj4kMnjTYyBIvS5VOVvG8Et/1CpukU2f3pT4BR
         FIe/2M314l2Tewx8QRpC4qi1vt4I/TJfO2m/qk1VTk0JDaqB6jQAb/U5ybnNeA18ra2U
         Lrq5AxOs9ijPKaUekbwqlWmWd8xQNDj7ioS6ElSFx241YI0GfAxtUNl/0qobmozI+llb
         LZ7cRq60UtHDwTqZfRBBicDwaOlxL3Ppf9IRjAsI26CRyLnVklSvWQtzA3kO67U8/OdR
         e/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gf0R91kG2d7lDzaIoH7oyEyl99OABalSiO8tr5ySzv0=;
        b=XbV4OoZlFS4QU0jMWFPic/bllhz/BJt8v1g3MMl9UmHSXJ1zMik0dJl7eIDE5MBJP4
         2k03HAgLvmhWSRu68Lmif6IcQezIhkarSwGmjwkgERQtg46iwtovLn2/gNHJHPxXOFmZ
         dXfZdgopfnVUVv6ihJhYACIFwCH9FiSWSC3xFH3/YH0Od0oqzpWRkEFRiWvi3dHn4Gqt
         Z86PWtagpogxg73idQxoBOsWjucH9F/wLSMtg4T8R2SktxDyZ9X+pXu8BKvlWHLmd3iW
         NFnUPifiYyAgG6ErWxan5Cm2/6A3F8ZJ1/revj6zOvdtJiBf7M1QRnmmSSR+Vf2l1GFO
         57QA==
X-Gm-Message-State: AOUpUlFZ9Zr1LwnZL3mCTANtVaehS/Kh9r0B7RSIN+rEYeV0AOy+Bpuc
        0m2tWn59HajexHNTTScO1+lb/Q==
X-Google-Smtp-Source: AAOMgpcmOuVfeysJeGeBXx3jaZVMwa7yZh2pIS3GX8TzPCGJqGMIhUBukOk39i70LkptFvredyOoOg==
X-Received: by 2002:a1c:ea53:: with SMTP id i80-v6mr1830568wmh.113.1531841825082;
        Tue, 17 Jul 2018 08:37:05 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16971464wmb.3.2018.07.17.08.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:37:04 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 14/15] ASoC: meson: add axg sound card DT binding documentation
Date:   Tue, 17 Jul 2018 17:36:41 +0200
Message-Id: <20180717153643.8806-18-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding documentation for axg sound card

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-sound-card.txt      | 124 +++++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
new file mode 100644
index 000000000000..39e005da0407
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
@@ -0,0 +1,124 @@
+Amlogic AXG sound card:
+
+Required properties:
+
+- compatible: "amlogic,axg-sound-card"
+- amlogic,name : User specified audio sound card name, one string
+
+Optional properties:
+
+- amlogic,aux-devs : List of phandles pointing to auxiliary devices
+- amlogic,widgets : Please refer to widgets.txt.
+- amlogic,routing : A list of the connections between audio components.
+
+Subnodes:
+
+- amlogic,dai-link: Container for dai-link level properties and the
+		    CODEC sub-nodes. There should be at least one (and
+		    probably) subnode of this type.
+
+Required dai-link properties:
+
+- sound-dai: phandle and port of the CPU DAI.
+
+Required TDM Backend dai-link properties:
+- dai-format : CPU/CODEC common audio format
+
+Optional TDM Backend dai-link properties:
+- dai-tdm-slot-rx-mask-{0,1,2,3}: Receive direction slot masks
+- dai-tdm-slot-tx-mask-{0,1,2,3}: Transmit direction slot masks
+				  When omitted, mask is assumed to have to no
+				  slots. A valid must have at one slot, so at
+				  least one these mask should be provided with
+				  an enabled slot.
+- dai-tdm-slot-num : Please refer to tdm-slot.txt.
+		     If omitted, slot number is set to accommodate the largest
+		     mask provided.
+- dai-tdm-slot-width : Please refer to tdm-slot.txt. default to 32 if omitted.
+- mclk-fs : Multiplication factor between stream rate and mclk
+
+Backend dai-link subnodes:
+
+- codec: dai-link representing backend links should have at least one subnode.
+	 One subnode for each codec of the dai-link.
+	 dai-link representing frontend links have no codec, therefore have no
+	 subnodes
+
+Required codec subnodes properties:
+
+- sound-dai: phandle and port of the CODEC DAI.
+
+Optional codec subnodes properties:
+
+- dai-tdm-slot-tx-mask : Please refer to tdm-slot.txt.
+- dai-tdm-slot-rx-mask : Please refer to tdm-slot.txt.
+
+Example:
+
+sound {
+	compatible = "amlogic,axg-sound-card";
+	amlogic,name = "AXG-S420";
+	amlogic,aux-devs = <&tdmin_a>, <&tdmout_c>;
+	amlogic,widgets = "Line", "Lineout",
+			  "Line", "Linein",
+			  "Speaker", "Speaker1 Left",
+			  "Speaker", "Speaker1 Right";
+			  "Speaker", "Speaker2 Left",
+			  "Speaker", "Speaker2 Right";
+	amlogic,routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
+			  "SPDIFOUT IN 0", "FRDDR_A OUT 3",
+			  "TDM_C Playback", "TDMOUT_C OUT",
+			  "TDMIN_A IN 2", "TDM_C Capture",
+			  "TDMIN_A IN 5", "TDM_C Loopback",
+			  "TODDR_A IN 0", "TDMIN_A OUT",
+			  "Lineout", "Lineout AOUTL",
+			  "Lineout", "Lineout AOUTR",
+			  "Speaker1 Left", "SPK1 OUT_A",
+			  "Speaker2 Left", "SPK2 OUT_A",
+			  "Speaker1 Right", "SPK1 OUT_B",
+			  "Speaker2 Right", "SPK2 OUT_B",
+			  "Linein AINL", "Linein",
+			  "Linein AINR", "Linein";
+
+	amlogic,dai-link@0 {
+		sound-dai = <&frddr_a>;
+	};
+
+	amlogic,dai-link@1 {
+		sound-dai = <&toddr_a>;
+	};
+
+	amlogic,dai-link@2 {
+		sound-dai = <&tdmif_c>;
+		dai-format = "i2s";
+		dai-tdm-slot-tx-mask-2 = <1 1>;
+		dai-tdm-slot-tx-mask-3 = <1 1>;
+		dai-tdm-slot-rx-mask-1 = <1 1>;
+		mclk-fs = <256>;
+
+		codec@0 {
+			sound-dai = <&lineout>;
+		};
+
+		codec@1 {
+			sound-dai = <&speaker_amp1>;
+		};
+
+		codec@2 {
+			sound-dai = <&speaker_amp2>;
+		};
+
+		codec@3 {
+			sound-dai = <&linein>;
+		};
+
+	};
+
+	amlogic,dai-link@4 {
+		sound-dai = <&spdifout>;
+
+		codec {
+			sound-dai = <&spdif_dit>;
+		};
+	};
+};
-- 
2.14.4

