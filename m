Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754344AbeDBKFs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:05:48 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32932 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754207AbeDBKFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:05:47 -0400
X-Google-Smtp-Source: AIpwx4/c+2x5A2XpEtkZf4GplSHoNKy6Lrw6x1NSYdKr0+51NQCv6ff54dKneQhNfQ/o5hkxckmKWQ==
Date: Mon, 2 Apr 2018 12:05:43 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/mm changes for v4.17
Message-ID: <20180402100543.42fmo3qnx6c4hcjw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-mm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

   # HEAD: eaeb8e76cd5751e805f6e4a3fcec91d283e3b0c2 x86/cpu/tme: Fix spelling: "configuation" -> "configuration"

  - Extend the memmap= boot parameter syntax to allow the
    redeclaration and dropping of existing ranges, and to
    support all e820 range types.
                                              (Jan H. Schönherr)

  - Improve the W+X boot time security checks to remove false
    positive warnings on Xen.
                                              (Jan Beulich)

  - Support booting as Xen PVH guest          (Juergen Gross)

  - Improved 5-level paging (LA57) support, in particular it's
    possible now to have a single kernel image for both 4-level
    and 5-level hardware.
                                              (Kirill A. Shutemov)

  - AMD hardware RAM encryption support (SME/SEV) fixes

                                              (Tom Lendacky)

  - Preparatory commits for hardware-encrypted RAM support on
    Intel CPUs.
                                              (Kirill A. Shutemov)

  - Improved Intel-MID support                (Andy Shevchenko)

  - Show EFI page tables in page_tables debug files.

                                              (Andy Lutomirski)

  - ... plus misc fixes and smaller cleanups.

  out-of-topic modifications in x86-mm-for-linus:
  -------------------------------------------------
  drivers/acpi/osl.c                 # dfc9327ab7c9: acpi: Introduce acpi_arch_ge
  include/asm-generic/5level-fixup.h # c65e774fb3f6: x86/mm: Make PGDIR_SHIFT and
  include/asm-generic/pgtable-nop4d.h# c65e774fb3f6: x86/mm: Make PGDIR_SHIFT and
  include/linux/acpi.h               # dfc9327ab7c9: acpi: Introduce acpi_arch_ge
  include/linux/kasan.h              # c65e774fb3f6: x86/mm: Make PGDIR_SHIFT and
  include/linux/mmzone.h             # fc5d1073cae2: x86/mm/32: Remove unused nod
  mm/kasan/kasan_init.c              # c65e774fb3f6: x86/mm: Make PGDIR_SHIFT and
  mm/sparse.c                        # fc5d1073cae2: x86/mm/32: Remove unused nod
  mm/zsmalloc.c                      # 02390b87a945: mm/zsmalloc: Prepare to vari

 Thanks,

	Ingo

------------------>
Andy Lutomirski (1):
      x86/mm/dump_pagetables: Add the EFI pagetable to the debugfs 'page_tables' directory

Andy Shevchenko (3):
      ACPI, x86/boot: Split out acpi_generic_reduce_hw_init() and export
      ACPI, x86/boot: Introduce the ->reduced_hw_early_init() ACPI callback
      x86/platform/intel-mid: Add special handling for ACPI HW reduced platforms

Baoquan He (1):
      kdump, vmcoreinfo: Export pgtable_l5_enabled value

Colin Ian King (1):
      x86/cpu/tme: Fix spelling: "configuation" -> "configuration"

David Rientjes (1):
      x86/mm/32: Remove unused node_memmap_size_bytes() & CONFIG_NEED_NODE_MEMMAP_SIZE logic

Jan Beulich (1):
      x86/mm: Consider effective protection attributes in W+X check

Jan H. Schönherr (1):
      x86/boot/e820: Implement a range manipulation operator

Juergen Gross (4):
      acpi: Introduce acpi_arch_get_root_pointer() for getting rsdp address
      x86/acpi: Add a new x86_init_acpi structure to x86_init_ops
      x86/xen: Add pvh specific rsdp address retrieval function
      x86/boot: Make the x86_init noop functions static

Kirill A. Shutemov (39):
      x86/boot/compressed/64: Rename pagetable.c to kaslr_64.c
      x86/boot/compressed/64: Introduce paging_prepare()
      x86/mm/encrypt: Move page table helpers into separate translation unit
      x86/mm/encrypt: Simplify sme_populate_pgd() and sme_populate_pgd_large()
      x86/mm/encrypt: Simplify sme_pgtable_calc()
      x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52
      mm/zsmalloc: Prepare to variable MAX_PHYSMEM_BITS
      x86/mm: Make virtual memory layout dynamic for CONFIG_X86_5LEVEL=y
      x86/mm: Introduce 'pgtable_l5_enabled'
      x86/mm: Make LDT_BASE_ADDR dynamic
      x86/mm: Make PGDIR_SHIFT and PTRS_PER_P4D variable
      x86/mm: Make MAX_PHYSADDR_BITS and MAX_PHYSMEM_BITS dynamic
      x86/mm: Make __VIRTUAL_MASK_SHIFT dynamic
      x86/mm: Initialize 'pgtable_l5_enabled' at boot-time
      x86/mm: Initialize 'pgdir_shift' and 'ptrs_per_p4d' at boot-time
      x86/mm: Initialize 'page_offset_base' at boot-time
      x86/mm: Adjust vmalloc base and size at boot-time
      x86/mm: Initialize vmemmap_base at boot-time
      x86/mm: Support boot-time switching of paging modes in the early boot code
      x86/mm: Fold p4d page table layer at runtime
      x86/mm: Replace compile-time checks for 5-level paging with runtime-time checks
      x86/mm: Allow to boot without LA57 if CONFIG_X86_5LEVEL=y
      x86/xen: Allow XEN_PV and XEN_PVH to be enabled with X86_5LEVEL
      x86/mm: Redefine some of page table helpers as macros
      x86/mm: Optimize boot-time paging mode switching cost
      x86/boot/compressed/64: Describe the logic behind the LA57 check
      x86/boot/compressed/64: Find a place for 32-bit trampoline
      x86/boot/compressed/64: Save and restore trampoline memory
      x86/boot/compressed/64: Set up trampoline memory
      x86/boot/compressed/64: Prepare new top-level page table for trampoline
      x86/mm: Do not use paravirtualized calls in native_set_p4d()
      x86/boot/compressed/64: Make sure we have a 32-bit code segment
      x86/boot/compressed/64: Use stack from trampoline memory
      x86/boot/compressed/64: Use page table in trampoline memory
      x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G
      x86/tme: Detect if TME and MKTME is activated by BIOS
      x86/pconfig: Detect PCONFIG targets
      x86/pconfig: Provide defines and helper to run MKTME_KEY_PROG leaf
      x86/mm: Update comment in detect_tme() regarding x86_phys_bits

Nadav Amit (1):
      x86/mm: Align TLB invalidation info

Tom Lendacky (2):
      x86/mm/sme: Disable stack protection for mem_encrypt_identity.c
      x86/boot: Fix SEV boot failure from change to __PHYSICAL_MASK_SHIFT

Toshi Kani (1):
      x86/mm: Remove pointless checks in vmalloc_fault


 Documentation/admin-guide/kernel-parameters.txt    |   9 +
 Documentation/x86/x86_64/5level-paging.txt         |   9 +-
 arch/x86/Kconfig                                   |  17 +-
 arch/x86/boot/compressed/Makefile                  |   2 +-
 arch/x86/boot/compressed/head_64.S                 | 168 ++++--
 arch/x86/boot/compressed/kaslr.c                   |  14 +
 .../boot/compressed/{pagetable.c => kaslr_64.c}    |  14 +-
 arch/x86/boot/compressed/mem_encrypt.S             |  17 +-
 arch/x86/boot/compressed/misc.c                    |  22 +-
 arch/x86/boot/compressed/misc.h                    |   7 +-
 arch/x86/boot/compressed/pgtable.h                 |  20 +
 arch/x86/boot/compressed/pgtable_64.c              | 148 +++++-
 arch/x86/entry/entry_64.S                          |   5 +
 arch/x86/include/asm/acpi.h                        |  11 +
 arch/x86/include/asm/intel_pconfig.h               |  65 +++
 arch/x86/include/asm/kaslr.h                       |   4 -
 arch/x86/include/asm/mem_encrypt.h                 |   1 +
 arch/x86/include/asm/page_64.h                     |   4 +
 arch/x86/include/asm/page_64_types.h               |  20 +-
 arch/x86/include/asm/paravirt.h                    |  21 +-
 arch/x86/include/asm/pgalloc.h                     |   5 +-
 arch/x86/include/asm/pgtable-3level_types.h        |   1 +
 arch/x86/include/asm/pgtable.h                     |  11 +-
 arch/x86/include/asm/pgtable_32.h                  |   2 +
 arch/x86/include/asm/pgtable_32_types.h            |   2 +
 arch/x86/include/asm/pgtable_64.h                  |  23 +-
 arch/x86/include/asm/pgtable_64_types.h            |  70 ++-
 arch/x86/include/asm/required-features.h           |   8 +-
 arch/x86/include/asm/sparsemem.h                   |   9 +-
 arch/x86/include/asm/x86_init.h                    |  11 +
 arch/x86/kernel/acpi/boot.c                        |  22 +-
 arch/x86/kernel/cpu/Makefile                       |   2 +-
 arch/x86/kernel/cpu/intel.c                        |  87 ++++
 arch/x86/kernel/cpu/intel_pconfig.c                |  82 +++
 arch/x86/kernel/cpu/mcheck/mce.c                   |  18 +-
 arch/x86/kernel/e820.c                             |  18 +
 arch/x86/kernel/head64.c                           |  81 ++-
 arch/x86/kernel/head_64.S                          |  22 +-
 arch/x86/kernel/machine_kexec_64.c                 |   1 +
 arch/x86/kernel/setup.c                            |   5 +-
 arch/x86/kernel/x86_init.c                         |  15 +-
 arch/x86/mm/Makefile                               |  15 +-
 arch/x86/mm/debug_pagetables.c                     |  32 ++
 arch/x86/mm/dump_pagetables.c                      | 125 +++--
 arch/x86/mm/fault.c                                |  60 +--
 arch/x86/mm/ident_map.c                            |   2 +-
 arch/x86/mm/init_64.c                              |  32 +-
 arch/x86/mm/kasan_init_64.c                        |  20 +-
 arch/x86/mm/kaslr.c                                |  29 +-
 arch/x86/mm/mem_encrypt.c                          | 578 +--------------------
 arch/x86/mm/mem_encrypt_identity.c                 | 564 ++++++++++++++++++++
 arch/x86/mm/numa_32.c                              |  11 -
 arch/x86/mm/tlb.c                                  |   4 +-
 arch/x86/platform/efi/efi_64.c                     |  10 +-
 arch/x86/platform/intel-mid/intel-mid.c            |   6 +
 arch/x86/power/hibernate_64.c                      |   6 +-
 arch/x86/xen/Kconfig                               |   5 -
 arch/x86/xen/enlighten_pvh.c                       |  14 +-
 arch/x86/xen/mmu_pv.c                              |  21 +
 drivers/acpi/osl.c                                 |   5 +-
 include/asm-generic/5level-fixup.h                 |   1 +
 include/asm-generic/pgtable-nop4d.h                |   9 +-
 include/linux/acpi.h                               |   7 +
 include/linux/kasan.h                              |   2 +-
 include/linux/mmzone.h                             |   5 -
 mm/kasan/kasan_init.c                              |   2 +-
 mm/sparse.c                                        |  22 -
 mm/zsmalloc.c                                      |  13 +-
 68 files changed, 1657 insertions(+), 1016 deletions(-)
 rename arch/x86/boot/compressed/{pagetable.c => kaslr_64.c} (91%)
 create mode 100644 arch/x86/boot/compressed/pgtable.h
 create mode 100644 arch/x86/include/asm/intel_pconfig.h
 create mode 100644 arch/x86/kernel/cpu/intel_pconfig.c
 create mode 100644 arch/x86/mm/mem_encrypt_identity.c
