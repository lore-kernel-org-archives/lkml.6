Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760D8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515CF20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfBVIkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:40:07 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.5]:51607 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbfBVIkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:40:06 -0500
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.eu-central-1.aws.symcld.net id 3B/1F-12121-265BF6C5; Fri, 22 Feb 2019 08:40:02 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRWlGSWpSXmKPExsVy8+3OTbpJW/N
  jDK7vZLWY+vAJm8X8I+dYLU5tb2Ky+Halg8ni8q45bBazl/SzWCy9fpHJonXvEXaL/Ve8HDg9
  1sxbw+jx7eskFo+ds+6ye2xa1cnmcfzGdiaPz5vkAtiiWDPzkvIrElgzjj2oLfgtVbH5WTt7A
  +MbsS5GLg4hgaeMEotvvWLsYuQEciokfj7dygRiswlYSexes5gFxBYRUJa4+n0vmM0s0MskMf
  V/eBcjB4ewgI3E/4NyIGEWAVWJzS13wFp5BXwlfjWuZQWxJQTkJG6e62QGsTkFjCQmXHnABtI
  qJGAo0X3WHqJcUOLkzCdQ0yUkDr54wQxxjZbE1X8H2UHKJQQUJF6+iYMw4ySW7guHGK4p8XzH
  U0YI215i+vurzBC2ocT3Wd9YIGxziY0b5kPZNhKH/rayQdimEivmXmaewCg2C8kRs5AcsYCRa
  RWjRVJRZnpGSW5iZo6uoYGBrqGhsa6Rrqm5XmKVbqJeaqlucmpeSVEiUFIvsbxYr7gyNzknRS
  8vtWQTIzBWUwqZLHcwbliafohRkoNJSZR33qz8GCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvBp
  bgHKCRanpqRVpmTnApAGTluDgURLh7d4MlOYtLkjMLc5Mh0idYlSUEue9ApIQAElklObBtcES
  1SVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwryXNwFN4cnMK4Gb/gpoMRPQ4ln/s0EWlyQip
  KQaGAN+N3bOfLJKYNLXaVrWUZY+OrkH/7v+8Du0TjMpq+bcX9+kfVPnXmqeJCRWk3F09uwJvx
  43fJO9djBlc8PdZ59EMyzdqlevvC5ts/Txi4smPjtF9WRKVuWk1f7iYdzyO6jmoZZrwpSdPhk
  TPA6K8NRyLtevrs6vqbwou75Lb214vWbx/k06ZUosxRmJhlrMRcWJAKzGvnxPAwAA
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-14.tower-229.messagelabs.com!1550824801!1588901!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26046 invoked from network); 22 Feb 2019 08:40:02 -0000
Received: from unknown (HELO mail.wago.com) (217.237.185.178)
  by server-14.tower-229.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 22 Feb 2019 08:40:02 -0000
Received: from lc010965.wago.local (10.1.101.133) by SVEX01012.wago.local
 (10.1.103.230) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Fri, 22 Feb
 2019 09:40:01 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)
        id 393D117000DD; Fri, 22 Feb 2019 09:40:01 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     Mark Brown <broonie@kernel.org>
CC:     J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] regulator: tps65218: Add support for LS2
Date:   Fri, 22 Feb 2019 09:38:54 +0100
Message-ID: <1550824734-26581-1-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190220164851.GD9878@sirena.org.uk>
References: <20190220164851.GD9878@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.133]
X-ClientProxiedBy: SVEX01009.wago.local (10.1.103.227) To SVEX01012.wago.local
 (10.1.103.230)
X-KSE-ServerInfo: SVEX01012.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 22.02.2019 05:06:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: deb34f4f-1670-42da-9b53-f8c7bceb0e0a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-use the "tps65218_pmic_*_current_limit()" functions of LS3
and calculate the different required bit-shift by counting the
trailing 0s in "struct regulator_desc.csel_mask"

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---

Somehow the header changes got lost in the first patch, Sorry.

 drivers/regulator/tps65218-regulator.c | 18 +++++++++++++-----
 include/linux/mfd/tps65218.h           |  3 ++-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 5dd559e..95708d3 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -205,7 +205,8 @@ static int tps65218_pmic_set_input_current_lim(struct regulator_dev *dev,
 		return -EINVAL;
 
 	return tps65218_set_bits(tps, dev->desc->csel_reg, dev->desc->csel_mask,
-				 index << 2, TPS65218_PROTECT_L1);
+				 index << __builtin_ctz(dev->desc->csel_mask),
+				 TPS65218_PROTECT_L1);
 }
 
 static int tps65218_pmic_set_current_limit(struct regulator_dev *dev,
@@ -224,7 +225,8 @@ static int tps65218_pmic_set_current_limit(struct regulator_dev *dev,
 		return -EINVAL;
 
 	return tps65218_set_bits(tps, dev->desc->csel_reg, dev->desc->csel_mask,
-				 index << 2, TPS65218_PROTECT_L1);
+				 index << __builtin_ctz(dev->desc->csel_mask),
+				 TPS65218_PROTECT_L1);
 }
 
 static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
@@ -237,12 +239,13 @@ static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
 	if (retval < 0)
 		return retval;
 
-	index = (index & dev->desc->csel_mask) >> 2;
+	index = (index & dev->desc->csel_mask) >>
+					 __builtin_ctz(dev->desc->csel_mask);
 
 	return ls3_currents[index];
 }
 
-static struct regulator_ops tps65218_ls3_ops = {
+static struct regulator_ops tps65218_ls23_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
@@ -304,8 +307,13 @@ static const struct regulator_desc regulators[] = {
 			   TPS65218_ENABLE2_LDO1_EN, 0, 0, ldo1_dcdc3_ranges,
 			   2, 0, 0, TPS65218_REG_SEQ6,
 			   TPS65218_SEQ6_LDO1_SEQ_MASK),
+	TPS65218_REGULATOR("LS2", "regulator-ls2", TPS65218_LS_2,
+			   REGULATOR_CURRENT, tps65218_ls23_ops, 0, 0, 0,
+			   TPS65218_REG_ENABLE2, TPS65218_ENABLE2_LS2_EN,
+			   TPS65218_REG_CONFIG2, TPS65218_CONFIG2_LS2ILIM_MASK,
+			   NULL, 0, 0, 0, 0, 0),
 	TPS65218_REGULATOR("LS3", "regulator-ls3", TPS65218_LS_3,
-			   REGULATOR_CURRENT, tps65218_ls3_ops, 0, 0, 0,
+			   REGULATOR_CURRENT, tps65218_ls23_ops, 0, 0, 0,
 			   TPS65218_REG_ENABLE2, TPS65218_ENABLE2_LS3_EN,
 			   TPS65218_REG_CONFIG2, TPS65218_CONFIG2_LS3ILIM_MASK,
 			   NULL, 0, 0, 0, 0, 0),
diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
index 3cbe103..b0470c3 100644
--- a/include/linux/mfd/tps65218.h
+++ b/include/linux/mfd/tps65218.h
@@ -212,6 +212,7 @@ enum tps65218_regulator_id {
 	/* LDOs */
 	TPS65218_LDO_1,
 	/* LS's */
+	TPS65218_LS_2,
 	TPS65218_LS_3,
 };
 
@@ -222,7 +223,7 @@ enum tps65218_regulator_id {
 /* Number of LDO voltage regulators available */
 #define TPS65218_NUM_LDO		1
 /* Number of total LS current regulators available */
-#define TPS65218_NUM_LS			1
+#define TPS65218_NUM_LS			2
 /* Number of total regulators available */
 #define TPS65218_NUM_REGULATOR		(TPS65218_NUM_DCDC + TPS65218_NUM_LDO \
 					 + TPS65218_NUM_LS)
-- 
2.7.4

