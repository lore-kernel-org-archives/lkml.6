Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B572C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220302147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfBTNBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:01:00 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:57810 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfBTNA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:00:58 -0500
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id f10v1z00e3XaVaC0610vqP; Wed, 20 Feb 2019 14:00:55 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gwRUd-0001TM-Mz; Wed, 20 Feb 2019 14:00:55 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gwRUd-0000Dh-Ku; Wed, 20 Feb 2019 14:00:55 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, Baoquan He <bhe@redhat.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] iommu: Fix kerneldoc for iommu_ops.flush_iotlb_all()
Date:   Wed, 20 Feb 2019 14:00:51 +0100
Message-Id: <20190220130053.784-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220130053.784-1-geert+renesas@glider.be>
References: <20190220130053.784-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the API wrapper is called iommu_flush_tlb_all(), the actual
iommu_ops method is called .flush_iotlb_all(), not .flush_tlb_all().

Fixes: add02cfdc9bc2987 ("iommu: Introduce Interface for IOMMU TLB Flushing")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 477ef47c357c0553..848fb07026b67169 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -167,7 +167,7 @@ struct iommu_resv_region {
  * @detach_dev: detach device from an iommu domain
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
- * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
+ * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
  * @iotlb_range_add: Add a given iova range to the flush queue for this domain
  * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
-- 
2.17.1

