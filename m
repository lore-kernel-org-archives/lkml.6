Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeEDJVK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:21:10 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:59489 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbeEDJVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:21:08 -0400
Date: Fri, 4 May 2018 12:20:53 +0300
From: Aapo Vienamo <aapo.vienamo@iki.fi>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: tegra: remove redundant return statement
Message-ID: <20180504092053.GA20277@orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 2001:708:30:1450:fc8b:6ffb:95c6:39ee
X-SA-Exim-Mail-From: aapo.vienamo@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A redundant return statement is removed from
tegra_sdhci_set_uhs_signaling(). The function returns void and the
return does not affect the control flow of the function.

Signed-off-by: Aapo Vienamo <aapo.vienamo@iki.fi>
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index b877c13184c2..970d38f68939 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -231,7 +231,7 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 	if (timing == MMC_TIMING_UHS_DDR50)
 		tegra_host->ddr_signaling = true;
 
-	return sdhci_set_uhs_signaling(host, timing);
+	sdhci_set_uhs_signaling(host, timing);
 }
 
 static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
-- 
2.16.1
