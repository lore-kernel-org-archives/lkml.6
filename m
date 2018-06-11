Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Y767ByBkHluxYgAAmS7hNA
	; Mon, 11 Jun 2018 11:59:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 00E1C607E7; Mon, 11 Jun 2018 11:59:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyh/Osag"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2BE5D60792;
	Mon, 11 Jun 2018 11:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BE5D60792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933438AbeFKL7Y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:59:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35467 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933341AbeFKL7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:59:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id j15-v6so16028840wme.0;
        Mon, 11 Jun 2018 04:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R/cfs1Vx01BzkQmh1dkDLW6kUx8xjmgO0gHCKfS+kpQ=;
        b=eyh/OsagoGRSF4dAsVUpBiyaD+zEEvYBtpmKyjvC1ma+sWOfAZTJXC65KHfYQVlSD+
         7e44iGwiL9nB3NL8zeTZt0zotnbNrHXdvDoST7kPb/fFsnrh4v3sVvKGH58M97C5NkJS
         DTgOLI9Xs23J79Y4Il4++u06aPsCfRVrY5Y8995wnbRZdoRWCRZpfWc3Y3vv9cgTkzMe
         BdAksYx70tTxtDmNiJo2BU+PtqWvqU26nKdCiwQ89TonbQlHLzDmpNe8+pTVrrNsRdEK
         L/lzmaGcnv9rXfu3AXKb+MRrq/bdrMxdRsR11nmmEl/WKHDkD/BzxZb/xJdqiNzEeVo5
         SI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R/cfs1Vx01BzkQmh1dkDLW6kUx8xjmgO0gHCKfS+kpQ=;
        b=it0Z1WolMPj1vlD0DMCuj9IKXnu9vF2SDx+I+d7hB+xZc7CUU2ukgf2WwAqfsOXfhn
         fYRjZElTJOvrixN/AE49v9Ahn8CUaANn3G0yQwPqDVJO9hcBIgL0ThYC+ZOrPggtiy+O
         16BHX1SEU9pPcDfVERsXejq3sIuaFj4f8SJap0s9BHUsdFM551HhIU7KkXwwxjs/p8me
         +RymGeClHmTwOjwel33BHt+4mME5E6cWCtwIVLjcBUd3pjrzAfqiH9OXqO1dTsDCXIpe
         CKj0sMmZ8qtl7tVerij8CyJ/T927KQhW/UuunNC9vhVn/RdS6tJcjnanauFUhbDdDkXW
         ErVQ==
X-Gm-Message-State: APt69E1vLeiarqSolqkJsS8j/qGXis1CqNwEpnlaSKfXb/Dg2ljRg/yi
        U1rGLGG3Oaa0KX5NmnO8ZoZRsEPm
X-Google-Smtp-Source: ADUXVKLmWVlmdSE7dP5iTqcbDHL3/UbUY/FShXlc9TgPW+M4xdZth/VXKp9G+F0dgBi8EhaaIED0yA==
X-Received: by 2002:a1c:800e:: with SMTP id b14-v6mr7750473wmd.83.1528718360283;
        Mon, 11 Jun 2018 04:59:20 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t124-v6sm7974796wmt.29.2018.06.11.04.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:59:19 -0700 (PDT)
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
Subject: [PATCH v6 13/14] regulator: da9063: Handle less LDOs on DA9063L
Date: Mon, 11 Jun 2018 13:58:50 +0200
Message-Id: <20180611115851.1987-13-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
References: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the LDOs present only on DA9063 at the end of the list, so that
the DA9063L can simply indicate less LDOs and still share the list of
regulators with DA9063.

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
V2: No change
V3: No change
V4: Change subject s/mfd/regulator/
V5: No change
V6: No change
---
 drivers/regulator/da9063-regulator.c | 76 +++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 02a036f310de..edc2a0ae0011 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -529,6 +529,32 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_A,
 				 DA9063_BMEM_ILIM_MASK),
 	},
+	{
+		DA9063_LDO(DA9063, LDO3, 900, 20, 3440),
+		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VLDO3_SEL),
+		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO3_LIM),
+	},
+	{
+		DA9063_LDO(DA9063, LDO7, 900, 50, 3600),
+		.suspend = BFIELD(DA9063_REG_LDO7_CONT, DA9063_VLDO7_SEL),
+		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO7_LIM),
+	},
+	{
+		DA9063_LDO(DA9063, LDO8, 900, 50, 3600),
+		.suspend = BFIELD(DA9063_REG_LDO8_CONT, DA9063_VLDO8_SEL),
+		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO8_LIM),
+	},
+	{
+		DA9063_LDO(DA9063, LDO9, 950, 50, 3600),
+		.suspend = BFIELD(DA9063_REG_LDO9_CONT, DA9063_VLDO9_SEL),
+	},
+	{
+		DA9063_LDO(DA9063, LDO11, 900, 50, 3600),
+		.suspend = BFIELD(DA9063_REG_LDO11_CONT, DA9063_VLDO11_SEL),
+		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO11_LIM),
+	},
+
+	/* The following LDOs are present only on DA9063, not on DA9063L */
 	{
 		DA9063_LDO(DA9063, LDO1, 600, 20, 1860),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VLDO1_SEL),
@@ -537,11 +563,6 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 		DA9063_LDO(DA9063, LDO2, 600, 20, 1860),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VLDO2_SEL),
 	},
-	{
-		DA9063_LDO(DA9063, LDO3, 900, 20, 3440),
-		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VLDO3_SEL),
-		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO3_LIM),
-	},
 	{
 		DA9063_LDO(DA9063, LDO4, 900, 20, 3440),
 		.suspend = BFIELD(DA9063_REG_DVC_2, DA9063_VLDO4_SEL),
@@ -555,29 +576,11 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 		DA9063_LDO(DA9063, LDO6, 900, 50, 3600),
 		.suspend = BFIELD(DA9063_REG_LDO6_CONT, DA9063_VLDO6_SEL),
 	},
-	{
-		DA9063_LDO(DA9063, LDO7, 900, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO7_CONT, DA9063_VLDO7_SEL),
-		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO7_LIM),
-	},
-	{
-		DA9063_LDO(DA9063, LDO8, 900, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO8_CONT, DA9063_VLDO8_SEL),
-		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO8_LIM),
-	},
-	{
-		DA9063_LDO(DA9063, LDO9, 950, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO9_CONT, DA9063_VLDO9_SEL),
-	},
+
 	{
 		DA9063_LDO(DA9063, LDO10, 900, 50, 3600),
 		.suspend = BFIELD(DA9063_REG_LDO10_CONT, DA9063_VLDO10_SEL),
 	},
-	{
-		DA9063_LDO(DA9063, LDO11, 900, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO11_CONT, DA9063_VLDO11_SEL),
-		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO11_LIM),
-	},
 };
 
 /* Link chip model with regulators info table */
@@ -587,6 +590,11 @@ static struct da9063_dev_model regulators_models[] = {
 		.n_regulators = ARRAY_SIZE(da9063_regulator_info),
 		.type = PMIC_TYPE_DA9063,
 	},
+	{
+		.regulator_info = da9063_regulator_info,
+		.n_regulators = ARRAY_SIZE(da9063_regulator_info) - 6,
+		.type = PMIC_TYPE_DA9063L,
+	},
 	{ }
 };
 
@@ -641,28 +649,34 @@ static struct of_regulator_match da9063_matches[] = {
 	[DA9063_ID_BPERI]            = { .name = "bperi",           },
 	[DA9063_ID_BCORES_MERGED]    = { .name = "bcores-merged"    },
 	[DA9063_ID_BMEM_BIO_MERGED]  = { .name = "bmem-bio-merged", },
+	[DA9063_ID_LDO3]             = { .name = "ldo3",            },
+	[DA9063_ID_LDO7]             = { .name = "ldo7",            },
+	[DA9063_ID_LDO8]             = { .name = "ldo8",            },
+	[DA9063_ID_LDO9]             = { .name = "ldo9",            },
+	[DA9063_ID_LDO11]            = { .name = "ldo11",           },
+	/* The following LDOs are present only on DA9063, not on DA9063L */
 	[DA9063_ID_LDO1]             = { .name = "ldo1",            },
 	[DA9063_ID_LDO2]             = { .name = "ldo2",            },
-	[DA9063_ID_LDO3]             = { .name = "ldo3",            },
 	[DA9063_ID_LDO4]             = { .name = "ldo4",            },
 	[DA9063_ID_LDO5]             = { .name = "ldo5",            },
 	[DA9063_ID_LDO6]             = { .name = "ldo6",            },
-	[DA9063_ID_LDO7]             = { .name = "ldo7",            },
-	[DA9063_ID_LDO8]             = { .name = "ldo8",            },
-	[DA9063_ID_LDO9]             = { .name = "ldo9",            },
 	[DA9063_ID_LDO10]            = { .name = "ldo10",           },
-	[DA9063_ID_LDO11]            = { .name = "ldo11",           },
 };
 
 static struct da9063_regulators_pdata *da9063_parse_regulators_dt(
 		struct platform_device *pdev,
 		struct of_regulator_match **da9063_reg_matches)
 {
+	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
 	struct da9063_regulators_pdata *pdata;
 	struct da9063_regulator_data *rdata;
 	struct device_node *node;
+	int da9063_matches_len = ARRAY_SIZE(da9063_matches);
 	int i, n, num;
 
+	if (da9063->type == PMIC_TYPE_DA9063L)
+		da9063_matches_len -= 6;
+
 	node = of_get_child_by_name(pdev->dev.parent->of_node, "regulators");
 	if (!node) {
 		dev_err(&pdev->dev, "Regulators device node not found\n");
@@ -670,7 +684,7 @@ static struct da9063_regulators_pdata *da9063_parse_regulators_dt(
 	}
 
 	num = of_regulator_match(&pdev->dev, node, da9063_matches,
-				 ARRAY_SIZE(da9063_matches));
+				 da9063_matches_len);
 	of_node_put(node);
 	if (num < 0) {
 		dev_err(&pdev->dev, "Failed to match regulators\n");
@@ -689,7 +703,7 @@ static struct da9063_regulators_pdata *da9063_parse_regulators_dt(
 	pdata->n_regulators = num;
 
 	n = 0;
-	for (i = 0; i < ARRAY_SIZE(da9063_matches); i++) {
+	for (i = 0; i < da9063_matches_len; i++) {
 		if (!da9063_matches[i].init_data)
 			continue;
 
-- 
2.16.2
