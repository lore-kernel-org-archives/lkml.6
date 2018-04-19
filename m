Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbeDSO0h (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:26:37 -0400
Received: from sauhun.de ([88.99.104.3]:45294 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753072AbeDSOGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:06:52 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org
Subject: [PATCH 08/61] dmaengine: dw: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:05:38 +0200
Message-Id: <20180419140641.27926-9-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/dma/dw/platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index bc31fe802061..f62dd0944908 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -293,8 +293,7 @@ MODULE_DEVICE_TABLE(acpi, dw_dma_acpi_id_table);
 
 static int dw_suspend_late(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct dw_dma_chip *chip = platform_get_drvdata(pdev);
+	struct dw_dma_chip *chip = dev_get_drvdata(dev);
 
 	dw_dma_disable(chip);
 	clk_disable_unprepare(chip->clk);
@@ -304,8 +303,7 @@ static int dw_suspend_late(struct device *dev)
 
 static int dw_resume_early(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct dw_dma_chip *chip = platform_get_drvdata(pdev);
+	struct dw_dma_chip *chip = dev_get_drvdata(dev);
 	int ret;
 
 	ret = clk_prepare_enable(chip->clk);
-- 
2.11.0
