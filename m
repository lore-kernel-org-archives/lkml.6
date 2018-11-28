Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1836AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D602E20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Bmj4kX20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D602E20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeK1QpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:45:10 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12465 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeK1QpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:45:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bfe2b240000>; Tue, 27 Nov 2018 21:44:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 27 Nov 2018 21:44:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 27 Nov 2018 21:44:43 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 28 Nov
 2018 05:44:43 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Nov 2018 05:44:43 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bfe2b490000>; Tue, 27 Nov 2018 21:44:42 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v3 1/3] thermal: tegra: remove unnecessary warnings
Date:   Wed, 28 Nov 2018 13:44:35 +0800
Message-ID: <1543383877-20555-2-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543383877-20555-1-git-send-email-wni@nvidia.com>
References: <1543383877-20555-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543383844; bh=tiSPTxwuKbullojPR6io265Sk3vNB/HOZVXyZXeLi6c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Bmj4kX201rBZp/BWZNZMV6yKqhIecXXrBSJpho6Al5lMeUhJ/TfHXKGCPz0mlPrKD
         H85xarxdpFVoG0ONbE4+iDTMO1IZv2k6AdjXxguvbKZ7QWTCmmmsg/cPE6rfL7okLP
         wAdgTYaJ4HdvvQYjfHTTuTi/P/A08ss8yqRKhyaIn5kovOoGTGwG1qqVcKaC51CVJP
         4wYq6Qyg2qePlGK0jT4tEtlCaFoYSJJZHaSFymAzgs7oyBCMeYxizUBEBc6HPoGAA9
         hy7yY26XFU9gjdJytFpRTmtN/YztUMTuZegH/wbsSTjMzR8Lw2Kjw6BRvT5vhb8POZ
         ppaNGn4+r28VA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert warnings to info as not all platforms may
have all the thresholds and sensors enabled.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ed28110a3535..55cc1f2f6a45 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -550,7 +550,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 
 	ret = tz->ops->get_crit_temp(tz, &temperature);
 	if (ret) {
-		dev_warn(dev, "thermtrip: %s: missing critical temperature\n",
+		dev_info(dev, "thermtrip: %s: missing critical temperature\n",
 			 sg->name);
 		goto set_throttle;
 	}
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

