Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PZ/INFaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0789460555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932375AbeFFSov (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:44:51 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34499 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932137AbeFFSot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:44:49 -0400
X-Google-Smtp-Source: ADUXVKJfRUYGkUT6h8XWzrZp2GhI0NcopCFpuBSWN9Pkf1n7HHol+Sinle3759SQwVXmEUqq4fDUYg==
From: Corentin Labbe <clabbe@baylibre.com>
To: ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] mmc: dw_mmc should depend on COMMON_CLK
Date: Wed,  6 Jun 2018 18:43:32 +0000
Message-Id: <1528310612-10158-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the following build failure on m68k:
ERROR: "clk_set_rate" [drivers/mmc/host/dw_mmc.ko] undefined!

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0581c199c996..77d6ba090436 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -666,7 +666,7 @@ config MMC_CAVIUM_THUNDERX
 
 config MMC_DW
 	tristate "Synopsys DesignWare Memory Card Interface"
-	depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
+	depends on COMMON_CLK && (ARC || ARM || ARM64 || MIPS || COMPILE_TEST)
 	help
 	  This selects support for the Synopsys DesignWare Mobile Storage IP
 	  block, this provides host support for SD and MMC interfaces, in both
-- 
2.16.4
