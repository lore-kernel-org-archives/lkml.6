Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F15C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A92218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfBARvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:51:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36008 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbfBARvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:51:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45FEB15BE;
        Fri,  1 Feb 2019 09:51:45 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58EED3F589;
        Fri,  1 Feb 2019 09:51:44 -0800 (PST)
Date:   Fri, 1 Feb 2019 17:51:41 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com
Subject: [GIT PULL] arm64: fixes for -rc5
Message-ID: <20190201175141.GB14567@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Although we're still debugging a few minor arm64-specific issues in
mainline, I didn't want to hold this lot up in the meantime. We've got
an additional KASLR fix after the previous one wasn't quite complete, a
fix for a performance regression when mapping executable pages into
userspace and some fixes for kprobe blacklisting. All candidates for
stable and summarised in the tag.

Please pull. Thanks,

Will

--->8

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to f7daa9c8fd191724b9ab9580a7be55cd1a67d799:

  arm64: hibernate: Clean the __hyp_text to PoC after resume (2019-02-01 14:10:02 +0000)

----------------------------------------------------------------
arm64 fixes for -rc5

- Fix module loading when KASLR is configured but disabled at runtime

- Fix accidental IPI when mapping user executable pages

- Ensure hyp-stub and KVM world switch code cannot be kprobed

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: kaslr: ensure randomized quantities are clean also when kaslr is off

Catalin Marinas (1):
      arm64: Do not issue IPIs for user executable ptes

James Morse (3):
      arm64: kprobe: Always blacklist the KVM world-switch code
      arm64: hyp-stub: Forbid kprobing of the hyp-stub
      arm64: hibernate: Clean the __hyp_text to PoC after resume

 arch/arm64/kernel/hibernate.c      | 4 +++-
 arch/arm64/kernel/hyp-stub.S       | 2 ++
 arch/arm64/kernel/kaslr.c          | 1 +
 arch/arm64/kernel/probes/kprobes.c | 6 +++---
 arch/arm64/mm/flush.c              | 6 +++++-
 5 files changed, 14 insertions(+), 5 deletions(-)
