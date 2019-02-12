Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7832C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8529320842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BDCr7HLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfBLQ3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:29:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34103 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfBLQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:29:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so3410249wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 08:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b17QC1yK688ZWb10QT74DyiITU1l1NF57mYQWB4mILg=;
        b=BDCr7HLaHSqb428CRXZ/Z9TcOnEG95cpoVfxWv8J25RgsnhRbyTYrc+3Gqvue2yt5o
         OtjNL4O3IqninjuwGjxt3T8jQTSCATXqRPIoXTeuIBgCzGHFDZueLdHGdHeASD9P1gQb
         p9wLKnWshLm5O8OONHhdJphcHA69/mZmCqnIGbopu5RySfaTH9sF5J+pzMyb/yulX3Yo
         5d30M66PMQaflm/RHMM3CDl7PeN5GmsTu0fVm8jM5xEzA1EU5KCIV9dpSNVm+EBwNG6/
         9kJTCd3yucJayEP57E9yBSKPYqo0xwXmjasszjfDgbg2PfRTry8Utl+QT+iy1JqzL6W+
         29fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b17QC1yK688ZWb10QT74DyiITU1l1NF57mYQWB4mILg=;
        b=QIqIvdZCm9pGuI3nBByn+VdEPBmuXE14+y0wPgWvSXFu8UZvIAVSUJLXxg2Ayg5dVR
         sUqM5rtvzhC/BbcK9lXhkM30DEO8UL+m4UELvHW+ZlNzTmWjky62fkSSAQKCNqK4s8aC
         ZCkbcqWpYJz/z4LsqFRLsl7kyj1U7Si/1ocyvV5SCcW/qgP7N1l8w3Ob4wrSlo6bI7b9
         HOAtLkS1EhUeAIsC8G4oFj4TQZPSzGIRRMMPTbMfYnzB/DQujeBWtI206yHQydxhECGR
         UuLKSnbLQQyLGHaRNq66EcwzrMew/Xygtv3eE0qVaVpZavKsOvjUrnHapsjDiaFTFaPU
         e4Lw==
X-Gm-Message-State: AHQUAubIaO/IUWfOccGN9zywJNPRti3zTMmtHof0jNPJX/siy564dl/R
        3/qi/M4jgxYIP4gVULCuENoabQ==
X-Google-Smtp-Source: AHgI3IY8s6GmdUBtOUQFfSkBuVkNgpDYcmzMLfGgo/WKJn9PPQyGz1Cr8YNYgitIJ2HzRlcK6Sit8Q==
X-Received: by 2002:adf:91a7:: with SMTP id 36mr3352120wri.77.1549988942155;
        Tue, 12 Feb 2019 08:29:02 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z1sm7800876wrw.28.2019.02.12.08.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 08:29:01 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: clk: add G12A AO Clock and Reset Bindings
Date:   Tue, 12 Feb 2019 17:28:58 +0100
Message-Id: <20190212162859.20743-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212162859.20743-1-narmstrong@baylibre.com>
References: <20190212162859.20743-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Amlogic G12A AO Clock and Reset controllers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/clock/amlogic,gxbb-aoclkc.txt    |  1 +
 include/dt-bindings/clock/g12a-aoclkc.h       | 34 +++++++++++++++++++
 include/dt-bindings/reset/g12a-aoclkc.h       | 18 ++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
 create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
index 79511d7bb321..c41f0be5d438 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
@@ -10,6 +10,7 @@ Required Properties:
 	- GXL (S905X, S905D) : "amlogic,meson-gxl-aoclkc"
 	- GXM (S912) : "amlogic,meson-gxm-aoclkc"
 	- AXG (A113D, A113X) : "amlogic,meson-axg-aoclkc"
+	- G12A (S905X2, S905D2, S905Y2) : "amlogic,meson-g12a-aoclkc"
 	followed by the common "amlogic,meson-gx-aoclkc"
 - clocks: list of clock phandle, one for each entry clock-names.
 - clock-names: should contain the following:
diff --git a/include/dt-bindings/clock/g12a-aoclkc.h b/include/dt-bindings/clock/g12a-aoclkc.h
new file mode 100644
index 000000000000..8db01ffbeb06
--- /dev/null
+++ b/include/dt-bindings/clock/g12a-aoclkc.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Qiufang Dai <qiufang.dai@amlogic.com>
+ */
+
+#ifndef DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
+#define DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
+
+#define CLKID_AO_AHB		0
+#define CLKID_AO_IR_IN		1
+#define CLKID_AO_I2C_M0		2
+#define CLKID_AO_I2C_S0		3
+#define CLKID_AO_UART		4
+#define CLKID_AO_PROD_I2C	5
+#define CLKID_AO_UART2		6
+#define CLKID_AO_IR_OUT		7
+#define CLKID_AO_SAR_ADC	8
+#define CLKID_AO_MAILBOX	9
+#define CLKID_AO_M3		10
+#define CLKID_AO_AHB_SRAM	11
+#define CLKID_AO_RTI		12
+#define CLKID_AO_M4_FCLK	13
+#define CLKID_AO_M4_HCLK	14
+#define CLKID_AO_CLK81		15
+#define CLKID_AO_SAR_ADC_CLK	18
+#define CLKID_AO_32K		23
+#define CLKID_AO_CEC		27
+#define CLKID_AO_CTS_RTC_OSCIN	28
+
+#endif
diff --git a/include/dt-bindings/reset/g12a-aoclkc.h b/include/dt-bindings/reset/g12a-aoclkc.h
new file mode 100644
index 000000000000..bd2e2337135c
--- /dev/null
+++ b/include/dt-bindings/reset/g12a-aoclkc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef DT_BINDINGS_RESET_AMLOGIC_MESON_G12A_AOCLK
+#define DT_BINDINGS_RESET_AMLOGIC_MESON_G12A_AOCLK
+
+#define RESET_AO_IR_IN		0
+#define RESET_AO_UART		1
+#define RESET_AO_I2C_M		2
+#define RESET_AO_I2C_S		3
+#define RESET_AO_SAR_ADC	4
+#define RESET_AO_UART2		5
+#define RESET_AO_IR_OUT		6
+
+#endif
-- 
2.20.1

