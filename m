Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C46ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DC521470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DC521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeJTCHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:07:06 -0400
Received: from foss.arm.com ([217.140.101.70]:56566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeJTCHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:07:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6F88A78;
        Fri, 19 Oct 2018 10:59:57 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74F803F71D;
        Fri, 19 Oct 2018 10:59:56 -0700 (PDT)
Date:   Fri, 19 Oct 2018 18:59:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updated for 4.20
Message-ID: <20181019175952.GA57321@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Greg,

I'm sending the pull request for 4.20 slightly earlier as I'm on holiday
next week (not in Edinburgh). Apart from some new arm64 features and
clean-ups, this request also contains the core mmu_gather changes for
tracking the levels of the page table being cleared and a minor update
to the generic compat_sys_sigaltstack() introducing COMPAT_SIGMINSKSZ.

Thanks.

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 4debef5510071032c6d5dace31ca1cc42a120073:

  arm64: KVM: Guests can skip __install_bp_hardening_cb()s HYP work (2018-10-19 15:37:25 +0100)

----------------------------------------------------------------
arm64 updates for 4.20:

- Core mmu_gather changes which allow tracking the levels of page-table
  being cleared together with the arm64 low-level flushing routines

- Support for the new ARMv8.5 PSTATE.SSBS bit which can be used to
  mitigate Spectre-v4 dynamically without trapping to EL3 firmware

- Introduce COMPAT_SIGMINSTKSZ for use in compat_sys_sigaltstack

- Optimise emulation of MRS instructions to ID_* registers on ARMv8.4

- Support for Common Not Private (CnP) translations allowing threads of
  the same CPU to share the TLB entries

- Accelerated crc32 routines

- Move swapper_pg_dir to the rodata section

- Trap WFI instruction executed in user space

- ARM erratum 1188874 workaround (arch_timer)

- Miscellaneous fixes and clean-ups

----------------------------------------------------------------
Andrew Murray (1):
      arm64: Remove unused VGA console support

Anshuman Khandual (8):
      arm64/cpufeatures: Introduce ESR_ELx_SYS64_ISS_RT()
      arm64/cpufeatures: Factorize emulate_mrs()
      arm64/cpufeatures: Emulate MRS instructions by parsing ESR_ELx.ISS
      arm64/mm: Use ESR_ELx_FSC macro while decoding fault exception
      arm64/mm: Reorganize arguments for is_el1_permission_fault()
      arm64/mm: Define esr_to_debug_fault_info()
      arm64/numa: Report correct memblock range for the dummy node
      arm64/numa: Unify common error path in numa_init()

Ard Biesheuvel (4):
      lib/crc32: make core crc32() routines weak so they can be overridden
      arm64: cpufeature: add feature for CRC32 instructions
      arm64/lib: add accelerated crc32 routines
      arm64: remove unused asm/compiler.h header file

Arnd Bergmann (1):
      arm64: arch_timer: avoid unused function warning

Giacomo Travaglini (1):
      arm64: docs: Fix typos in ELF hwcaps

Hari Vyas (1):
      arm64: fix for bad_mode() handler to always result in panic

James Morse (6):
      arm64: Kconfig: Remove ARCH_HAS_HOLES_MEMORYMODEL
      arm64: mm: Use #ifdef for the __PAGETABLE_P?D_FOLDED defines
      MAINTAINERS: fix bad sdei paths
      Revert "arm64: uaccess: implement unsafe accessors"
      arm64: mm: Use __pa_symbol() for set_swapper_pgd()
      arm64: KVM: Guests can skip __install_bp_hardening_cb()s HYP work

Julien Thierry (4):
      arm64: uaccess: implement unsafe accessors
      arm64: daifflags: Use irqflags functions for daifflags
      arm64: Use daifflag_restore after bp_hardening
      arm64: xen: Use existing helper to check interrupt status

Jun Yao (4):
      arm64/mm: Pass ttbr1 as a parameter to __enable_mmu()
      arm64/mm: Separate boot-time page tables from swapper_pg_dir
      arm64/mm: use fixmap to modify swapper_pg_dir
      arm64/mm: move runtime pgds to rodata

Kyrylo Tkachov (1):
      arm64: Fix typo in a comment in arch/arm64/mm/kasan_init.c

Marc Zyngier (9):
      arm64: Add decoding macros for CP15_32 and CP15_64 traps
      arm64: compat: Add separate CP15 trapping hook
      arm64: compat: Add condition code checks and IT advance
      arm64: compat: Add cp15_32 and cp15_64 handler arrays
      arm64: compat: Add CNTVCT trap handler
      arm64: compat: Add CNTFRQ trap handler
      arm64: arch_timer: Add workaround for ARM erratum 1188873
      arm64: Trap WFI executed in userspace
      arm64: Add silicon-errata.txt entry for ARM erratum 1188873

Peter Zijlstra (2):
      asm-generic/tlb: Track freeing of page-table directories in struct mmu_gather
      mm/memory: Move mmu_gather and TLB invalidation code into its own file

Punit Agrawal (1):
      Documentation/arm64: HugeTLB page implementation

Rob Herring (1):
      perf: Convert to using %pOFn instead of device_node.name

Shaokun Zhang (1):
      arm64: mm: Drop the unused cpu parameter

Suzuki K Poulose (4):
      arm64: sysreg: Clean up instructions for modifying PSTATE fields
      arm64: cpufeature: ctr: Fix cpu capability check for late CPUs
      arm64: cpufeature: Fix handling of CTR_EL0.IDC field
      arm64: cpufeature: Trap CTR_EL0 access only where it is necessary

Tri Vo (1):
      arm64: lse: remove -fcall-used-x0 flag

Vladimir Murzin (2):
      arm64: mm: Support Common Not Private translations
      arm64: KVM: Enable Common Not Private translations

Will Deacon (26):
      asm-generic/tlb: Guard with #ifdef CONFIG_MMU
      asm-generic/tlb: Track which levels of the page tables have been cleared
      MAINTAINERS: Add entry for MMU GATHER AND TLB INVALIDATION
      Merge branch 'tlb/asm-generic' into aarch64/for-next/core
      arm64: dump: Use consistent capitalisation for page-table dumps
      arm64: tlb: Use last-level invalidation in flush_tlb_kernel_range()
      arm64: tlb: Add DSB ISHST prior to TLBI in __flush_tlb_[kernel_]pgtable()
      arm64: pgtable: Implement p[mu]d_valid() and check in set_p[mu]d()
      arm64: tlb: Justify non-leaf invalidation in flush_tlb_range()
      arm64: tlbflush: Allow stride to be specified for __flush_tlb_range()
      arm64: tlb: Remove redundant !CONFIG_HAVE_RCU_TABLE_FREE code
      arm64: tlb: Adjust stride and type of TLBI according to mmu_gather
      arm64: tlb: Avoid synchronous TLBIs when freeing page tables
      arm64: tlb: Rewrite stale comment in asm/tlbflush.h
      arm64: Fix silly typo in comment
      arm64: cpufeature: Detect SSBS and advertise to userspace
      arm64: ssbd: Drop #ifdefs for PR_SPEC_STORE_BYPASS
      arm64: entry: Allow handling of undefined instructions from EL1
      arm64: ssbd: Add support for PSTATE.SSBS rather than trapping to EL3
      KVM: arm64: Set SCTLR_EL2.DSSBS if SSBD is forcefully disabled and !vhe
      arm64: cpu: Move errata and feature enable callbacks closer to callers
      arm64: force_signal_inject: WARN if called from kernel context
      arm64: cpu_errata: Remove ARM64_MISMATCHED_CACHE_LINE_SIZE
      signal: Introduce COMPAT_SIGMINSTKSZ for use in compat_sys_sigaltstack
      arm64: compat: Provide definition for COMPAT_SIGMINSTKSZ
      arm64: docs: Document SSBS HWCAP

zhong jiang (1):
      arm64/kprobes: remove an extra semicolon in arch_prepare_kprobe

 Documentation/arm64/elf_hwcaps.txt      |  12 +-
 Documentation/arm64/hugetlbpage.txt     |  38 +++++
 Documentation/arm64/silicon-errata.txt  |   1 +
 MAINTAINERS                             |  17 ++-
 arch/arm/include/asm/kvm_arm.h          |   1 +
 arch/arm/include/asm/kvm_mmu.h          |   5 +
 arch/arm64/Kconfig                      |  34 ++++-
 arch/arm64/include/asm/assembler.h      |   7 +-
 arch/arm64/include/asm/cache.h          |  40 +++++
 arch/arm64/include/asm/compat.h         |   1 +
 arch/arm64/include/asm/compiler.h       |  30 ----
 arch/arm64/include/asm/cpucaps.h        |   7 +-
 arch/arm64/include/asm/cpufeature.h     |   9 +-
 arch/arm64/include/asm/cputype.h        |   2 +
 arch/arm64/include/asm/daifflags.h      |  15 +-
 arch/arm64/include/asm/esr.h            |  77 ++++++++++
 arch/arm64/include/asm/kernel-pgtable.h |   2 +-
 arch/arm64/include/asm/kvm_arm.h        |   1 +
 arch/arm64/include/asm/kvm_emulate.h    |   2 +-
 arch/arm64/include/asm/kvm_host.h       |  11 ++
 arch/arm64/include/asm/kvm_mmu.h        |   5 +
 arch/arm64/include/asm/mmu.h            |   3 +
 arch/arm64/include/asm/mmu_context.h    |  17 ++-
 arch/arm64/include/asm/page.h           |   2 -
 arch/arm64/include/asm/pgtable-hwdef.h  |   2 +
 arch/arm64/include/asm/pgtable.h        |  48 +++++-
 arch/arm64/include/asm/processor.h      |  11 +-
 arch/arm64/include/asm/ptrace.h         |   1 +
 arch/arm64/include/asm/sysreg.h         |  44 ++++--
 arch/arm64/include/asm/tlb.h            |  34 ++---
 arch/arm64/include/asm/tlbflush.h       | 112 +++++++++-----
 arch/arm64/include/asm/uaccess.h        |   1 -
 arch/arm64/include/asm/xen/events.h     |   2 +-
 arch/arm64/include/uapi/asm/hwcap.h     |   1 +
 arch/arm64/include/uapi/asm/ptrace.h    |   1 +
 arch/arm64/kernel/cpu_errata.c          |  96 +++++++++---
 arch/arm64/kernel/cpufeature.c          | 195 +++++++++++++++++++++---
 arch/arm64/kernel/cpuinfo.c             |  11 +-
 arch/arm64/kernel/entry.S               |  18 ++-
 arch/arm64/kernel/head.S                |  40 ++---
 arch/arm64/kernel/probes/kprobes.c      |   2 +-
 arch/arm64/kernel/process.c             |   4 +
 arch/arm64/kernel/psci.c                |   1 -
 arch/arm64/kernel/setup.c               |   4 -
 arch/arm64/kernel/sleep.S               |   1 +
 arch/arm64/kernel/ssbd.c                |  24 ++-
 arch/arm64/kernel/suspend.c             |   4 +
 arch/arm64/kernel/traps.c               | 211 ++++++++++++++++++++++++--
 arch/arm64/kernel/vmlinux.lds.S         |  35 +++--
 arch/arm64/kvm/hyp-init.S               |   3 +
 arch/arm64/kvm/hyp/sysreg-sr.c          |  11 ++
 arch/arm64/lib/Makefile                 |   4 +-
 arch/arm64/lib/crc32.S                  |  60 ++++++++
 arch/arm64/mm/context.c                 |  11 +-
 arch/arm64/mm/dump.c                    |   6 +-
 arch/arm64/mm/fault.c                   |  38 ++---
 arch/arm64/mm/init.c                    |   2 -
 arch/arm64/mm/kasan_init.c              |   2 +-
 arch/arm64/mm/mmu.c                     |  46 +++---
 arch/arm64/mm/numa.c                    |  13 +-
 arch/arm64/mm/proc.S                    |  11 +-
 drivers/clocksource/arm_arch_timer.c    |  15 ++
 drivers/perf/arm_pmu_platform.c         |   6 +-
 include/asm-generic/tlb.h               |  86 +++++++++--
 include/linux/compat.h                  |   3 +
 kernel/signal.c                         |  14 +-
 lib/crc32.c                             |  11 +-
 mm/Makefile                             |   6 +-
 mm/memory.c                             | 247 ------------------------------
 mm/mmu_gather.c                         | 261 ++++++++++++++++++++++++++++++++
 virt/kvm/arm/arm.c                      |   4 +-
 71 files changed, 1511 insertions(+), 591 deletions(-)
 create mode 100644 Documentation/arm64/hugetlbpage.txt
 delete mode 100644 arch/arm64/include/asm/compiler.h
 create mode 100644 arch/arm64/lib/crc32.S
 create mode 100644 mm/mmu_gather.c

-- 
Catalin
