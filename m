Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE5AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4DF214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeLRGxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:53:30 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:58143 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbeLRGxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 01:53:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TG1j1yV_1545115948;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TG1j1yV_1545115948)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Dec 2018 14:52:35 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ying.huang@intel.com, tim.c.chen@intel.com, minchan@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] mm: swap: add comment for swap_vma_readahead
Date:   Tue, 18 Dec 2018 14:52:28 +0800
Message-Id: <1545115948-25467-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1545115948-25467-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1545115948-25467-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap_vma_readahead()'s comment is missed, just add it.

Cc: Huang Ying <ying.huang@intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/swap_state.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 7cc3c29..c12aedf 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -695,6 +695,23 @@ static void swap_ra_info(struct vm_fault *vmf,
 	pte_unmap(orig_pte);
 }
 
+/**
+ * swap_vm_readahead - swap in pages in hope we need them soon
+ * @entry: swap entry of this memory
+ * @gfp_mask: memory allocation flags
+ * @vmf: fault information
+ *
+ * Returns the struct page for entry and addr, after queueing swapin.
+ *
+ * Primitive swap readahead code. We simply read in a few pages whoes
+ * virtual addresses are around the fault address in the same vma.
+ *
+ * This has been extended to use the NUMA policies from the mm triggering
+ * the readahead.
+ *
+ * Caller must hold down_read on the vma->vm_mm if vmf->vma is not NULL.
+ *
+ */
 static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 				       struct vm_fault *vmf)
 {
-- 
1.8.3.1

