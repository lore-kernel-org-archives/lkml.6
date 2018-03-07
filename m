Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933491AbeCGNYE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:24:04 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:46448 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753901AbeCGNVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:21:16 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, <kishon@ti.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 02/11] mmc: sdhci-omap: Remove setting ADMA capability in driver
Date: Wed, 7 Mar 2018 18:50:11 +0530
Message-ID: <20180307132020.30951-3-kishon@ti.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180307132020.30951-1-kishon@ti.com>
References: <20180307132020.30951-1-kishon@ti.com>
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
---
 drivers/mmc/host/sdhci-omap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 3cce30584d2f..0c40b13fb67d 100644
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
2.11.0
