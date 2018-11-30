Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E74C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C449F20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C449F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeLAHeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:34:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:16042 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeLAHeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:34:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 12:23:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="294484490"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 30 Nov 2018 12:23:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 73D87288; Fri, 30 Nov 2018 22:23:45 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com, bhe@redhat.com,
        hans.van.kranenburg@mendix.com, x86@kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 0/2] Fixups for LDT remap placement change
Date:   Fri, 30 Nov 2018 23:23:26 +0300
Message-Id: <20181130202328.65359-1-kirill.shutemov@linux.intel.com>
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

v2:
 - Fix typo

Kirill A. Shutemov (2):
  x86/mm: Fix guard hole handling
  x86/dump_pagetables: Fix LDT remap address marker

 arch/x86/include/asm/pgtable_64_types.h |  5 +++++
 arch/x86/mm/dump_pagetables.c           | 15 ++++++---------
 arch/x86/xen/mmu_pv.c                   | 11 ++++++-----
 3 files changed, 17 insertions(+), 14 deletions(-)

-- 
2.19.2

