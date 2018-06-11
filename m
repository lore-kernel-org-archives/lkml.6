Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CFNaO3xkHlurBQAAmS7hNA
	; Mon, 11 Jun 2018 12:01:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 64DE9607BB; Mon, 11 Jun 2018 12:01:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6QdtMjv"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9F714601C3;
	Mon, 11 Jun 2018 12:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F714601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933368AbeFKL7O (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:59:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39625 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933300AbeFKL7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:59:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so15955909wmc.4;
        Mon, 11 Jun 2018 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dlqnSMwncpFwBDktDGo0oHZ1gznSHRFoxKjC5rCsMPU=;
        b=b6QdtMjvHv1HOWg9wSrClogXdTaPSjBDmC5YddMcP5BU+W0a9iIB35RNEGQqEaJfLU
         CysMOy+xvnFs3FtA8GXIOt/5UGCPwiYfbUXM7MdPwva3FCLY1uOe6MO/sF494wfFYEM5
         rodf/QHYDDfAfCESuj3CLjBErP4owpb/egRzyYNowKfzL862dVFsIBhpn85z5EmNfDvO
         AIETdTUD+HMGdSSL2LPwZvbsZks5j7zHORc99w7nyo5XbHn1TBS9hU2QpSDKwcy44cGA
         Nqy+kupTxNqFflG49COqJfacqvfiuJzvBQKQkHYalOe3gdudbOgU/DETvbojA4ielpry
         r0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dlqnSMwncpFwBDktDGo0oHZ1gznSHRFoxKjC5rCsMPU=;
        b=Wzgu+eBFOn5GYEYUDFnouEoNWrkwT+2nRDI+IoC6KL5pFSIpfg17EO8jlmPOaoob4e
         s76v7Dii1RdofC9OoFkbEZ8g0WSZpk5KN15wn3SxsgFzvcoJnf7zoF9cLma8rp0zjjm/
         +jQosC4BTKZQWu/plWTjooPVIru7W+WbmFhhLyqrzUtLAUtJr+IU3p0EnvblyEny7971
         1MohktSPoRatThRMpXh3tom40QIbUuBii+GSJ5UQoANKXtJcjEv8NHAdWLx0SZK4RRsF
         Tk3eS6DcW0Mnbv2S8gYn/5kQDxluA35OJMakPgboSjDmHMjED2bSq9XyHo9/UIYmrewU
         hsmA==
X-Gm-Message-State: APt69E2BppLD6LCz011zT/vSRZyIjqDK9EBOoGeZwJRxjQJyMEES19uY
        2+EegAUaXhiJ8ag10Wi08bCaWY0f
X-Google-Smtp-Source: ADUXVKIY8Wu06g1QoBgLxaNYP1pfSqiB4nYTA++m5tapJ1sS4X5yOdMEhJrdBXSUUfJYBOWll6+ObQ==
X-Received: by 2002:a1c:5582:: with SMTP id j124-v6mr8400859wmb.153.1528718345882;
        Mon, 11 Jun 2018 04:59:05 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t124-v6sm7974796wmt.29.2018.06.11.04.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:59:05 -0700 (PDT)
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 03/14] mfd: da9063: Use regmap_reg_range
Date: Mon, 11 Jun 2018 13:58:40 +0200
Message-Id: <20180611115851.1987-3-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
References: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the regmap_range tables to use regmap_reg_range() macro.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V5: New patch
V6: No change
---
 drivers/mfd/da9063-i2c.c | 174 ++++++++++++-----------------------------------
 1 file changed, 42 insertions(+), 132 deletions(-)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 29456e807ed4..e9797153bc19 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -29,78 +29,33 @@
 #include <linux/regulator/of_regulator.h>
 
 static const struct regmap_range da9063_ad_readable_ranges[] = {
-	{
-		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_AD_REG_SECOND_D,
-	}, {
-		.range_min = DA9063_REG_SEQ,
-		.range_max = DA9063_REG_ID_32_31,
-	}, {
-		.range_min = DA9063_REG_SEQ_A,
-		.range_max = DA9063_REG_AUTO3_LOW,
-	}, {
-		.range_min = DA9063_REG_T_OFFSET,
-		.range_max = DA9063_AD_REG_GP_ID_19,
-	}, {
-		.range_min = DA9063_REG_CHIP_ID,
-		.range_max = DA9063_REG_CHIP_VARIANT,
-	},
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_AD_REG_SECOND_D),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_AD_REG_GP_ID_19),
+	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
 };
 
 static const struct regmap_range da9063_ad_writeable_ranges[] = {
-	{
-		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_REG_PAGE_CON,
-	}, {
-		.range_min = DA9063_REG_FAULT_LOG,
-		.range_max = DA9063_REG_VSYS_MON,
-	}, {
-		.range_min = DA9063_REG_COUNT_S,
-		.range_max = DA9063_AD_REG_ALARM_Y,
-	}, {
-		.range_min = DA9063_REG_SEQ,
-		.range_max = DA9063_REG_ID_32_31,
-	}, {
-		.range_min = DA9063_REG_SEQ_A,
-		.range_max = DA9063_REG_AUTO3_LOW,
-	}, {
-		.range_min = DA9063_REG_CONFIG_I,
-		.range_max = DA9063_AD_REG_MON_REG_4,
-	}, {
-		.range_min = DA9063_AD_REG_GP_ID_0,
-		.range_max = DA9063_AD_REG_GP_ID_19,
-	},
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_PAGE_CON),
+	regmap_reg_range(DA9063_REG_FAULT_LOG, DA9063_REG_VSYS_MON),
+	regmap_reg_range(DA9063_REG_COUNT_S, DA9063_AD_REG_ALARM_Y),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_CONFIG_I, DA9063_AD_REG_MON_REG_4),
+	regmap_reg_range(DA9063_AD_REG_GP_ID_0, DA9063_AD_REG_GP_ID_19),
 };
 
 static const struct regmap_range da9063_ad_volatile_ranges[] = {
-	{
-		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_REG_EVENT_D,
-	}, {
-		.range_min = DA9063_REG_CONTROL_A,
-		.range_max = DA9063_REG_CONTROL_B,
-	}, {
-		.range_min = DA9063_REG_CONTROL_E,
-		.range_max = DA9063_REG_CONTROL_F,
-	}, {
-		.range_min = DA9063_REG_BCORE2_CONT,
-		.range_max = DA9063_REG_LDO11_CONT,
-	}, {
-		.range_min = DA9063_REG_DVC_1,
-		.range_max = DA9063_REG_ADC_MAN,
-	}, {
-		.range_min = DA9063_REG_ADC_RES_L,
-		.range_max = DA9063_AD_REG_SECOND_D,
-	}, {
-		.range_min = DA9063_REG_SEQ,
-		.range_max = DA9063_REG_SEQ,
-	}, {
-		.range_min = DA9063_REG_EN_32K,
-		.range_max = DA9063_REG_EN_32K,
-	}, {
-		.range_min = DA9063_AD_REG_MON_REG_5,
-		.range_max = DA9063_AD_REG_MON_REG_6,
-	},
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_EVENT_D),
+	regmap_reg_range(DA9063_REG_CONTROL_A, DA9063_REG_CONTROL_B),
+	regmap_reg_range(DA9063_REG_CONTROL_E, DA9063_REG_CONTROL_F),
+	regmap_reg_range(DA9063_REG_BCORE2_CONT, DA9063_REG_LDO11_CONT),
+	regmap_reg_range(DA9063_REG_DVC_1, DA9063_REG_ADC_MAN),
+	regmap_reg_range(DA9063_REG_ADC_RES_L, DA9063_AD_REG_SECOND_D),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_SEQ),
+	regmap_reg_range(DA9063_REG_EN_32K, DA9063_REG_EN_32K),
+	regmap_reg_range(DA9063_AD_REG_MON_REG_5, DA9063_AD_REG_MON_REG_6),
 };
 
 static const struct regmap_access_table da9063_ad_readable_table = {
@@ -119,78 +74,33 @@ static const struct regmap_access_table da9063_ad_volatile_table = {
 };
 
 static const struct regmap_range da9063_bb_readable_ranges[] = {
-	{
-		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_BB_REG_SECOND_D,
-	}, {
-		.range_min = DA9063_REG_SEQ,
-		.range_max = DA9063_REG_ID_32_31,
-	}, {
-		.range_min = DA9063_REG_SEQ_A,
-		.range_max = DA9063_REG_AUTO3_LOW,
-	}, {
-		.range_min = DA9063_REG_T_OFFSET,
-		.range_max = DA9063_BB_REG_GP_ID_19,
-	}, {
-		.range_min = DA9063_REG_CHIP_ID,
-		.range_max = DA9063_REG_CHIP_VARIANT,
-	},
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_BB_REG_SECOND_D),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_19),
+	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
 };
 
 static const struct regmap_range da9063_bb_writeable_ranges[] = {
-	{
-		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_REG_PAGE_CON,
-	}, {
-		.range_min = DA9063_REG_FAULT_LOG,
-		.range_max = DA9063_REG_VSYS_MON,
-	}, {
-		.range_min = DA9063_REG_COUNT_S,
-		.range_max = DA9063_BB_REG_ALARM_Y,
-	}, {
-		.range_min = DA9063_REG_SEQ,
-		.range_max = DA9063_REG_ID_32_31,
-	}, {
-		.range_min = DA9063_REG_SEQ_A,
-		.range_max = DA9063_REG_AUTO3_LOW,
-	}, {
-		.range_min = DA9063_REG_CONFIG_I,
-		.range_max = DA9063_BB_REG_MON_REG_4,
-	}, {
-		.range_min = DA9063_BB_REG_GP_ID_0,
-		.range_max = DA9063_BB_REG_GP_ID_19,
-	},
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_PAGE_CON),
+	regmap_reg_range(DA9063_REG_FAULT_LOG, DA9063_REG_VSYS_MON),
+	regmap_reg_range(DA9063_REG_COUNT_S, DA9063_BB_REG_ALARM_Y),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_CONFIG_I, DA9063_BB_REG_MON_REG_4),
+	regmap_reg_range(DA9063_BB_REG_GP_ID_0, DA9063_BB_REG_GP_ID_19),
 };
 
 static const struct regmap_range da9063_bb_volatile_ranges[] = {
-	{
-		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_REG_EVENT_D,
-	}, {
-		.range_min = DA9063_REG_CONTROL_A,
-		.range_max = DA9063_REG_CONTROL_B,
-	}, {
-		.range_min = DA9063_REG_CONTROL_E,
-		.range_max = DA9063_REG_CONTROL_F,
-	}, {
-		.range_min = DA9063_REG_BCORE2_CONT,
-		.range_max = DA9063_REG_LDO11_CONT,
-	}, {
-		.range_min = DA9063_REG_DVC_1,
-		.range_max = DA9063_REG_ADC_MAN,
-	}, {
-		.range_min = DA9063_REG_ADC_RES_L,
-		.range_max = DA9063_BB_REG_SECOND_D,
-	}, {
-		.range_min = DA9063_REG_SEQ,
-		.range_max = DA9063_REG_SEQ,
-	}, {
-		.range_min = DA9063_REG_EN_32K,
-		.range_max = DA9063_REG_EN_32K,
-	}, {
-		.range_min = DA9063_BB_REG_MON_REG_5,
-		.range_max = DA9063_BB_REG_MON_REG_6,
-	},
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_EVENT_D),
+	regmap_reg_range(DA9063_REG_CONTROL_A, DA9063_REG_CONTROL_B),
+	regmap_reg_range(DA9063_REG_CONTROL_E, DA9063_REG_CONTROL_F),
+	regmap_reg_range(DA9063_REG_BCORE2_CONT, DA9063_REG_LDO11_CONT),
+	regmap_reg_range(DA9063_REG_DVC_1, DA9063_REG_ADC_MAN),
+	regmap_reg_range(DA9063_REG_ADC_RES_L, DA9063_BB_REG_SECOND_D),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_SEQ),
+	regmap_reg_range(DA9063_REG_EN_32K, DA9063_REG_EN_32K),
+	regmap_reg_range(DA9063_BB_REG_MON_REG_5, DA9063_BB_REG_MON_REG_6),
 };
 
 static const struct regmap_access_table da9063_bb_readable_table = {
-- 
2.16.2
