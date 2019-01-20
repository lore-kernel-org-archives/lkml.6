Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FC8C61CE8
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 00:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E032420883
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 00:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfATAE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 19:04:28 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46982 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbfATAE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 19:04:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78345A78;
        Sat, 19 Jan 2019 16:04:27 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF3F43F6A8;
        Sat, 19 Jan 2019 16:04:25 -0800 (PST)
Date:   Sun, 20 Jan 2019 00:04:22 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, ard.biesheuvel@linaro.org
Subject: [GIT PULL] arm64: fixes for -rc3
Message-ID: <20190120000420.GM26876@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these three arm64 fixes for -rc3. We've plugged a couple of
nasty issues involving KASLR-enabled kernels, and removed a redundant
#define that was introduced as part of the KHWASAN fixes from akpm at -rc2.

The kernel.org servers wouldn't talk to me from NZ (the keys appeared to
have changed), so I ended up pushing via the UK which seems to have worked.
Please shout if anything looks weird.

Cheers,

Will

--->8

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 7fa1e2e6afa7f4c9f46528e61de6a15d9e8dffd9:

  kasan, arm64: remove redundant ARCH_SLAB_MINALIGN define (2019-01-16 12:09:11 +0000)

----------------------------------------------------------------
arm64 fixes for -rc3

- Fix broken kpti page-table rewrite in bizarre KASLR configuration

- Fix module loading with KASLR

- Remove redundant definition of ARCH_SLAB_MINALIGN

----------------------------------------------------------------
Andrey Konovalov (1):
      kasan, arm64: remove redundant ARCH_SLAB_MINALIGN define

Ard Biesheuvel (1):
      arm64: kaslr: ensure randomized quantities are clean to the PoC

James Morse (1):
      arm64: kpti: Update arm64_kernel_use_ng_mappings() when forced on

 arch/arm64/include/asm/cache.h | 2 --
 arch/arm64/include/asm/mmu.h   | 5 ++++-
 arch/arm64/kernel/kaslr.c      | 8 ++++++--
 3 files changed, 10 insertions(+), 5 deletions(-)
