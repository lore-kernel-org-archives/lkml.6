Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78FAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8218022360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MgP2KIyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8218022360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbeKNTKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:10:23 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35575 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbeKNTKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:10:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so7081429pgu.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 01:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IRUXU/GFwnJl002dQVlSIACjSnNwZF6k9T9koevdIfU=;
        b=MgP2KIyE/Z5xkWXYph0HjfOigzpkQYVms1EkRMG4ehWPeNBeBF56HsZYWpv/crCUwL
         vj9Nr1LnZKKUpmBLIYImVHwp0VweT4krV8Jaj8tvmvEcR9zAZ/ZbNHiS4fAZdf90X8tG
         D1MLf6kMvinSd5hIqHSHPvxJDQ0e4s6RFrWB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IRUXU/GFwnJl002dQVlSIACjSnNwZF6k9T9koevdIfU=;
        b=XsQUZhMCedu3AkQX5ETOR7mbTV7yX3V2y4YOYeHmfOC7VaxkuNIK1eEDnSHYij2m4B
         jZVl/GvL/IrkGBNVdp7A57h14CvgVOxHTNuqc3M6VgYbf7Kion3WrejYFR83VBltO2cV
         XVmQP3hhBdnQlVArrsVZNZlyttNiLObOgz8t4PEIlTKCSBU9K2mIxRuibuzffCEiKYht
         eyv4ZCWfm2mtL6RIHGt4c7pY3XKJh3QlGVpNbMcZRpSjtXjv9DovNFfYTLmcWaZuKpk0
         5sGY0OntN0UyXCeucqofG4APDCEg31yFN5vXwJD5+fbqcyagENP8C7Ezx+nnrn5WvCMK
         J/WQ==
X-Gm-Message-State: AGRZ1gIFV4sOJfUv+cCojKe35G+2exi0G5DXE4YPd+mzS9blvd78YeWa
        E7dJPL4OH+AXXSL2px6owTllKw==
X-Google-Smtp-Source: AJdET5fS2/rM84cBs7+I7ETXCiaqASRxD6WHfhPOnYcdusmmF006ASXy38lhUKPXrr84G6tp7uYrpQ==
X-Received: by 2002:a63:f710:: with SMTP id x16mr1005124pgh.322.1542186480492;
        Wed, 14 Nov 2018 01:08:00 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 127-v6sm25048814pfx.91.2018.11.14.01.07.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 01:07:59 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org
Subject: [PATCH 5/5] power: supply: sc27xx: Save last battery capacity
Date:   Wed, 14 Nov 2018 17:07:08 +0800
Message-Id: <db2aa7892d7ecfae563ef22de5bbc7587ea3471f.1542185618.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
References: <cover.1542185618.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
References: <cover.1542185618.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

Our charger manager can optimize the battery capacity periodically, so
we can save last battery capacity into registers. Then next system
power-on, we can read the last saved battery capacity as the initial
battery capacity, which can make the battery capacity more accurate.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |  143 +++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 8c52e29..181a8f7 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -39,6 +39,9 @@
 #define SC27XX_FGU_CLBCNT_VALH		0x68
 #define SC27XX_FGU_CLBCNT_VALL		0x6c
 #define SC27XX_FGU_CLBCNT_QMAXL		0x74
+#define SC27XX_FGU_USER_AREA_SET	0xa0
+#define SC27XX_FGU_USER_AREA_CLEAR	0xa4
+#define SC27XX_FGU_USER_AREA_STATUS	0xa8
 
 #define SC27XX_WRITE_SELCLB_EN		BIT(0)
 #define SC27XX_FGU_CLBCNT_MASK		GENMASK(15, 0)
@@ -49,6 +52,14 @@
 #define SC27XX_FGU_LOW_OVERLOAD_INT	BIT(0)
 #define SC27XX_FGU_CLBCNT_DELTA_INT	BIT(2)
 
+#define SC27XX_FGU_MODE_AREA_MASK	GENMASK(15, 12)
+#define SC27XX_FGU_CAP_AREA_MASK	GENMASK(11, 0)
+#define SC27XX_FGU_MODE_AREA_SHIFT	12
+
+#define SC27XX_FGU_FIRST_POWERTON	GENMASK(3, 0)
+#define SC27XX_FGU_DEFAULT_CAP		GENMASK(11, 0)
+#define SC27XX_FGU_NORMAIL_POWERTON	0x5
+
 #define SC27XX_FGU_CUR_BASIC_ADC	8192
 #define SC27XX_FGU_SAMPLE_HZ		2
 
@@ -119,6 +130,80 @@ static int sc27xx_fgu_voltage_to_adc(struct sc27xx_fgu_data *data, int vol)
 	return DIV_ROUND_CLOSEST(vol * data->vol_1000mv_adc, 1000);
 }
 
+static bool sc27xx_fgu_is_first_poweron(struct sc27xx_fgu_data *data)
+{
+	int ret, status, cap, mode;
+
+	ret = regmap_read(data->regmap,
+			  data->base + SC27XX_FGU_USER_AREA_STATUS, &status);
+	if (ret)
+		return false;
+
+	/*
+	 * We use low 4 bits to save the last battery capacity and high 12 bits
+	 * to save the system boot mode.
+	 */
+	mode = (status & SC27XX_FGU_MODE_AREA_MASK) >> SC27XX_FGU_MODE_AREA_SHIFT;
+	cap = status & SC27XX_FGU_CAP_AREA_MASK;
+
+	/*
+	 * When FGU has been powered down, the user area registers became
+	 * default value (0xffff), which can be used to valid if the system is
+	 * first power on or not.
+	 */
+	if (mode == SC27XX_FGU_FIRST_POWERTON || cap == SC27XX_FGU_DEFAULT_CAP)
+		return true;
+
+	return false;
+}
+
+static int sc27xx_fgu_save_boot_mode(struct sc27xx_fgu_data *data,
+				     int boot_mode)
+{
+	int ret;
+
+	ret = regmap_update_bits(data->regmap,
+				 data->base + SC27XX_FGU_USER_AREA_CLEAR,
+				 SC27XX_FGU_MODE_AREA_MASK,
+				 SC27XX_FGU_MODE_AREA_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap,
+				  data->base + SC27XX_FGU_USER_AREA_SET,
+				  SC27XX_FGU_MODE_AREA_MASK,
+				  boot_mode << SC27XX_FGU_MODE_AREA_SHIFT);
+}
+
+static int sc27xx_fgu_save_last_cap(struct sc27xx_fgu_data *data, int cap)
+{
+	int ret;
+
+	ret = regmap_update_bits(data->regmap,
+				 data->base + SC27XX_FGU_USER_AREA_CLEAR,
+				 SC27XX_FGU_CAP_AREA_MASK,
+				 SC27XX_FGU_CAP_AREA_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap,
+				  data->base + SC27XX_FGU_USER_AREA_SET,
+				  SC27XX_FGU_CAP_AREA_MASK, cap);
+}
+
+static int sc27xx_fgu_read_last_cap(struct sc27xx_fgu_data *data, int *cap)
+{
+	int ret, value;
+
+	ret = regmap_read(data->regmap,
+			  data->base + SC27XX_FGU_USER_AREA_STATUS, &value);
+	if (ret)
+		return ret;
+
+	*cap = value & SC27XX_FGU_CAP_AREA_MASK;
+	return 0;
+}
+
 /*
  * When system boots on, we can not read battery capacity from coulomb
  * registers, since now the coulomb registers are invalid. So we should
@@ -128,6 +213,20 @@ static int sc27xx_fgu_voltage_to_adc(struct sc27xx_fgu_data *data, int vol)
 static int sc27xx_fgu_get_boot_capacity(struct sc27xx_fgu_data *data, int *cap)
 {
 	int volt, cur, oci, ocv, ret;
+	bool is_first_poweron = sc27xx_fgu_is_first_poweron(data);
+
+	/*
+	 * If system is not the first power on, we should use the last saved
+	 * battery capacity as the initial battery capacity. Otherwise we should
+	 * re-calculate the initial battery capacity.
+	 */
+	if (!is_first_poweron) {
+		ret = sc27xx_fgu_read_last_cap(data, cap);
+		if (ret)
+			return ret;
+
+		return sc27xx_fgu_save_boot_mode(data, SC27XX_FGU_NORMAIL_POWERTON);
+	}
 
 	/*
 	 * After system booting on, the SC27XX_FGU_CLBCNT_QMAXL register saved
@@ -160,7 +259,11 @@ static int sc27xx_fgu_get_boot_capacity(struct sc27xx_fgu_data *data, int *cap)
 	*cap = power_supply_ocv2cap_simple(data->cap_table, data->table_len,
 					   ocv);
 
-	return 0;
+	ret = sc27xx_fgu_save_last_cap(data, *cap);
+	if (ret)
+		return ret;
+
+	return sc27xx_fgu_save_boot_mode(data, SC27XX_FGU_NORMAIL_POWERTON);
 }
 
 static int sc27xx_fgu_set_clbcnt(struct sc27xx_fgu_data *data, int clbcnt)
@@ -418,6 +521,30 @@ static int sc27xx_fgu_get_property(struct power_supply *psy,
 	return ret;
 }
 
+static int sc27xx_fgu_set_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   const union power_supply_propval *val)
+{
+	struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = sc27xx_fgu_save_last_cap(data, val->intval);
+		if (ret < 0)
+			dev_err(data->dev, "failed to save battery capacity\n");
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
 static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
 {
 	struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
@@ -425,6 +552,18 @@ static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
 	power_supply_changed(data->battery);
 }
 
+static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
+					    enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CAPACITY:
+		return 1;
+
+	default:
+		return 0;
+	}
+}
+
 static enum power_supply_property sc27xx_fgu_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_HEALTH,
@@ -444,7 +583,9 @@ static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
 	.properties		= sc27xx_fgu_props,
 	.num_properties		= ARRAY_SIZE(sc27xx_fgu_props),
 	.get_property		= sc27xx_fgu_get_property,
+	.set_property		= sc27xx_fgu_set_property,
 	.external_power_changed	= sc27xx_fgu_external_power_changed,
+	.property_is_writeable	= sc27xx_fgu_property_is_writeable,
 };
 
 static void sc27xx_fgu_adjust_cap(struct sc27xx_fgu_data *data, int cap)
-- 
1.7.9.5

