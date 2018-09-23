Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ABAC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 03:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FC8214DC
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 03:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FC8214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbeIWJYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 05:24:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:35568 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeIWJYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 05:24:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Sep 2018 20:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,291,1534834800"; 
   d="scan'208";a="82567476"
Received: from chua-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.211.99])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2018 20:28:51 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1g3v4l-0004Xn-9H; Sun, 23 Sep 2018 11:28:51 +0800
Date:   Sun, 23 Sep 2018 11:28:51 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     trivial@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: fix comment typo in inc_tlb_flush_pending()
Message-ID: <20180923032851.2kakcz5x7sm5tfcd@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: trivial@kernel.org
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 include/linux/mm_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 27c5446f3deb..d4f99f5f677c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -552,7 +552,7 @@ static inline void inc_tlb_flush_pending(struct mm_struct *mm)
 	 *	flush_tlb_range();
 	 *	atomic_dec(&mm->tlb_flush_pending);
 	 *
-	 * Where the increment if constrained by the PTL unlock, it thus
+	 * Where the increment is constrained by the PTL unlock, it thus
 	 * ensures that the increment is visible if the PTE modification is
 	 * visible. After all, if there is no PTE modification, nobody cares
 	 * about TLB flushes either.
-- 
2.15.0

