Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E714C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3378D21708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3378D21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeI1B6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:58:15 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49278 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727622AbeI1B6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:58:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0T9aYYqz_1538077089;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T9aYYqz_1538077089)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Sep 2018 03:38:15 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     dan.j.williams@intel.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: dax: add comment for PFN_SPECIAL
Date:   Fri, 28 Sep 2018 03:38:09 +0800
Message-Id: <1538077089-14550-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment for PFN_SPECIAL is missed in pfn_t.h. Add comment to get
consistent with other pfn flags.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/pfn_t.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 21713dc..d2e5dd4 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -9,6 +9,7 @@
  * PFN_SG_LAST - pfn references a page and is the last scatterlist entry
  * PFN_DEV - pfn is not covered by system memmap by default
  * PFN_MAP - pfn has a dynamic page mapping established by a device driver
+ * PFN_SPECIAL - indicates that _PAGE_SPECIAL should be used for DAX ptes
  */
 #define PFN_FLAGS_MASK (((u64) ~PAGE_MASK) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
 #define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
-- 
1.8.3.1

