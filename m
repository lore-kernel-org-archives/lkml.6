Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 75bqCmRkHlsGcAAAmS7hNA
	; Mon, 11 Jun 2018 12:01:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3A809607E4; Mon, 11 Jun 2018 12:01:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVUQFYPm"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9840760351;
	Mon, 11 Jun 2018 12:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9840760351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933072AbeFKMB2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:01:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46429 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933356AbeFKL7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:59:14 -0400
Received: by mail-wr0-f196.google.com with SMTP id v13-v6so20098616wrp.13;
        Mon, 11 Jun 2018 04:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xdLxjk0Q8O47kyIPh0dVVd/xYllcF+e5dBFDiji/Cmk=;
        b=GVUQFYPmQD3jvB/0oVamN8/djGlsHatemNoySupUZEH6j/ObCO3LH0cF6n9VCnPWGa
         7p4SK2dDrmQSqaspmBGp1vNx3Zb93VtscXOS3oDFdJTK9RCmZxASfXRvS0fx5rHb3hCX
         0fC443DjFmDjfjf+LBPW8oNZHmSUheR+7dnZpY95h1khxbT6Mf7no81VATyUe0lpXY1L
         uwoMbLVv8zrlndMMQ2B5sbPFqLKlsS0RCA77h5wFl3IGn/4gSgsjsWWHTRg98otE2BZQ
         ZR2r8nO1JMiZ28bBdAlJLp01zgtMYwnZC6UBddw0ISptBKz23FDVPeJ8hC4r547qxiC5
         LSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xdLxjk0Q8O47kyIPh0dVVd/xYllcF+e5dBFDiji/Cmk=;
        b=o1K5caaPnSvRYxVgTqAr60ABp4fmC3J/LFsshq87z3FEY6QQ6M10wVHqJnOlNrKKkY
         aFndFbd3720jJMSzq1ujQTnE0F8Z54WmyQKtWSjUkaFQjl73vVziSc+YHy7ulvPCZ/Ia
         AqqAnJJrke0kcRPpfrWT1r422LF+RjKTv7ZsucQpfqQwQYdDKgWDAUvcaQNe/FxkY9FI
         HtUBKCrJQqd2jeOvVpCRMbmjKK+Dqx830LQy7xxl3zx5ngj4NMMpqK474xZXED5L5RFV
         jxTV/HjZjQZJRsfFrv2Epxud0ctRYBYag+SoC/p3jNqq9CagXIfQln8e0G8AzYYbUHPv
         zcsw==
X-Gm-Message-State: APt69E2u8NT0zQqz6+fxTWoBGvGKVdBegx2qR9GdNJ96KqMy514UYOy7
        D0oKgWfrs9mh2fDyBkT7to5Toya+
X-Google-Smtp-Source: ADUXVKJi2y2B5gxkvKwZoF5hRFUhvuQGmt8Fps+GZIzLRqL6BWGGc3WQhsAa2JCr/X5yYx1/MV7F2A==
X-Received: by 2002:adf:8462:: with SMTP id 89-v6mr13948387wrf.138.1528718352720;
        Mon, 11 Jun 2018 04:59:12 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t124-v6sm7974796wmt.29.2018.06.11.04.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:59:11 -0700 (PDT)
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
Subject: [PATCH v6 07/14] mfd: da9063: Rename PMIC_DA9063 to PMIC_CHIP_ID_DA9063
Date: Mon, 11 Jun 2018 13:58:44 +0200
Message-Id: <20180611115851.1987-7-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
References: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC_DA9063 is a complete misnomer, it denotes the value of the
DA9063 chip ID register, so rename it as such. It is also the value
of chip ID register of DA9063L though, so drop the enum as all the
DA9063 "models" share the same chip ID and thus the distinction will
have to be made using DT or otherwise.

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
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
V2: No change
V3: No change
V4: No change
V5: No change
V6: No change
---
 drivers/mfd/da9063-core.c            | 2 +-
 drivers/mfd/da9063-i2c.c             | 2 +-
 drivers/regulator/da9063-regulator.c | 2 +-
 include/linux/mfd/da9063/core.h      | 4 +---
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index f57558590283..c54777cc2f12 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -192,7 +192,7 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 		dev_err(da9063->dev, "Cannot read chip model id.\n");
 		return -EIO;
 	}
-	if (model != PMIC_DA9063) {
+	if (model != PMIC_CHIP_ID_DA9063) {
 		dev_err(da9063->dev, "Invalid chip model id: 0x%02x\n", model);
 		return -ENODEV;
 	}
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index e9797153bc19..d1fe88777e3f 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -181,7 +181,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 }
 
 static const struct i2c_device_id da9063_i2c_id[] = {
-	{"da9063", PMIC_DA9063},
+	{ "da9063", PMIC_CHIP_ID_DA9063 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 6a8f9cd69f52..87c884ae0064 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -585,7 +585,7 @@ static struct da9063_dev_model regulators_models[] = {
 	{
 		.regulator_info = da9063_regulator_info,
 		.n_regulators = ARRAY_SIZE(da9063_regulator_info),
-		.dev_model = PMIC_DA9063,
+		.dev_model = PMIC_CHIP_ID_DA9063,
 	},
 	{ }
 };
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index 260cd5834861..e015b065db7e 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -29,9 +29,7 @@
 #define DA9063_DRVNAME_RTC		"da9063-rtc"
 #define DA9063_DRVNAME_VIBRATION	"da9063-vibration"
 
-enum da9063_models {
-	PMIC_DA9063 = 0x61,
-};
+#define PMIC_CHIP_ID_DA9063		0x61
 
 enum da9063_variant_codes {
 	PMIC_DA9063_AD = 0x3,
-- 
2.16.2
