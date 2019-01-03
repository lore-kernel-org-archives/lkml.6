Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21385C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50B020815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bHUKZAUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfACKN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:13:26 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1195 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730826AbfACKNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:13:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2de02c0000>; Thu, 03 Jan 2019 02:13:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Jan 2019 02:13:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 03 Jan 2019 02:13:20 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 3 Jan
 2019 10:13:20 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 3 Jan 2019 10:13:20 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c2de03e0003>; Thu, 03 Jan 2019 02:13:20 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v7 3/3] thermal: tegra: add get_trend ops
Date:   Thu, 3 Jan 2019 18:12:49 +0800
Message-ID: <1546510369-28491-4-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546510369-28491-1-git-send-email-wni@nvidia.com>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546510381; bh=CPv8clNO3ZkTySxTbU/rChZf1+SNxEeg9i6YGatXaZw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=bHUKZAUiOLwV8wL+3nha1uH5bprfPrPZsauoz6AKkxr3bYP/Sog6CKzA+mVILs/A0
         t4KE427Hxc82QXiFc3oRZF34tnabtK2X90Rnrjor1PzAnWa6ZiuTHBscHCBa4sp1Zx
         v+yRbwRbcR18tbJwkNCb77UKybQmkw/NbqBNl595ujCV6jWJqBKDqMdy5R0/9BQlG7
         Lgpjj55WLqH21ltdZenXDpV7ooN8xCwwmqaVCeELghBGHIVqN0fFxlpXlN9d/e1tEe
         nZSQ+gu/WC6ReSgpPPkUqhNys4FbRGN68q9iOXXARFoADxxfBccCWhoQEWWp1PibE/
         d3h7Ogk93veHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for get_trend ops that allows soctherm
sensors to be used with the step-wise governor.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index fd2703c0cfc5..864205af104b 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -488,9 +488,43 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
 	return 0;
 }
 
+static int tegra_thermctl_get_trend(void *data, int trip,
+				    enum thermal_trend *trend)
+{
+	struct tegra_thermctl_zone *zone = data;
+	struct thermal_zone_device *tz = zone->tz;
+	int trip_temp, temp, last_temp, ret;
+
+	if (!tz)
+		return -EINVAL;
+
+	ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
+	if (ret)
+		return ret;
+
+	mutex_lock(&tz->lock);
+	temp = tz->temperature;
+	last_temp = tz->last_temperature;
+	mutex_unlock(&tz->lock);
+
+	if (temp > trip_temp) {
+		if (temp >= last_temp)
+			*trend = THERMAL_TREND_RAISING;
+		else
+			*trend = THERMAL_TREND_STABLE;
+	} else if (temp < trip_temp) {
+		*trend = THERMAL_TREND_DROPPING;
+	} else {
+		*trend = THERMAL_TREND_STABLE;
+	}
+
+	return 0;
+}
+
 static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
 	.get_temp = tegra_thermctl_get_temp,
 	.set_trip_temp = tegra_thermctl_set_trip_temp,
+	.get_trend = tegra_thermctl_get_trend,
 };
 
 static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
-- 
2.7.4

