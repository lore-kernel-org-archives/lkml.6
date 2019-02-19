Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F283C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218432146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfBSKEr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:04:47 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11523 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727500AbfBSKEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:04:43 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JA31s9015937;
        Tue, 19 Feb 2019 11:04:36 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qpc6x7p48-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 19 Feb 2019 11:04:36 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C9DAA3A;
        Tue, 19 Feb 2019 10:04:34 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AAC0F2796;
        Tue, 19 Feb 2019 10:04:34 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 19 Feb
 2019 11:04:33 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Tue, 19 Feb 2019 11:04:33 +0100
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
CC:     Pascal PAILLET-LME <p.paillet@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 5/8] regulator: stpmic1: Remove support for regulator pull
 down
Thread-Topic: [PATCH 5/8] regulator: stpmic1: Remove support for regulator
 pull down
Thread-Index: AQHUyDqD+87cpMH+zEiqQTpa1+pPcw==
Date:   Tue, 19 Feb 2019 10:04:33 +0000
Message-ID: <1550570647-9555-6-git-send-email-p.paillet@st.com>
References: <1550570647-9555-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1550570647-9555-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator high pull down are enabled by default so remove support in the
driver.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 drivers/regulator/stpmic1_regulator.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index f5c0e58..6970e45 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -133,7 +133,6 @@ enum {
 	.disable = regulator_disable_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.set_pull_down = regulator_set_pull_down_regmap,
 	.set_over_current_protection = stpmic1_set_icc,
 };
 
@@ -145,7 +144,6 @@ enum {
 	.disable = regulator_disable_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.set_pull_down = regulator_set_pull_down_regmap,
 	.get_bypass = regulator_get_bypass_regmap,
 	.set_bypass = regulator_set_bypass_regmap,
 	.set_over_current_protection = stpmic1_set_icc,
@@ -155,7 +153,6 @@ enum {
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
-	.set_pull_down = regulator_set_pull_down_regmap,
 	.set_over_current_protection = stpmic1_set_icc,
 };
 
@@ -177,7 +174,6 @@ enum {
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
-	.set_pull_down = regulator_set_pull_down_regmap,
 };
 
 static const struct regulator_ops stpmic1_switch_regul_ops = {
@@ -203,8 +199,6 @@ enum {
 	.enable_val = 1, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
-	.pull_down_reg = ids##_PULL_DOWN_REG, \
-	.pull_down_mask = ids##_PULL_DOWN_MASK, \
 	.supply_name = #base, \
 }
 
@@ -228,8 +222,6 @@ enum {
 	.bypass_mask = LDO_BYPASS_MASK, \
 	.bypass_val_on = LDO_BYPASS_MASK, \
 	.bypass_val_off = 0, \
-	.pull_down_reg = ids##_PULL_DOWN_REG, \
-	.pull_down_mask = ids##_PULL_DOWN_MASK, \
 	.supply_name = #base, \
 }
 
@@ -247,8 +239,6 @@ enum {
 	.enable_val = 1, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
-	.pull_down_reg = ids##_PULL_DOWN_REG, \
-	.pull_down_mask = ids##_PULL_DOWN_MASK, \
 	.supply_name = #base, \
 }
 
@@ -288,8 +278,6 @@ enum {
 	.enable_val = 1, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
-	.pull_down_reg = ids##_PULL_DOWN_REG, \
-	.pull_down_mask = ids##_PULL_DOWN_MASK, \
 	.supply_name = #base, \
 }
 
-- 
1.9.1
