Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA549C282C7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6BD218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCSaI/fO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfAYRvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:51:00 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39815 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbfAYRu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:50:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so9069995ljh.6;
        Fri, 25 Jan 2019 09:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sR7vptffNLJhjIvvskAjl+NHWhoMeph6+VUdWpkkqW4=;
        b=cCSaI/fOBgL5ExarI/S0UAKgNuCZcxXU7Ur/+tS4AXBHRSJvfp/iLRkc+wdjcX1ruD
         oW6Q7krkWyToDQioVWoBid5J3MD1UhIOR9u+GrXR1lAS1uzBeGTvaEw0N3G/EkLx1M8K
         me9aBqrtuWRtTgwWwnzzP82pRVTbdi7dBjfh3fHVz3pBTjMhpQ567axkmYccQCUrWRGE
         VjAL1MU1PAO8AFvUz7ifRi6G9p+RZUECeHIQ1QzZhk1spH7R8B9gFVF/l5n9qWq9ChQf
         PBoNSkG3xlk1Ok0zxAybylDUoSbNyHTW+VBzhgSM1zSly9KLzYLXZheZMuuNv2Q7R8dv
         7V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sR7vptffNLJhjIvvskAjl+NHWhoMeph6+VUdWpkkqW4=;
        b=TG1HayL/eQH8pE6wJftuG9Qxil+PhhP04X/jdTKnLXj7fszSudkizHz5ixPSSE14ew
         vBOIyf3+w42UvS1ZM7Sccj3fOtZqRp9UxHuuRztd7jxTfy1jpZVa38imjketpU2fWI2H
         xvVSnzBxdXkZDyoDK/HVp+BXaPMrE7Nljjwd0/L90lrk83NFBTO1EGJTCkct+STjtbDY
         grtN1dFmlJ5jKOwvN0A1Q/ls7YDLZRL6qkdupQuQnoGUxuOT4JbG3aMLs85hWhvfjJRW
         RXGbM2O77L4bWhbfNqG7Hmfy1FJpLDWOeHBm60GLxuSrxznavbjIBho/QNaTzfHjcV9J
         Ps7w==
X-Gm-Message-State: AJcUukcuNQsUCV1FZL2hPzoIZxi6XD6zoW4RzJ3mQtM+6YbayyjQ8uL1
        qttWVWQLEh60auxLFPOr+nc=
X-Google-Smtp-Source: ALg8bN6TrjB4C4tB+FKsiRIGTG13D6kj9UV/xv0cvzF/wIaljotm4+/VaoApUnsJtVuuN1W9TB6g0g==
X-Received: by 2002:a2e:197:: with SMTP id f23-v6mr9922603lji.144.1548438653913;
        Fri, 25 Jan 2019 09:50:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6921:1f1d:2918:d853])
        by smtp.googlemail.com with ESMTPSA id l21-v6sm1575606ljj.48.2019.01.25.09.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 09:50:53 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, colyli@suse.de,
        ckeepax@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com,
        arnd@arndb.de, xiaotong.lu@spreadtrum.com, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/4] input: misc: gp2a: Enable device tree
Date:   Fri, 25 Jan 2019 18:50:44 +0100
Message-Id: <20190125175045.22576-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Enable probing of gp2a via device tree via a simple of_match table

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/gp2ap002a00f.c | 46 +++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index 090c8c313295..01a7d44ae921 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -21,6 +21,8 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/input/gp2ap002a00f.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 
 struct gp2a_data {
 	struct iio_channel *channel;
@@ -140,6 +142,35 @@ static int gp2a_initialize(struct gp2a_data *dt)
 	return error;
 }
 
+static struct gp2a_platform_data *gp2a_parse_dt_pdata(struct device *dev)
+{
+	struct gp2a_platform_data *pdata;
+	int ret;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->wakeup = of_property_read_bool(dev->of_node, "wakeup");
+
+	pdata->vout_gpio = of_get_named_gpio(dev->of_node, "vout-gpio", 0);
+	if (pdata->vout_gpio < 0) {
+		dev_err(dev, "failed to find vout-gpio");
+		return ERR_PTR(-EINVAL);
+	}
+
+	ret = device_property_read_u32(dev, "light-adc-max",
+				       &pdata->light_adc_max);
+	if (ret)
+		pdata->light_adc_max = 4096;
+	ret = device_property_read_u32(dev, "light-adc-fuzz",
+				       &pdata->light_adc_fuzz);
+	if (ret)
+		pdata->light_adc_fuzz = 80;
+
+	return pdata;
+}
+
 static int gp2a_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
@@ -147,6 +178,12 @@ static int gp2a_probe(struct i2c_client *client,
 	struct gp2a_data *dt;
 	int error, value;
 
+	if (IS_ENABLED(CONFIG_OF) && client->dev.of_node) {
+		pdata = gp2a_parse_dt_pdata(&client->dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
+
 	if (!pdata)
 		return -EINVAL;
 
@@ -317,6 +354,14 @@ static int __maybe_unused gp2a_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(gp2a_pm, gp2a_suspend, gp2a_resume);
 
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id gp2a_of_match[] = {
+	{ .compatible = "sharp,gp2ap002a00f" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, gp2a_of_match);
+#endif
+
 static const struct i2c_device_id gp2a_i2c_id[] = {
 	{ GP2A_I2C_NAME, 0 },
 	{ }
@@ -326,6 +371,7 @@ MODULE_DEVICE_TABLE(i2c, gp2a_i2c_id);
 static struct i2c_driver gp2a_i2c_driver = {
 	.driver = {
 		.name	= GP2A_I2C_NAME,
+		.of_match_table = of_match_ptr(gp2a_of_match),
 		.pm	= &gp2a_pm,
 	},
 	.probe		= gp2a_probe,
-- 
2.17.1

