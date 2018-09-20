Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAA0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444872147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444872147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbeIUBsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:48:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:62935 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387773AbeIUBsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:48:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 13:02:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="264386347"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2018 13:02:03 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 0/7] mm: faster get user pages
Date:   Thu, 20 Sep 2018 14:03:51 -0600
Message-Id: <20180920200358.31680-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:

  Fixed shift size for following huge PMD on powerpc

  Updated change log with addition justification details

Keith Busch (7):
  mm/gup_benchmark: Time put_page
  mm/gup_benchmark: Add additional pinning methods
  tools/gup_benchmark: Fix 'write' flag usage
  tools/gup_benchmark: Allow user specified file
  tools/gup_benchmark: Add parameter for hugetlb
  mm/gup: Combine parameters into struct
  mm/gup: Cache dev_pagemap while pinning pages

 include/linux/huge_mm.h                    |  12 +-
 include/linux/hugetlb.h                    |   2 +-
 include/linux/mm.h                         |  27 ++-
 mm/gup.c                                   | 279 ++++++++++++++---------------
 mm/gup_benchmark.c                         |  36 +++-
 mm/huge_memory.c                           |  67 ++++---
 mm/nommu.c                                 |   6 +-
 tools/testing/selftests/vm/gup_benchmark.c |  40 ++++-
 8 files changed, 262 insertions(+), 207 deletions(-)

-- 
2.14.4

