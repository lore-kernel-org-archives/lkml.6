Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9623C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B7920850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B7920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeLEOg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:36:56 -0500
Received: from 8bytes.org ([81.169.241.247]:51846 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeLEOgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:36:54 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9F125141; Wed,  5 Dec 2018 15:36:52 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 1/4] iommu/sysfs: Rename iommu_release_device()
Date:   Wed,  5 Dec 2018 15:36:43 +0100
Message-Id: <20181205143646.4876-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205143646.4876-1-joro@8bytes.org>
References: <20181205143646.4876-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Remove the iommu_ prefix from the function and a few other
static data structures so that the iommu_release_device name
can be re-used in iommu core code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu-sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index 36d1a7ce7fc4..71c2249d3260 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -22,25 +22,25 @@ static struct attribute *devices_attr[] = {
 	NULL,
 };
 
-static const struct attribute_group iommu_devices_attr_group = {
+static const struct attribute_group devices_attr_group = {
 	.name = "devices",
 	.attrs = devices_attr,
 };
 
-static const struct attribute_group *iommu_dev_groups[] = {
-	&iommu_devices_attr_group,
+static const struct attribute_group *dev_groups[] = {
+	&devices_attr_group,
 	NULL,
 };
 
-static void iommu_release_device(struct device *dev)
+static void release_device(struct device *dev)
 {
 	kfree(dev);
 }
 
 static struct class iommu_class = {
 	.name = "iommu",
-	.dev_release = iommu_release_device,
-	.dev_groups = iommu_dev_groups,
+	.dev_release = release_device,
+	.dev_groups = dev_groups,
 };
 
 static int __init iommu_dev_init(void)
-- 
2.17.1

