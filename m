Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967770AbeCALWQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:22:16 -0500
Received: from regular1.263xmail.com ([211.150.99.135]:50632 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967592AbeCALWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:22:14 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <095a3f675d7f5f1cab6893b881def490>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, Jeffy Chen <jeffy.chen@rock-chips.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/omap: Increase group ref in .device_group()
Date: Thu,  1 Mar 2018 19:22:08 +0800
Message-Id: <20180301112208.25284-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase group refcounting in omap_iommu_device_group().

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index e135ab830ebf..c33b7b104e72 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1536,7 +1536,7 @@ static struct iommu_group *omap_iommu_device_group(struct device *dev)
 	struct iommu_group *group = ERR_PTR(-EINVAL);
 
 	if (arch_data->iommu_dev)
-		group = arch_data->iommu_dev->group;
+		group = iommu_group_ref_get(arch_data->iommu_dev->group);
 
 	return group;
 }
-- 
2.11.0
