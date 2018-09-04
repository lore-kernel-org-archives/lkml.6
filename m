Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8263C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750052086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750052086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeIDQKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:10:07 -0400
Received: from foss.arm.com ([217.140.101.70]:41344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbeIDQKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:10:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 944571684;
        Tue,  4 Sep 2018 04:45:20 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66C8C3F5BC;
        Tue,  4 Sep 2018 04:45:20 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id C0F8F1AE3654; Tue,  4 Sep 2018 12:45:33 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, npiggin@gmail.com, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        mhocko@suse.com, aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v2 5/5] MAINTAINERS: Add entry for MMU GATHER AND TLB INVALIDATION
Date:   Tue,  4 Sep 2018 12:45:33 +0100
Message-Id: <1536061533-16188-6-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1536061533-16188-1-git-send-email-will.deacon@arm.com>
References: <1536061533-16188-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently had to debug a TLB invalidation problem on the munmap()
path, which was made more difficult than necessary because:

  (a) The MMU gather code had changed without people realising
  (b) Many people subtly misunderstood the operation of the MMU gather
      code and its interactions with RCU and arch-specific TLB invalidation
  (c) Untangling the intended behaviour involved educated guesswork and
      plenty of discussion

Hopefully, we can avoid getting into this mess again by designating a
cross-arch group of people to look after this code. It is not intended
that they will have a separate tree, but they at least provide a point
of contact for anybody working in this area and can co-ordinate any
proposed future changes to the internal API.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052aeac39..e490a0a0605a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9681,6 +9681,18 @@ S:	Maintained
 F:	arch/arm/boot/dts/mmp*
 F:	arch/arm/mach-mmp/
 
+MMU GATHER AND TLB INVALIDATION
+M:	Will Deacon <will.deacon@arm.com>
+M:	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
+M:	Nick Piggin <npiggin@gmail.com>
+M:	Peter Zijlstra <peterz@infradead.org>
+L:	linux-arch@vger.kernel.org
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	arch/*/include/asm/tlb.h
+F:	include/asm-generic/tlb.h
+F:	mm/mmu_gather.c
+
 MN88472 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-- 
2.1.4

