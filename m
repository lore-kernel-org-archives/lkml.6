Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCFDC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7F220815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OekfIzak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfACKNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:13:19 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19160 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfACKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:13:17 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2de0310004>; Thu, 03 Jan 2019 02:13:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Jan 2019 02:13:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 03 Jan 2019 02:13:16 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 3 Jan
 2019 10:13:16 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 3 Jan
 2019 10:13:15 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 3 Jan 2019 10:13:16 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c2de0390006>; Thu, 03 Jan 2019 02:13:15 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v7 1/3] thermal: tegra: remove unnecessary warnings
Date:   Thu, 3 Jan 2019 18:12:47 +0800
Message-ID: <1546510369-28491-2-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546510369-28491-1-git-send-email-wni@nvidia.com>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546510385; bh=CIAOn2sEPPbyAd05vU8yMm8rjqYHhrJH/s8j68mzeFE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=OekfIzakgA/ijRqRBV/Lj0/DHBOm4xc7BaPwgaTE8MY1q6ECqEilEGJ6u88t/Hgyj
         UbYXnIquoJAKUhdokT9V3Qq23TeORVXAHsEqtFzbDhlYzSNuyE5zIiBwOf4rZruh4R
         jeDge8ChoFszh9cBYVFw+VL7BODBCvd9AoAfhFLr5fJs/dKZfJnc04q0/5bm8AomQQ
         ipnXWST3MJU+SVuZLGAoYGZJdOxnIYF+hxOYwea2Ucyen0ETFY2svl5ONmvWp764IZ
         DsBwP/3T+n5pMXAwauCUMKoSkk53p1c9s6ylHOq5yU1cnCGHX9k5y3VgyBx4crhjnk
         ltBXbiyknNKMQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert warnings to info as not all platforms may
have all the thresholds and sensors enabled.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ed28110a3535..f07de8258e93 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -569,7 +569,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 set_throttle:
 	ret = get_hot_temp(tz, &trip, &temperature);
 	if (ret) {
-		dev_warn(dev, "throttrip: %s: missing hot temperature\n",
+		dev_info(dev, "throttrip: %s: missing hot temperature\n",
 			 sg->name);
 		return 0;
 	}
@@ -600,7 +600,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 	}
 
 	if (i == THROTTLE_SIZE)
-		dev_warn(dev, "throttrip: %s: missing throttle cdev\n",
+		dev_info(dev, "throttrip: %s: missing throttle cdev\n",
 			 sg->name);
 
 	return 0;
-- 
2.7.4

