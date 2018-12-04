Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304D5C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020EA206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020EA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeLDQaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:30:06 -0500
Received: from 8bytes.org ([81.169.241.247]:51458 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeLDQaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:30:06 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9C016259; Tue,  4 Dec 2018 17:30:04 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/9] Access dev->iommu_fwspec through functions
Date:   Tue,  4 Dec 2018 17:29:53 +0100
Message-Id: <20181204163002.15800-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is a patch-set to wrap accesses to dev->iommu_fwspec
into functions. This will make it easier to move the pointer
into a separate struct and consolitdate the iommu-related
pointers in 'struct device'.

Regards,

	Joerg

Joerg Roedel (9):
  iommu: Introduce wrappers around dev->iommu_fwspec
  ACPI/IORT: Use helper functions to access dev->iommu_fwspec
  iommu/arm-smmu: Use helper functions to access dev->iommu_fwspec
  iommu/dma: Use helper functions to access dev->iommu_fwspec
  iommu/ipmmu-vmsa: Use helper functions to access dev->iommu_fwspec
  iommu/mediatek: Use helper functions to access dev->iommu_fwspec
  iommu/of: Use helper functions to access dev->iommu_fwspec
  iommu/qcom: Use helper functions to access dev->iommu_fwspec
  iommu/tegra: Use helper functions to access dev->iommu_fwspec

 drivers/acpi/arm64/iort.c    | 12 +++++++-----
 drivers/iommu/arm-smmu-v3.c  | 16 +++++++++-------
 drivers/iommu/arm-smmu.c     | 12 ++++++------
 drivers/iommu/dma-iommu.c    |  2 +-
 drivers/iommu/iommu.c        | 14 +++++++-------
 drivers/iommu/ipmmu-vmsa.c   | 12 ++++++++----
 drivers/iommu/mtk_iommu.c    | 21 ++++++++++++---------
 drivers/iommu/mtk_iommu_v1.c | 28 ++++++++++++++++------------
 drivers/iommu/of_iommu.c     |  7 +++++--
 drivers/iommu/qcom_iommu.c   | 18 ++++++++++--------
 drivers/iommu/tegra-smmu.c   |  2 +-
 include/linux/iommu.h        | 11 +++++++++++
 12 files changed, 93 insertions(+), 62 deletions(-)

-- 
2.17.1

