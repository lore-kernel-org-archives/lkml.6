Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7EAC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE88E217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfBHRf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:35:26 -0500
Received: from foss.arm.com ([217.140.101.70]:54790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfBHRfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23AF880D;
        Fri,  8 Feb 2019 09:35:19 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37D793F719;
        Fri,  8 Feb 2019 09:35:18 -0800 (PST)
Date:   Fri, 8 Feb 2019 17:35:15 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64: fixes for -rc6
Message-ID: <20190208173515.GC24375@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these two arm64 fixes for -rc6. They resolve a kernel NULL
dereference in kexec and bogus kernel page table dumping when userspace
is configured for 52-bit virtual addressing.

Cheers,

Will

--->8

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to ea5736805190e912903c27c9f17c7a4341a405e9:

  arm64: kexec_file: handle empty command-line (2019-02-05 09:34:49 +0000)

----------------------------------------------------------------
arm64 fixes for -rc6

- Fix kernel oops when attemping kexec_file() with a NULL cmdline

- Fix page table output in debugfs when CONFIG_ARM64_USER_VA_BITS_52=y

----------------------------------------------------------------
Jean-Philippe Brucker (1):
      arm64: kexec_file: handle empty command-line

Will Deacon (1):
      arm64: ptdump: Don't iterate kernel page tables using PTRS_PER_PXX

 arch/arm64/kernel/machine_kexec_file.c |  4 ++-
 arch/arm64/mm/dump.c                   | 59 +++++++++++++++++-----------------
 2 files changed, 32 insertions(+), 31 deletions(-)
