Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981CAC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582F921A17
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582F921A17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbeFUVSd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:18:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:27244 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754278AbeFUVSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:18:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 14:18:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="48912128"
Received: from hanvin-mobl2.amr.corp.intel.com ([10.254.42.214])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2018 14:18:02 -0700
From:   "H. Peter Anvin, Intel" <h.peter.anvin@intel.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "H. Peter Anvin" <hpa@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        "Markus T . Metzger" <markus.t.metzger@intel.com>
Subject: [PATCH v3 5/7] x86/segment: add #define for the last user-visible GDT slot
Date:   Thu, 21 Jun 2018 14:17:52 -0700
Message-Id: <20180621211754.12757-6-h.peter.anvin@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180621211754.12757-1-h.peter.anvin@intel.com>
References: <20180621211754.12757-1-h.peter.anvin@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@linux.intel.com>

We don't want to advertise to user space how many slots the kernel
GDT has, but user space can trivially find out what the last
user-accessible GDT slot is.  Add a #define for that so we can use
that in sizing a regset.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Markus T. Metzger <markus.t.metzger@intel.com>
---
 arch/x86/include/asm/segment.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index e293c122d0d5..5eb809eec048 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -115,6 +115,11 @@
  */
 #define GDT_ENTRIES			32
 
+/*
+ * Last user-visible GDT slot
+ */
+#define GDT_LAST_USER			GDT_ENTRY_DEFAULT_USER_DS
+
 /*
  * Segment selector values corresponding to the above entries:
  */
@@ -194,6 +199,11 @@
  */
 #define GDT_ENTRIES			16
 
+/*
+ * Last user-visible GDT slot
+ */
+#define GDT_LAST_USER			GDT_ENTRY_PER_CPU
+
 /*
  * Segment selector values corresponding to the above entries:
  *
-- 
2.14.4

