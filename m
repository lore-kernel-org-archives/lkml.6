Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeC1LGQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:06:16 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:6570 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752159AbeC1LGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:06:15 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRWlGSWpSXmKPExsUSt3Opsa5q+e4
  og9szOCzufz3KaHF51xw2i8sTO9kdmD12zrrL7nHn2h42j8+b5AKYo1gz85LyKxJYMzb/OMBY
  cLSNseLsxaVsDYxzyroYuTiEBNYzSjxa8Za5i5ETyKmQuPyniQ3EZhMwlJj35j0jiM0ioCpx9
  uYesBphAQ+JvgVtTCC2iECQxPKGBpYuRg4OZgFziQ039EHCvAIOEvu//mWHsAUlTs58wgJiMw
  tISBx88YIZpFxIQEti+bFIkLCEgL3E9PdXwcISAvoSjcdiIcKGEt9nfWOBsM0lFq/fwjSBkX8
  WkqGzkAxdwMi0itEiqSgzPaMkNzEzR9fQwEDX0NBY1xxI6iVW6SbppZbqJqfmlRQlAiX1EsuL
  9Yorc5NzUvTyUks2MQIDlgEIdjBeept8iFGSg0lJlFcybneUEF9SfkplRmJxRnxRaU5q8SFGG
  Q4OJQne+DKgnGBRanpqRVpmDjB2YNISHDxKIrx/SoHSvMUFibnFmekQqVOMuhw3XrxuYxZiyc
  vPS5US5/0KUiQAUpRRmgc3AhbHlxhlpYR5GYGOEuIpSC3KzSxBlX/FKM7BqCTM6wxyCU9mXgn
  cpldARzABHbGtaQfIESWJCCmpBsYd98/q7dbuXlyx5OGcZa46G34clrtw8NqdDRuX52r61zLX
  z8/Kv5niX7PvjOfG3MSGnxptC59bN/3/u2D9a4lTTEL+Tdbveh6lrS5Z8f+sMN9RidbVoYutF
  nZKznxlZbNyrZdktmCQReWVG7nbcj7qxz3eZr510mVNqXZD+x2HNfTYXi7u+/9HiaU4I9FQi7
  moOBEAuHWqsd4CAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-29.tower-239.messagelabs.com!1522235172!782707!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Wed, 28 Mar 2018 12:03:09 +0100
Subject: [PATCH V1] mfd: da9062: use core helper regmap_reg_range macros
To: LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
CC: Support Opensource <support.opensource@diasemi.com>
Message-ID: <20180328110612.1FCAD3FACC@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 28/03/2018 08:23:00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Replace multi-line entries in the regmap_range arrays with single
line macros: regmap_reg_range(). This will leave the static structure
array entries for regmap_range unaltered. It will significantly reduce
the line count in the DA9062/61 core file.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.16-rc7

Hi,

This is a cosmetic tidy up operation. It reduces the line-count in the
file by over 200.

It will replace regmap_range[] array entries, such as this: 
{
  .range_min = DA9062AA_DEVICE_ID,
  .range_max = DA9062AA_CONFIG_ID,
},

with a single line,
 regmap_reg_range(DA9062AA_DEVICE_ID, DA9062AA_CONFIG_ID),

Regards,
Steve Twiss, Dialog Semiconductor


 drivers/mfd/da9062-core.c | 462 ++++++++++++----------------------------------
 1 file changed, 114 insertions(+), 348 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index fe18115..9f61059 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -365,186 +365,69 @@ static int da9062_get_device_type(struct da9062 *chip)
 }
 
 static const struct regmap_range da9061_aa_readable_ranges[] = {
-	{
-		.range_min = DA9062AA_PAGE_CON,
-		.range_max = DA9062AA_STATUS_B,
-	}, {
-		.range_min = DA9062AA_STATUS_D,
-		.range_max = DA9062AA_EVENT_C,
-	}, {
-		.range_min = DA9062AA_IRQ_MASK_A,
-		.range_max = DA9062AA_IRQ_MASK_C,
-	}, {
-		.range_min = DA9062AA_CONTROL_A,
-		.range_max = DA9062AA_GPIO_4,
-	}, {
-		.range_min = DA9062AA_GPIO_WKUP_MODE,
-		.range_max = DA9062AA_GPIO_OUT3_4,
-	}, {
-		.range_min = DA9062AA_BUCK1_CONT,
-		.range_max = DA9062AA_BUCK4_CONT,
-	}, {
-		.range_min = DA9062AA_BUCK3_CONT,
-		.range_max = DA9062AA_BUCK3_CONT,
-	}, {
-		.range_min = DA9062AA_LDO1_CONT,
-		.range_max = DA9062AA_LDO4_CONT,
-	}, {
-		.range_min = DA9062AA_DVC_1,
-		.range_max = DA9062AA_DVC_1,
-	}, {
-		.range_min = DA9062AA_SEQ,
-		.range_max = DA9062AA_ID_4_3,
-	}, {
-		.range_min = DA9062AA_ID_12_11,
-		.range_max = DA9062AA_ID_16_15,
-	}, {
-		.range_min = DA9062AA_ID_22_21,
-		.range_max = DA9062AA_ID_32_31,
-	}, {
-		.range_min = DA9062AA_SEQ_A,
-		.range_max = DA9062AA_WAIT,
-	}, {
-		.range_min = DA9062AA_RESET,
-		.range_max = DA9062AA_BUCK_ILIM_C,
-	}, {
-		.range_min = DA9062AA_BUCK1_CFG,
-		.range_max = DA9062AA_BUCK3_CFG,
-	}, {
-		.range_min = DA9062AA_VBUCK1_A,
-		.range_max = DA9062AA_VBUCK4_A,
-	}, {
-		.range_min = DA9062AA_VBUCK3_A,
-		.range_max = DA9062AA_VBUCK3_A,
-	}, {
-		.range_min = DA9062AA_VLDO1_A,
-		.range_max = DA9062AA_VLDO4_A,
-	}, {
-		.range_min = DA9062AA_VBUCK1_B,
-		.range_max = DA9062AA_VBUCK4_B,
-	}, {
-		.range_min = DA9062AA_VBUCK3_B,
-		.range_max = DA9062AA_VBUCK3_B,
-	}, {
-		.range_min = DA9062AA_VLDO1_B,
-		.range_max = DA9062AA_VLDO4_B,
-	}, {
-		.range_min = DA9062AA_INTERFACE,
-		.range_max = DA9062AA_CONFIG_E,
-	}, {
-		.range_min = DA9062AA_CONFIG_G,
-		.range_max = DA9062AA_CONFIG_K,
-	}, {
-		.range_min = DA9062AA_CONFIG_M,
-		.range_max = DA9062AA_CONFIG_M,
-	}, {
-		.range_min = DA9062AA_GP_ID_0,
-		.range_max = DA9062AA_GP_ID_19,
-	}, {
-		.range_min = DA9062AA_DEVICE_ID,
-		.range_max = DA9062AA_CONFIG_ID,
-	},
+	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_STATUS_B),
+	regmap_reg_range(DA9062AA_STATUS_D, DA9062AA_EVENT_C),
+	regmap_reg_range(DA9062AA_IRQ_MASK_A, DA9062AA_IRQ_MASK_C),
+	regmap_reg_range(DA9062AA_CONTROL_A, DA9062AA_GPIO_4),
+	regmap_reg_range(DA9062AA_GPIO_WKUP_MODE, DA9062AA_GPIO_OUT3_4),
+	regmap_reg_range(DA9062AA_BUCK1_CONT, DA9062AA_BUCK4_CONT),
+	regmap_reg_range(DA9062AA_BUCK3_CONT, DA9062AA_BUCK3_CONT),
+	regmap_reg_range(DA9062AA_LDO1_CONT, DA9062AA_LDO4_CONT),
+	regmap_reg_range(DA9062AA_DVC_1, DA9062AA_DVC_1),
+	regmap_reg_range(DA9062AA_SEQ, DA9062AA_ID_4_3),
+	regmap_reg_range(DA9062AA_ID_12_11, DA9062AA_ID_16_15),
+	regmap_reg_range(DA9062AA_ID_22_21, DA9062AA_ID_32_31),
+	regmap_reg_range(DA9062AA_SEQ_A, DA9062AA_WAIT),
+	regmap_reg_range(DA9062AA_RESET, DA9062AA_BUCK_ILIM_C),
+	regmap_reg_range(DA9062AA_BUCK1_CFG, DA9062AA_BUCK3_CFG),
+	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
+	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
+	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
+	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
+	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
+	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
+	regmap_reg_range(DA9062AA_INTERFACE, DA9062AA_CONFIG_E),
+	regmap_reg_range(DA9062AA_CONFIG_G, DA9062AA_CONFIG_K),
+	regmap_reg_range(DA9062AA_CONFIG_M, DA9062AA_CONFIG_M),
+	regmap_reg_range(DA9062AA_GP_ID_0, DA9062AA_GP_ID_19),
+	regmap_reg_range(DA9062AA_DEVICE_ID, DA9062AA_CONFIG_ID),
 };
 
 static const struct regmap_range da9061_aa_writeable_ranges[] = {
-	{
-		.range_min = DA9062AA_PAGE_CON,
-		.range_max = DA9062AA_PAGE_CON,
-	}, {
-		.range_min = DA9062AA_FAULT_LOG,
-		.range_max = DA9062AA_EVENT_C,
-	}, {
-		.range_min = DA9062AA_IRQ_MASK_A,
-		.range_max = DA9062AA_IRQ_MASK_C,
-	}, {
-		.range_min = DA9062AA_CONTROL_A,
-		.range_max = DA9062AA_GPIO_4,
-	}, {
-		.range_min = DA9062AA_GPIO_WKUP_MODE,
-		.range_max = DA9062AA_GPIO_OUT3_4,
-	}, {
-		.range_min = DA9062AA_BUCK1_CONT,
-		.range_max = DA9062AA_BUCK4_CONT,
-	}, {
-		.range_min = DA9062AA_BUCK3_CONT,
-		.range_max = DA9062AA_BUCK3_CONT,
-	}, {
-		.range_min = DA9062AA_LDO1_CONT,
-		.range_max = DA9062AA_LDO4_CONT,
-	}, {
-		.range_min = DA9062AA_DVC_1,
-		.range_max = DA9062AA_DVC_1,
-	}, {
-		.range_min = DA9062AA_SEQ,
-		.range_max = DA9062AA_ID_4_3,
-	}, {
-		.range_min = DA9062AA_ID_12_11,
-		.range_max = DA9062AA_ID_16_15,
-	}, {
-		.range_min = DA9062AA_ID_22_21,
-		.range_max = DA9062AA_ID_32_31,
-	}, {
-		.range_min = DA9062AA_SEQ_A,
-		.range_max = DA9062AA_WAIT,
-	}, {
-		.range_min = DA9062AA_RESET,
-		.range_max = DA9062AA_BUCK_ILIM_C,
-	}, {
-		.range_min = DA9062AA_BUCK1_CFG,
-		.range_max = DA9062AA_BUCK3_CFG,
-	}, {
-		.range_min = DA9062AA_VBUCK1_A,
-		.range_max = DA9062AA_VBUCK4_A,
-	}, {
-		.range_min = DA9062AA_VBUCK3_A,
-		.range_max = DA9062AA_VBUCK3_A,
-	}, {
-		.range_min = DA9062AA_VLDO1_A,
-		.range_max = DA9062AA_VLDO4_A,
-	}, {
-		.range_min = DA9062AA_VBUCK1_B,
-		.range_max = DA9062AA_VBUCK4_B,
-	}, {
-		.range_min = DA9062AA_VBUCK3_B,
-		.range_max = DA9062AA_VBUCK3_B,
-	}, {
-		.range_min = DA9062AA_VLDO1_B,
-		.range_max = DA9062AA_VLDO4_B,
-	}, {
-		.range_min = DA9062AA_GP_ID_0,
-		.range_max = DA9062AA_GP_ID_19,
-	},
+	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_PAGE_CON),
+	regmap_reg_range(DA9062AA_FAULT_LOG, DA9062AA_EVENT_C),
+	regmap_reg_range(DA9062AA_IRQ_MASK_A, DA9062AA_IRQ_MASK_C),
+	regmap_reg_range(DA9062AA_CONTROL_A, DA9062AA_GPIO_4),
+	regmap_reg_range(DA9062AA_GPIO_WKUP_MODE, DA9062AA_GPIO_OUT3_4),
+	regmap_reg_range(DA9062AA_BUCK1_CONT, DA9062AA_BUCK4_CONT),
+	regmap_reg_range(DA9062AA_BUCK3_CONT, DA9062AA_BUCK3_CONT),
+	regmap_reg_range(DA9062AA_LDO1_CONT, DA9062AA_LDO4_CONT),
+	regmap_reg_range(DA9062AA_DVC_1, DA9062AA_DVC_1),
+	regmap_reg_range(DA9062AA_SEQ, DA9062AA_ID_4_3),
+	regmap_reg_range(DA9062AA_ID_12_11, DA9062AA_ID_16_15),
+	regmap_reg_range(DA9062AA_ID_22_21, DA9062AA_ID_32_31),
+	regmap_reg_range(DA9062AA_SEQ_A, DA9062AA_WAIT),
+	regmap_reg_range(DA9062AA_RESET, DA9062AA_BUCK_ILIM_C),
+	regmap_reg_range(DA9062AA_BUCK1_CFG, DA9062AA_BUCK3_CFG),
+	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
+	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
+	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
+	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
+	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
+	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
+	regmap_reg_range(DA9062AA_GP_ID_0, DA9062AA_GP_ID_19),
 };
 
 static const struct regmap_range da9061_aa_volatile_ranges[] = {
-	{
-		.range_min = DA9062AA_PAGE_CON,
-		.range_max = DA9062AA_STATUS_B,
-	}, {
-		.range_min = DA9062AA_STATUS_D,
-		.range_max = DA9062AA_EVENT_C,
-	}, {
-		.range_min = DA9062AA_CONTROL_A,
-		.range_max = DA9062AA_CONTROL_B,
-	}, {
-		.range_min = DA9062AA_CONTROL_E,
-		.range_max = DA9062AA_CONTROL_F,
-	}, {
-		.range_min = DA9062AA_BUCK1_CONT,
-		.range_max = DA9062AA_BUCK4_CONT,
-	}, {
-		.range_min = DA9062AA_BUCK3_CONT,
-		.range_max = DA9062AA_BUCK3_CONT,
-	}, {
-		.range_min = DA9062AA_LDO1_CONT,
-		.range_max = DA9062AA_LDO4_CONT,
-	}, {
-		.range_min = DA9062AA_DVC_1,
-		.range_max = DA9062AA_DVC_1,
-	}, {
-		.range_min = DA9062AA_SEQ,
-		.range_max = DA9062AA_SEQ,
-	},
+	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_STATUS_B),
+	regmap_reg_range(DA9062AA_STATUS_D, DA9062AA_EVENT_C),
+	regmap_reg_range(DA9062AA_CONTROL_A, DA9062AA_CONTROL_B),
+	regmap_reg_range(DA9062AA_CONTROL_E, DA9062AA_CONTROL_F),
+	regmap_reg_range(DA9062AA_BUCK1_CONT, DA9062AA_BUCK4_CONT),
+	regmap_reg_range(DA9062AA_BUCK3_CONT, DA9062AA_BUCK3_CONT),
+	regmap_reg_range(DA9062AA_LDO1_CONT, DA9062AA_LDO4_CONT),
+	regmap_reg_range(DA9062AA_DVC_1, DA9062AA_DVC_1),
+	regmap_reg_range(DA9062AA_SEQ, DA9062AA_SEQ),
 };
 
 static const struct regmap_access_table da9061_aa_readable_table = {
@@ -587,186 +470,69 @@ static int da9062_get_device_type(struct da9062 *chip)
 };
 
 static const struct regmap_range da9062_aa_readable_ranges[] = {
-	{
-		.range_min = DA9062AA_PAGE_CON,
-		.range_max = DA9062AA_STATUS_B,
-	}, {
-		.range_min = DA9062AA_STATUS_D,
-		.range_max = DA9062AA_EVENT_C,
-	}, {
-		.range_min = DA9062AA_IRQ_MASK_A,
-		.range_max = DA9062AA_IRQ_MASK_C,
-	}, {
-		.range_min = DA9062AA_CONTROL_A,
-		.range_max = DA9062AA_GPIO_4,
-	}, {
-		.range_min = DA9062AA_GPIO_WKUP_MODE,
-		.range_max = DA9062AA_BUCK4_CONT,
-	}, {
-		.range_min = DA9062AA_BUCK3_CONT,
-		.range_max = DA9062AA_BUCK3_CONT,
-	}, {
-		.range_min = DA9062AA_LDO1_CONT,
-		.range_max = DA9062AA_LDO4_CONT,
-	}, {
-		.range_min = DA9062AA_DVC_1,
-		.range_max = DA9062AA_DVC_1,
-	}, {
-		.range_min = DA9062AA_COUNT_S,
-		.range_max = DA9062AA_SECOND_D,
-	}, {
-		.range_min = DA9062AA_SEQ,
-		.range_max = DA9062AA_ID_4_3,
-	}, {
-		.range_min = DA9062AA_ID_12_11,
-		.range_max = DA9062AA_ID_16_15,
-	}, {
-		.range_min = DA9062AA_ID_22_21,
-		.range_max = DA9062AA_ID_32_31,
-	}, {
-		.range_min = DA9062AA_SEQ_A,
-		.range_max = DA9062AA_BUCK3_CFG,
-	}, {
-		.range_min = DA9062AA_VBUCK2_A,
-		.range_max = DA9062AA_VBUCK4_A,
-	}, {
-		.range_min = DA9062AA_VBUCK3_A,
-		.range_max = DA9062AA_VBUCK3_A,
-	}, {
-		.range_min = DA9062AA_VLDO1_A,
-		.range_max = DA9062AA_VLDO4_A,
-	}, {
-		.range_min = DA9062AA_VBUCK2_B,
-		.range_max = DA9062AA_VBUCK4_B,
-	}, {
-		.range_min = DA9062AA_VBUCK3_B,
-		.range_max = DA9062AA_VBUCK3_B,
-	}, {
-		.range_min = DA9062AA_VLDO1_B,
-		.range_max = DA9062AA_VLDO4_B,
-	}, {
-		.range_min = DA9062AA_BBAT_CONT,
-		.range_max = DA9062AA_BBAT_CONT,
-	}, {
-		.range_min = DA9062AA_INTERFACE,
-		.range_max = DA9062AA_CONFIG_E,
-	}, {
-		.range_min = DA9062AA_CONFIG_G,
-		.range_max = DA9062AA_CONFIG_K,
-	}, {
-		.range_min = DA9062AA_CONFIG_M,
-		.range_max = DA9062AA_CONFIG_M,
-	}, {
-		.range_min = DA9062AA_TRIM_CLDR,
-		.range_max = DA9062AA_GP_ID_19,
-	}, {
-		.range_min = DA9062AA_DEVICE_ID,
-		.range_max = DA9062AA_CONFIG_ID,
-	},
+	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_STATUS_B),
+	regmap_reg_range(DA9062AA_STATUS_D, DA9062AA_EVENT_C),
+	regmap_reg_range(DA9062AA_IRQ_MASK_A, DA9062AA_IRQ_MASK_C),
+	regmap_reg_range(DA9062AA_CONTROL_A, DA9062AA_GPIO_4),
+	regmap_reg_range(DA9062AA_GPIO_WKUP_MODE, DA9062AA_BUCK4_CONT),
+	regmap_reg_range(DA9062AA_BUCK3_CONT, DA9062AA_BUCK3_CONT),
+	regmap_reg_range(DA9062AA_LDO1_CONT, DA9062AA_LDO4_CONT),
+	regmap_reg_range(DA9062AA_DVC_1, DA9062AA_DVC_1),
+	regmap_reg_range(DA9062AA_COUNT_S, DA9062AA_SECOND_D),
+	regmap_reg_range(DA9062AA_SEQ, DA9062AA_ID_4_3),
+	regmap_reg_range(DA9062AA_ID_12_11, DA9062AA_ID_16_15),
+	regmap_reg_range(DA9062AA_ID_22_21, DA9062AA_ID_32_31),
+	regmap_reg_range(DA9062AA_SEQ_A, DA9062AA_BUCK3_CFG),
+	regmap_reg_range(DA9062AA_VBUCK2_A, DA9062AA_VBUCK4_A),
+	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
+	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
+	regmap_reg_range(DA9062AA_VBUCK2_B, DA9062AA_VBUCK4_B),
+	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
+	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
+	regmap_reg_range(DA9062AA_BBAT_CONT, DA9062AA_BBAT_CONT),
+	regmap_reg_range(DA9062AA_INTERFACE, DA9062AA_CONFIG_E),
+	regmap_reg_range(DA9062AA_CONFIG_G, DA9062AA_CONFIG_K),
+	regmap_reg_range(DA9062AA_CONFIG_M, DA9062AA_CONFIG_M),
+	regmap_reg_range(DA9062AA_TRIM_CLDR, DA9062AA_GP_ID_19),
+	regmap_reg_range(DA9062AA_DEVICE_ID, DA9062AA_CONFIG_ID),
 };
 
 static const struct regmap_range da9062_aa_writeable_ranges[] = {
-	{
-		.range_min = DA9062AA_PAGE_CON,
-		.range_max = DA9062AA_PAGE_CON,
-	}, {
-		.range_min = DA9062AA_FAULT_LOG,
-		.range_max = DA9062AA_EVENT_C,
-	}, {
-		.range_min = DA9062AA_IRQ_MASK_A,
-		.range_max = DA9062AA_IRQ_MASK_C,
-	}, {
-		.range_min = DA9062AA_CONTROL_A,
-		.range_max = DA9062AA_GPIO_4,
-	}, {
-		.range_min = DA9062AA_GPIO_WKUP_MODE,
-		.range_max = DA9062AA_BUCK4_CONT,
-	}, {
-		.range_min = DA9062AA_BUCK3_CONT,
-		.range_max = DA9062AA_BUCK3_CONT,
-	}, {
-		.range_min = DA9062AA_LDO1_CONT,
-		.range_max = DA9062AA_LDO4_CONT,
-	}, {
-		.range_min = DA9062AA_DVC_1,
-		.range_max = DA9062AA_DVC_1,
-	}, {
-		.range_min = DA9062AA_COUNT_S,
-		.range_max = DA9062AA_ALARM_Y,
-	}, {
-		.range_min = DA9062AA_SEQ,
-		.range_max = DA9062AA_ID_4_3,
-	}, {
-		.range_min = DA9062AA_ID_12_11,
-		.range_max = DA9062AA_ID_16_15,
-	}, {
-		.range_min = DA9062AA_ID_22_21,
-		.range_max = DA9062AA_ID_32_31,
-	}, {
-		.range_min = DA9062AA_SEQ_A,
-		.range_max = DA9062AA_BUCK3_CFG,
-	}, {
-		.range_min = DA9062AA_VBUCK2_A,
-		.range_max = DA9062AA_VBUCK4_A,
-	}, {
-		.range_min = DA9062AA_VBUCK3_A,
-		.range_max = DA9062AA_VBUCK3_A,
-	}, {
-		.range_min = DA9062AA_VLDO1_A,
-		.range_max = DA9062AA_VLDO4_A,
-	}, {
-		.range_min = DA9062AA_VBUCK2_B,
-		.range_max = DA9062AA_VBUCK4_B,
-	}, {
-		.range_min = DA9062AA_VBUCK3_B,
-		.range_max = DA9062AA_VBUCK3_B,
-	}, {
-		.range_min = DA9062AA_VLDO1_B,
-		.range_max = DA9062AA_VLDO4_B,
-	}, {
-		.range_min = DA9062AA_BBAT_CONT,
-		.range_max = DA9062AA_BBAT_CONT,
-	}, {
-		.range_min = DA9062AA_GP_ID_0,
-		.range_max = DA9062AA_GP_ID_19,
-	},
+	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_PAGE_CON),
+	regmap_reg_range(DA9062AA_FAULT_LOG, DA9062AA_EVENT_C),
+	regmap_reg_range(DA9062AA_IRQ_MASK_A, DA9062AA_IRQ_MASK_C),
+	regmap_reg_range(DA9062AA_CONTROL_A, DA9062AA_GPIO_4),
+	regmap_reg_range(DA9062AA_GPIO_WKUP_MODE, DA9062AA_BUCK4_CONT),
+	regmap_reg_range(DA9062AA_BUCK3_CONT, DA9062AA_BUCK3_CONT),
+	regmap_reg_range(DA9062AA_LDO1_CONT, DA9062AA_LDO4_CONT),
+	regmap_reg_range(DA9062AA_DVC_1, DA9062AA_DVC_1),
+	regmap_reg_range(DA9062AA_COUNT_S, DA9062AA_ALARM_Y),
+	regmap_reg_range(DA9062AA_SEQ, DA9062AA_ID_4_3),
+	regmap_reg_range(DA9062AA_ID_12_11, DA9062AA_ID_16_15),
+	regmap_reg_range(DA9062AA_ID_22_21, DA9062AA_ID_32_31),
+	regmap_reg_range(DA9062AA_SEQ_A, DA9062AA_BUCK3_CFG),
+	regmap_reg_range(DA9062AA_VBUCK2_A, DA9062AA_VBUCK4_A),
+	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
+	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
+	regmap_reg_range(DA9062AA_VBUCK2_B, DA9062AA_VBUCK4_B),
+	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
+	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
+	regmap_reg_range(DA9062AA_BBAT_CONT, DA9062AA_BBAT_CONT),
+	regmap_reg_range(DA9062AA_GP_ID_0, DA9062AA_GP_ID_19),
 };
 
 static const struct regmap_range da9062_aa_volatile_ranges[] = {
-	{
-		.range_min = DA9062AA_PAGE_CON,
-		.range_max = DA9062AA_STATUS_B,
-	}, {
-		.range_min = DA9062AA_STATUS_D,
-		.range_max = DA9062AA_EVENT_C,
-	}, {
-		.range_min = DA9062AA_CONTROL_A,
-		.range_max = DA9062AA_CONTROL_B,
-	}, {
-		.range_min = DA9062AA_CONTROL_E,
-		.range_max = DA9062AA_CONTROL_F,
-	}, {
-		.range_min = DA9062AA_BUCK2_CONT,
-		.range_max = DA9062AA_BUCK4_CONT,
-	}, {
-		.range_min = DA9062AA_BUCK3_CONT,
-		.range_max = DA9062AA_BUCK3_CONT,
-	}, {
-		.range_min = DA9062AA_LDO1_CONT,
-		.range_max = DA9062AA_LDO4_CONT,
-	}, {
-		.range_min = DA9062AA_DVC_1,
-		.range_max = DA9062AA_DVC_1,
-	}, {
-		.range_min = DA9062AA_COUNT_S,
-		.range_max = DA9062AA_SECOND_D,
-	}, {
-		.range_min = DA9062AA_SEQ,
-		.range_max = DA9062AA_SEQ,
-	}, {
-		.range_min = DA9062AA_EN_32K,
-		.range_max = DA9062AA_EN_32K,
-	},
+	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_STATUS_B),
+	regmap_reg_range(DA9062AA_STATUS_D, DA9062AA_EVENT_C),
+	regmap_reg_range(DA9062AA_CONTROL_A, DA9062AA_CONTROL_B),
+	regmap_reg_range(DA9062AA_CONTROL_E, DA9062AA_CONTROL_F),
+	regmap_reg_range(DA9062AA_BUCK2_CONT, DA9062AA_BUCK4_CONT),
+	regmap_reg_range(DA9062AA_BUCK3_CONT, DA9062AA_BUCK3_CONT),
+	regmap_reg_range(DA9062AA_LDO1_CONT, DA9062AA_LDO4_CONT),
+	regmap_reg_range(DA9062AA_DVC_1, DA9062AA_DVC_1),
+	regmap_reg_range(DA9062AA_COUNT_S, DA9062AA_SECOND_D),
+	regmap_reg_range(DA9062AA_SEQ, DA9062AA_SEQ),
+	regmap_reg_range(DA9062AA_EN_32K, DA9062AA_EN_32K),
 };
 
 static const struct regmap_access_table da9062_aa_readable_table = {
-- 
end-of-patch for PATCH V1
