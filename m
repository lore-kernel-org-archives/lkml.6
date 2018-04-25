Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753848AbeDYMNK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:13:10 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:63432 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbeDYMKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:10:06 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH v4 04/12] mmc: sdhci-omap: Invoke sdhci_get_of_property to read sdhci dt properties
Date: Wed, 25 Apr 2018 17:39:29 +0530
Message-ID: <20180425120937.29867-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425120937.29867-1-kishon@ti.com>
References: <20180425120937.29867-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invoke sdhci_get_of_property defined in sdhci-pltfm.c to read
sdhci specific properties from dt node.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/sdhci-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index b4400be0606f..2d9ea23610d5 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -893,6 +893,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	host->ioaddr += offset;
 
 	mmc = host->mmc;
+	sdhci_get_of_property(pdev);
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		goto err_pltfm_free;
-- 
2.17.0
