Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1234C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D12B20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D12B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeIDHWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:22:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbeIDHWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:22:25 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DC26076D4B5E;
        Tue,  4 Sep 2018 10:59:23 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Tue, 4 Sep 2018
 10:59:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] mmc: tegra: fix inconsistent IS_ERR and PTR_ERR
Date:   Tue, 4 Sep 2018 10:59:09 +0800
Message-ID: <20180904025909.13700-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in tegra_sdhci_init_pinctrl_info,
the proper pointer to be passed as argument is 'pinctrl_state_1v8'

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index e80716c..c789158 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -724,7 +724,7 @@ static int tegra_sdhci_init_pinctrl_info(struct device *dev,
 		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-1v8");
 	if (IS_ERR(tegra_host->pinctrl_state_1v8)) {
 		dev_warn(dev, "Missing 1.8V pad state, err: %ld\n",
-			 PTR_ERR(tegra_host->pinctrl_state_3v3));
+			 PTR_ERR(tegra_host->pinctrl_state_1v8));
 		return -1;
 	}
 
-- 
2.7.0


