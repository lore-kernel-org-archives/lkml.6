Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753604AbeDSOOR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:14:17 -0400
Received: from sauhun.de ([88.99.104.3]:45270 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753524AbeDSOHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:08 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 42/61] ptp: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:12 +0200
Message-Id: <20180419140641.27926-43-wsa+renesas@sang-engineering.com>
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

 drivers/ptp/ptp_dte.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_dte.c b/drivers/ptp/ptp_dte.c
index 6edd3b9c7f01..5481a27d4fec 100644
--- a/drivers/ptp/ptp_dte.c
+++ b/drivers/ptp/ptp_dte.c
@@ -287,8 +287,7 @@ static int ptp_dte_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int ptp_dte_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ptp_dte *ptp_dte = platform_get_drvdata(pdev);
+	struct ptp_dte *ptp_dte = dev_get_drvdata(dev);
 	u8 i;
 
 	for (i = 0; i < DTE_NUM_REGS_TO_RESTORE; i++) {
@@ -304,8 +303,7 @@ static int ptp_dte_suspend(struct device *dev)
 
 static int ptp_dte_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ptp_dte *ptp_dte = platform_get_drvdata(pdev);
+	struct ptp_dte *ptp_dte = dev_get_drvdata(dev);
 	u8 i;
 
 	for (i = 0; i < DTE_NUM_REGS_TO_RESTORE; i++) {
-- 
2.11.0
