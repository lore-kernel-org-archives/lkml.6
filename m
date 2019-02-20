Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8311C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A6D2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfBTMbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:31:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:19199 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727447AbfBTMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:31:42 -0500
X-UUID: ed557a846bce4d6eb2ece2bbc098d64a-20190220
X-UUID: ed557a846bce4d6eb2ece2bbc098d64a-20190220
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1821676404; Wed, 20 Feb 2019 20:31:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 20:31:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 20:31:36 +0800
From:   <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [PATCH v2,3/7] thermal: mediatek: add calibration item
Date:   Wed, 20 Feb 2019 20:31:29 +0800
Message-ID: <1550665893-22561-4-git-send-email-michael.kao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550665893-22561-1-git-send-email-michael.kao@mediatek.com>
References: <1550665893-22561-1-git-send-email-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A680BDA5DBE42D0DF397EB212030EB7EF88D2FAEE9FBF70178385BBFADECA3752000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

Add calibration item in thermal_data to support
the project with different calibration coefficient.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 07f8ad7..45c6587 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -105,6 +105,9 @@
 /* The number of sensing points per bank */
 #define MT8173_NUM_SENSORS_PER_ZONE	4
 
+/* The calibration coefficient of sensor  */
+#define MT8173_CALIBRATION	165
+
 /*
  * Layout of the fuses providing the calibration data
  * These macros could be used for MT8173, MT2701, and MT2712.
@@ -147,6 +150,9 @@ enum {
 /* The number of sensing points per bank */
 #define MT2701_NUM_SENSORS_PER_ZONE	3
 
+/* The calibration coefficient of sensor  */
+#define MT2701_CALIBRATION	165
+
 /* MT2712 thermal sensors */
 #define MT2712_TS1	0
 #define MT2712_TS2	1
@@ -162,12 +168,18 @@ enum {
 /* The number of sensing points per bank */
 #define MT2712_NUM_SENSORS_PER_ZONE	4
 
+/* The calibration coefficient of sensor  */
+#define MT2712_CALIBRATION	165
+
 #define MT7622_TEMP_AUXADC_CHANNEL	11
 #define MT7622_NUM_SENSORS		1
 #define MT7622_NUM_ZONES		1
 #define MT7622_NUM_SENSORS_PER_ZONE	1
 #define MT7622_TS1	0
 
+/* The calibration coefficient of sensor  */
+#define MT7622_CALIBRATION	165
+
 struct mtk_thermal;
 
 struct thermal_bank_cfg {
@@ -188,6 +200,7 @@ struct mtk_thermal_data {
 	const int *sensor_mux_values;
 	const int *msr;
 	const int *adcpnp;
+	const int cali_val;
 	struct thermal_bank_cfg bank_data[];
 };
 
@@ -295,6 +308,7 @@ struct mtk_thermal {
 	.num_banks = MT8173_NUM_ZONES,
 	.num_sensors = MT8173_NUM_SENSORS,
 	.vts_index = mt8173_vts_index,
+	.cali_val = MT8173_CALIBRATION,
 	.bank_data = {
 		{
 			.num_sensors = 2,
@@ -330,6 +344,7 @@ struct mtk_thermal {
 	.num_banks = 1,
 	.num_sensors = MT2701_NUM_SENSORS,
 	.vts_index = mt2701_vts_index,
+	.cali_val = MT2701_CALIBRATION,
 	.bank_data = {
 		{
 			.num_sensors = 3,
@@ -356,6 +371,7 @@ struct mtk_thermal {
 	.num_banks = 1,
 	.num_sensors = MT2712_NUM_SENSORS,
 	.vts_index = mt2712_vts_index,
+	.cali_val = MT2712_CALIBRATION,
 	.bank_data = {
 		{
 			.num_sensors = 4,
@@ -376,6 +392,7 @@ struct mtk_thermal {
 	.num_banks = MT7622_NUM_ZONES,
 	.num_sensors = MT7622_NUM_SENSORS,
 	.vts_index = mt7622_vts_index,
+	.cali_val = MT7622_CALIBRATION,
 	.bank_data = {
 		{
 			.num_sensors = 1,
@@ -402,7 +419,7 @@ static int raw_to_mcelsius(struct mtk_thermal *mt, int sensno, s32 raw)
 	raw &= 0xfff;
 
 	tmp = 203450520 << 3;
-	tmp /= 165 + mt->o_slope;
+	tmp /= mt->conf->cali_val + mt->o_slope;
 	tmp /= 10000 + mt->adc_ge;
 	tmp *= raw - mt->vts[sensno] - 3350;
 	tmp >>= 3;
-- 
1.9.1

