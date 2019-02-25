Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1437C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D342173C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfBYGmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:42:51 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.130]:19715 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbfBYGmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:42:50 -0500
Received: from [46.226.53.56] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.eu-west-1.aws.symcld.net id 82/90-27207-66E837C5; Mon, 25 Feb 2019 06:42:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRWlGSWpSXmKPExsVy8+3OTbppfcU
  xBtums1lMffiEzWL+kXOsFqe2NzFZfLvSwWRxedccNovZS/pZLJZev8hk0br3CLvF/iteDpwe
  a+atYfT49nUSi8fOWXfZPTat6mTzOH5jO5PH501yAWxRrJl5SfkVCawZLdc2sRfskqo4+quTs
  YFxh1gXIxeHkMBTRon9u/cxdzFyAjkVEg/2vGQBsdkErCR2r1kMZosIKEtc/b4XzGYW6GWSmP
  o/HMQWFnCQ6Jv6nR3EZhFQlTjadJAJxOYV8JX4duMs2EwJATmJm+c6wWxOAT+J++e/s0AsnsA
  o0dZ2kBWiQVDi5MwnUAskJA6+eAF1kJbE1X8H2SEGKUhMfb8SyOYAsuMkLvdnQ4Q1JZ7veMoI
  YdtLTH9/FWqvocT3Wd9YIGxziXn3pkDFbSQO/W1lg7BNJVbMvcw8gVFsFpIrZiG5YgEj0ypGi
  6SizPSMktzEzBxdQwMDXUNDI10jAyNdQyMTvcQq3WS91FLd8tTiEl1DvcTyYr3iytzknBS9vN
  SSTYzAqE0pOFWzg3F6d/ohRkkOJiVRXpvc4hghvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErxxPUA
  5waLU9NSKtMwcYPqASUtw8CiJ8Cb1AqV5iwsSc4sz0yFSpxgVpcR574H0CYAkMkrz4NpgKesS
  o6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWHeRpApPJl5JXDTXwEtZgJa3PclH2RxSSJCSqqBU
  cSw8vMX06WPgrIcFmoWXvmT4l/9xttiWbngYy+JHHUejYNLF/odOb+06LrnGiMWOYbpv6L2+L
  wJmpTMvnd62OqJ+2fOWHnV8JVexe1Hy38pJn4KuHzke6Urc8Cb/Fsyb/VEJzRt+mLy+VXtL5m
  8COb5/f0OtaH3QsQssuaVLQ18vPjMSv1N25VYijMSDbWYi4oTAQyArEhUAwAA
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-13.tower-308.messagelabs.com!1551076965!2123184!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16494 invoked from network); 25 Feb 2019 06:42:46 -0000
Received: from unknown (HELO mail.wago.com) (217.237.185.178)
  by server-13.tower-308.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 25 Feb 2019 06:42:46 -0000
Received: from lc010965.wago.local (10.1.101.132) by SVEX01012.wago.local
 (10.1.103.230) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Mon, 25 Feb
 2019 07:42:45 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)
        id 2C0071700281; Mon, 25 Feb 2019 07:42:45 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     Mark Brown <broonie@kernel.org>
CC:     J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] regulator: tps65218: add support for LS2
Date:   Mon, 25 Feb 2019 07:41:06 +0100
Message-ID: <1551076866-12578-3-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551076866-12578-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1551076866-12578-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.132]
X-ClientProxiedBy: SVEX01012.wago.local (10.1.103.230) To SVEX01012.wago.local
 (10.1.103.230)
X-KSE-ServerInfo: SVEX01012.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 25.02.2019 03:58:00
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

