Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D034EC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D1E20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D1E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeJXA4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:56:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:65112 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbeJXA4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:56:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 09:32:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,416,1534834800"; 
   d="scan'208";a="84947007"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 23 Oct 2018 09:32:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 37BF0BA; Tue, 23 Oct 2018 19:32:04 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/2] Fix couple of issues with LDT remap for PTI
Date:   Tue, 23 Oct 2018 19:31:55 +0300
Message-Id: <20181023163157.41441-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset fixes issues with LDT remap for PTI:

 - Layout collision due to KASLR with 5-level paging;

 - Information leak via Meltdown-like attack;

Please review and consider applying.

Kirill A. Shutemov (2):
  x86/mm: Move LDT remap out of KASLR region on 5-level paging
  x86/ldt: Unmap PTEs for the slow before freeing LDT

 Documentation/x86/x86_64/mm.txt         |  8 ++--
 arch/x86/include/asm/page_64_types.h    | 12 ++---
 arch/x86/include/asm/pgtable_64_types.h |  4 +-
 arch/x86/kernel/ldt.c                   | 59 ++++++++++++++++---------
 arch/x86/xen/mmu_pv.c                   |  6 +--
 5 files changed, 53 insertions(+), 36 deletions(-)

-- 
2.19.1

