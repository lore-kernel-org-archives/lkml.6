Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbeCISkY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:40:24 -0500
Received: from foss.arm.com ([217.140.101.70]:56696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751246AbeCISkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:40:23 -0500
Date: Fri, 9 Mar 2018 18:40:19 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 4.16-rc5
Message-ID: <20180309184014.xeczrjhn5no77s7j@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to e21da1c992007594d391e7b301779cf30f438691:

  arm64: Relax ARM_SMCCC_ARCH_WORKAROUND_1 discovery (2018-03-09 17:52:07 +0000)

----------------------------------------------------------------
arm64 fixes:

- The SMCCC firmware interface for the spectre variant 2 mitigation has
  been updated to allow the discovery of whether the CPU needs the
  workaround. This pull request relaxes the kernel check on the return
  value from firmware.

- Fix the commit allowing changing from global to non-global page table
  entries which inadvertently disallowed other safe attribute changes.

- Fix sleeping in atomic during the arm_perf_teardown_cpu() code.

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: mm: fix thinko in non-global page table attribute check

Marc Zyngier (1):
      arm64: Relax ARM_SMCCC_ARCH_WORKAROUND_1 discovery

Will Deacon (1):
      arm_pmu: Use disable_irq_nosync when disabling SPI in CPU teardown hook

 arch/arm64/kernel/cpu_errata.c | 4 ++--
 arch/arm64/mm/mmu.c            | 8 ++++----
 drivers/perf/arm_pmu.c         | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
Catalin
