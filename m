Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE93C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE102084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE102084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeLKPFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:05:17 -0500
Received: from 8bytes.org ([81.169.241.247]:53498 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbeLKPFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:05:17 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 42BF83AA; Tue, 11 Dec 2018 16:05:15 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jroedel@suse.de,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4 v2] Consolidate iommu_ops->add/remove_device() calls
Date:   Tue, 11 Dec 2018 16:05:09 +0100
Message-Id: <20181211150513.15161-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is the second version of the patch-set to wrap the
invocation of iommu_ops->add/remove_device() into functions.
The functions will do more setup stuff later when the the
iommu-related pointers in 'struct device' are consolidated.

Since version one this patch-set was rebased to v4.20-rc6
and I removed the pointer checks for the function pointers,
as suggested by Robin. I checked all 16 drivers and all of
them implement the add/remove_device call-backs.

Please review, if there are no objections I plan to queue
these patches in the IOMMU tree.

Thanks,

	Joerg

Joerg Roedel (4):
  iommu/sysfs: Rename iommu_release_device()
  iommu: Consolitate ->add/remove_device() calls
  iommu/of: Don't call iommu_ops->add_device directly
  ACPI/IORT: Don't call iommu_ops->add_device directly

 drivers/acpi/arm64/iort.c   |  4 +--
 drivers/iommu/iommu-sysfs.c | 12 ++++-----
 drivers/iommu/iommu.c       | 51 ++++++++++++++++++-------------------
 drivers/iommu/of_iommu.c    |  6 ++---
 include/linux/iommu.h       |  3 +++
 5 files changed, 39 insertions(+), 37 deletions(-)

-- 
2.17.1

