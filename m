Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52127ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5ED20779
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h7cFQ0E9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5ED20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbeGQQQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:16:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42473 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbeGQQQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:16:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so1725950wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fpyojqqEXxBMVGQ9gOj0nSaGphKtXorSOcTurNY/3cc=;
        b=h7cFQ0E99C5He0aTuGhI2oM1xKwg9NbZH1e3UuDi2GEq8v10llg/46wOTJ5WL69eRF
         OYilMmDCWm8M03ECCgb47vmGVbSOGhCe+nK94TV33unOHxE9lYX2cfPGzEM1XImUz4Do
         ZiG4UQ2y79jihzwFkGbT0Mq2D8hN7tt7A2g7W9KiWT6gkXvQBjpnTkjcXnX5oDUjhgIK
         Cj7+/QSkyOrl1ZVt782QeCc7kSWgx9QEa3Uz+J9Xden6RYB3wZZEG+c51PvsG/lec/Lf
         K/ImscxuiNnolRidsFSTP5kShoiZIhhEVLGm31IdwVhGPigZe6qaOtVVAwGLSWnPLNi+
         Xs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fpyojqqEXxBMVGQ9gOj0nSaGphKtXorSOcTurNY/3cc=;
        b=nUPDdypnH+rxLX2RYk9GrqjzBZ6jsdD1qy5RMtw1yiod/K86PTGZ2LYf5IZS9+z7/L
         R9rs1/WMuQMThLsoE/DlmYWmSkpiZ0ffUDwL8Yu7B2xKq5pLWwxfC3aso3McmyszIKYX
         lOQc+r+e7wHyoum7HhDS65SVcNz+xKrZ65mJGFcAtNa8G6hlYSZcRWC4iZ4Mj1eJmQY/
         Kyvxv3NmGFQjytyHS45ZYwwpzCfJoq83VRBbqWWXfj09rBirAXOcAH8rV3L16BZ34IeN
         lAkn5b+ml2p4JxLdJEs8wmJRNxxlkjvRZ6xjxYwnv/6hT/TRBVXyxnCzuTtvxiucfgaz
         fVbQ==
X-Gm-Message-State: AOUpUlHZSAzYcx9DZSr3rbucFeavSFowliuRy2+PR2d++484oX7xsMIv
        9iCXCXx5pvuTBRGiP4E+tI4RrQ==
X-Google-Smtp-Source: AAOMgpcK1lszas2G2hxs9HE8rfCvIFthk0KibnQXHOoTjvyHpLSS+bT4gjnczSYfpcHxZBQt++ZASQ==
X-Received: by 2002:adf:e3c5:: with SMTP id k5-v6mr1854206wrm.94.1531842194289;
        Tue, 17 Jul 2018 08:43:14 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s12-v6sm17598252wmc.2.2018.07.17.08.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:43:13 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH RESEND 01/15] ASoC: meson: add axg fifos DT binding documentation
Date:   Tue, 17 Jul 2018 17:42:50 +0200
Message-Id: <20180717154304.9973-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717154304.9973-1-jbrunet@baylibre.com>
References: <20180717154304.9973-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT bindings documentation for axg's FIFOs: TODDR and FRDDR.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/sound/amlogic,axg-fifo.txt | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
new file mode 100644
index 000000000000..3dfc2515e5c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
@@ -0,0 +1,23 @@
+* Amlogic Audio FIFO controllers
+
+Required properties:
+- compatible: 'amlogic,axg-toddr' or
+	      'amlogic,axg-frddr'
+- reg: physical base address of the controller and length of memory
+       mapped region.
+- interrupts: interrupt specifier for the fifo.
+- clocks: phandle to the fifo peripheral clock provided by the audio
+	  clock controller.
+- resets: phandle to memory ARB line provided by the arb reset controller.
+- #sound-dai-cells: must be 0.
+
+Example of FRDDR A on the A113 SoC:
+
+frddr_a: audio-controller@1c0 {
+	compatible = "amlogic,axg-frddr";
+	reg = <0x0 0x1c0 0x0 0x1c>;
+	#sound-dai-cells = <0>;
+	interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
+	clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
+	resets = <&arb AXG_ARB_FRDDR_A>;
+};
-- 
2.14.4

