Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeERWES (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:04:18 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46085 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeERWEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:04:11 -0400
X-Google-Smtp-Source: AB8JxZq7UjySbRguPOrmOjlmA+D4KM3NmAJt2zZyJDSRkYmy1ZG1fGQjr0yM3uQ+lUWR59RDX1Ge+Q==
From: Scott Branden <scott.branden@broadcom.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 1/3] mmc: sdhci-iproc: remove hard coded mmc cap 1.8v
Date: Fri, 18 May 2018 15:03:55 -0700
Message-Id: <1526681037-2074-2-git-send-email-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526681037-2074-1-git-send-email-scott.branden@broadcom.com>
References: <1526681037-2074-1-git-send-email-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinath Mannam <srinath.mannam@broadcom.com>

Remove hard coded mmc cap 1.8v from platform data as it is board specific.
The 1.8v DDR mmc caps can be enabled using DTS property for those
boards that support it.

Fixes: b17b4ab8ce38 ("mmc: sdhci-iproc: define MMC caps in platform data")
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/mmc/host/sdhci-iproc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 0ef741b..6f430da 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -206,7 +206,6 @@ static const struct sdhci_iproc_data iproc_data = {
 	.caps1 = SDHCI_DRIVER_TYPE_C |
 		 SDHCI_DRIVER_TYPE_D |
 		 SDHCI_SUPPORT_DDR50,
-	.mmc_caps = MMC_CAP_1_8V_DDR,
 };
 
 static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
-- 
2.5.0
