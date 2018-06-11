Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7Js1Ox1kHluUYgAAmS7hNA
	; Mon, 11 Jun 2018 11:59:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D88EB607E4; Mon, 11 Jun 2018 11:59:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXD/Iyy0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 33C5960351;
	Mon, 11 Jun 2018 11:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33C5960351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933425AbeFKL7W (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:59:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53571 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933093AbeFKL7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:59:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id x6-v6so14146527wmc.3;
        Mon, 11 Jun 2018 04:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nW4Y3Hmy+etDpn8UpYab7hHeguWXF8Ildaizkt5vMig=;
        b=jXD/Iyy03fsgQRBWRWkumqAwX5T6n6zd2JLlFSb2c/dr4SyPKWitCaiJaaRooVM8RA
         qUNsEZah6kMSuDluJRUxzb2WlFRs5h75HkicXBQe5aHO8L6ETTUsTGzdLDvs8g51wWxQ
         Q8tswYFLIu6d19TVpt6OVZ8qPadBXCy7S6hXv9cO2e2rktvHK9Xl+/mcxtJGsRMdqDVm
         yls+pfuh0XV5K9BDGHNfvUbYX5GBLCJb1EF/k5l/mVG/XSkQw60j8l2QWsYSxxxmJira
         FqJpV+i1Y30azfwwASLgQNDClg8riA0mMSFYyHBcniDLwH7qimyo0Y9D3cjYRNnGH4L2
         QlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nW4Y3Hmy+etDpn8UpYab7hHeguWXF8Ildaizkt5vMig=;
        b=oWpkib26BbAUwAfp55cqAbaQSl5llYMqAzQi8jkhgD/R56cW9W2CyLR4YPCuec/xRI
         PjpptPXZNt3IT/zRiu4beNaP/NJ5bK/DGhYuEgtalhsYeTUhUzoBJI4/DY8tnbzzSmH8
         3031nMl6/VqfuqepCD/T2V4pVpo58KbAVTa5A9pfyorWErs0mQCmeGOX3C1dNB9/T2Yd
         OiTR+S04761K70/ZLT7TzxYg1gI/gcLxGxMm3I3DNbwehoP7ZBsmsS9lv50stYHM62kX
         ra5u+MBea/jyxkJvew9db7ETM1yP64tA92XwQCBTTwuEAGvcXNoVJKeTf+1Crvu6S6qG
         Nglw==
X-Gm-Message-State: APt69E1UaYix2wGY/hVOun/0z9UxqvioJiKYW6QXHbDiSWYtHymubiYN
        q2uKm+pi0HI+nEF9H6X39ZFMAQAb
X-Google-Smtp-Source: ADUXVKL4v2cEI99gDRGudZ/MnhQyWGsJPYHZ9/UC9drmIG09W/WEOHvJQaBoqZQmaf0RuzfDHBd8Xw==
X-Received: by 2002:a1c:e306:: with SMTP id a6-v6mr7369420wmh.15.1528718356633;
        Mon, 11 Jun 2018 04:59:16 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t124-v6sm7974796wmt.29.2018.06.11.04.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:59:15 -0700 (PDT)
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
Subject: [PATCH v6 10/14] mfd: da9063: Add custom regmap for DA9063L
Date: Mon, 11 Jun 2018 13:58:47 +0200
Message-Id: <20180611115851.1987-10-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
References: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DA9063L does not have an RTC. Add custom regmap for DA9063L to
prevent access into that register block.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V3: New patch
V4: Drop mention of buggy datasheet in the commit message
V5: Use regmap_reg_range macro
V6: No change
---
 drivers/mfd/da9063-i2c.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 6fe9c3464b41..a449a9263dd7 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -118,6 +118,50 @@ static const struct regmap_access_table da9063_bb_volatile_table = {
 	.n_yes_ranges = ARRAY_SIZE(da9063_bb_volatile_ranges),
 };
 
+static const struct regmap_range da9063l_bb_readable_ranges[] = {
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_MON_A10_RES),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_19),
+	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
+};
+
+static const struct regmap_range da9063l_bb_writeable_ranges[] = {
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_PAGE_CON),
+	regmap_reg_range(DA9063_REG_FAULT_LOG, DA9063_REG_VSYS_MON),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_CONFIG_I, DA9063_BB_REG_MON_REG_4),
+	regmap_reg_range(DA9063_BB_REG_GP_ID_0, DA9063_BB_REG_GP_ID_19),
+};
+
+static const struct regmap_range da9063l_bb_volatile_ranges[] = {
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_EVENT_D),
+	regmap_reg_range(DA9063_REG_CONTROL_A, DA9063_REG_CONTROL_B),
+	regmap_reg_range(DA9063_REG_CONTROL_E, DA9063_REG_CONTROL_F),
+	regmap_reg_range(DA9063_REG_BCORE2_CONT, DA9063_REG_LDO11_CONT),
+	regmap_reg_range(DA9063_REG_DVC_1, DA9063_REG_ADC_MAN),
+	regmap_reg_range(DA9063_REG_ADC_RES_L, DA9063_REG_MON_A10_RES),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_SEQ),
+	regmap_reg_range(DA9063_REG_EN_32K, DA9063_REG_EN_32K),
+	regmap_reg_range(DA9063_BB_REG_MON_REG_5, DA9063_BB_REG_MON_REG_6),
+};
+
+static const struct regmap_access_table da9063l_bb_readable_table = {
+	.yes_ranges = da9063l_bb_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063l_bb_readable_ranges),
+};
+
+static const struct regmap_access_table da9063l_bb_writeable_table = {
+	.yes_ranges = da9063l_bb_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063l_bb_writeable_ranges),
+};
+
+static const struct regmap_access_table da9063l_bb_volatile_table = {
+	.yes_ranges = da9063l_bb_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063l_bb_volatile_ranges),
+};
+
 static const struct regmap_range_cfg da9063_range_cfg[] = {
 	{
 		.range_min = DA9063_REG_PAGE_CON,
@@ -164,6 +208,10 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 		da9063_regmap_config.rd_table = &da9063_ad_readable_table;
 		da9063_regmap_config.wr_table = &da9063_ad_writeable_table;
 		da9063_regmap_config.volatile_table = &da9063_ad_volatile_table;
+	} else if (da9063->type == PMIC_TYPE_DA9063L) {
+		da9063_regmap_config.rd_table = &da9063l_bb_readable_table;
+		da9063_regmap_config.wr_table = &da9063l_bb_writeable_table;
+		da9063_regmap_config.volatile_table = &da9063l_bb_volatile_table;
 	} else {
 		da9063_regmap_config.rd_table = &da9063_bb_readable_table;
 		da9063_regmap_config.wr_table = &da9063_bb_writeable_table;
-- 
2.16.2
