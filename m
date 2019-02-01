Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248D7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81E120870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfBAHcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:32:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:57767 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBAHcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:32:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 23:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; 
   d="scan'208";a="114430663"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by orsmga008.jf.intel.com with ESMTP; 31 Jan 2019 23:32:28 -0800
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Subject: [PATCH 00/10] ICL support and other enhancements for PMC Core
Date:   Fri,  1 Feb 2019 13:02:24 +0530
Message-Id: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provides Icelake support for PMC Core driver and while
doing so it introduces the Icelake Mobile to intel-family.h as per the
CPUID from below Coreboot link
https://github.com/coreboot/coreboot/blob/5ebcea3aaaa3cd358bc5bccaa156b13a6ef25df6/src/soc/intel/common/block/include/intelblocks/mp_init.h
and provides some fixes and enhancements to the driver.

This series:
 -adds ICL U/Y CPUID to intel-family.h
 -enable PMC driver for ICL. 
 -introduce a new "package cstate show" feature
 -fixes a customer issue related to S0ix on latest HP laptops.
 -fixes some minor bugs  

Rajneesh Bhardwaj (10):
  platform/x86: intel_pmc_core: Handle CFL regmap properly
  platform/x86: intel_pmc_core: Fix PCH IP sts reading
  platform/x86: intel_pmc_core: Fix PCH IP name
  platform/x86: intel_pmc_core: Fix file permissions for ltr_show
  platform/x86: intel_pmc_core: Include Reserved IP for LTR
  x86/cpu: Add Icelake to Intel family
  platform/x86: intel_pmc_core: Convert to INTEL_CPU_FAM6 macro
  platform/x86: intel_pmc_core: Add ICL platform support
  platform/x86: intel_pmc_core: Add Package cstates residency info
  platform/x86: intel_pmc_core: Quirk to ignore XTAL shutdown

 arch/x86/include/asm/intel-family.h   |   2 +
 drivers/platform/x86/intel_pmc_core.c | 155 +++++++++++++++++++++-----
 drivers/platform/x86/intel_pmc_core.h |  14 ++-
 3 files changed, 145 insertions(+), 26 deletions(-)

-- 
2.17.1

