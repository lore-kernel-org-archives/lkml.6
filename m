Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC82CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A096E2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A096E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbeKVCf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:35:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53608 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730072AbeKVCf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:35:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 713D9331A;
        Wed, 21 Nov 2018 08:00:56 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E21F83F5CF;
        Wed, 21 Nov 2018 08:00:54 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, konrad.wilk@oracle.com
Cc:     m.szyprowski@samsung.com, john.stultz@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sstabellini@kernel.org
Subject: [PATCH v2 0/2] SWIOTLB fixes for 4.20
Date:   Wed, 21 Nov 2018 16:00:49 +0000
Message-Id: <cover.1542812807.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a quick v2 addressing Christoph's nits and collecting the tags
given so far. I've reproduced my USB problem with a commit prior to the
dma-mapping pull, so it looks like the cache maintenance changes are off
the hook for that one (and I'll have to venture into USB/UAS territory).

No objection from me if Konrad wants to pick this up instead depending
on timing.

Robin.


Robin Murphy (2):
  dma-direct: Make DIRECT_MAPPING_ERROR viable for SWIOTLB
  swiotlb: Skip cache maintenance on map error

 include/linux/dma-direct.h | 2 +-
 kernel/dma/swiotlb.c       | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.19.1.dirty

