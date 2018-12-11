Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A7EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557E82054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557E82054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeLKNnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:43:49 -0500
Received: from 8bytes.org ([81.169.241.247]:53202 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeLKNns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:43:48 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9D00E284; Tue, 11 Dec 2018 14:43:46 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>, oohall@gmail.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        jroedel@suse.de, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 0/6 v2] Introduce device_iommu_mapped() function
Date:   Tue, 11 Dec 2018 14:43:37 +0100
Message-Id: <20181211134343.10664-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is the second version of this patch-set. It replaces
the various (dev->iommu_group) checks with a function call
which better expresses their intend.

Changes to the first version are the added patch for
rcar-dmac, a driver I missed before. I also added all
Acked-By's I received on the first version.

Please review and provide Acks, if there are no objections.
I have some iommu patches that depend on these, so I'd like
to carry this patch-set in the IOMMU tree.

Regards,

	Joerg

Joerg Roedel (6):
  driver core: Introduce device_iommu_mapped() function
  iommu/of: Use device_iommu_mapped()
  ACPI/IORT: Use device_iommu_mapped()
  powerpc/iommu: Use device_iommu_mapped()
  xhci: Use device_iommu_mapped()
  dmaengine: sh: rcar-dmac: Use device_iommu_mapped()

 arch/powerpc/kernel/eeh.c   |  2 +-
 arch/powerpc/kernel/iommu.c |  6 +++---
 drivers/acpi/arm64/iort.c   |  2 +-
 drivers/dma/sh/rcar-dmac.c  |  2 +-
 drivers/iommu/of_iommu.c    |  2 +-
 drivers/usb/host/xhci.c     |  2 +-
 include/linux/device.h      | 10 ++++++++++
 7 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.17.1

