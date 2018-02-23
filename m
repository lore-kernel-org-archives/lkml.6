Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934728AbeBWSuY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 13:50:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59898 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934713AbeBWSuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:50:22 -0500
Date: Fri, 23 Feb 2018 18:50:18 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 4.16-rc3
Message-ID: <20180223185015.j7v33ou2merujgh4@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 and perf fixes below (the latter pushed by Will to
the arm64 fixes/core branch). Thanks.

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 9f416319f40cd857d2bb517630e5855a905ef3fb:

  arm64: fix unwind_frame() for filtered out fn for function graph tracing (2018-02-23 13:46:38 +0000)

----------------------------------------------------------------
arm64 fixes:

- Compilation error when accessing MPIDR_HWID_BITMASK from .S

- CTR_EL0 field definitions

- Remove/disable some kernel messages on user faults (unhandled signals,
  unimplemented syscalls)

- Kernel page fault in unwind_frame() with function graph tracing

- perf sleeping while atomic errors when booting with ACPI

----------------------------------------------------------------
Bhupesh Sharma (1):
      arm64: Fix compilation error while accessing MPIDR_HWID_BITMASK from .S files

Mark Rutland (9):
      ARM: ux500: remove PMU IRQ bouncer
      arm_pmu: kill arm_pmu_platdata
      arm_pmu: fold platform helpers into platform code
      arm_pmu: add armpmu_alloc_atomic()
      arm_pmu: acpi: check for mismatched PPIs
      arm_pmu: explicitly enable/disable SPIs at hotplug
      arm_pmu: note IRQs and PMUs per-cpu
      arm_pmu: acpi: request IRQs up-front
      arm64: perf: correct PMUVer probing

Michael Weiser (2):
      arm64: Disable unhandled signal log messages by default
      arm64: Remove unimplemented syscall log message

Pratyush Anand (1):
      arm64: fix unwind_frame() for filtered out fn for function graph tracing

Robin Murphy (1):
      arm64: uaccess: Formalise types for access_ok()

Will Deacon (3):
      arm64: cpufeature: Fix CTR_EL0 field definitions
      arm64: __show_regs: Only resolve kernel symbols when running at EL1
      arm64: Enforce BBM for huge IO/VMAP mappings

 arch/arm/mach-ux500/cpu-db8500.c     |  35 ---------
 arch/arm64/include/asm/cputype.h     |   2 +-
 arch/arm64/include/asm/stacktrace.h  |   2 +-
 arch/arm64/include/asm/uaccess.h     |  12 +--
 arch/arm64/kernel/armv8_deprecated.c |   4 +-
 arch/arm64/kernel/cpufeature.c       |   6 +-
 arch/arm64/kernel/perf_event.c       |   4 +-
 arch/arm64/kernel/process.c          |  11 ++-
 arch/arm64/kernel/stacktrace.c       |   5 ++
 arch/arm64/kernel/sys_compat.c       |   2 +-
 arch/arm64/kernel/time.c             |   2 +-
 arch/arm64/kernel/traps.c            |  10 +--
 arch/arm64/mm/mmu.c                  |  10 +++
 drivers/perf/arm_pmu.c               | 138 ++++++++++++++++-------------------
 drivers/perf/arm_pmu_acpi.c          |  61 +++++++++++-----
 drivers/perf/arm_pmu_platform.c      |  37 ++++++++--
 include/linux/perf/arm_pmu.h         |  26 +------
 17 files changed, 183 insertions(+), 184 deletions(-)

-- 
Catalin
