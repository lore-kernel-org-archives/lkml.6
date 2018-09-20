Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37708ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C1E2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C1E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbeITVyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:54:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48536 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeITVyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:54:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C708D80D;
        Thu, 20 Sep 2018 09:10:32 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F23CE3F557;
        Thu, 20 Sep 2018 09:10:30 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v8 0/7] Add non-strict mode support for iommu-dma
Date:   Thu, 20 Sep 2018 17:10:20 +0100
Message-Id: <cover.1537458163.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Hopefully this is the last spin of the series - I've now dropped my light
touch and fixed up all the various prose text, plus implemented the proper
quirk support for short-descriptor because it's actually just a trivial
cut-and-paste job.

Robin.


Robin Murphy (2):
  iommu/io-pgtable-arm-v7s: Add support for non-strict mode
  iommu/arm-smmu: Support non-strict mode

Zhen Lei (5):
  iommu/arm-smmu-v3: Implement flush_iotlb_all hook
  iommu/dma: Add support for non-strict mode
  iommu: Add "iommu.strict" command line option
  iommu/io-pgtable-arm: Add support for non-strict mode
  iommu/arm-smmu-v3: Add support for non-strict mode

 .../admin-guide/kernel-parameters.txt         | 12 +++
 drivers/iommu/arm-smmu-v3.c                   | 89 +++++++++++++-----
 drivers/iommu/arm-smmu.c                      | 93 +++++++++++++------
 drivers/iommu/dma-iommu.c                     | 32 ++++++-
 drivers/iommu/io-pgtable-arm-v7s.c            | 11 ++-
 drivers/iommu/io-pgtable-arm.c                | 14 ++-
 drivers/iommu/io-pgtable.h                    |  5 +
 drivers/iommu/iommu.c                         | 23 +++++
 include/linux/iommu.h                         |  1 +
 9 files changed, 225 insertions(+), 55 deletions(-)

-- 
2.19.0.dirty

