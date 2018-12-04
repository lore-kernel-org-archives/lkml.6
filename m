Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0C9C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A471A2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="c5auvi1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A471A2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLDS3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:29:03 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38911 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeLDS3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:29:03 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so14810921ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 10:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dE6xaf6/OWa8KouvVvcD78R7daQdpbpYxISf1TSUByU=;
        b=c5auvi1p85rJbzWnotwu6PN6EoIKsZCKJrOgpVIqpW7c+6H2VbW79rkG2An8G0wjRl
         tRFs0bd2E3vV1UDBjb5DdGF+2CGFKbdRkKU1gmcFBVDosafuWzoaFBhkmXBje9yMmftR
         Ppr1mIXCiv3F73JHrs9+8xeU7Bzgc1FTFuPEiD6YxTEV3K0z91tSrdZjq8wUFusVShcv
         FCQpsyb35PbScPbE6tMYACBhi8iBhx76FeZGVpe4dgSpJxWajRm0gT1pcW5ay+uoaFLT
         6qdczZhwIYLoAXuAH3EP8EzRVMUWgXq/IujyvHk2/QrjQZi2SY7C1Q4x1hUSNTx74xBN
         ubcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dE6xaf6/OWa8KouvVvcD78R7daQdpbpYxISf1TSUByU=;
        b=Jf4mNW3OOLYxzbSmRnX3i2Alol+yx2OCfd+SwVtgFbqz9Bn08bm1S87qETAkYXHqbu
         RVqW7bfhvPc3W8zAheQBmZFPEAwqeGM6/Ul4WUKk+QteXj/KKYvSP2ys7xD0CY3zsqt+
         LTkYGqJa23Gp2SAQKntRMTRzvY5j+aLwUKqRY8C2xVEr6Fx/IlG7ttmS/sZfSgjDz1k4
         QLAvHdyZjcgIDIPHLGFe49RInCuvRhcIb9LO4/eqbHxx1bD+S4x38EeyH98IklJpVv9q
         DeVueJRbPpqSXEjdjTN3yNfeFHHRKSz3Nj346BoG/U/MAPee03wYUN6Yn9+c9hAhMdqb
         fyHQ==
X-Gm-Message-State: AA+aEWaOsLZ7IXXsESwChhlTlmSHBUwY8uZHGtO8Hx8OlUlBEen4X/Dw
        GPCWqYMuQcelRJHr31XVs4mwxg==
X-Google-Smtp-Source: AFSGD/Uqy8Ae3kiFOluZpIPqn50tpIB/KFWvpGQ9fKzuRF9WlPTfRDKaSNFY/PlEgfR/Xq2yn3uLzg==
X-Received: by 2002:a50:abc5:: with SMTP id u63mr18618135edc.87.1543948141051;
        Tue, 04 Dec 2018 10:29:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:a0:bc00:11d1:2e6f:352b:514f])
        by smtp.gmail.com with ESMTPSA id e14sm4940939edb.79.2018.12.04.10.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 10:29:00 -0800 (PST)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     iommu@lists.linux-foundation.org
Cc:     tom <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typo. Change tlb_range_add to iotlb_range_add and tlb_sync to iotlb_sync
Date:   Tue,  4 Dec 2018 18:27:34 +0000
Message-Id: <20181204182734.20184-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tom <murphyt7@tcd.ie>

Someone forgot to update this comment.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 include/linux/iommu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a1d28f42cb77..11db18b9ffe8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -168,8 +168,8 @@ struct iommu_resv_region {
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
- * @tlb_range_add: Add a given iova range to the flush queue for this domain
- * @tlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
+ * @iotlb_range_add: Add a given iova range to the flush queue for this domain
+ * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
  * @iova_to_phys: translate iova to physical address
  * @add_device: add device to iommu grouping
-- 
2.11.0

