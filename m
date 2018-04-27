Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757947AbeD0LvI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:51:08 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:61726 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757437AbeD0Lrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:47:48 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <kishon@ti.com>
Subject: [PATCH v5 04/14] mmc: sdhci-omap: Invoke sdhci_get_of_property to read sdhci dt properties
Date: Fri, 27 Apr 2018 17:17:13 +0530
Message-ID: <20180427114723.2687-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427114723.2687-1-kishon@ti.com>
References: <20180427114723.2687-1-kishon@ti.com>
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
index b3dc7f1466e5..d5c1a9c71f95 100644
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
