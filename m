Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB38C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAEB2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAEB2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbeIGU0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:26:30 -0400
Received: from foss.arm.com ([217.140.101.70]:33822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbeIGU0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:26:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC00618A;
        Fri,  7 Sep 2018 08:45:01 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD5EC3F5BC;
        Fri,  7 Sep 2018 08:45:01 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id E7D321AE37BD; Fri,  7 Sep 2018 16:45:16 +0100 (BST)
Date:   Fri, 7 Sep 2018 16:45:16 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com
Subject: [GIT PULL] arm64: fix for -rc3
Message-ID: <20180907154516.GG12788@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Just one small fix here, preventing a VM_WARN_ON when a !present PMD/PUD
is "freed" as part of a huge ioremap() operation. The correct behaviour
is to skip the free silently in this case, which is a little weird (the
function is a bit of a misnomer), but it follows the x86 implementation.

I also renewed the expiry dates on my gpg subkeys this week, so you might
need to re-fetch them if you can find a working keyserver.

Cheers,

Will

--->8

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to fac880c7d074fdfca874114b5c47b36aa034e4ee:

  arm64: fix erroneous warnings in page freeing functions (2018-09-06 18:01:13 +0100)

----------------------------------------------------------------
arm64 fix

- Remove accidental VM_WARN_ON

----------------------------------------------------------------
Mark Rutland (1):
      arm64: fix erroneous warnings in page freeing functions

 arch/arm64/mm/mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
