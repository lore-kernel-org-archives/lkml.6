Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7901AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3181923F44
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ADYr4658"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3181923F44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933177AbeGFOcD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:32:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33602 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeGFOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:31:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so5540953wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 07:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q5udfyfJ9fkE3pRFewWqqyHAAM6JHa/PdncLvJV13n4=;
        b=ADYr4658e2hrwNoBIUZciWF6aWijp7owrLRJqKkbS0+Lcu+CPXrmoNKZfeO4YemeQK
         w5tMvJr1k7jFhvotnMeFHsc2Ye9398OL0wrvocRUr+iHA3DLM/W1i21RvK6QbmAC+FG8
         zY2v8FXwB6Uym5x7+PJfT1sESaBPtwJ7HAeJ2a7SSbKblGgzlkPIHuwEy/AYNHRdBHd5
         kvFH4Wln7QxZA7oIIAHuxudHSgBjpXxXXxXuqx+YYm835ROBZZrMNxFWi05O/Q+VXDmv
         KjkXdLnJiWRP4gUx0tZtawfI3d5s0q2a5cGjm7tbJlxgHo2/sEaYVZ3YRgDl+6oN/6RA
         yLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q5udfyfJ9fkE3pRFewWqqyHAAM6JHa/PdncLvJV13n4=;
        b=UOhJWQkiIpk+8tCGAZlEw8LuoWQv1xesf4vxiEl6jNEmj3YOBmlZEsM2GfmOEAFL2u
         XfEPEU+vzHgt83na54BnJj3q1aCrdQ1wKunTxDeFwsAtxlfhe03v4MvmsqaQwH0sDRCt
         e1BRlFwRqL4F5Ao8aqiO7Pnvj16jHqp+QkyPToF0X9WKv5MbIS3OhFbXPmEW71t9ILjM
         65sSOsXVGspFPKVDopE18RoGS1eVbUBmsKam1NVPauxJFg25XsaG+7GtNCVudxijUaop
         4p3FGcJ6sySWHMDcaYyp66E6jMn3CZTFw8UHztzm0WgidpANEJXXFOopZQCk3XvKVDNZ
         SUxw==
X-Gm-Message-State: APt69E1AzR/GzqEz5Eyhyt8tQlARYMNTBmCrH5cOuhWJRc+5TuYMrjhI
        CNPpDq5+sSF3yWjUo9D6kllkUA==
X-Google-Smtp-Source: AAOMgpdZeO7uyuf+n/74SmMfFELkX/0X0JIKaFtiXFMiuHF+6H2xjHaCnUGbx5zlzfY+Qh7/Hys6tQ==
X-Received: by 2002:a1c:bd5:: with SMTP id 204-v6mr7244408wml.160.1530887488120;
        Fri, 06 Jul 2018 07:31:28 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b190-v6sm14358709wma.24.2018.07.06.07.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 07:31:27 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] reset: meson: add dt-bindings for meson-axg audio arb
Date:   Fri,  6 Jul 2018 16:31:21 +0200
Message-Id: <20180706143122.7612-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180706143122.7612-1-jbrunet@baylibre.com>
References: <20180706143122.7612-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for the audio memory arbitror found on Amlogic's
A113 based SoCs

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/reset/amlogic,meson-axg-audio-arb.txt  | 21 +++++++++++++++++++++
 .../dt-bindings/reset/amlogic,meson-axg-audio-arb.h | 17 +++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
 create mode 100644 include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
new file mode 100644
index 000000000000..e29b3463f2e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
@@ -0,0 +1,21 @@
+* Amlogic audio memory arbitror controller
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

