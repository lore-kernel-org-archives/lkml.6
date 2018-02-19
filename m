Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeBSCEd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 21:04:33 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:54864 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeBSCEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 21:04:30 -0500
X-Google-Smtp-Source: AH8x227P+LqfjbhW58jkyBBHLw/w8lZLbPDNCitlO6Giinb8G/yiW/MiVDzCE2fmgdXsu3Md3P3TftwxGr9IRfov/VE=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 18 Feb 2018 18:04:28 -0800
X-Google-Sender-Auth: JZAgyAXiEHvbuhtcxuY3Je4VOrI
Message-ID: <CA+55aFwDnBq9V6TVbc82DzVYpf-ELF7UcYzHuY0ei1Xjnob+0A@mail.gmail.com>
Subject: Linux 4.16-rc2
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1J24bqX010813

It's been a quiet week, and rc2 is out.

I take the fairly quiet rc be a good sign for 4.16, but honestly, rc2
is often fairly calm. That's probably because people are taking a
breather after the merge window, but also simply because it might take
a while to find any issues.

But let's be optimistic, and just assume - at least for now - that
it's because all is well.

The diffstat is fairly odd, but that often happens with small rc's
just because then just a couple of pulls will skew things easily in
one or two directions. This time the patch is about one third
architecture updates (arm64, x86, powerpc), one third tooling (mostly
'perf') and one third "rest". And yes, the bulk of that rest is
drivers (gpu, nvme, sound, misc), but those drivers are still
distinctly *not* the bulk of the whole patch.

Go out and test, it all looks fine.

                 Linus

---

Aaron Ma (1):
      platform/x86: ideapad-laptop: Increase timeout to wait for EC answer

Aishwarya Pant (3):
      Documentation/ABI: update cpuidle sysfs documentation
      ACPI / DPTF: Document dptf_power sysfs atttributes
      ACPI: dock: document sysfs interface

Alexander Abrosimov (1):
      platform/x86: dell-laptop: Removed duplicates in DMI whitelist

Alexey Kardashevskiy (1):
      powerpc/mm: Flush radix process translations when setting MMU type

Andreas Gruenbacher (1):
      gfs2: Fixes to "Implement iomap for block_map"

Andrey Ryabinin (1):
      platform/x86: wmi: fix off-by-one write in wmi_dev_probe()

Andy Lutomirski (1):
      x86/mm: Rename flush_tlb_single() and flush_tlb_one() to
__flush_tlb_one_[user|kernel]()

Andy Shevchenko (6):
      ACPI / bus: Do not traverse through non-existed device table
      ACPI / bus: Remove checks in acpi_get_match_data()
      ACPI / bus: Rename acpi_get_match_data() to acpi_device_get_match_data()
      device property: Constify device_get_match_data()
      perf tools: Substitute yet another strtoull()
      irqdomain: Re-use DEFINE_SHOW_ATTRIBUTE() macro

Aneesh Kumar K.V (4):
      powerpc/mm: Fix crashes with 16G huge pages
      powerpc/mm/hash64: Allocate larger PMD table if hugetlb config is enabled
      powerpc/mm/hash64: Store the slot information at the right
offset for hugetlb
      powerpc/mm/hash64: Zero PGD pages on allocation

Ard Biesheuvel (1):
      crypto: sha3-generic - deal with oversize stack frames

Arnaldo Carvalho de Melo (1):
      perf evsel: Expose the perf_missing_features struct

Arnd Bergmann (2):
      x86/error_inject: Make just_return_func() globally visible
      mm: hide a #warning for COMPILE_TEST

Artem Savkov (2):
      crypto: sun4i_ss_prng - fix return value of sun4i_ss_prng_generate
      crypto: sun4i_ss_prng - convert lock to _bh in sun4i_ss_prng_generate

Balbir Singh (1):
      powerpc/mm/radix: Split linear mapping on hot-unplug

Borislav Petkov (2):
      x86/MCE: Fix build warning introduced by "x86: do not use print_symbol()"
      x86/entry/64: Remove the unused 'icebp' macro

Chris Wilson (7):
      drm/i915/perf: Fix compiler warning for string truncation
      drm/i915/perf: Fix compiler warning for string truncation
      drm/i915: Avoid truncation before clamping userspace's priority value
      drm/i915: Don't wake the device up to check if the engine is asleep
      drm/i915/breadcrumbs: Ignore unsubmitted signalers
      drm/i915: Lock out execlist tasklet while peeking inside for busy-stats
      drm/i915/pmu: Fix building without CONFIG_PM

Christian Borntraeger (1):
      virtio/s390: implement PM operations for virtio_ccw

Christoph Hellwig (4):
      dma-direct: mark as is_phys
      dma-direct: comment the dma_direct_free calling convention
      dma-mapping: fix a comment typo
      powerpc/macio: set a proper dma_coherent_mask

Colin Ian King (1):
      ocxl: fix signed comparison with less than zero

Corentin Labbe (2):
      ia64: fix build failure with CONFIG_SWIOTLB
      powerpc/pseries: Add empty update_numa_cpu_lookup_table() for NUMA=n

Cyril Bur (1):
      powerpc: Expose TSCR via sysfs only on powernv

Cédric Le Goater (1):
      powerpc/xive: Use hw CPU ids when configuring the CPU queues

Dan Carpenter (1):
      x86/spectre: Fix an error message

Dan Williams (4):
      x86/entry/64: Clear extra registers beyond syscall arguments, to
reduce speculation attack surface
      x86/entry/64: Clear registers for exceptions/interrupts, to
reduce speculation attack surface
      x86/entry/64/compat: Clear registers for compat syscalls, to
reduce speculation attack surface
      x86/speculation: Fix up array_index_nospec_mask() asm constraint

Daniel Mack (1):
      ALSA: usb: add more device quirks for USB DSD devices

David Woodhouse (4):
      x86/speculation: Update Speculation Control microcode blacklist
      x86/speculation: Correct Speculation Control microcode blacklist again
      Revert "x86/speculation: Simplify indirect_branch_prediction_barrier()"
      KVM/x86: Reduce retpoline performance impact in
slot_handle_level_range(), by always inlining iterator helper methods

Dominik Brodowski (13):
      x86/entry/64: Merge SAVE_C_REGS and SAVE_EXTRA_REGS, remove
unused extensions
      x86/entry/64: Merge the POP_C_REGS and POP_EXTRA_REGS macros
into a single POP_REGS macro
      x86/entry/64: Interleave XOR register clearing with PUSH instructions
      x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS macro
      x86/entry/64: Use PUSH_AND_CLEAN_REGS in more cases
      x86/entry/64: Get rid of the ALLOC_PT_GPREGS_ON_STACK and
SAVE_AND_CLEAR_REGS macros
      x86/entry/64: Indent PUSH_AND_CLEAR_REGS and POP_REGS properly
      selftests/x86: Fix vDSO selftest segfault for vsyscall=none
      selftests/x86: Clean up and document sscanf() usage
      selftests/x86: Fix build bug caused by the 5lvl test which has
been moved to the VM directory
      selftests/x86: Do not rely on "int $0x80" in test_mremap_vdso.c
      selftests/x86: Do not rely on "int $0x80" in single_step_syscall.c
      selftests/x86: Disable tests requiring 32-bit support on pure
64-bit systems

Eric Biggers (1):
      crypto: sha512-mb - initialize pending lengths correctly

Filipe Manana (1):
      Btrfs: fix null pointer dereference when replacing missing device

Geert Uytterhoeven (4):
      compiler-gcc.h: Introduce __optimize function attribute
      compiler-gcc.h: __nostackprotector needs gcc-4.4 and up
      crypto: sha3-generic - Use __optimize to support old compilers
      mtd: nand: MTD_NAND_MARVELL should depend on HAS_DMA

Greg Kurz (1):
      9p/trans_virtio: discard zero-length reply

Guenter Roeck (3):
      hwmon: (k10temp) Only apply temperature offset if result is positive
      powerpc/pseries: Fix build break for SPLPAR=n and CPU hotplug
      powerpc/kdump: Fix powernv build break when KEXEC_CORE=n

Gustavo A. R. Silva (2):
      ACPI: SPCR: Mark expected switch fall-through in acpi_parse_spcr
      x86/cpu: Change type of x86_cache_size variable to unsigned int

Hans de Goede (4):
      drm/i915/vlv: Add cdclk workaround for DSI
      drm/i915: Add intel_bios_cleanup() function
      drm/i915: Free memdup-ed DSI VBT data structures on driver_unload
      drm/i915: Fix DSI panels with v1 MIPI sequences without a
DEASSERT sequence v3

Harish (1):
      selftests/powerpc: Fix to use ucontext_t instead of struct ucontext

Hendrik Brueckner (3):
      perf s390: Grab a copy of arch/s390/kernel/syscall/syscall.tbl
      perf s390: Rework system call table creation by using syscall.tbl
      Revert "tools include s390: Grab a copy of
arch/s390/include/uapi/asm/unistd.h"

Horia Geantă (1):
      crypto: caam - fix endless loop when DECO acquire fails

Hui Wang (1):
      ALSA: hda - Fix headset mic detection problem for two Dell machines

Ingo Molnar (5):
      x86/Kconfig: Further simplify the NR_CPUS config
      x86/speculation: Clean up various Spectre related details
      selftests/x86/pkeys: Remove unused functions
      x86/entry/64: Fix CR3 restore in paranoid_exit()
      tools/headers: Synchronize kernel ABI headers, v4.16-rc1

Israel Rukshin (1):
      nvmet: Change return code of discard command if not supported

Jaedon Shin (2):
      MIPS: BMIPS: Fix section mismatch warning
      irqchip/bcm: Remove hashed address printing

James Hogan (2):
      usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT
      sparc,leon: Select USB_UHCI_BIG_ENDIAN_{MMIO,DESC}

James Smart (2):
      nvme_fc: correct abort race condition on resets
      nvme_fc: cleanup io completion

Jan-Marek Glogowski (1):
      ALSA: hda/realtek: PCI quirk for Fujitsu U7x7

Jerome Brunet (1):
      Revert "mmc: meson-gx: include tx phase in the tuning process"

Jessica Yu (2):
      kprobes: Propagate error from arm_kprobe_ftrace()
      kprobes: Propagate error from disarm_kprobe_ftrace()

Jia Zhang (3):
      vfs/proc/kcore, x86/mm/kcore: Fix SMAP fault when dumping
vsyscall user page
      x86/mm/kcore: Add vsyscall page to /proc/kcore conditionally
      x86/cpu: Rename cpu_data.x86_mask to cpu_data.x86_stepping

Jia-Ju Bai (1):
      opp: cpu: Replace GFP_ATOMIC with GFP_KERNEL in
dev_pm_opp_init_cpufreq_table

Jianchao Wang (1):
      nvme: fix the deadlock in nvme_update_formats

Joao Martins (1):
      xenbus: track caller request id

Josh Poimboeuf (3):
      x86/entry/64: Fix paranoid_entry() frame pointer warning
      objtool: Fix segfault in ignore_unreachable_insn()
      x86/debug, objtool: Annotate WARN()-related UD2 as reachable

Juri Lelli (1):
      Documentation/locking/mutex-design: Update to reflect latest changes

Kai-Heng Feng (1):
      drm/amdgpu: add new device to use atpx quirk

Kailang Yang (2):
      ALSA: hda/realtek - Add headset mode support for Dell laptop
      ALSA: hda/realtek - Enable Thinkpad Dock device for ALC298 platform

Kan Liang (16):
      perf evlist: Remove stale mmap read for backward
      perf mmap: Recalculate size for overwrite mode
      perf mmap: Cleanup perf_mmap__push()
      perf mmap: Introduce perf_mmap__read_init()
      perf mmap: Add new return value logic for perf_mmap__read_init()
      perf mmap: Discard 'prev' in perf_mmap__read()
      perf mmap: Introduce perf_mmap__read_done()
      perf mmap: Introduce perf_mmap__read_event()
      perf test: Update mmap read functions for backward-ring-buffer test
      perf mmap: Discard legacy interface for mmap read
      perf top: Check per-event overwrite term
      perf top: Add overwrite fall back
      perf hists browser: Add parameter to disable lost event warning
      perf top: Remove lost events checking
      perf top: Switch default mode to overwrite mode
      perf top: Check the latency of perf_top__mmap_read()

KarimAllah Ahmed (2):
      X86/nVMX: Properly set spec_ctrl and pred_cmd before merging MSRs
      KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we have a valid
L02 MSR bitmap

Keith Busch (3):
      nvme: Fix discard buffer overrun
      nvme-pci: Remap CMB SQ entries on every controller reset
      nvme-pci: Fix timeouts in connecting state

Kirill Marinushkin (1):
      ALSA: usb-audio: Fix UAC2 get_ctl request with a RANGE attribute

LEROY Christophe (1):
      crypto: talitos - fix Kernel Oops on hashing an empty file

Lassi Ylikojola (1):
      ALSA: usb-audio: add implicit fb quirk for Behringer UFX1204

Laszlo Toth (1):
      platform/x86: dell-laptop: fix kbd_get_state's request value

Leo Yan (1):
      sched/cpufreq: Remove unused SUGOV_KTHREAD_PRIORITY macro

Linus Torvalds (1):
      Linux 4.16-rc2

Liu Bo (6):
      Btrfs: fix deadlock in run_delalloc_nocow
      Btrfs: fix crash due to not cleaning up tree log block's dirty bits
      Btrfs: fix extent state leak from tree log
      Btrfs: fix btrfs_evict_inode to handle abnormal inodes correctly
      Btrfs: fix use-after-free on root->orphan_block_rsv
      Btrfs: fix unexpected -EEXIST when creating new inode

Lukas Wunner (1):
      PM / runtime: Update links_count also if !CONFIG_SRCU

Madhavan Srinivasan (1):
      powerpc/64s: Fix MASKABLE_RELON_EXCEPTION_HV_OOL macro

Marc Zyngier (1):
      irqchip/gic-v2m: Add PCI Multi-MSI support

Marcin Nowakowski (1):
      MIPS: Fix incorrect mem=X@Y handling

Mark Salter (1):
      irqchip/gic-v3: Change pr_debug message to pr_devel

Masayoshi Mizuma (1):
      x86/smpboot: Fix uncore_pci_remove() indexing bug when
hot-removing a physical CPU

Mathieu Desnoyers (1):
      membarrier-sync-core: Document architecture support

Matt Redfearn (1):
      irqchip/mips-gic: Avoid spuriously handling masked interrupts

Matthew Whitehead (3):
      x86/Kconfig: Add missing i586-class CPUs to the X86_CMPXCHG64
Kconfig group
      x86/Kconfig: Exclude i586-class CPUs lacking PAE support from
the HIGHMEM64G Kconfig group
      x86/Kconfig: Explicitly enumerate i686-class CPUs in Kconfig

Matthias Lange (1):
      ALSA: ac97: Fix copy and paste typo in documentation

Max Gurtovoy (3):
      nvme: rename NVME_CTRL_RECONNECTING state to NVME_CTRL_CONNECTING
      nvme-rdma: use NVME_CTRL_CONNECTING state to mark init process
      nvme: delete NVME_CTRL_LIVE --> NVME_CTRL_CONNECTING transition

Michael Kelley (1):
      cpumask: Make for_each_cpu_wrap() available on UP as well

Minwoo Im (1):
      block: fix a typo in comment of BLK_MQ_POLL_STATS_BKTS

Nadav Amit (1):
      x86/mm/pti: Fix PTI comment in entry_SYSCALL_64()

Nathan Fontenot (2):
      powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove
      powerpc/pseries: Check for zero filled ibm,dynamic-memory property

NeilBrown (1):
      dm: correctly handle chained bios in dec_pending()

Nicholas Piggin (4):
      powerpc/64s: Fix may_hard_irq_enable() for PMI soft masking
      powerpc/64s/radix: Boot-time NULL pointer protection using a guard-PID
      powerpc/vas: Don't set uses_vas for kernel windows
      powerpc/powernv: IMC fix out of bounds memory access at shutdown

Nikolay Borisov (2):
      btrfs: Ignore errors from btrfs_qgroup_trace_extent_post
      btrfs: Fix use-after-free when cleaning up fs_devs with a single
stale device

Nitesh Shetty (1):
      blk: optimization for classic polling

Nitzan Carmi (1):
      nvme-rdma: fix sysfs invoked reset_ctrl error flow

Paul Burton (2):
      dt-bindings: Document mti,mips-cpc binding
      MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()

Peter Zijlstra (7):
      x86/cpufeature: Reindent _static_cpu_has()
      x86/cpufeature: Update _static_cpu_has() to use all named variables
      objtool: Fix switch-table detection
      MAINTAINERS: Add Peter Zijlstra as objtool co-maintainer
      sched/core: Fix DEBUG_SPINLOCK annotation for rq->lock
      x86/debug: Use UD2 for WARN()
      x86/speculation: Add <asm/msr-index.h> dependency

Phil Elwell (1):
      mmc: bcm2835: Don't overwrite max frequency unconditionally

Prarit Bhargava (1):
      x86/xen: Calculate __max_logical_packages on PV domains

Progyan Bhattacharya (1):
      x86/build: Add arch/x86/tools/insn_decoder_test to .gitignore

Rafael J. Wysocki (2):
      ACPI / EC: Restore polling during noirq suspend/resume phases
      PM: cpuidle: Fix cpuidle_poll_state_init() prototype

Randy Dunlap (1):
      x86/Kconfig: Simplify NR_CPUS config

Robin Murphy (1):
      arm64: cputype: Silence Sparse warnings

Roland Dreier (1):
      nvme: Don't use a stack buffer for keep-alive command

Rui Wang (1):
      selftests/x86/mpx: Fix incorrect bounds with old _sigfault

Sam Bobroff (1):
      powerpc/pseries: Enable RAS hotplug events later

Sangwon Hong (1):
      perf data: Document missing --force option

Shanker Donthineni (2):
      arm64: Add missing Falkor part number for branch predictor hardening
      irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()

Stefan Agner (1):
      mtd: nand: vf610: set correct ooblayout

Stefano Stabellini (2):
      pvcalls-front: introduce a per sock_mapping refcount
      pvcalls-front: wait for other operations to return when release
passive sockets

Stephen Boyd (1):
      irqchip/gic-v3: Ignore disabled ITS nodes

Takashi Iwai (1):
      ALSA: seq: Fix racy pool initializations

Thierry Reding (1):
      drm/nouveau: Make clock gate support conditional

Thomas Richter (1):
      perf test: Fix test trace+probe_libc_inet_pton.sh for s390x

Tina Zhang (1):
      drm/i915/gvt: Support BAR0 8-byte reads/writes

Tony Lindgren (1):
      PM / wakeirq: Fix unbalanced IRQ enable for wakeirq

Tony Luck (1):
      x86/mm, mm/hwpoison: Don't unconditionally unmap kernel 1:1 pages

Tvrtko Ursulin (2):
      drm/i915/pmu: Fix PMU enable vs execlists tasklet race
      drm/i915/pmu: Fix sleep under atomic in RC6 readout

Tycho Andersen (1):
      locking/semaphore: Update the file path in documentation

Ulf Magnusson (1):
      ALSA: ac97: kconfig: Remove select of undefined symbol AC97

Weinan Li (2):
      drm/i915/gvt: add 0xe4f0 into gen9 render list
      drm/i915/gvt: fix one typo of render_mmio trace

Wen Yang (2):
      sched/deadline: Make update_curr_dl() more accurate
      sched/rt: Make update_curr_rt() more accurate

Will Deacon (6):
      locking/qspinlock: Ensure node is initialised before updating prev->next
      locking/qspinlock: Ensure node->count is updated before initialising node
      locking/atomic/bitops: Document and clarify ordering semantics
for failed test_and_{}_bit()
      arm64: proc: Set PTE_NG for table entries to avoid traversing them twice
      nospec: Move array_index_nospec() parameter checking into separate macro
      arm64: mm: Use READ_ONCE/WRITE_ONCE when accessing page tables

William Cohen (1):
      perf vendor events aarch64: Add JSON metrics for ARM Cortex-A53 Processor

Zygo Blaxell (1):
      btrfs: remove spurious WARN_ON(ref->count < 0) in find_parent_nodes

mike.travis@hpe.com (1):
      x86/platform/UV: Fix GAM Range Table entries less than 1GB
