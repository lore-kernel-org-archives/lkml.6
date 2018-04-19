Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753596AbeDSOV7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:21:59 -0400
Received: from sauhun.de ([88.99.104.3]:45270 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753384AbeDSOHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:00 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 24/61] iommu: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:05:54 +0200
Message-Id: <20180419140641.27926-25-wsa+renesas@sang-engineering.com>
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

 drivers/iommu/qcom_iommu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 65b9c99707f8..fe88a4880d3a 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -885,16 +885,14 @@ static int qcom_iommu_device_remove(struct platform_device *pdev)
 
 static int __maybe_unused qcom_iommu_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
+	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev);
 
 	return qcom_iommu_enable_clocks(qcom_iommu);
 }
 
 static int __maybe_unused qcom_iommu_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
+	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev);
 
 	qcom_iommu_disable_clocks(qcom_iommu);
 
-- 
2.11.0
