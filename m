Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EhDTOUZkHlsGbQAAmS7hNA
	; Mon, 11 Jun 2018 12:00:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CED18607E4; Mon, 11 Jun 2018 12:00:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOzMVHX5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 43DE0601C3;
	Mon, 11 Jun 2018 12:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43DE0601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933195AbeFKMAC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:00:02 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34613 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933407AbeFKL7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:59:20 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so20114734wro.1;
        Mon, 11 Jun 2018 04:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ROqarQcUbRjTNGoRFFwVBtFCzqlS726GHAZNfRCPmCM=;
        b=HOzMVHX5XcuEyxmVmS0e6HkVjNCQrb9JxfWHDagJ8xAmpSQiGV0usxcDgRipbJJrg8
         57fmpUqdPfPN1L8mXZhb0Chz9AOLffaXH5BF+9I4zHCugoQyr3RAB1Ynf0BZiLVP5VwH
         om8Vu0EIvzGJnZmmxVrMe2JsCj4WEszHZBJNEzQp9w8+8T0yTRbzUOQ6uRWjA2h+46gm
         YuKWk8Bv9TYi1q9SJgAbwzD7Mw6NwJ/8ro+V7yxJ2KlPC5odHuf4rrDcYLxd/jNJ7BdA
         PKf865raBAXh4lW7f//F310DUv9bQ2+NvMFDzw0GVvG50Fbu6m1aYhCeij3hnjZjlXiL
         UFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ROqarQcUbRjTNGoRFFwVBtFCzqlS726GHAZNfRCPmCM=;
        b=SpCriG6zsqy5sqEy6BfXfjyZsqBW+Jpyd6t0sDhj1Eer0DZBfAcsXAPY9JVsXN3CrW
         GTZefw3IgJKOa7muNS9aP54cVEkdY/ZmK87lzWcHHrKY9Yez3cM5/lug0SW/AowQAyLh
         jgVcZr3iGBbKbjgTlkNikTNgjOyrRIHBgZB0VtUvmXqykKDlUFGR8KmP6HBRErIR/3Jt
         wQwXOWhVhDEEW81I9qYCUd3uaGfDeCWSM7l7sGduXjJQG+mLn6ShNiddwtXufetvbl7X
         g3aPkoeTcSKI+gDMkc6rX6g33L0JFhunHGFuidGMwVp9Qmd0BaSjPGYmrEN1layDmsSQ
         sbOA==
X-Gm-Message-State: APt69E0okCFxhDWTv29Y+Yjx4rz4NKViAwmX89JTq38usaO1KQgXvGed
        zsmm8bXKie2GkhWfCGS5ZekBJi2m
X-Google-Smtp-Source: ADUXVKI098rEsEGXYr5y8JdArir0vTWn+tf69kppL1d1PYO8rSIWiGFmZoNGttEuxmhnPbDQFYWO3g==
X-Received: by 2002:adf:98cf:: with SMTP id w73-v6mr13514341wrb.209.1528718359117;
        Mon, 11 Jun 2018 04:59:19 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t124-v6sm7974796wmt.29.2018.06.11.04.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:59:18 -0700 (PDT)
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
Subject: [PATCH v6 12/14] mfd: da9063: Register RTC only on DA9063L
Date: Mon, 11 Jun 2018 13:58:49 +0200
Message-Id: <20180611115851.1987-12-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
References: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DA9063L does not contain RTC block, unlike the full DA9063.
Split the RTC block into separate mfd cell and register it only
on DA9063.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V2: No change
V3: Rework of mfd: da9063: Disallow RTC on DA9063L
V4: - Change the original failure text
    - Use PLATFORM_DEVID_NONE in mfd_add_devices
V5: Rebase on top of new 01 and 02 patches
V6: No change
---
 drivers/mfd/da9063-core.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index ded59990f18c..6e4ce49b4405 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -76,7 +76,7 @@ static struct resource da9063_hwmon_resources[] = {
 };
 
 
-static const struct mfd_cell da9063_devs[] = {
+static const struct mfd_cell da9063_common_devs[] = {
 	{
 		.name		= DA9063_DRVNAME_REGULATORS,
 		.num_resources	= ARRAY_SIZE(da9063_regulators_resources),
@@ -100,15 +100,19 @@ static const struct mfd_cell da9063_devs[] = {
 		.resources	= da9063_onkey_resources,
 		.of_compatible = "dlg,da9063-onkey",
 	},
+	{
+		.name		= DA9063_DRVNAME_VIBRATION,
+	},
+};
+
+/* Only present on DA9063 , not on DA9063L */
+static const struct mfd_cell da9063_devs[] = {
 	{
 		.name		= DA9063_DRVNAME_RTC,
 		.num_resources	= ARRAY_SIZE(da9063_rtc_resources),
 		.resources	= da9063_rtc_resources,
 		.of_compatible	= "dlg,da9063-rtc",
 	},
-	{
-		.name		= DA9063_DRVNAME_VIBRATION,
-	},
 };
 
 static int da9063_clear_fault_log(struct da9063 *da9063)
@@ -226,10 +230,23 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 	da9063->irq_base = regmap_irq_chip_get_base(da9063->regmap_irq);
 
 	ret = devm_mfd_add_devices(da9063->dev, PLATFORM_DEVID_NONE,
-				   da9063_devs, ARRAY_SIZE(da9063_devs),
+				   da9063_common_devs,
+				   ARRAY_SIZE(da9063_common_devs),
 				   NULL, da9063->irq_base, NULL);
-	if (ret)
-		dev_err(da9063->dev, "Cannot add MFD cells\n");
+	if (ret) {
+		dev_err(da9063->dev, "Failed to add child devices\n");
+		return ret;
+	}
+
+	if (da9063->type == PMIC_TYPE_DA9063) {
+		ret = devm_mfd_add_devices(da9063->dev, PLATFORM_DEVID_NONE,
+					   da9063_devs, ARRAY_SIZE(da9063_devs),
+					   NULL, da9063->irq_base, NULL);
+		if (ret) {
+			dev_err(da9063->dev, "Failed to add child devices\n");
+			return ret;
+		}
+	}
 
 	return ret;
 }
-- 
2.16.2
