Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6287C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AC620855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eD+Z5bmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfBUKTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:19:30 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11646 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfBUKT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:19:27 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6e7b2b0000>; Thu, 21 Feb 2019 02:19:23 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 Feb 2019 02:19:24 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 Feb 2019 02:19:24 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 10:19:24 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 10:19:24 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 10:19:24 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6e7b2a0001>; Thu, 21 Feb 2019 02:19:24 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>,
        <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 12/12] thermal: tegra: enable OC hw throttle
Date:   Thu, 21 Feb 2019 18:18:47 +0800
Message-ID: <1550744327-4677-13-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550744327-4677-1-git-send-email-wni@nvidia.com>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550744363; bh=Sl+wJmNn/ydwrsW8A5Jg1smwva0MESYqVZ3SZfjpeg4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=eD+Z5bmLw4tGDjU5iV/+w5SN6GOXt5jcX37FSS3eoRN8yqtSFWbPQSoKW2MzKLxCC
         eOhK2/zAYL/MKDmvhtVLxTMqtPk3k2ZEdpDpmul4LJgcjN5yyGSeZDw502IwcchU+h
         E3PW+JjCXUJhjT3ZgZFzzMRvatC+LA/3Y40mOGv/ri72YBZZeZabIr/NergF+Go4d1
         4/Didu+qzTnqlp8VlzIGorsWzyVlTTitoOxq8/LRyBer5SdOlgu+p53zRAkyEuYbu3
         Gbc9rCT15KsppDSm8WDRSy6TRO1lO1EM1IRKCaXLdOYof+Vj7N8L1gjhxOOMohiBz6
         QU58gsJ5GFz5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse Over Current settings from DT and program them to
generate interrupts. Also enable hw throttling whenever
there are OC events. Log the OC events as debug messages.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 130 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 120 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index b8c66368e54e..6e3f329d1ac4 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -106,9 +106,26 @@
 #define STATS_CTL_CLR_UP			0x2
 #define STATS_CTL_EN_UP				0x1
 
+#define OC1_CFG					0x310
+#define OC1_CFG_LONG_LATENCY_MASK		BIT(6)
+#define OC1_CFG_HW_RESTORE_MASK			BIT(5)
+#define OC1_CFG_PWR_GOOD_MASK_MASK		BIT(4)
+#define OC1_CFG_THROTTLE_MODE_MASK		(0x3 << 2)
+#define OC1_CFG_ALARM_POLARITY_MASK		BIT(1)
+#define OC1_CFG_EN_THROTTLE_MASK		BIT(0)
+
+#define OC1_CNT_THRESHOLD			0x314
+#define OC1_THROTTLE_PERIOD			0x318
+#define OC1_ALARM_COUNT				0x31c
+#define OC1_FILTER				0x320
+#define OC1_STATS				0x3a8
+
 #define OC_INTR_STATUS				0x39c
 #define OC_INTR_ENABLE				0x3a0
 #define OC_INTR_DISABLE				0x3a4
+#define OC_STATS_CTL				0x3c4
+#define OC_STATS_CTL_CLR_ALL			0x2
+#define OC_STATS_CTL_EN_ALL			0x1
 
 #define OC_INTR_OC1_MASK			BIT(0)
 #define OC_INTR_OC2_MASK			BIT(1)
@@ -207,6 +224,25 @@
 #define THROT_DELAY_CTRL(throt)		(THROT_DELAY_LITE + \
 					(THROT_OFFSET * throt))
 
+#define ALARM_OFFSET			0x14
+#define ALARM_CFG(throt)		(OC1_CFG + \
+					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
+
+#define ALARM_CNT_THRESHOLD(throt)	(OC1_CNT_THRESHOLD + \
+					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
+
+#define ALARM_THROTTLE_PERIOD(throt)	(OC1_THROTTLE_PERIOD + \
+					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
+
+#define ALARM_ALARM_COUNT(throt)	(OC1_ALARM_COUNT + \
+					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
+
+#define ALARM_FILTER(throt)		(OC1_FILTER + \
+					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
+
+#define ALARM_STATS(throt)		(OC1_STATS + \
+					(4 * (throt - THROTTLE_OC1)))
+
 /* get CCROC_THROT_PSKIP_xxx offset per HIGH/MED/LOW vect*/
 #define CCROC_THROT_OFFSET			0x0c
 #define CCROC_THROT_PSKIP_CTRL_CPU_REG(vect)    (CCROC_THROT_PSKIP_CTRL_CPU + \
@@ -218,6 +254,9 @@
 #define THERMCTL_LVL_REGS_SIZE		0x20
 #define THERMCTL_LVL_REG(rg, lv)	((rg) + ((lv) * THERMCTL_LVL_REGS_SIZE))
 
+#define OC_THROTTLE_MODE_DISABLED	0
+#define OC_THROTTLE_MODE_BRIEF		2
+
 static const int min_low_temp = -127000;
 static const int max_high_temp = 127000;
 
@@ -266,6 +305,15 @@ struct tegra_thermctl_zone {
 	const struct tegra_tsensor_group *sg;
 };
 
+struct soctherm_oc_cfg {
+	u32 active_low;
+	u32 throt_period;
+	u32 alarm_cnt_thresh;
+	u32 alarm_filter;
+	u32 mode;
+	bool intr_en;
+};
+
 struct soctherm_throt_cfg {
 	const char *name;
 	unsigned int id;
@@ -273,6 +321,7 @@ struct soctherm_throt_cfg {
 	u8 cpu_throt_level;
 	u32 cpu_throt_depth;
 	u32 gpu_throt_level;
+	struct soctherm_oc_cfg oc_cfg;
 	struct thermal_cooling_device *cdev;
 	bool init;
 };
@@ -715,7 +764,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 		return 0;
 	}
 
-	for (i = 0; i < THROTTLE_SIZE; i++) {
+	for (i = 0; i < THROTTLE_OC1; i++) {
 		struct thermal_cooling_device *cdev;
 
 		if (!ts->throt_cfgs[i].init)
@@ -1537,6 +1586,32 @@ static int soctherm_thermtrips_parse(struct platform_device *pdev)
 	return 0;
 }
 
+static void soctherm_oc_cfg_parse(struct device *dev,
+				struct device_node *np_oc,
+				struct soctherm_throt_cfg *stc)
+{
+	u32 val;
+
+	if (of_property_read_bool(np_oc, "nvidia,polarity-active-low"))
+		stc->oc_cfg.active_low = 1;
+	else
+		stc->oc_cfg.active_low = 0;
+
+	if (!of_property_read_u32(np_oc, "nvidia,count-threshold", &val)) {
+		stc->oc_cfg.intr_en = 1;
+		stc->oc_cfg.alarm_cnt_thresh = val;
+	}
+
+	if (!of_property_read_u32(np_oc, "nvidia,throttle-period-us", &val))
+		stc->oc_cfg.throt_period = val;
+
+	if (!of_property_read_u32(np_oc, "nvidia,alarm-filter", &val))
+		stc->oc_cfg.alarm_filter = val;
+
+	/* BRIEF throttling by default, do not support STICKY */
+	stc->oc_cfg.mode = OC_THROTTLE_MODE_BRIEF;
+}
+
 static int soctherm_throt_cfg_parse(struct device *dev,
 				    struct device_node *np,
 				    struct soctherm_throt_cfg *stc)
@@ -1619,24 +1694,34 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 			continue;
 		}
 
+		if (stc->init) {
+			dev_err(dev, "throttle-cfg: %s: redefined!\n", name);
+			of_node_put(np_stcc);
+			break;
+		}
 
 		err = soctherm_throt_cfg_parse(dev, np_stcc, stc);
 		if (err)
 			continue;
 
-		tcd = thermal_of_cooling_device_register(np_stcc,
+		if (stc->id >= THROTTLE_OC1) {
+			soctherm_oc_cfg_parse(dev, np_stcc, stc);
+			stc->init = true;
+		} else {
+
+			tcd = thermal_of_cooling_device_register(np_stcc,
 							 (char *)name, ts,
 							 &throt_cooling_ops);
-		of_node_put(np_stcc);
-		if (IS_ERR_OR_NULL(tcd)) {
-			dev_err(dev,
-				"throttle-cfg: %s: failed to register cooling device\n",
-				name);
-			continue;
+			if (IS_ERR_OR_NULL(tcd)) {
+				dev_err(dev,
+					"throttle-cfg: %s: failed to register cooling device\n",
+					name);
+				continue;
+			}
+			stc->cdev = tcd;
+			stc->init = true;
 		}
 
-		stc->cdev = tcd;
-		stc->init = true;
 	}
 
 	of_node_put(np_stc);
@@ -1787,6 +1872,28 @@ static void throttlectl_gpu_level_select(struct tegra_soctherm *ts,
 	writel(r, ts->regs + THROT_PSKIP_CTRL(throt, THROTTLE_DEV_GPU));
 }
 
+static int soctherm_oc_cfg_program(struct tegra_soctherm *ts,
+				      enum soctherm_throttle_id throt)
+{
+	u32 r;
+	struct soctherm_oc_cfg *oc = &ts->throt_cfgs[throt].oc_cfg;
+
+	if (oc->mode == OC_THROTTLE_MODE_DISABLED)
+		return -EINVAL;
+
+	r = REG_SET_MASK(0, OC1_CFG_HW_RESTORE_MASK, 1);
+	r = REG_SET_MASK(r, OC1_CFG_THROTTLE_MODE_MASK, oc->mode);
+	r = REG_SET_MASK(r, OC1_CFG_ALARM_POLARITY_MASK, oc->active_low);
+	r = REG_SET_MASK(r, OC1_CFG_EN_THROTTLE_MASK, 1);
+	writel(r, ts->regs + ALARM_CFG(throt));
+	writel(oc->throt_period, ts->regs + ALARM_THROTTLE_PERIOD(throt));
+	writel(oc->alarm_cnt_thresh, ts->regs + ALARM_CNT_THRESHOLD(throt));
+	writel(oc->alarm_filter, ts->regs + ALARM_FILTER(throt));
+	soctherm_oc_intr_enable(ts, throt, oc->intr_en);
+
+	return 0;
+}
+
 /**
  * soctherm_throttle_program() - programs pulse skippers' configuration
  * @throt: the LIGHT/HEAVY of the throttle event id.
@@ -1803,6 +1910,9 @@ static void soctherm_throttle_program(struct tegra_soctherm *ts,
 	if (!stc.init)
 		return;
 
+	if ((throt >= THROTTLE_OC1) && (soctherm_oc_cfg_program(ts, throt)))
+		return;
+
 	/* Setup PSKIP parameters */
 	if (ts->soc->use_ccroc)
 		throttlectl_cpu_level_select(ts, throt);
-- 
2.7.4

