Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E4CECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5242156F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5242156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeIVEbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:31:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:61603 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbeIVEbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:31:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 15:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,286,1534834800"; 
   d="scan'208";a="234946778"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by orsmga004.jf.intel.com with ESMTP; 21 Sep 2018 15:37:57 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 0/6] mm: faster get user pages
Date:   Fri, 21 Sep 2018 16:39:50 -0600
Message-Id: <20180921223956.3485-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:

  Combine only the output parameters in a struct that need tracking,
  and squash to just one final kernel patch.

  Fixed compile bugs for all configs

Keith Busch (6):
  mm/gup_benchmark: Time put_page
  mm/gup_benchmark: Add additional pinning methods
  tools/gup_benchmark: Fix 'write' flag usage
  tools/gup_benchmark: Allow user specified file
  tools/gup_benchmark: Add parameter for hugetlb
  mm/gup: Cache dev_pagemap while pinning pages

 include/linux/huge_mm.h                    |  8 +--
 include/linux/mm.h                         | 19 ++++++-
 mm/gup.c                                   | 90 +++++++++++++++++-------------
 mm/gup_benchmark.c                         | 36 ++++++++++--
 mm/huge_memory.c                           | 38 ++++++-------
 mm/nommu.c                                 |  4 +-
 tools/testing/selftests/vm/gup_benchmark.c | 40 +++++++++++--
 7 files changed, 154 insertions(+), 81 deletions(-)

-- 
2.14.4

