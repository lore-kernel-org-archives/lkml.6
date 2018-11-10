Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92142C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 11:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DCE20883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 11:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DCE20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbeKJV3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 16:29:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42240 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728951AbeKJV3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 16:29:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00B80EBD;
        Sat, 10 Nov 2018 03:44:57 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3D913F718;
        Sat, 10 Nov 2018 03:44:56 -0800 (PST)
Date:   Sat, 10 Nov 2018 11:44:54 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 4.20-rc2
Message-ID: <20181110114452.GA90619@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 24cc61d8cb5a9232fadf21a830061853c1268fdd:

  arm64: memblock: don't permit memblock resizing until linear mapping is up (2018-11-08 17:54:03 +0000)

----------------------------------------------------------------
arm64 fixes:

- Fix occasional page fault during boot due to memblock resizing before
  the linear map is up.

- Define NET_IP_ALIGN to 0 to improve the DMA performance on some
  platforms.

- lib/raid6 test build fix.

- .mailmap update for Punit Agrawal

----------------------------------------------------------------
Ard Biesheuvel (2):
      arm64: mm: define NET_IP_ALIGN to 0
      arm64: memblock: don't permit memblock resizing until linear mapping is up

Jeremy Linton (1):
      lib/raid6: Fix arm64 test build

Punit Agrawal (1):
      mailmap: Update email for Punit Agrawal

 .mailmap                           | 1 +
 arch/arm64/include/asm/processor.h | 8 ++++++++
 arch/arm64/mm/init.c               | 2 --
 arch/arm64/mm/mmu.c                | 2 ++
 lib/raid6/test/Makefile            | 4 ++--
 5 files changed, 13 insertions(+), 4 deletions(-)

-- 
Catalin
