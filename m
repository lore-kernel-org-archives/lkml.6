Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753438AbeDYMKj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:10:39 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:63466 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbeDYMK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:10:29 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH v4 11/12] mmc: sdhci-omap: Add support for MMC/SD controller in k2g SoC
Date: Wed, 25 Apr 2018 17:39:36 +0530
Message-ID: <20180425120937.29867-12-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425120937.29867-1-kishon@ti.com>
References: <20180425120937.29867-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the new compatible added specifically to support
k2g's MMC/SD controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/sdhci-omap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index b2c54940d032..c1a19e8d0a08 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -720,6 +720,10 @@ static const struct sdhci_pltfm_data sdhci_omap_pdata = {
 	.ops = &sdhci_omap_ops,
 };
 
+static const struct sdhci_omap_data k2g_data = {
+	.offset = 0x200,
+};
+
 static const struct sdhci_omap_data dra7_data = {
 	.offset = 0x200,
 	.flags	= SDHCI_OMAP_REQUIRE_IODELAY,
@@ -727,6 +731,7 @@ static const struct sdhci_omap_data dra7_data = {
 
 static const struct of_device_id omap_sdhci_match[] = {
 	{ .compatible = "ti,dra7-sdhci", .data = &dra7_data },
+	{ .compatible = "ti,k2g-sdhci", .data = &k2g_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_sdhci_match);
-- 
2.17.0
