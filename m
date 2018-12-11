Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893EAC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAE52082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AAE52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeLKMTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:19:13 -0500
Received: from 8bytes.org ([81.169.241.247]:53078 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbeLKMTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:19:13 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 29686387; Tue, 11 Dec 2018 13:19:12 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/9 v2] Access dev->iommu_fwspec through functions
Date:   Tue, 11 Dec 2018 13:19:01 +0100
Message-Id: <20181211121910.5604-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is the second patch-set to wrap accesses to
dev->iommu_fwspec into functions so that the pointer
location can be changed more easily later on.

This version is rebased to v4.20-rc6 and addresses Robin's
comments. The Ack from will is also added.

If there are no objections I'd like to queue these patches
soon.

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

 drivers/acpi/arm64/iort.c    | 19 ++++++++++---------
 drivers/iommu/arm-smmu-v3.c  | 16 +++++++++-------
 drivers/iommu/arm-smmu.c     | 12 ++++++------
 drivers/iommu/dma-iommu.c    |  2 +-
 drivers/iommu/iommu.c        | 14 +++++++-------
 drivers/iommu/ipmmu-vmsa.c   | 12 ++++++++----
 drivers/iommu/mtk_iommu.c    | 21 ++++++++++++---------
 drivers/iommu/mtk_iommu_v1.c | 28 ++++++++++++++++------------
 drivers/iommu/of_iommu.c     | 10 +++++++---
 drivers/iommu/qcom_iommu.c   | 18 ++++++++++--------
 drivers/iommu/tegra-smmu.c   |  2 +-
 include/linux/iommu.h        | 11 +++++++++++
 12 files changed, 98 insertions(+), 67 deletions(-)

-- 
2.17.1

