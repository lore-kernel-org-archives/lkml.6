Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61839C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3634720850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3634720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeLCR2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:28:31 -0500
Received: from foss.arm.com ([217.140.101.70]:42858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbeLCR2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:28:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 466371682;
        Mon,  3 Dec 2018 09:28:26 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DAC373F59C;
        Mon,  3 Dec 2018 09:28:24 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
Subject: [PATCH 0/4] dma-debug: implement dynamic entry allocation
Date:   Mon,  3 Dec 2018 17:28:05 +0000
Message-Id: <cover.1543856576.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HNS_ENET discussion got me thinking, why not just make DMA debug
cleverer so that (in terms of basic functionality at least) we don't
need to worry about driver- or arch-specific configuration at all?

Patches #2 and #3 are the real meat here - #1 is just some preparatory
cleanup motivated by moving printks around, and could be split out if
desired; I kept #4 separate as a possible nice-to-have depending on
what people think.

Robin.


Robin Murphy (4):
  dma-debug: Use pr_fmt()
  dma-debug: Refactor dma_debug_entry allocation
  dma-debug: Dynamically expand the dma_debug_entry pool
  dma-debug: Make leak-like behaviour apparent

 kernel/dma/debug.c | 198 ++++++++++++++++++++++++---------------------
 1 file changed, 105 insertions(+), 93 deletions(-)

-- 
2.19.1.dirty

