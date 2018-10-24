Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856CCECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549C620833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549C620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeJYGbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:31:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:10462 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbeJYGbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:31:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 15:01:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,422,1534834800"; 
   d="scan'208";a="100417538"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 24 Oct 2018 15:01:19 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH 0/2] x86: Enumerate direct stores instructions
Date:   Wed, 24 Oct 2018 14:57:15 -0700
Message-Id: <1540418237-125817-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct stores instructionis MOVDIRI and MOVDIR64B will be available in
Tremont and other future x86 processors.

This patch set enumerates the instructions through CPUID.

GCC 8 implements intrinsics for the direct stores instructions.
User can try these instructions from GCC tree:
https://gcc.gnu.org/git/?p=gcc.git;a=summary
Before running the instructions, user needs to check availability of
the features by CPUID, or /proc/cpuinfo, etc.

Detailed information on the instructions and the MSR can be found in
the latest Intel Architecture Instruction Set Extensions and Future
Features Programming Reference at
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

Please note: this patch set was sent out with umonitor/umwait/tpause
instructions patches before. But since we find the other patches are not
fully ready yet, this time these direct stores instructions patches are
sent out separately.

Fenghua Yu (2):
  x86/cpufeatures: Enumerate MOVDIRI instruction
  x86/cpufeatures: Enumerate MOVDIR64B instruction

 arch/x86/include/asm/cpufeatures.h | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.5.0

