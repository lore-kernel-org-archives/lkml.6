Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083B7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E7820877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zD0rJqpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E7820877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbeGQQKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:10:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45132 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731296AbeGQQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:10:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id c4-v6so1691348wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N6GTffq4VROTez5mVO69vAu2OUH/qIKN2B9n0MrCC48=;
        b=zD0rJqpzzmZeQRz+j/gOf0lnbKMZFINYgLzHVw1wZL9K1//hl43MbJvT1ynw9kXR8o
         Uy+awm0k3n6FqkWlGnngjmsS8JMQ/jEVcEVMOTUdZol/Vm1pf0eCZuobbC4L53SJ24CT
         SWr6jXpJ0SsZ+V0LkwsC/68cBL/8iZfWKcyEU7PYNXciPuTSrn3BAy8dPpL8t49NoISQ
         9xf8d45EFRitwgIEp0Ua1aOTcttg3U84cDbeyLUWLRJQK3ti5v6DtbrJot/MnBm7iCeH
         9azCXL+DhkAjECAfiEyt4G2Y+3i6wT23cTgFJv5EhV8SKDAp1q9HdH74AkX8Jfv/Rarn
         PF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N6GTffq4VROTez5mVO69vAu2OUH/qIKN2B9n0MrCC48=;
        b=qQrkyp37vQDKA3CndpOG6ltilCedQLCeE5l7S1J5C8H4aY2yqzAOuCNK3tc+nb3ePC
         /E9IvGaDdgHWIzhjYAhlmWz1/PLX8aQvMLTVSqjbf+jIpRH/Lcr29Dr2E4qb5cf57IZ8
         DS0yGYt4FJf5QlxOG58hQgupXavlcWuuGwDw9Ja3w7rCuOTqniu2P39hi1aqDA8LgCNl
         DUjHzYTce/sAcI6+prX8mnq2/hKNQQldINqnOnGcC78TZ86P8OMP9lkBi6FVrzfo5kZh
         8BeFiT+U3f7mjUx2eRRvcVbOvwR7kXa+GlaRPDUJ56qTjLAop0qCZWnIpCYaXHYHUzKv
         brRQ==
X-Gm-Message-State: AOUpUlHZUuD0941+jrz6O2jCZ9MRjH1qj+KdswEB31ZJx5jfOVx9mJNN
        BXiR4fpjDEsAiB4zwXuisAiuIA==
X-Google-Smtp-Source: AAOMgpcgtZSFYh3JkSReNd1u6UTORLm21MX6fnAB19ug8ojqRbnsQJmAJJ7zbkICNSOCL4GTv2y9DQ==
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr1857934wrf.46.1531841826105;
        Tue, 17 Jul 2018 08:37:06 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16971464wmb.3.2018.07.17.08.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:37:05 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 14/15] ASoC: meson: add axg sound card DT bindings documentation
Date:   Tue, 17 Jul 2018 17:36:42 +0200
Message-Id: <20180717153643.8806-19-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT bindings documentation for axg sound card

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

