Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D99FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1771A216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1771A216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeI1L7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:59:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:42793 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeI1L7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:59:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 22:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,313,1534834800"; 
   d="scan'208";a="84109443"
Received: from ali-mobl7.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.213.57])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Sep 2018 22:36:43 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1g5lQH-0003qg-Mv; Fri, 28 Sep 2018 13:34:41 +0800
Date:   Fri, 28 Sep 2018 13:34:41 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     trivial@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [PATCH] mm: fix __get_user_pages_fast() comment
Message-ID: <20180928053441.rpzwafzlsnp74mkl@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmu_gather_tlb no longer exist. Replace with mmu_table_batch.

CC: trivial@kernel.org
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index fc5f98069f4e..69194043ddd4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1798,8 +1798,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	 * interrupts disabled by get_futex_key.
 	 *
 	 * With interrupts disabled, we block page table pages from being
-	 * freed from under us. See mmu_gather_tlb in asm-generic/tlb.h
-	 * for more details.
+	 * freed from under us. See struct mmu_table_batch comments in
+	 * include/asm-generic/tlb.h for more details.
 	 *
 	 * We do not adopt an rcu_read_lock(.) here as we also want to
 	 * block IPIs that come from THPs splitting.
-- 
2.15.0

