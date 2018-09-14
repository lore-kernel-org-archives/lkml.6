Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE91ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239F12083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239F12083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeINVeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:34:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36080 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeINVeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:34:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECB0680D;
        Fri, 14 Sep 2018 09:18:50 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE5B83F557;
        Fri, 14 Sep 2018 09:18:50 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 5D6D21AE2F82; Fri, 14 Sep 2018 17:19:08 +0100 (BST)
Date:   Fri, 14 Sep 2018 17:19:08 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com
Subject: [GIT PULL] arm64: fixes for -rc4
Message-ID: <20180914161908.GF6236@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The trickle of arm64 fixes continues to come in. Nothing that's the end
of the world, but we've got a fix for PCI IO port accesses, an accidental
naked "asm goto" and a fix to the vmcoreinfo PT_NOTE merged this time
around which we'd like to get sorted before it becomes ABI.

Details in the tag, but please pull.

Thanks,

Will

--->8

The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 500dd232449e7c07500e713dc6970aa713f8e4f1:

  asm-generic: io: Fix ioport_map() for !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO (2018-09-14 09:49:21 +0100)

----------------------------------------------------------------
arm64 fixes

- Fix ioport_map() mapping the wrong physical address for some I/O BARs

- Remove direct use of "asm goto", since some compilers don't like that

- Ensure kimage_voffset is always present in vmcoreinfo PT_NOTE

----------------------------------------------------------------
Andrew Murray (1):
      asm-generic: io: Fix ioport_map() for !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO

James Morse (1):
      arm64: kernel: arch_crash_save_vmcoreinfo() should depend on CONFIG_CRASH_CORE

Miguel Ojeda (1):
      arm64: jump_label.h: use asm_volatile_goto macro instead of "asm goto"

 arch/arm64/include/asm/jump_label.h |  4 ++--
 arch/arm64/kernel/Makefile          |  1 +
 arch/arm64/kernel/crash_core.c      | 19 +++++++++++++++++++
 arch/arm64/kernel/machine_kexec.c   | 11 -----------
 include/asm-generic/io.h            |  3 ++-
 5 files changed, 24 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/kernel/crash_core.c
