Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id H0hkGyZkHlu+YgAAmS7hNA
	; Mon, 11 Jun 2018 12:01:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9B328607BB; Mon, 11 Jun 2018 12:01:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS0rlWRN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E491260351;
	Mon, 11 Jun 2018 12:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E491260351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933015AbeFKMBL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:01:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52510 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933369AbeFKL7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:59:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so14212460wmb.2;
        Mon, 11 Jun 2018 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cN+60n4BKajOWmKOdya9NSESmrRg018NuSBryO1xDvg=;
        b=LS0rlWRNA33QIGhnHznqNSxYcr/9OElPh7ZTPjpXL96gITZCAWhH/bSTHfQQh8xnIw
         JwoSPJRhk+rsPMutPIHciwMLoJM8fwxzXoYf6ykmUUlAbgVy78/i70beF+MuinBUG+ik
         SQF/jHYoEkc51CpXO3+k2HjO9RUOZxt3vrMlPcYOAn7za5UWLcAXVdhjSb0qMUnltqSB
         D6Bt8LTosrYDtUMLxH0oWCxy99YlnhOo85yBfMWhxWDKoDmKWMgRLq1i7aq/4wsjTzcM
         zUIH1f+85CxchPrea+52ejf+FFtG2ZffLN/8k2hYXFIXC4lkCoPmrDy+SLxFX8ifahE7
         MjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cN+60n4BKajOWmKOdya9NSESmrRg018NuSBryO1xDvg=;
        b=mVuCzWDaF/sHWwXafmposV1V4BBen6kQ9JEN3jv/4FLVD/XUhghcCLLEhbN+DVx63k
         j/B6L+fNWoC3ODQph6dm9OeXB8s9vArH4MVvbT2iv+QsuIL/J2AE7S0yCdDD2endNp0G
         JbdpU4dv4CBOPIu/nSL/HcLvrxrz+2U7ba708E1us1S2SEgaA3Z2UWsDgrqRSeovSI65
         6MVD/KjwRn042Jv2IQTDd4AuHRPFUTegDyRCqXnDiOy/mUKR8PdnjBdJFd+FPMcqY0s3
         dsIx3tyUjbdtazzUo989adJkIjGTksCBvGv8m536PTk8FXKNmb1yL7Mlpr06FtGj+Ho3
         uKWw==
X-Gm-Message-State: APt69E37ypFbE47NtYtQQom+86BcsnA5191DtMplXddnVqAlH9dQHCGn
        0LwlT+5PqBzY3cofFLXoOruxXGkR
X-Google-Smtp-Source: ADUXVKIVK0EWKn3SGR8OeUZPCYvHI39oKiegpaJR6msnxUQC5ZJA1wIRQTIYcF1kCYuUniggJMN2bQ==
X-Received: by 2002:a1c:9e95:: with SMTP id h143-v6mr8371507wme.68.1528718353996;
        Mon, 11 Jun 2018 04:59:13 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t124-v6sm7974796wmt.29.2018.06.11.04.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:59:13 -0700 (PDT)
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
Subject: [PATCH v6 08/14] mfd: da9063: Replace model with type
Date: Mon, 11 Jun 2018 13:58:45 +0200
Message-Id: <20180611115851.1987-8-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
References: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The model number stored in the struct da9063 is the same for all
variants of the da9063 since it is the chip ID, which is always
the same. Replace that with a separate identifier instead, which
allows us to discern the DA9063 variants by setting the type
based on either DT match or otherwise.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V2: Drop useless cast of id->driver_data
V3: Fix kernel 0day error , s/dev_model/type/
V4: No change
V5: No change
V6: Zap one more missing da9063->model
---
 drivers/mfd/da9063-core.c            | 1 -
 drivers/mfd/da9063-i2c.c             | 5 +++--
 drivers/regulator/da9063-regulator.c | 8 ++++----
 include/linux/mfd/da9063/core.h      | 6 +++++-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index c54777cc2f12..ded59990f18c 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -215,7 +215,6 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 		return -ENODEV;
 	}
 
-	da9063->model = model;
 	da9063->variant_code = variant_code;
 
 	ret = da9063_irq_init(da9063);
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index d1fe88777e3f..6fe9c3464b41 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -146,7 +146,7 @@ static const struct of_device_id da9063_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, da9063_dt_ids);
 static int da9063_i2c_probe(struct i2c_client *i2c,
-	const struct i2c_device_id *id)
+			    const struct i2c_device_id *id)
 {
 	struct da9063 *da9063;
 	int ret;
@@ -158,6 +158,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, da9063);
 	da9063->dev = &i2c->dev;
 	da9063->chip_irq = i2c->irq;
+	da9063->type = id->driver_data;
 
 	if (da9063->variant_code == PMIC_DA9063_AD) {
 		da9063_regmap_config.rd_table = &da9063_ad_readable_table;
@@ -181,7 +182,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 }
 
 static const struct i2c_device_id da9063_i2c_id[] = {
-	{ "da9063", PMIC_CHIP_ID_DA9063 },
+	{ "da9063", PMIC_TYPE_DA9063 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 87c884ae0064..02a036f310de 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -98,7 +98,7 @@ struct da9063_regulator_info {
 struct da9063_dev_model {
 	const struct da9063_regulator_info	*regulator_info;
 	unsigned				n_regulators;
-	unsigned				dev_model;
+	enum da9063_type			type;
 };
 
 /* Single regulator settings */
@@ -585,7 +585,7 @@ static struct da9063_dev_model regulators_models[] = {
 	{
 		.regulator_info = da9063_regulator_info,
 		.n_regulators = ARRAY_SIZE(da9063_regulator_info),
-		.dev_model = PMIC_CHIP_ID_DA9063,
+		.type = PMIC_TYPE_DA9063,
 	},
 	{ }
 };
@@ -741,12 +741,12 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 
 	/* Find regulators set for particular device model */
 	for (model = regulators_models; model->regulator_info; model++) {
-		if (model->dev_model == da9063->model)
+		if (model->type == da9063->type)
 			break;
 	}
 	if (!model->regulator_info) {
 		dev_err(&pdev->dev, "Chip model not recognised (%u)\n",
-			da9063->model);
+			da9063->type);
 		return -ENODEV;
 	}
 
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index e015b065db7e..9e36097adc42 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -31,6 +31,10 @@
 
 #define PMIC_CHIP_ID_DA9063		0x61
 
+enum da9063_type {
+	PMIC_TYPE_DA9063 = 0,
+};
+
 enum da9063_variant_codes {
 	PMIC_DA9063_AD = 0x3,
 	PMIC_DA9063_BB = 0x5,
@@ -73,7 +77,7 @@ enum da9063_irqs {
 struct da9063 {
 	/* Device */
 	struct device	*dev;
-	unsigned short	model;
+	enum da9063_type type;
 	unsigned char	variant_code;
 	unsigned int	flags;
 
-- 
2.16.2
