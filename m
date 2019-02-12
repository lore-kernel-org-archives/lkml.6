Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF206C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FEE218AD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfBLCMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:12:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:26869 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfBLCMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:12:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 18:12:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="146057849"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2019 18:12:50 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.or,
        tglx@linutronix.de, Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 1/6] x86, mm: remove second argument of split_mem_range()
Date:   Tue, 12 Feb 2019 10:12:10 +0800
Message-Id: <20190212021215.13247-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190212021215.13247-1-richardw.yang@linux.intel.com>
References: <20190212021215.13247-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second argument is always zero.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 arch/x86/mm/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index ef99f3892e1f..1b980b70911a 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -330,13 +330,13 @@ static const char *page_size_string(struct map_range *mr)
 	return str_4k;
 }
 
-static int __meminit split_mem_range(struct map_range *mr, int nr_range,
+static int __meminit split_mem_range(struct map_range *mr,
 				     unsigned long start,
 				     unsigned long end)
 {
 	unsigned long start_pfn, end_pfn, limit_pfn;
 	unsigned long pfn;
-	int i;
+	int i, nr_range = 0;
 
 	limit_pfn = PFN_DOWN(end);
 
@@ -474,7 +474,7 @@ unsigned long __ref init_memory_mapping(unsigned long start,
 	       start, end - 1);
 
 	memset(mr, 0, sizeof(mr));
-	nr_range = split_mem_range(mr, 0, start, end);
+	nr_range = split_mem_range(mr, start, end);
 
 	for (i = 0; i < nr_range; i++)
 		ret = kernel_physical_mapping_init(mr[i].start, mr[i].end,
-- 
2.19.1

