Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3FAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C8F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfBUPPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:15:21 -0500
Received: from foss.arm.com ([217.140.101.70]:46046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfBUPPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:15:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D944CA78;
        Thu, 21 Feb 2019 07:15:20 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7BFC3F5C1;
        Thu, 21 Feb 2019 07:15:19 -0800 (PST)
Date:   Thu, 21 Feb 2019 15:15:17 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64: late fixes for 5.0
Message-ID: <20190221151517.GB13320@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these three small arm64 fixes for 5.0. They fix a build breakage
with clang introduced in 4.20, an oversight in our sigframe restoration
relating to the SSBS bit and a boot fix for systems with newer revisions of
our interrupt controller.

Summary in the tag.

Cheers,

Will

-->8

The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438:

  Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 74698f6971f25d045301139413578865fc2bd8f9:

  arm64: Relax GIC version check during early boot (2019-02-20 14:05:37 +0000)

----------------------------------------------------------------
arm64 fixes for 5.0

- Fix handling of PSTATE.SSBS bit in sigreturn()

- Fix version checking of the GIC during early boot

- Fix clang builds failing due to use of NEON in the crypto code

----------------------------------------------------------------
Mark Rutland (1):
      arm64: fix SSBS sanitization

Nathan Chancellor (1):
      arm64/neon: Disable -Wincompatible-pointer-types when building with Clang

Vladimir Murzin (1):
      arm64: Relax GIC version check during early boot

 arch/arm64/include/asm/neon-intrinsics.h |  4 ++++
 arch/arm64/kernel/head.S                 |  3 +--
 arch/arm64/kernel/ptrace.c               | 15 ++++++++-------
 3 files changed, 13 insertions(+), 9 deletions(-)
