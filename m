Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B855C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20882086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20882086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeIKR1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:27:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51211 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeIKR1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:27:41 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fzhmT-0002P8-9f; Tue, 11 Sep 2018 12:28:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/fsl: fix spelling mistake pci_endpt_partioning -> pci_endpt_partitioning
Date:   Tue, 11 Sep 2018 13:28:32 +0100
Message-Id: <20180911122832.32383-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in variable name

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iommu/fsl_pamu_domain.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index f089136e9c3f..18970d38f698 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -916,13 +916,13 @@ static struct iommu_group *get_shared_pci_device_group(struct pci_dev *pdev)
 static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
 {
 	struct pci_controller *pci_ctl;
-	bool pci_endpt_partioning;
+	bool pci_endpt_partitioning;
 	struct iommu_group *group = NULL;
 
 	pci_ctl = pci_bus_to_host(pdev->bus);
-	pci_endpt_partioning = check_pci_ctl_endpt_part(pci_ctl);
+	pci_endpt_partitioning = check_pci_ctl_endpt_part(pci_ctl);
 	/* We can partition PCIe devices so assign device group to the device */
-	if (pci_endpt_partioning) {
+	if (pci_endpt_partitioning) {
 		group = pci_device_group(&pdev->dev);
 
 		/*
-- 
2.17.1

