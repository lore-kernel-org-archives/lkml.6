Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E35C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EEE27DAF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EEE27DAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937106AbeF2TbQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:31:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:7747 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937052AbeF2TbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:31:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 12:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,287,1526367600"; 
   d="scan'208";a="51552401"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2018 12:31:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 96D5758D; Fri, 29 Jun 2018 22:31:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/6] x86/tsc: Clean up legacy code for Intel MID
Date:   Fri, 29 Jun 2018 22:31:07 +0300
Message-Id: <20180629193113.84425-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Thomas noticed there is unusual initialization is going on on Intel MID
platforms when TSC is being calibrated.

It appears that we have tsc_msr.c to support Intel MID in a more generic way.

So, this patch series removes legacy calibration code and does accompanying
clean ups.

Has been tested on Intel Medfield and Intel Merrifield platforms.

Andy Shevchenko (6):
  x86/cpu: Introduce INTEL_CPU_FAM*() helper macros
  x86/tsc: Convert to use x86_match_cpu() and INTEL_CPU_FAM6()
  x86/tsc: Add missed header to tsc_msr.c
  x86/tsc: Use SPDX identifier and update Intel copyright
  x86/platform/intel-mid: Remove custom TSC calibration
  x86/platform/intel-mid: Remove per platform code

 arch/x86/include/asm/intel-family.h           |  13 +++
 arch/x86/include/asm/intel-mid.h              |  43 -------
 arch/x86/kernel/tsc_msr.c                     |  96 ++++++++--------
 arch/x86/platform/intel-mid/Makefile          |   2 +-
 arch/x86/platform/intel-mid/intel-mid.c       |  23 +---
 .../platform/intel-mid/intel_mid_weak_decls.h |  18 ---
 arch/x86/platform/intel-mid/mfld.c            |  70 ------------
 arch/x86/platform/intel-mid/mrfld.c           | 105 ------------------
 8 files changed, 66 insertions(+), 304 deletions(-)
 delete mode 100644 arch/x86/platform/intel-mid/intel_mid_weak_decls.h
 delete mode 100644 arch/x86/platform/intel-mid/mfld.c
 delete mode 100644 arch/x86/platform/intel-mid/mrfld.c

-- 
2.18.0

