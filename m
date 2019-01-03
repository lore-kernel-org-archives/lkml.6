Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73962C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7A521479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfACNs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:48:28 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:59862 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728233AbfACNs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:48:27 -0500
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-central-1.aws.symcld.net id F1/30-19014-7A21E2C5; Thu, 03 Jan 2019 13:48:23 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRWlGSWpSXmKPExsVy8+3OTbrLhfR
  iDN49ZLaY+vAJm8X8I+dYLU5tb2KyuP/1KKPFtysdTBaXd81hs5i9pJ/FYun1i0wWrXuPsFvs
  v+LlwOWxZt4aRo9vXyexeOycdZfdY9OqTjaPO9f2sHkcv7GdyePzJrkA9ijWzLyk/IoE1oyV+
  96zF/TLVlzeOIO1gXGqZBcjF4eQwCpGiSsHrrBCOE+AnL132boYOYGclYwS599lgNhsAlYSu9
  csZgGxRQSUJR4sbQBrYBbYyiRx4+9FsAZhASeJSbNOghWxCKhILDi4mRHE5hXwlvi3ZB4riC0
  hICdx81wnM4jNKeArcXT6QWaIZT4S92dMZoOoF5Q4OfMJ2BxmAQmJgy9eQNVoSVz9d5AdYo6C
  xM4fx4DiHEB2nMTl/myIsKbE8x1PGSFse4np768yQ9iGEt9nfWOBsM0l7hzugqqxkTj0t5UNw
  jaVWDH3MjOMfbx9FvMERolZSC6aheSiBYxMqxgtk4oy0zNKchMzc3QNDQx0DQ2Ndc11jYyN9R
  KrdJP0Ukt1k1PzSooSgbJ6ieXFesWVuck5KXp5qSWbGIHRn1LI/nIH46+F6YcYJTmYlER5TW7
  oxgjxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4A0W1IsREixKTU+tSMvMAaYhmLQEB4+SCO9pAaA0
  b3FBYm5xZjpE6hSjopQ4rw5InwBIIqM0D64NlvouMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgV
  BLmrQCZwpOZVwI3/RXQYiagxSYSOiCLSxIRUlINjOyxMby3+9w7689Ha6XGlnw9IdITOtv+uj
  jnZJVZE188Waa1UaxHtfHMWe4JU3xuBNV/cdNbfDWsc9Evrm3zfiwsfz57CndjahDDF1H5+fs
  yFZfpb+5OlxdqFRSznyL2k1/v2ynxl6veSVtWqT5rnet/NU3u3Q+Dj9N2Z3If6dzNHMRx9GXo
  GiWW4oxEQy3mouJEAN/Glhp4AwAA
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-33.tower-246.messagelabs.com!1546523295!3405224!15
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20905 invoked from network); 3 Jan 2019 13:48:23 -0000
Received: from unknown (HELO SVEX01006.wago.local) (217.237.185.178)
  by server-33.tower-246.messagelabs.com with AES128-SHA encrypted SMTP; 3 Jan 2019 13:48:23 -0000
Received: from SVEX01012.wago.local (10.1.103.230) by SVEX01006.wago.local
 (10.1.101.122) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 3 Jan
 2019 14:47:48 +0100
Received: from lc010965.wago.local (10.1.101.139) by SVEX01012.wago.local
 (10.1.103.230) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Thu, 3 Jan 2019
 14:47:48 +0100
Received: from LC010965.wago.local (lc010965.wago.local [127.0.0.1])    by
 lc010965.wago.local (Postfix) with ESMTP id DDD0A17029D0;      Thu,  3 Jan 2019
 14:47:47 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     "J, KEERTHY" <j-keerthy@ti.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v2 2/2] mfd: tps65218.c: Add input voltage options
Date:   Thu, 3 Jan 2019 14:47:06 +0100
Message-ID: <1546523226-358-3-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.139]
X-ClientProxiedBy: SVEX01012.wago.local (10.1.103.230) To SVEX01012.wago.local
 (10.1.103.230)
X-KSE-ServerInfo: SVEX01012.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 03.01.2019 11:05:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: deb34f4f-1670-42da-9b53-f8c7bceb0e0a
X-PP-Proceessed: 76874689-fff8-43e0-8f1a-01f8fc6dac97
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These options apply to all regulators in this chip.

ti,strict-supply-voltage-supervision:
  Set STRICT flag in CONFIG1
ti,under-voltage-limit-microvolt:
  Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
ti,under-voltage-hyst-microvolt:
  Select 200mV or 400mV UVLOHYS in CONFIG2

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 drivers/mfd/tps65218.c       | 87 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/tps65218.h |  4 ++
 2 files changed, 91 insertions(+)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 8bcdecf..b5e0f3a 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -211,6 +211,81 @@ static const struct of_device_id of_tps65218_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, of_tps65218_match_table);
 
+static int tps65218_voltage_set_strict(struct tps65218 *tps)
+{
+	u32 strict;
+
+	if (of_property_read_u32(tps->dev->of_node,
+			"ti,strict-supply-voltage-supervision", &strict))
+		return 0;
+
+	if (strict != 0 && strict != 1) {
+		dev_err(tps->dev,
+			"Invalid ti,strict-supply-voltage-supervision value\n");
+		return -EINVAL;
+	}
+
+	tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
+		TPS65218_CONFIG1_STRICT,
+		strict ? TPS65218_CONFIG1_STRICT : 0, TPS65218_PROTECT_L1);
+	return 0;
+}
+
+static int tps65218_voltage_set_uv_hyst(struct tps65218 *tps)
+{
+	u32 hyst;
+
+	if (of_property_read_u32(tps->dev->of_node,
+			"ti,under-voltage-hyst-microvolt", &hyst))
+		return 0;
+
+	if (hyst != 400000 && hyst != 200000) {
+		dev_err(tps->dev,
+			"Invalid ti,under-voltage-hyst-microvolt value\n");
+		return -EINVAL;
+	}
+
+	tps65218_update_bits(tps, TPS65218_REG_CONFIG2,
+		TPS65218_CONFIG2_UVLOHYS,
+		hyst == 400000 ? TPS65218_CONFIG2_UVLOHYS : 0,
+		TPS65218_PROTECT_L1);
+	return 0;
+}
+
+static int tps65218_voltage_set_uvlo(struct tps65218 *tps)
+{
+	u32 uvlo;
+	int uvloval;
+
+	if (of_property_read_u32(tps->dev->of_node,
+			 "ti,under-voltage-limit-microvolt", &uvlo))
+		return 0;
+
+	switch (uvlo) {
+	case 2750000:
+		uvloval = TPS65218_CONFIG1_UVLO_2750000;
+		break;
+	case 2950000:
+		uvloval = TPS65218_CONFIG1_UVLO_2950000;
+		break;
+	case 3250000:
+		uvloval = TPS65218_CONFIG1_UVLO_3250000;
+		break;
+	case 3350000:
+		uvloval = TPS65218_CONFIG1_UVLO_3350000;
+		break;
+	default:
+		dev_err(tps->dev,
+			"Invalid ti,under-voltage-limit-microvolt value\n");
+		return -EINVAL;
+	}
+
+	tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
+		TPS65218_CONFIG1_UVLO_MASK, uvloval,
+		TPS65218_PROTECT_L1);
+	return 0;
+}
+
 static int tps65218_probe(struct i2c_client *client,
 				const struct i2c_device_id *ids)
 {
@@ -249,6 +324,18 @@ static int tps65218_probe(struct i2c_client *client,
 
 	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;
 
+	ret = tps65218_voltage_set_strict(tps);
+	if (ret)
+		return ret;
+
+	ret = tps65218_voltage_set_uvlo(tps);
+	if (ret)
+		return ret;
+
+	ret = tps65218_voltage_set_uv_hyst(tps);
+	if (ret)
+		return ret;
+
 	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65218_cells,
 			      ARRAY_SIZE(tps65218_cells), NULL, 0,
 			      regmap_irq_get_domain(tps->irq_data));
diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
index c204d9a..3cbe103 100644
--- a/include/linux/mfd/tps65218.h
+++ b/include/linux/mfd/tps65218.h
@@ -137,6 +137,10 @@
 #define TPS65218_CONFIG1_PGDLY_MASK	0x18
 #define TPS65218_CONFIG1_STRICT		BIT(2)
 #define TPS65218_CONFIG1_UVLO_MASK	0x3
+#define TPS65218_CONFIG1_UVLO_2750000	0x0
+#define TPS65218_CONFIG1_UVLO_2950000	0x1
+#define TPS65218_CONFIG1_UVLO_3250000	0x2
+#define TPS65218_CONFIG1_UVLO_3350000	0x3
 
 #define TPS65218_CONFIG2_DC12_RST	BIT(7)
 #define TPS65218_CONFIG2_UVLOHYS	BIT(6)
-- 
2.7.4

