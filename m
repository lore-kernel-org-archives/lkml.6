Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3F9C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88172466F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88172466F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933755AbeFVRhZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:37:25 -0400
Received: from foss.arm.com ([217.140.101.70]:39046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932973AbeFVRhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:37:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63DFF14;
        Fri, 22 Jun 2018 10:37:24 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.cambridge.arm.com [10.1.206.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 523293F557;
        Fri, 22 Jun 2018 10:37:23 -0700 (PDT)
Date:   Fri, 22 Jun 2018 18:37:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 4.18-rc2
Message-ID: <20180622173714.jtvicri5szn4dzb4@armageddon.cambridge.arm.com>
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

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 71c8fc0c96abf8e53e74ed4d891d671e585f9076:

  arm64: mm: Ensure writes to swapper are ordered wrt subsequent cache maintenance (2018-06-22 17:23:40 +0100)

----------------------------------------------------------------
arm64 fixes:

- Zero buffers allocated with FORCE_CONTIGUOUS explicitly until the CMA
  code honours __GFP_ZERO

- notrace annotation for secondary_start_kernel()

- Use early_param() instead of __setup() for "kpti=" as it is needed for
  the cpufeature callback remapping swapper to non-global mappings

- Ensure writes to swapper are ordered wrt subsequent cache maintenance
  in the kpti non-global remapping code

----------------------------------------------------------------
Marek Szyprowski (1):
      arm64: dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag

Will Deacon (2):
      arm64: kpti: Use early_param for kpti= command-line option
      arm64: mm: Ensure writes to swapper are ordered wrt subsequent cache maintenance

Zhizhou Zhang (1):
      arm64: make secondary_start_kernel() notrace

 arch/arm64/kernel/cpufeature.c | 2 +-
 arch/arm64/kernel/smp.c        | 2 +-
 arch/arm64/mm/dma-mapping.c    | 9 +++++----
 arch/arm64/mm/proc.S           | 5 +++--
 4 files changed, 10 insertions(+), 8 deletions(-)

-- 
Catalin
