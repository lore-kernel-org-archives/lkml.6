Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CF7C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2798206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2798206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeKUAj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:39:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49398 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbeKUAj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:39:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4204FEBD;
        Tue, 20 Nov 2018 06:10:09 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D59A13F5A0;
        Tue, 20 Nov 2018 06:10:07 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, konrad.wilk@oracle.com
Cc:     m.szyprowski@samsung.com, john.stultz@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] SWIOTLB fixes for 4.20
Date:   Tue, 20 Nov 2018 14:09:51 +0000
Message-Id: <cover.1542722463.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is what I have so far, which at least resolves the most ovbious
problems. I still haven't got very far with the USB corruption issue
I see on Juno with -rc1, but I'm yet to confirm whether that's actually
attributable to the SWIOTLB changes or something else entirely.

Robin.

Robin Murphy (2):
  swiotlb: Make DIRECT_MAPPING_ERROR viable
  swiotlb: Skip cache maintenance on map error

 include/linux/dma-direct.h | 2 +-
 kernel/dma/swiotlb.c       | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.19.1.dirty

