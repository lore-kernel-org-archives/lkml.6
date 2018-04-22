Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbeDVJPc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 05:15:32 -0400
Received: from sauhun.de ([88.99.104.3]:37602 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751654AbeDVJOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 05:14:20 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: dmaengine@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] dmaengine: idma64: simplify getting .drvdata
Date: Sun, 22 Apr 2018 11:14:12 +0200
Message-Id: <20180422091415.7587-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
References: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply to your tree directly.

 drivers/dma/idma64.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 1953e57505f4..e5c911200bdb 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -670,8 +670,7 @@ static int idma64_platform_remove(struct platform_device *pdev)
 
 static int idma64_pm_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct idma64_chip *chip = platform_get_drvdata(pdev);
+	struct idma64_chip *chip = dev_get_drvdata(dev);
 
 	idma64_off(chip->idma64);
 	return 0;
@@ -679,8 +678,7 @@ static int idma64_pm_suspend(struct device *dev)
 
 static int idma64_pm_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct idma64_chip *chip = platform_get_drvdata(pdev);
+	struct idma64_chip *chip = dev_get_drvdata(dev);
 
 	idma64_on(chip->idma64);
 	return 0;
-- 
2.11.0
