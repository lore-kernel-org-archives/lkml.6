Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BECC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59A12082F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59A12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeLDR0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:26:55 -0500
Received: from 8bytes.org ([81.169.241.247]:51546 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbeLDR0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:26:25 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C580D259; Tue,  4 Dec 2018 18:26:23 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/5] Introduce device_iommu_maped() function
Date:   Tue,  4 Dec 2018 18:24:59 +0100
Message-Id: <20181204172504.19708-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is a patch-set to replace the dev->iommu_group checks
in the source tree by a proper function call. The pointer
checks mostly happen to check whether a device is managed my
an IOMMU. For that purpose a pointer check is not very
descriptable, so replace it by a function call that make its
purpose readable.

This also starts to remove direct access to the
dev->iommu_group pointer outside of iommu-code. This is
another move towards consolidating the various
iommu-related pointers in 'struct device' into one pointer
only.

Please review.

Thanks,

	Joerg

Joerg Roedel (5):
  driver core: Introduce device_iommu_mapped() function
  iommu/of: Use device_iommu_mapped()
  ACPI/IORT: Use device_iommu_mapped()
  powerpc/iommu: Use device_iommu_mapped()
  xhci: Use device_iommu_mapped()

 arch/powerpc/kernel/eeh.c   |  2 +-
 arch/powerpc/kernel/iommu.c |  6 +++---
 drivers/acpi/arm64/iort.c   |  2 +-
 drivers/iommu/of_iommu.c    |  2 +-
 drivers/usb/host/xhci.c     |  2 +-
 include/linux/device.h      | 10 ++++++++++
 6 files changed, 17 insertions(+), 7 deletions(-)

-- 
2.17.1

