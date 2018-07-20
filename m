Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E311ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB3520661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bkDj+F6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB3520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeGTQP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:15:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37171 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731863AbeGTQP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:15:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id a19-v6so10164560wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9pWkYvO82DZ1ByhdduFL5lj1yKvcGUzRP13CjILYgJA=;
        b=bkDj+F6w6HNsRRHAUzF/6NHL+MFo2fzoVrGRXYXwXn3itbbqdD6To4o7/ulgGRKmg0
         HSC8mBtyxyiTDz1H76AcZpIkwF/QT0m/h8qpOby1MC6/mRwXeUrsNShpOmyR5APnzRdG
         gCfcFolQ84S1gbMtkHxkC3EuCsWheA7sg3PEa4dBmZbY7J1JWlrzmiTrV5fZTVClEAVq
         kpQPuKJKemxJCAEUy8wXkdiRsLayk/j7uEEuiSyVYo1rCWvQqviMCNahxyK1M50GKbZj
         rQAjU7DdR1DZxfsDJpDk3IpevYm9VNS8G7bp07kc1qk1Xdw6fRsox5SuU7pc3asCSyfR
         Lnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9pWkYvO82DZ1ByhdduFL5lj1yKvcGUzRP13CjILYgJA=;
        b=aam+ryON0obuOE34rsXVF7J4Uuc1MTAKnRRkfMobpIAcFREFh4JXj4qFV9NIz3Ev73
         0SZWb56SHYpN70CASUryMNybhLCdJZtqSLJW8WkSouE2CJwHBRgg1zRJWvSJeYX6f6Ra
         zRgLngc9aVhjKug0Ryj/jx76ZgWKH7xDTVrEy27w2X44CuKH4C2nTpU5F5BE651yOza0
         dm/V5vfBTP9z+CvVqUOG25VXRTs2JA/jLRUPxEUwmNodRb9Di4WVv33jm9IJqAvKWGdE
         t5yLkaA0+o6Z1WKtpEtEADJN7WqY4ksLIm22V+o4OCJfNOekOT4B92QW3+mTHuTV3TJC
         xvoQ==
X-Gm-Message-State: AOUpUlFHeTEDgwXhxflcTX2ojwp7WiEhTfOSJzIGBbWE96rV2ALvchCd
        o7giOXNw9MoAQzQXJfcqRnKjSA==
X-Google-Smtp-Source: AAOMgpeGNGVOypV7rrEPGGhCVZskCiwTEWHpHePCVoQiaeXcq0u8SBO3eTsc1JOJRIlZhd0G84JGeQ==
X-Received: by 2002:a1c:8291:: with SMTP id e139-v6mr1956587wmd.39.1532100397515;
        Fri, 20 Jul 2018 08:26:37 -0700 (PDT)
Received: from boomer.baylibre.local (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id j3-v6sm2910051wrt.70.2018.07.20.08.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:26:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] reset: meson: add dt-bindings for meson-axg audio arb
Date:   Fri, 20 Jul 2018 17:26:32 +0200
Message-Id: <20180720152633.6227-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720152633.6227-1-jbrunet@baylibre.com>
References: <20180720152633.6227-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for the audio memory arbiter found on Amlogic's
A113 based SoCs

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/reset/amlogic,meson-axg-audio-arb.txt  | 21 +++++++++++++++++++++
 .../dt-bindings/reset/amlogic,meson-axg-audio-arb.h | 17 +++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
 create mode 100644 include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
new file mode 100644
index 000000000000..26e542eb96df
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
@@ -0,0 +1,21 @@
+* Amlogic audio memory arbiter controller
+
+The Amlogic Audio ARB is a simple device which enables or
+disables the access of Audio FIFOs to DDR on AXG based SoC.
+
+Required properties:
+- compatible: 'amlogic,meson-axg-audio-arb'
+- reg: physical base address of the controller and length of memory
+       mapped region.
+- clocks: phandle to the fifo peripheral clock provided by the audio
+	  clock controller.
+- #reset-cells: must be 1.
+
+Example on the A113 SoC:
+
+arb: reset-controller@280 {
+	compatible = "amlogic,meson-axg-audio-arb";
+	reg = <0x0 0x280 0x0 0x4>;
+	#reset-cells = <1>;
+	clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
+};
diff --git a/include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h b/include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h
new file mode 100644
index 000000000000..05c36367875c
--- /dev/null
+++ b/include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT)
+ *
+ * Copyright (c) 2018 Baylibre SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef _DT_BINDINGS_AMLOGIC_MESON_AXG_AUDIO_ARB_H
+#define _DT_BINDINGS_AMLOGIC_MESON_AXG_AUDIO_ARB_H
+
+#define AXG_ARB_TODDR_A	0
+#define AXG_ARB_TODDR_B	1
+#define AXG_ARB_TODDR_C	2
+#define AXG_ARB_FRDDR_A	3
+#define AXG_ARB_FRDDR_B	4
+#define AXG_ARB_FRDDR_C	5
+
+#endif /* _DT_BINDINGS_AMLOGIC_MESON_AXG_AUDIO_ARB_H */
-- 
2.14.4

