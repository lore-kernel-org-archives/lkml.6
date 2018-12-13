Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1A6C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621F620851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lrmIRYgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621F620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeLMUZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:25:47 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3245 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeLMUZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:25:46 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c12c0460000>; Thu, 13 Dec 2018 12:25:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Dec 2018 12:25:46 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 12:25:46 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 20:25:45 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 20:25:45 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 20:25:45 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c12c0490001>; Thu, 13 Dec 2018 12:25:45 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Sowjanya Komatineni" <skomatineni@nvidia.com>
Subject: [PATCH V1] mmc: tegra: Fix for SDMMC pads autocal parsing from dt
Date:   Thu, 13 Dec 2018 12:25:43 -0800
Message-ID: <1544732743-11106-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544732742; bh=OGVDjxK1VPqVz2Zi0Vx9gL4WcwlKPIZ1+Hl94WpM9Eg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=lrmIRYgAdSWXnwuIWWZ/rpDXNbM8OcdFjLXbtVRFBBLmMJWyESgxzHBtvBB2JYsJR
         bmj11RXN/88S3SRLPFoLK4XyWIiydcwl7Qj3sRoG3JDwr6+NOuF6Qfjue4JybvxcqZ
         u656JNDt96HSN6jzlm2L8B4YMnn0v1/GdkYKe0iHBCHEVYe9iyQKT5Xcbfx858kV65
         BC2tZ1oDlfsXjD403YfC5cInfN40vvpHHfMM9mBVs8Icjz2BzLyUIoL002eRMuxHet
         GDiNHM48GfAwYjcbVx4p08yCPf0XHTmm6KUVuTVjvTodsLIuyqdoxx7VEJrZ5bihFf
         QDD5V+gkyTAhg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the SDMMC pads auto calibration values parsed from
devicetree are assigned incorrectly. This patch fixes it.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 7b95d088fdef..e6ace31e2a41 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -510,25 +510,25 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
 
 	err = device_property_read_u32(host->mmc->parent,
 			"nvidia,pad-autocal-pull-up-offset-3v3-timeout",
-			&autocal->pull_up_3v3);
+			&autocal->pull_up_3v3_timeout);
 	if (err)
 		autocal->pull_up_3v3_timeout = 0;
 
 	err = device_property_read_u32(host->mmc->parent,
 			"nvidia,pad-autocal-pull-down-offset-3v3-timeout",
-			&autocal->pull_down_3v3);
+			&autocal->pull_down_3v3_timeout);
 	if (err)
 		autocal->pull_down_3v3_timeout = 0;
 
 	err = device_property_read_u32(host->mmc->parent,
 			"nvidia,pad-autocal-pull-up-offset-1v8-timeout",
-			&autocal->pull_up_1v8);
+			&autocal->pull_up_1v8_timeout);
 	if (err)
 		autocal->pull_up_1v8_timeout = 0;
 
 	err = device_property_read_u32(host->mmc->parent,
 			"nvidia,pad-autocal-pull-down-offset-1v8-timeout",
-			&autocal->pull_down_1v8);
+			&autocal->pull_down_1v8_timeout);
 	if (err)
 		autocal->pull_down_1v8_timeout = 0;
 
-- 
2.7.4

