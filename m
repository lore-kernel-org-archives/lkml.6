Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74EEC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA02C20867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA02C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeLAL6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:58:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:65499 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbeLAL6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:58:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 16:47:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,300,1539673200"; 
   d="scan'208";a="94840139"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007.jf.intel.com with ESMTP; 30 Nov 2018 16:47:45 -0800
Subject: [PATCH v2 2/5] generic/pgtable: Introduce {p4d,pgd}_same()
From:   Dan Williams <dan.j.williams@intel.com>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Nov 2018 16:35:16 -0800
Message-ID: <154362451675.2367148.4683338505844518956.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154362450646.2367148.16448130381211111341.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154362450646.2367148.16448130381211111341.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for introducing '_safe' versions of page table entry 'set'
helpers, introduce generic versions of p4d_same() and pgd_same().

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/asm-generic/pgtable.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index eea50ef8b8cd..dae7f98babed 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -386,6 +386,20 @@ static inline int pud_same(pud_t pud_a, pud_t pud_b)
 }
 #endif
 
+#ifndef __HAVE_ARCH_P4D_SAME
+static inline int p4d_same(p4d_t p4d_a, p4d_t p4d_b)
+{
+	return p4d_val(p4d_a) == p4d_val(p4d_b);
+}
+#endif
+
+#ifndef __HAVE_ARCH_PGD_SAME
+static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
+{
+	return pgd_val(pgd_a) == pgd_val(pgd_b);
+}
+#endif
+
 #ifndef __HAVE_ARCH_DO_SWAP_PAGE
 /*
  * Some architectures support metadata associated with a page. When a

