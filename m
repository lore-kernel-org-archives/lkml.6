Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeERWEu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:04:50 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41094 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbeERWEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:04:15 -0400
X-Google-Smtp-Source: AB8JxZqEEcnqjin5FaAVSQ2Yikd0KepPGlLqID4IjIi4Ih6TUT4S7e298X/zAqnv08CQShN0cIeuQw==
From: Scott Branden <scott.branden@broadcom.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Corneliu Doban <corneliu.doban@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 3/3] mmc: sdhci-iproc: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for cygnus
Date: Fri, 18 May 2018 15:03:57 -0700
Message-Id: <1526681037-2074-4-git-send-email-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526681037-2074-1-git-send-email-scott.branden@broadcom.com>
References: <1526681037-2074-1-git-send-email-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corneliu Doban <corneliu.doban@broadcom.com>

The SDHCI_QUIRK2_HOST_OFF_CARD_ON is needed for the driver to
properly reset the host controller (reset all) on initialization
after exiting deep sleep.

Signed-off-by: Corneliu Doban <corneliu.doban@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/mmc/host/sdhci-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 1f0ab08..d0e83db 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -186,7 +186,7 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
 
 static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
-	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN | SDHCI_QUIRK2_HOST_OFF_CARD_ON,
 	.ops = &sdhci_iproc_32only_ops,
 };
 
-- 
2.5.0
