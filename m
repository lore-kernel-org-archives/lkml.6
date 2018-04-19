Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753817AbeDSOK3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:10:29 -0400
Received: from sauhun.de ([88.99.104.3]:45270 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752640AbeDSOHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:13 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 54/61] uio: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:24 +0200
Message-Id: <20180419140641.27926-55-wsa+renesas@sang-engineering.com>
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

 drivers/uio/uio_fsl_elbc_gpcm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/uio/uio_fsl_elbc_gpcm.c b/drivers/uio/uio_fsl_elbc_gpcm.c
index b46323d9dc18..50b460c540f7 100644
--- a/drivers/uio/uio_fsl_elbc_gpcm.c
+++ b/drivers/uio/uio_fsl_elbc_gpcm.c
@@ -73,8 +73,7 @@ DEVICE_ATTR(reg_or, S_IRUGO|S_IWUSR|S_IWGRP, reg_show, reg_store);
 static ssize_t reg_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct uio_info *info = platform_get_drvdata(pdev);
+	struct uio_info *info = dev_get_drvdata(dev);
 	struct fsl_elbc_gpcm *priv = info->priv;
 	struct fsl_lbc_bank *bank = &priv->lbc->bank[priv->bank];
 
@@ -93,8 +92,7 @@ static ssize_t reg_show(struct device *dev, struct device_attribute *attr,
 static ssize_t reg_store(struct device *dev, struct device_attribute *attr,
 			 const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct uio_info *info = platform_get_drvdata(pdev);
+	struct uio_info *info = dev_get_drvdata(dev);
 	struct fsl_elbc_gpcm *priv = info->priv;
 	struct fsl_lbc_bank *bank = &priv->lbc->bank[priv->bank];
 	unsigned long val;
-- 
2.11.0
