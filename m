Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFCAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18C5206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18C5206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeIDQKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:10:06 -0400
Received: from foss.arm.com ([217.140.101.70]:41262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbeIDQKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:10:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A84D980D;
        Tue,  4 Sep 2018 04:45:19 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 762E03F5BC;
        Tue,  4 Sep 2018 04:45:19 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7E1F61AE3546; Tue,  4 Sep 2018 12:45:33 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, npiggin@gmail.com, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        mhocko@suse.com, aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v2 0/5] Extend and consolidate mmu_gather into new file
Date:   Tue,  4 Sep 2018 12:45:28 +0100
Message-Id: <1536061533-16188-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series builds on the core changes I previously posted here:

  rfc:	http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/597821.html
  v1:	http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/598919.html

The main changes are:

  * Move the mmu_gather bits out of memory.c and into their own file
    (looped in the mm people for this)

  * Add a MAINTAINERS entry for the new file, and all tlb.h headers.
    If any mm developers would like to be included here as well, please
    just ask.

I'd like to queue these patches on their own branch in the arm64 git so
that others can develop on top of them for the next merge window. Peter
and Nick have both expressed an interest in that, and I already have a
bunch of arm64 optimisations on top which I posted previously.

Cheers,

Will

--->8

Peter Zijlstra (2):
  asm-generic/tlb: Track freeing of page-table directories in struct
    mmu_gather
  mm/memory: Move mmu_gather and TLB invalidation code into its own file

Will Deacon (3):
  asm-generic/tlb: Guard with #ifdef CONFIG_MMU
  asm-generic/tlb: Track which levels of the page tables have been
    cleared
  MAINTAINERS: Add entry for MMU GATHER AND TLB INVALIDATION

 MAINTAINERS               |  12 +++
 include/asm-generic/tlb.h |  86 ++++++++++++---
 mm/Makefile               |   6 +-
 mm/memory.c               | 247 -------------------------------------------
 mm/mmu_gather.c           | 259 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 348 insertions(+), 262 deletions(-)
 create mode 100644 mm/mmu_gather.c

-- 
2.1.4

