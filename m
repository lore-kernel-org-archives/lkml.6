Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2BFC004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49D5206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvOUnICT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49D5206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbeI2EPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:15:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44062 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeI2EPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:15:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so5134500pff.11;
        Fri, 28 Sep 2018 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=npQ3xWQWGGJNGPKbAJA6+96Rj377BwfjmaODrJXnkRw=;
        b=DvOUnICTFGnpyXAE4pcg5fSfEPIH5BgTqeFAy735fAU3oknltScFGGfieUD+cOVPLb
         en6k5mP8QKLz6z6cxDsLJhlkDurmmZu6ySdz1waJWY91fh7tr1pgsIiyAMHz3Y/xBWJ0
         hDmKleWYuOF0YeDmtQ54TFEsEHNS3akW1Et4H2Pra1nCVddys286bZHd9lBQXuK/0toJ
         NdvKo+4jQaOCV8sSmW7x0d3pPzHytREkRy+7VtcZTB4wOHbuKCQh4OyGBfs2q+hRo/+D
         WSk37CA14VwXswv9F7H6gTGRhpbs/30+ZxF9s60iX/qv4W5hgO/t/LC5wWS8M4i6m31R
         +ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=npQ3xWQWGGJNGPKbAJA6+96Rj377BwfjmaODrJXnkRw=;
        b=ONF9vBpY7gilRY5Rgo/LPxiTNLL6Ln6ZnZNJ07StPOsO5gBqQ12ShWsf+8Rg2FJMFv
         W44uNkgVrIG6SIuzrLaHwhOGeXYIE1XraTEca5NLUN7dqvDB78SvLik44nSzjAWvO7Ki
         HoQs/AesajHlIxHfs62GmN7qyxsyqWwxuOiovHDR2pUSIfQJtrmQrzoW0wCFIGgL5zzy
         Oyw/rsiyvZ+rDP3V506V74moL7ouT9bbW05Rcjrg/KWE7PUxAoVLLHHEuXcZjCDxg9w1
         6t3pYBMDli9pyFJlJ0hnOR/aJtVFqHVg/Yz7PoAyNETlIxiAk6r4017b4uXC6PspmC2H
         jrkQ==
X-Gm-Message-State: ABuFfohV8+/80gu6sZ3o2P9KfFuQ0a+n9ey/erSqm9udRlgGNUNsgbJi
        4eTGRrNg1Tb66ot8nDkjjaU=
X-Google-Smtp-Source: ACcGV63BHsG1aW5MB1SaSkbZvzbYXLK2HlzHV2B3tjJSbCuyogre9kB75HaJgPhICJZKg8becSU49w==
X-Received: by 2002:a63:5558:: with SMTP id f24-v6mr453664pgm.37.1538171382266;
        Fri, 28 Sep 2018 14:49:42 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r1-v6sm136842pgo.81.2018.09.28.14.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 14:49:41 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: ina3221: Add suspend and resume functions
Date:   Fri, 28 Sep 2018 14:49:21 -0700
Message-Id: <20180928214921.11528-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180928214921.11528-1-nicoleotsuka@gmail.com>
References: <20180928214921.11528-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the hardware design, an INA3221 chip might lose
its power during system suspend/resume. So this patch adds
a pair of suspend and resume functions to cache the register
values including config register value and limit settings.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina3221.c | 54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index cfe65ff01051..26f66f728b27 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -91,11 +91,13 @@ static const unsigned int register_channel[] = {
  * @regmap: Register map of the device
  * @fields: Register fields of the device
  * @shunt_resistors: Array of resistor values per channel
+ * @reg_config: Register value of INA3221_CONFIG
  */
 struct ina3221_data {
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
 	int shunt_resistors[INA3221_NUM_CHANNELS];
+	u32 reg_config;
 };
 
 static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
@@ -415,8 +417,59 @@ static int ina3221_probe(struct i2c_client *client,
 		return PTR_ERR(hwmon_dev);
 	}
 
+	dev_set_drvdata(dev, ina);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ina3221_suspend(struct device *dev)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	int ret;
+
+	/* Save config register value and enable cache-only */
+	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
+	if (ret)
+		return ret;
+
+	regcache_cache_only(ina->regmap, true);
+	regcache_mark_dirty(ina->regmap);
+
+	return 0;
+}
+
+static int ina3221_resume(struct device *dev)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	int ret;
+
+	regcache_cache_only(ina->regmap, false);
+
+	/* Software reset the chip */
+	ret = regmap_field_write(ina->fields[F_RST], true);
+	if (ret) {
+		dev_err(dev, "Unable to reset device\n");
+		return ret;
+	}
+
+	/* Restore cached register values to hardware */
+	ret = regcache_sync(ina->regmap);
+	if (ret)
+		return ret;
+
+	/* Restore config register value to hardware */
+	ret = regmap_write(ina->regmap, INA3221_CONFIG, ina->reg_config);
+	if (ret)
+		return ret;
+
 	return 0;
 }
+#endif
+
+static const struct dev_pm_ops ina3221_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(ina3221_suspend, ina3221_resume)
+};
 
 static const struct of_device_id ina3221_of_match_table[] = {
 	{ .compatible = "ti,ina3221", },
@@ -435,6 +488,7 @@ static struct i2c_driver ina3221_i2c_driver = {
 	.driver = {
 		.name = INA3221_DRIVER_NAME,
 		.of_match_table = ina3221_of_match_table,
+		.pm = &ina3221_pm,
 	},
 	.id_table = ina3221_ids,
 };
-- 
2.17.1

