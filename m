Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77427C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C0620850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C0620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeLEOgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:36:54 -0500
Received: from 8bytes.org ([81.169.241.247]:51836 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbeLEOgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:36:53 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 975DF345; Wed,  5 Dec 2018 15:36:52 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/4] Consolitate iommu_ops->add/remove_device() calls
Date:   Wed,  5 Dec 2018 15:36:42 +0100
Message-Id: <20181205143646.4876-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch-set consolidates the calls to iommu_ops->add_device()
and remove_device() and the necessary checks into
probe/release functions that be extended later with more
setup work.

Regards,

       Joerg

Joerg Roedel (4):
  iommu/sysfs: Rename iommu_release_device()
  iommu: Consolitate ->add/remove_device() calls
  iommu/of: Don't call iommu_ops->add_device directly
  ACPI/IORT: Don't call iommu_ops->add_device directly

 drivers/acpi/arm64/iort.c   |  4 +--
 drivers/iommu/iommu-sysfs.c | 12 ++++-----
 drivers/iommu/iommu.c       | 54 +++++++++++++++++++------------------
 drivers/iommu/of_iommu.c    |  6 ++---
 include/linux/iommu.h       |  3 +++
 5 files changed, 42 insertions(+), 37 deletions(-)

-- 
2.17.1

