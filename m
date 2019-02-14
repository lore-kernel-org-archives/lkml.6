Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5465EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285D9218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391368AbfBNL4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:56:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:51463 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfBNL4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:56:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 03:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="122400471"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by fmsmga007.fm.intel.com with ESMTP; 14 Feb 2019 03:56:52 -0800
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Subject: [PATCH v3 0/5] ICL support and other enhancements for PMC Core
Date:   Thu, 14 Feb 2019 17:27:07 +0530
Message-Id: <20190214115712.19642-1-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
 * Dropped reference to coreboot project as suggested by Thomas and Boris.
 * Rebased onto "for-next" branch of pdx86 tree and dropped previously
   accepted five patches from v2 of this series since they are already
   present there.
 * Fixed checkpatch complains about 75 char limit for commit messages.

Changes in v2:
 * Addressed review comments from Thomas
 * Added tags revieved
 * Folded in SHA1 suggestions from Stephen Rothwell, though Andy might
   want to fix it via rebasing
 * Rebased and tested with Linux v5.0.0-rc6

This series:
 - Adds ICL U/Y CPUID to intel-family.h
 - Enables PMC driver for ICL 
 - Introduces a new "package cstate show" feature
 - Fixes a customer issue related to S0ix on latest HP laptops
 - Fixes some minor bugs  


Rajneesh Bhardwaj (5):
  x86/cpu: Add Icelake to Intel family
  platform/x86: intel_pmc_core: Convert to INTEL_CPU_FAM6 macro
  platform/x86: intel_pmc_core: Add ICL platform support
  platform/x86: intel_pmc_core: Add Package cstates residency info
  platform/x86: intel_pmc_core: Quirk to ignore XTAL shutdown

 arch/x86/include/asm/intel-family.h   |   2 +
 drivers/platform/x86/intel_pmc_core.c | 144 ++++++++++++++++++++++----
 drivers/platform/x86/intel_pmc_core.h |  10 ++
 3 files changed, 135 insertions(+), 21 deletions(-)

-- 
2.17.1

