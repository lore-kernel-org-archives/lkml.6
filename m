Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9655C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778CE24D04
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778CE24D04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937219AbeF2RUm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:20:42 -0400
Received: from foss.arm.com ([217.140.101.70]:37480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937202AbeF2RUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:20:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE77418A;
        Fri, 29 Jun 2018 10:20:40 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.cambridge.arm.com [10.1.206.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB6B43F5AD;
        Fri, 29 Jun 2018 10:20:39 -0700 (PDT)
Date:   Fri, 29 Jun 2018 18:20:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 4.18-rc3
Message-ID: <20180629172035.mmkauxlu7taulubu@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 24fe1b0efad4fcdd32ce46cffeab297f22581707:

  arm64: Remove unnecessary ISBs from set_{pte,pmd,pud} (2018-06-27 18:26:20 +0100)

----------------------------------------------------------------
arm64 fixes:

- The alternatives patching code uses flush_icache_range() which itself
  uses alternatives. Change the code to use an unpatched variant of
  cache maintenance

- Remove unnecessary ISBs from set_{pte,pmd,pud}

- perf: xgene_pmu: Fix IOB SLOW PMU parser error

----------------------------------------------------------------
Catalin Marinas (1):
      Merge branch 'perf/fixes' of git://git.kernel.org/.../will/linux

Hoan Tran (1):
      drivers/perf: xgene_pmu: Fix IOB SLOW PMU parser error

Will Deacon (2):
      arm64: Avoid flush_icache_range() in alternatives patching code
      arm64: Remove unnecessary ISBs from set_{pte,pmd,pud}

 arch/arm64/include/asm/alternative.h |  7 ++++-
 arch/arm64/include/asm/pgtable.h     |  6 +----
 arch/arm64/kernel/alternative.c      | 51 +++++++++++++++++++++++++++++++-----
 arch/arm64/kernel/module.c           |  5 ++--
 drivers/perf/xgene_pmu.c             |  2 +-
 5 files changed, 54 insertions(+), 17 deletions(-)

-- 
Catalin
