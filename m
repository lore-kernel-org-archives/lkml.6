Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CACC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43230222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1WNXKCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394956AbfBMVlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:41:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39592 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbfBMVlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:41:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id f132so1812718pfa.6;
        Wed, 13 Feb 2019 13:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wLmvmqHuKLo0jMVgOhqswHV98llcZw1Y6p8Tf9a/GTU=;
        b=q1WNXKCFMPXvHsH+kdD7TkDmIxQxz7Gu3pdOfEDuN3WB5/J7dGJwEssoHkOBzL0HtS
         kw0e5+VdnhaGxZ+bgfhXVR6SDCi8kaa/idKEojjauORIQp78+qAtJXXsTcwASDeAN60x
         PMLKepbIeDEIkHOGqzHZ8z4B4QUALNto96iuffAv4d86iZAyghGNFzzYC1Wa0e0w1A0V
         7U5PGPze9tg5P8Y+rywGjTqFQ/behg0w7F376uEv8Q79iyS4P5L8NR6M86T8H8hUwHXI
         HGdPr69lwNhiek1k1OI2grvcGVbCvvLCPhAyz7eRPVJlbwczMBvDHHownIeSQp2Zn4lS
         Cpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wLmvmqHuKLo0jMVgOhqswHV98llcZw1Y6p8Tf9a/GTU=;
        b=qy40zB0j1ItVxOfEnvLfX/xZIhQ3ckdQ+wuZCRBgfuHHsVPXo3XehcZeuxC1SydX5L
         MqciOKxKrgX6lb8K7BWyXf/kkszlXLowBsdV3QXfiFpSBJ0WUHaYDjt3EuGNLRFtg7Dl
         7XJE9hbwgYnjMSWfbaqFm5191l27cflfie/6FgGH4f410W3PZl//+IWnkpqrgJ1o1CPv
         twAJLlUgyElgdbnPW3mlERUQc6yHd5tez8elYCgrZrMkezh4H+mOJtfZ0akgxH4EuWpG
         u2LX1l1NzLQSC67iR2Pp1cTHNAs6/nFjS6nm/Crk0Z2lelmUGwMRfxPtzKfoGCihuWIW
         aZxw==
X-Gm-Message-State: AHQUAuZNiMfaQ4a+M58K8G6TUHsHUCpHVYFsDhyFu+gy/a4KD5yWVa/D
        rVdj0+CAk+PwsLLuXmpqlw8C0oDt
X-Google-Smtp-Source: AHgI3IaF1fZqE0Mi2O9QOjJawD2AH4b0sAQ6qMAOlYxBBSuKw2C2dyiZHFLf/ghj1TijKIzOqxljBg==
X-Received: by 2002:a63:68ca:: with SMTP id d193mr280117pgc.53.1550094080651;
        Wed, 13 Feb 2019 13:41:20 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.137])
        by smtp.gmail.com with ESMTPSA id w128sm335321pfw.79.2019.02.13.13.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:41:20 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [RFC 2/2] soc: samsung: pmu: Add the PMU data of exynos4412 to support low-power state
Date:   Wed, 13 Feb 2019 21:40:52 +0000
Message-Id: <20190213214052.2427-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213214052.2427-1-linux.amoon@gmail.com>
References: <20190213214052.2427-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds configration for PMU (Power Management Unit) state
tuning for exynos4412 SoC in order to enter low-power mode during
suspend power modes and help resume from suspend state.

Fixes: bfce552d0b1 ("drivers: soc: Add support for Exynos PMU driver")
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---

Changes from previous patch.
New patch to this series to support suspend and resume state

Changes have been tested on microSD card but fails to resume on cMMC.
It need to be investigated and more debuging
---
 drivers/soc/samsung/exynos4-pmu.c           | 83 +++++++++++++++++++++
 include/linux/soc/samsung/exynos-regs-pmu.h | 21 ++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/soc/samsung/exynos4-pmu.c b/drivers/soc/samsung/exynos4-pmu.c
index a7cdbf1aac0c..d261a0d2371e 100644
--- a/drivers/soc/samsung/exynos4-pmu.c
+++ b/drivers/soc/samsung/exynos4-pmu.c
@@ -200,10 +200,93 @@ static const struct exynos_pmu_conf exynos4412_pmu_config[] = {
 	{ PMU_TABLE_END,},
 };
 
+static unsigned int const exynos4412_list_feed[] = {
+	EXYNOS4_ARM_CORE0_OPTION,
+	EXYNOS4_ARM_CORE1_OPTION,
+	EXYNOS4_ARM_CORE2_OPTION,
+	EXYNOS4_ARM_CORE3_OPTION,
+	EXYNOS4_ARM_COMMON_OPTION,
+	EXYNOS4_CAM_OPTION,
+	EXYNOS4_TV_OPTION,
+	EXYNOS4_MFC_OPTION,
+	EXYNOS4_G3D_OPTION,
+	EXYNOS4_LCD0_OPTION,
+	EXYNOS4_ISP_OPTION,
+	EXYNOS4_MAUDIO_OPTION,
+	EXYNOS4_GPS_OPTION,
+	EXYNOS4_GPS_ALIVE_OPTION,
+};
+
+static void exynos4412_pmu_central_seq(bool enable)
+{
+	unsigned int value;
+
+	value = pmu_raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
+	if (enable)
+		value &= ~S5P_CENTRAL_LOWPWR_CFG;
+	else
+		value |= S5P_CENTRAL_LOWPWR_CFG;
+	pmu_raw_writel(value, S5P_CENTRAL_SEQ_CONFIGURATION);
+
+	value = pmu_raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK);
+	if (enable)
+		value &= ~S5P_CENTRAL_LOWPWR_CFG;
+	else
+		value |= S5P_CENTRAL_LOWPWR_CFG;
+	pmu_raw_writel(value, S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK);
+}
+
+static void exynos4412_pmu_init(void)
+{
+	unsigned int value;
+	int i;
+
+	/* Enable USE_STANDBY_WFI for all CORE */
+	pmu_raw_writel(S5P_USE_STANDBY_WFI_ALL, S5P_CENTRAL_SEQ_OPTION);
+
+	/* Decides whether to use retention capability */
+	value  = pmu_raw_readl(S5P_ARM_L2_0_OPTION);
+	value &= ~EXYNOS_L2_USE_RETENTION;
+	pmu_raw_writel(value, S5P_ARM_L2_0_OPTION);
+
+	value = pmu_raw_readl(S5P_ARM_L2_1_OPTION);
+	value &= ~EXYNOS_L2_USE_RETENTION;
+	pmu_raw_writel(value, S5P_ARM_L2_1_OPTION);
+
+	/* Set PSHOLD port for output high */
+	value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
+	value |= S5P_PS_HOLD_OUTPUT_HIGH;
+	pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
+
+	/* Enable signal for PSHOLD port */
+	value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
+	value |= S5P_PS_HOLD_EN;
+	pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
+
+	/* Enable only SC_FEEDBACK */
+	for (i = 0; i < ARRAY_SIZE(exynos4412_list_feed); i++) {
+		value =  pmu_raw_readl(exynos4412_list_feed[i]);
+		value &= ~(EXYNOS_USE_SC_COUNTER);
+		value |= EXYNOS_USE_SC_FEEDBACK;
+		pmu_raw_writel(value, exynos4412_list_feed[i]);
+	}
+
+	exynos4412_pmu_central_seq(false);
+
+	pr_info("EXYNOS4x12 PMU Initialize\n");
+}
+
+static void exynos4412_powerdown_conf(enum sys_powerdown mode)
+{
+	exynos4412_pmu_central_seq(true);
+}
+
 const struct exynos_pmu_data exynos4210_pmu_data = {
 	.pmu_config	= exynos4210_pmu_config,
 };
 
 const struct exynos_pmu_data exynos4412_pmu_data = {
 	.pmu_config		= exynos4412_pmu_config,
+	.pmu_init		= exynos4412_pmu_init,
+	.powerdown_conf		= exynos4412_powerdown_conf,
 };
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index 5addaf5ccbce..6beed3e669d2 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -16,6 +16,8 @@
 
 #define S5P_CENTRAL_SEQ_CONFIGURATION		0x0200
 
+#define S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK   0x0240
+
 #define S5P_CENTRAL_LOWPWR_CFG			(1 << 16)
 
 #define S5P_CENTRAL_SEQ_OPTION			0x0208
@@ -347,6 +349,25 @@
 #define EXYNOS3_OPTION_USE_SC_FEEDBACK			(1 << 1)
 #define EXYNOS3_OPTION_SKIP_DEACTIVATE_ACEACP_IN_PWDN	(1 << 7)
 
+/* EXYNOS4 */
+#define EXYNOS_USE_SC_FEEDBACK					BIT(1)
+#define EXYNOS_USE_SC_COUNTER					BIT(0)
+
+#define EXYNOS4_ARM_CORE0_OPTION				0x2008
+#define EXYNOS4_ARM_CORE1_OPTION				0x2088
+#define EXYNOS4_ARM_CORE2_OPTION				0x2108
+#define EXYNOS4_ARM_CORE3_OPTION				0x2188
+#define EXYNOS4_ARM_COMMON_OPTION				0x2408
+#define EXYNOS4_CAM_OPTION					0x3C08
+#define EXYNOS4_TV_OPTION					0x3C28
+#define EXYNOS4_MFC_OPTION					0x3C48
+#define EXYNOS4_G3D_OPTION					0x3C68
+#define EXYNOS4_LCD0_OPTION					0x3C88
+#define EXYNOS4_ISP_OPTION					0x3CA8
+#define EXYNOS4_MAUDIO_OPTION					0x3CC8
+#define EXYNOS4_GPS_OPTION					0x3CE8
+#define EXYNOS4_GPS_ALIVE_OPTION				0x3D08
+
 /* For EXYNOS5 */
 
 #define EXYNOS5_AUTO_WDTRESET_DISABLE				0x0408
-- 
2.20.1

