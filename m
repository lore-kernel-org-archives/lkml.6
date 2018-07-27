Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2A1C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475902089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475902089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbeG0NNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:13:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42360 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730314AbeG0NNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:13:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2030F15AD;
        Fri, 27 Jul 2018 04:51:34 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E667B3F575;
        Fri, 27 Jul 2018 04:51:33 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 5F09F1AE2DA4; Fri, 27 Jul 2018 12:51:34 +0100 (BST)
Date:   Fri, 27 Jul 2018 12:51:34 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com
Subject: [GIT PULL] arm64: fixes for -rc7
Message-ID: <20180727115133.GD25592@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Inevitably, after saying that I hoped we would be done on the fixes front,
a couple of issues have cropped up over the last week. Next time I'll stay
schtum.

As usual, details are in the tag, but we've fixed an over-eager BUILD_BUG_ON()
which Arnd ran into with arndconfig, as well as ensuring that KPTI really
is disabled on Thunder-X1, where the cure is worse than the disease (this
regressed when we reworked the heterogeneous CPU feature checking).

Please pull.

Thanks,

Will

--->8

The following changes since commit d72e90f33aa4709ebecc5005562f52335e106a60:

  Linux 4.18-rc6 (2018-07-22 14:12:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 7b0eb6b41a08fa1fa0d04b1c53becd62b5fbfaee:

  arm64: fix vmemmap BUILD_BUG_ON() triggering on !vmemmap setups (2018-07-25 13:32:30 +0100)

----------------------------------------------------------------
More arm64 fixes:

- Fix disabling of kpti on Thunder-X machines

- Fix premature BUILD_BUG_ON() found with randconfig

----------------------------------------------------------------
Dirk Mueller (1):
      arm64: Check for errata before evaluating cpu features

Johannes Weiner (1):
      arm64: fix vmemmap BUILD_BUG_ON() triggering on !vmemmap setups

 arch/arm64/kernel/cpufeature.c | 4 ++--
 arch/arm64/mm/init.c           | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)
