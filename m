Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE28C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9D321536
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9D321536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeHQTkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:40:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49242 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbeHQTkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:40:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88B0215A2;
        Fri, 17 Aug 2018 09:36:34 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A8F33F5B3;
        Fri, 17 Aug 2018 09:36:34 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0AC4F1AE2DE4; Fri, 17 Aug 2018 17:36:42 +0100 (BST)
Date:   Fri, 17 Aug 2018 17:36:42 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com
Subject: [GIT PULL] arm64: merge window fixes for -rc1
Message-ID: <20180817163641.GC12205@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm travelling next week and a couple of fixes came in since our main
pull request on Tuesday. Since one of them fixes a boot failure on
Hikey-960, I figured there was no point holding them off until -rc1 is
released, so please consider pulling them beforehand.

Details in the tag.

Cheers,

Will

--->8

The following changes since commit 3c4d9137eefecf273a520d392071ffc9df0a9a7a:

  arm64: alternative: Use true and false for boolean values (2018-08-08 11:20:54 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 5ad356eabc47d26a92140a0c4b20eba471c10de3:

  arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid() (2018-08-17 10:27:14 +0100)

----------------------------------------------------------------
A couple of arm64 fixes

- Fix boot on Hikey-960 by avoiding an IPI with interrupts disabled
- Fix address truncation in pfn_valid() implementation

----------------------------------------------------------------
Greg Hackmann (1):
      arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()

Will Deacon (1):
      arm64: Avoid calling stop_machine() when patching jump labels

 arch/arm64/kernel/jump_label.c | 2 +-
 arch/arm64/mm/init.c           | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)
