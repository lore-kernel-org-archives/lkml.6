Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18899C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94706216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94706216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeI1Egx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:36:53 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:52307 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbeI1Egx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:36:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0T9b-h7p_1538086549;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T9b-h7p_1538086549)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Sep 2018 06:15:55 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     dan.j.williams@intel.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH] mm: dax: add comment for PFN_SPECIAL
Date:   Fri, 28 Sep 2018 06:15:49 +0800
Message-Id: <1538086549-100536-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment for PFN_SPECIAL is missed in pfn_t.h. Add comment to get
consistent with other pfn flags.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v2: rephrase the comment per Dan

 include/linux/pfn_t.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 21713dc..d6cc4b5 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -9,6 +9,8 @@
  * PFN_SG_LAST - pfn references a page and is the last scatterlist entry
  * PFN_DEV - pfn is not covered by system memmap by default
  * PFN_MAP - pfn has a dynamic page mapping established by a device driver
+ * PFN_SPECIAL - for CONFIG_FS_DAX_LIMITED builds to allow XIP, but not
+ *		 get_user_pages 
  */
 #define PFN_FLAGS_MASK (((u64) ~PAGE_MASK) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
 #define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
-- 
1.8.3.1

