Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753004AbeDYMKI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:10:08 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:63420 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeDYMKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:10:01 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH v4 02/12] mmc: sdhci-omap: Remove setting ADMA capability in driver
Date: Wed, 25 Apr 2018 17:39:27 +0530
Message-ID: <20180425120937.29867-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425120937.29867-1-kishon@ti.com>
References: <20180425120937.29867-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdhci can directly get ADMA capability from MMCHS_CAPA register.
Remove explicitly setting ADMA here as some instances might not have
ADMA enabled. (sdhci_read_caps() is also removed from here since
sdhci_setup_host() invokes it).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/sdhci-omap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 9bb53702e0e5..6e2cf4cfeec0 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -923,9 +923,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	host->mmc_host_ops.card_busy = sdhci_omap_card_busy;
 	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
 
-	sdhci_read_caps(host);
-	host->caps |= SDHCI_CAN_DO_ADMA2;
-
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto err_put_sync;
-- 
2.17.0
