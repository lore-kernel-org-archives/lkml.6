Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4662BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A4620868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A4620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeK3XHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:07:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:24265 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbeK3XHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:07:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 03:58:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,298,1539673200"; 
   d="scan'208";a="94602915"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Nov 2018 03:58:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C6AF2325; Fri, 30 Nov 2018 13:57:59 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com, bhe@redhat.com,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/2] Fixups for LDT remap placement change
Date:   Fri, 30 Nov 2018 14:57:56 +0300
Message-Id: <20181130115758.4425-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a couple fixes for the recent LDT remap placement change.

The first patch fixes crash when kernel booted as Xen dom0.

The second patch fixes address space markers in dump_pagetables output.
It's purely cosmetic change, backporting to the stable tree is optional.

Kirill A. Shutemov (2):
  x86/mm: Fix guard hole handling
  x86/dump_pagetables: Fix LDT remap address marker

 arch/x86/include/asm/pgtable_64_types.h |  5 +++++
 arch/x86/mm/dump_pagetables.c           | 15 ++++++---------
 arch/x86/xen/mmu_pv.c                   | 11 ++++++-----
 3 files changed, 17 insertions(+), 14 deletions(-)

-- 
2.19.2

