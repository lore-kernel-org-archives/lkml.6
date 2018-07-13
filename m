Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AD8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DAE20854
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DAE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbeGMRcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:32:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:39244 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729735AbeGMRcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:32:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 10:17:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,348,1526367600"; 
   d="scan'208";a="66741805"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2018 10:17:03 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH] x86/ptrace: Add comments to x86_regset about empty slots
Date:   Fri, 13 Jul 2018 10:12:49 -0700
Message-Id: <20180713171249.11510-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_regset() goes through regsets sequentially.  Empty slots
in regset arrays causes mismatch.  Add comments to x86_regset
enum.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/kernel/ptrace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index e2ee403865eb..130ca4f27a17 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -42,6 +42,11 @@
 
 #include "tls.h"
 
+/*
+ * find_regset() goes through regsets sequentially.
+ * Do not create empty slots in x86_64_regsets[] or
+ * x86_32_regsets[] below.
+ */
 enum x86_regset {
 	REGSET_GENERAL,
 	REGSET_FP,
-- 
2.17.1

