Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbeBEMz0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:55:26 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:29249 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753015AbeBEMvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:51:35 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 07/16] mmc: sdhci_omap: Fix sdhci-omap quirks
Date: Mon, 5 Feb 2018 18:20:20 +0530
Message-ID: <20180205125029.21570-8-kishon@ti.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180205125029.21570-1-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SDHCI_QUIRK2_PRESET_VALUE_BROKEN quirk as setting preset values loads
incorrect CLKD values (for UHS modes).

Remove SDHCI_QUIRK2_NO_1_8_V quirk as sdhci-omap now supports UHS modes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 8b6170cd689b..d5a9e688dc1b 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -710,8 +710,8 @@ static const struct sdhci_pltfm_data sdhci_omap_pdata = {
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
-	.quirks2 = SDHCI_QUIRK2_NO_1_8_V |
-		   SDHCI_QUIRK2_ACMD23_BROKEN |
+	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN |
+		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 		   SDHCI_QUIRK2_RSP_136_HAS_CRC,
 	.ops = &sdhci_omap_ops,
 };
-- 
2.11.0
