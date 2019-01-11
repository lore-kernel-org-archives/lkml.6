Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A153C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A13205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbfAKSVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:21:02 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33162 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730454AbfAKSVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:21:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30FEF80D;
        Fri, 11 Jan 2019 10:21:01 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 217443F6CF;
        Fri, 11 Jan 2019 10:20:59 -0800 (PST)
Date:   Fri, 11 Jan 2019 18:20:57 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, lorenzo.pieralisi@arm.com
Subject: [GIT PULL] arm64: fixes for -rc2
Message-ID: <20190111182057.GB32645@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Another handful of arm64 fixes here. Most of the complication comes from
improving our kpti code to avoid lengthy pauses (30+ seconds) during boot
when we rewrite the page tables. There are also a couple of IORT fixes
that came in via Lorenzo. Usual summary in the tag.

Please pull,

Thanks,

Will

--->8

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 279667212ab2a4f36c3b0347657ddcc11f9cfa25:

  arm64: kexec_file: return successfully even if kaslr-seed doesn't exist (2019-01-11 10:10:51 +0000)

----------------------------------------------------------------
arm64 fixes for -rc2

- Don't error in kexec_file_load if kaslr-seed is missing in device-tree

- Fix incorrect argument type passed to iort_match_node_callback()

- Fix IORT build failure when CONFIG_IOMMU_API=n

- Fix kpti performance regression with new rodata default option

- Typo fix

----------------------------------------------------------------
AKASHI Takahiro (1):
      arm64: kexec_file: return successfully even if kaslr-seed doesn't exist

Jean-Philippe Brucker (1):
      ACPI/IORT: Fix rc_dma_get_range()

Qian Cai (1):
      ACPI/IORT: Fix build when CONFIG_IOMMU_API=n

Will Deacon (2):
      arm64: asm-prototypes: Fix fat-fingered typo in comment
      arm64: kpti: Avoid rewriting early page tables when KASLR is enabled

 arch/arm64/include/asm/asm-prototypes.h |  2 +-
 arch/arm64/include/asm/mmu.h            | 41 +++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable-prot.h   |  4 ++--
 arch/arm64/kernel/cpu_errata.c          |  2 +-
 arch/arm64/kernel/cpufeature.c          |  9 ++++++--
 arch/arm64/kernel/head.S                |  1 +
 arch/arm64/kernel/machine_kexec_file.c  |  4 +++-
 drivers/acpi/arm64/iort.c               |  5 ++--
 8 files changed, 59 insertions(+), 9 deletions(-)
