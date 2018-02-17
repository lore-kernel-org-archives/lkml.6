Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751071AbeBQJEL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 04:04:11 -0500
Received: from foss.arm.com ([217.140.101.70]:47324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbeBQJEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 04:04:10 -0500
Date: Sat, 17 Feb 2018 09:04:05 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 4.16-rc2
Message-ID: <20180217090404.guyuppnw4fnxyr3z@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. The bulk of this pull request is the
pte accessors annotation to READ/WRITE_ONCE (we tried to avoid pushing
this during the merging window to avoid conflicts). Thanks.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to e1a50de37860b3a93a9d643b09638db5aff47650:

  arm64: cputype: Silence Sparse warnings (2018-02-17 08:37:05 +0000)

----------------------------------------------------------------
arm64 fixes:

- Updated the page table accessors to use READ/WRITE_ONCE and prevent
  compiler transformation that could lead to an apparent loss of
  coherency

- Enabled branch predictor hardening for the Falkor CPU

- Fix interaction between kpti enabling and KASan causing the recursive
  page table walking to take a significant time

- Fix some sparse warnings

----------------------------------------------------------------
Robin Murphy (1):
      arm64: cputype: Silence Sparse warnings

Shanker Donthineni (1):
      arm64: Add missing Falkor part number for branch predictor hardening

Will Deacon (2):
      arm64: proc: Set PTE_NG for table entries to avoid traversing them twice
      arm64: mm: Use READ_ONCE/WRITE_ONCE when accessing page tables

 arch/arm64/include/asm/cputype.h     |   2 +-
 arch/arm64/include/asm/hugetlb.h     |   2 +-
 arch/arm64/include/asm/kvm_mmu.h     |  26 ++--
 arch/arm64/include/asm/mmu_context.h |   4 +-
 arch/arm64/include/asm/pgalloc.h     |  44 +++---
 arch/arm64/include/asm/pgtable.h     |  23 +--
 arch/arm64/kernel/cpu_errata.c       |   9 ++
 arch/arm64/kernel/efi.c              |   2 +-
 arch/arm64/kernel/hibernate.c        | 148 +++++++++---------
 arch/arm64/kvm/hyp/switch.c          |   4 +-
 arch/arm64/mm/dump.c                 |  54 ++++---
 arch/arm64/mm/fault.c                |  44 +++---
 arch/arm64/mm/hugetlbpage.c          |  94 ++++++------
 arch/arm64/mm/kasan_init.c           |  70 ++++-----
 arch/arm64/mm/mmu.c                  | 282 ++++++++++++++++++-----------------
 arch/arm64/mm/pageattr.c             |  32 ++--
 arch/arm64/mm/proc.S                 |  14 +-
 17 files changed, 448 insertions(+), 406 deletions(-)

-- 
Catalin
