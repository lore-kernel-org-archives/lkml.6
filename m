Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18B9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0E92070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfBTIQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:16:21 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.117]:44519 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbfBTIQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:16:19 -0500
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-b.eu-central-1.aws.symcld.net id 0A/BD-16347-FCC0D6C5; Wed, 20 Feb 2019 08:16:15 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRWlGSWpSXmKPExsVy8+3OTbrneXJ
  jDDbM17WY+vAJm8X8I+dYLU5tb2Ky+Halg8ni8q45bBazl/SzWCy9fpHJonXvEXaL/Ve8HDg9
  1sxbw+jx7eskFo+ds+6ye2xa1cnmcfzGdiaPz5vkAtiiWDPzkvIrElgz/u86zFZwTaSic/Udl
  gbGc4JdjFwcQgJPGSU6/i9h7GLkBHIqJI7tWMgMYrMJWEnsXrOYBcQWEVCQ+NB0jw2kgVlgAp
  PEmcMHWUESwgK2EvtnfAArYhFQlWj9txhsEK+Ar8Tts2vA4hICchI3z3WCDeUU8JOYNOkMM8Q
  yX4lr/b/YIeoFJU7OfAJWzywgIXHwxQuoGi2Jq/8OskPMUZDY+eMYM4QdJ/H5dwtTFyMHkK0p
  cXpZEkTYXmL6+6tQJYYS32d9gzrBXOLtjcmMELaNxKG/rWwQtqnE9yNXWCcwis1CcsUsJFcsY
  GRaxWiZVJSZnlGSm5iZo2toYKBraGisa6JraGKkl1ilm6SXWqqbnJpXUpQIlNVLLC/WK67MTc
  5J0ctLLdnECIzblEKWvh2MH9vTDzFKcjApifKW3ciJEeJLyk+pzEgszogvKs1JLT7EKMPBoST
  Bq8edGyMkWJSanlqRlpkDTCAwaQkOHiUR3rNcQGne4oLE3OLMdIjUKUZFKXFeUVaghABIIqM0
  D64NlrQuMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmZWIGmsKTmVcCN/0V0GImoMWz/meDL
  C5JREhJNTB6uOa8CHl5bsHWdUvMkhtro7I7fnSU/GJi119Q2xWtWFN1iHs9W1W7omhXdsYZE4
  MHk7T9rFh9Nx4Lz9sWnCHm1c8zN6B74hWGBcJhHyT3uq1cE3TGmfmR+KpQzzUTvLrWu+gvfet
  8OaHs/BqWhINn2NZO6P+keavnDkfIrw7V6d+08rbWyiqxFGckGmoxFxUnAgAzDBxmVQMAAA==
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-28.tower-239.messagelabs.com!1550650575!1443181!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1475 invoked from network); 20 Feb 2019 08:16:15 -0000
Received: from unknown (HELO mail.wago.com) (217.237.185.178)
  by server-28.tower-239.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 20 Feb 2019 08:16:15 -0000
Received: from lc010965.wago.local (10.1.101.139) by SVEX01013.wago.local
 (10.1.103.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 20 Feb
 2019 09:16:14 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)
        id DD3901704214; Wed, 20 Feb 2019 09:16:14 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     J Keerthy <j-keerthy@ti.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] regulator: tps65218: Add support for LS2
Date:   Wed, 20 Feb 2019 09:15:52 +0100
Message-ID: <1550650552-26013-4-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.139]
X-ClientProxiedBy: SVEX01013.wago.local (10.1.103.231) To SVEX01013.wago.local
 (10.1.103.231)
X-KSE-ServerInfo: SVEX01013.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 20.02.2019 07:25:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 0e6009ac-ccf0-4540-927c-32c649c0c00d
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
 1 file changed, 13 insertions(+), 5 deletions(-)

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
-- 
2.7.4

