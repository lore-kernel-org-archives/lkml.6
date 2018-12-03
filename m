Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20001C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FF4214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ES13xdpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FF4214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeLCNc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:32:28 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36153 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeLCNc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:32:27 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so7285089qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 05:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFtnXOJk34JsfWJZd01m3ADJA/D8osfUhgPthbLAvEM=;
        b=ES13xdpahgCvbqHWUtmELY1obONm+Y+3+JXt50FkCXB/4HGKn13Z+qkCgs/EjvZ6g7
         qmUbvuWVoc9h2x5GdehV3PvYW53kwkGzBRn/2PLyJjLhxxaUZredZoxqDJobBPFPbXwo
         R+0EI3NNt2z8nkopYhdts/bWzPq2Yeb7deKTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFtnXOJk34JsfWJZd01m3ADJA/D8osfUhgPthbLAvEM=;
        b=dFA1p6q4OhocTqgSQarHWr+OLCBVvdFfbeK24xOwbj9NhupUplQLD0c0GVvU+ouSNq
         DczBO6cljAWp3X4L0Wu8MyexyQVsQQdparB21nzlxRr/zAn6isbpjHwGsCT47ux6x9EC
         vw2JIRf8ZGerzzzJx9q5KZJoHnkr1K187AmtHosh3vR1GuhWu5KySS817c17qOrOT1YV
         6dk+XVlVSVYoEsMN/cKr8D3re/C7CEm8NUjl1GIIC439ZyxKH0LQnUVFzXHV1xmfJI9Q
         5Nid3eBhznjMXfzW18xGHyQBHOmR14e/4TJ+HkiTr4y7WpaokHiUyxqIHyXUzB14BANR
         pQEQ==
X-Gm-Message-State: AA+aEWYwmOnD9EgUX1aVliz07O8MJ0OCb0aa+XaO4Xx/KKMw2BbVD15g
        FFtj9hyyYUdsfW3BXsa/KKrhWw==
X-Google-Smtp-Source: AFSGD/WgGQv+2mzKg7LeioLzSmpzbvqbJL31FTj2NGBxiKAWZZ1ngKGyHacrFSjTxqImjVNDxcVtNQ==
X-Received: by 2002:a37:6f45:: with SMTP id k66mr12779246qkc.313.1543843884761;
        Mon, 03 Dec 2018 05:31:24 -0800 (PST)
Received: from workstation.celeiro.br ([138.204.25.29])
        by smtp.gmail.com with ESMTPSA id r56sm8619112qtj.30.2018.12.03.05.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 05:31:24 -0800 (PST)
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     sashal@kernel.org
Cc:     rafael.tinoco@linaro.org, gregkh@linuxfoundation.org,
        rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 4/5] thermal/drivers/hisi: Fix configuration register setting
Date:   Mon,  3 Dec 2018 11:31:06 -0200
Message-Id: <20181203133107.4002-5-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203133107.4002-1-rafael.tinoco@linaro.org>
References: <20181203133107.4002-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

patch b424315a287c70eeb5f920f84c92492bd2f5658e upstream.

The TEMP0_CFG configuration register contains different field to set up the
temperature controller. However in the code, nothing prevents a setup to
overwrite the previous one: eg. writing the hdak value overwrites the sensor
selection, the sensor selection overwrites the hdak value.

In order to prevent such thing, use a regmap-like mechanism by reading the
value before, set the corresponding bits and write the result.

Link: https://bugs.linaro.org/show_bug.cgi?id=4053 (PATCH 4/5)
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
(cherry picked from commit b424315a287c70eeb5f920f84c92492bd2f5658e)
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index a803043f37ae..31b52ebf426f 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -30,6 +30,8 @@
 #define TEMP0_TH			(0x4)
 #define TEMP0_RST_TH			(0x8)
 #define TEMP0_CFG			(0xC)
+#define TEMP0_CFG_SS_MSK		(0xF000)
+#define TEMP0_CFG_HDAK_MSK		(0x30)
 #define TEMP0_EN			(0x10)
 #define TEMP0_INT_EN			(0x14)
 #define TEMP0_INT_CLR			(0x18)
@@ -132,19 +134,41 @@ static inline void hisi_thermal_enable(void __iomem *addr, int value)
 	writel(value, addr + TEMP0_EN);
 }
 
-static inline void hisi_thermal_sensor_select(void __iomem *addr, int sensor)
+static inline int hisi_thermal_get_temperature(void __iomem *addr)
 {
-	writel((sensor << 12), addr + TEMP0_CFG);
+	return hisi_thermal_step_to_temp(readl(addr + TEMP0_VALUE));
 }
 
-static inline int hisi_thermal_get_temperature(void __iomem *addr)
+/*
+ * Temperature configuration register - Sensor selection
+ *
+ * Bits [19:12]
+ *
+ * 0x0: local sensor (default)
+ * 0x1: remote sensor 1 (ACPU cluster 1)
+ * 0x2: remote sensor 2 (ACPU cluster 0)
+ * 0x3: remote sensor 3 (G3D)
+ */
+static inline void hisi_thermal_sensor_select(void __iomem *addr, int sensor)
 {
-	return hisi_thermal_step_to_temp(readl(addr + TEMP0_VALUE));
+	writel((readl(addr + TEMP0_CFG) & ~TEMP0_CFG_SS_MSK) |
+	       (sensor << 12), addr + TEMP0_CFG);
 }
 
+/*
+ * Temperature configuration register - Hdak conversion polling interval
+ *
+ * Bits [5:4]
+ *
+ * 0x0 :   0.768 ms
+ * 0x1 :   6.144 ms
+ * 0x2 :  49.152 ms
+ * 0x3 : 393.216 ms
+ */
 static inline void hisi_thermal_hdak_set(void __iomem *addr, int value)
 {
-	writel(value, addr + TEMP0_CFG);
+	writel((readl(addr + TEMP0_CFG) & ~TEMP0_CFG_HDAK_MSK) |
+	       (value << 4), addr + TEMP0_CFG);
 }
 
 static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
-- 
2.20.0.rc1

