Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932466AbeCDXPn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 18:15:43 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:44966 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932206AbeCDXPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 18:15:40 -0500
X-Google-Smtp-Source: AG47ELsMMunOSGj2/5dTBR8a7s+gX7mpBWI+SKit8TajmPsm4Pn8ZbgC47DE9mmRLzZlxLT/Vgzh2Sqlx0yP+Ax5b9M=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Mar 2018 15:15:38 -0800
X-Google-Sender-Auth: Tx5Vo5ZcxNFPsz2vi68JUy6yMbw
Message-ID: <CA+55aFxXg8hi+T_DNCG_OrAotqSheyREw-Njf9XgUD1vXqAyHQ@mail.gmail.com>
Subject: Linux 4.16-rc4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w24NFqGS013685

Hmm. A reasonably calm week - the biggest change is to the 'kvm-stat'
tool, not any actual kernel files.

But there's small changes all over, with architecture updates (x86,
s390, arm, parisc) and drivers (media, md, gpu, sound) being the bulk
of it.  But there's some filesystem fixes (mostly btrfs),
documentation updates etc too.

Go test,

                Linus

---

Adam Ford (2):
      ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux
      ARM: dts: LogicPD SOM-LV: Fix I2C1 pinmux

Adrian Hunter (1):
      mmc: sdhci-pci: Fix S0i3 for Intel BYT-based controllers

Alex Deucher (3):
      drm/amd/powerplay/vega10: allow mclk switching with no displays
      drm/amd/powerplay/smu7: allow mclk switching with no displays
      Revert "drm/radeon/pm: autoswitch power state when in balanced mode"

Alexandre Belloni (1):
      MAINTAINERS: ARM: at91: update my email address

Alexandre Torgue (1):
      MAINTAINERS: update entries for ARM/STM32

Alexey Brodkin (2):
      ARCv2: Don't pretend we may set L-bit in STATUS32 with kflag instruction
      ARC: Enable fatal signals on boot for dev platforms

Aliaksei Karaliou (1):
      md/raid5: simplify uninitialization of shrinker

Anand Jain (1):
      btrfs: use proper endianness accessors for super_copy

Anders Roxell (2):
      selftests: sync: missing CFLAGS while compiling
      selftests: memfd: add config fragment for fuse

Andrea Parri (1):
      riscv/barrier: Define __smp_{mb,rmb,wmb}

Andy Shevchenko (1):
      auxdisplay: Move arm-charlcd binding to correct folder

Anna Karbownik (1):
      EDAC, sb_edac: Fix out of bound writes during DIMM configuration on KNL

Arnd Bergmann (10):
      ARM: kvm: fix building with gcc-8
      watchdog: rave-sp: add NVMEM dependency
      md: raid5: avoid string overflow warning
      ARM: clps711x: mark clps711x_compat as const
      ARM: davinci: mark spi_board_info arrays as const
      ARM: orion: fix orion_ge00_switch_board_info initialization
      media: dvb: fix DVB_MMAP symbol name
      media: dvb: fix DVB_MMAP dependency
      media: au0828: add VIDEO_V4L2 dependency
      ARM: omap2: set CONFIG_LIRC=y in defconfig

Artur Paszkiewicz (1):
      raid5-ppl: fix handling flush requests

Arvind Prasanna (1):
      kconfig: Update ncurses package names for menuconfig

Baegjae Sung (1):
      nvme-multipath: fix sysfs dangerously created links

Bartosz Golaszewski (1):
      arc: dts: use 'atmel' as manufacturer for at24 in axs10x_mb

Ben Crocker (1):
      drm/radeon: insist on 32-bit DMA for Cedar on PPC64/PPC64LE

BingJing Chang (1):
      md: fix a potential deadlock of raid5/raid10 reshape

Boaz Harrosh (1):
      dax: ->direct_access does not sleep anymore

Borislav Petkov (3):
      x86/microcode: Propagate return value from updating functions
      x86/CPU: Add a microcode loader callback
      x86/CPU: Check CPU feature bits after microcode upgrade

Brijesh Singh (5):
      crypto: ccp: Fix sparse, use plain integer as NULL pointer
      include: psp-sev: Capitalize invalid length enum
      KVM: SVM: no need to call access_ok() in LAUNCH_MEASURE command
      KVM: SVM: install RSM intercept
      KVM: SVM: Fix SEV LAUNCH_SECRET command

Cao jin (2):
      kbuild: drop superfluous GCC_PLUGINS_CFLAGS assignment
      kbuild/kallsyms: trivial typo fix

Chao Gao (1):
      KVM: nVMX: Don't halt vcpu when L1 is injecting events to L2

Chen-Yu Tsai (1):
      gpio: Handle deferred probing in of_find_gpio() properly

Chengguang Xu (4):
      libceph, ceph: avoid memory leak when specifying same option several times
      ceph: fix dentry leak when failing to init debugfs
      xfs: fix potential memory leak in mount option parsing
      ceph: fix potential memory leak in init_caches()

Chris Wilson (1):
      drm/i915: Clear the in-use marker on execbuf failure

Christian Borntraeger (5):
      KVM: s390: optimize wakeup for exitless interrupts
      KVM: s390: do not set intervention requests for GISA interrupts
      KVM: s390: force bp isolation for VSIE
      KVM: s390: use switch vs jump table in priv.c
      KVM: s390: use switch vs jump table in intercept.c

Christian König (1):
      PCI: Allow release of resources that were never assigned

Christoffer Dall (1):
      KVM: arm/arm64: Fix arch timers with userspace irqchips

Christoph Hellwig (3):
      nvme-fabrics: don't check for non-NULL module in nvmf_register_transport
      nvme-rdma: use blk_rq_payload_bytes instead of blk_rq_bytes
      nvmet-loop: use blk_rq_payload_bytes for sgl selection

Colin Ian King (2):
      clocksource/drivers/fsl_ftm_timer: Fix error return checking
      xen/pvcalls: fix null pointer dereference on map->sock

Coly Li (1):
      bcache: correct flash only vols (check all uuids)

Dafna Hirschfeld (1):
      Coccinelle: memdup: Fix typo in warning messages

Damien Le Moal (1):
      mq-deadline: Make sure to always unlock zones

Dan Williams (5):
      nospec: Kill array_index_nospec_mask_check()
      nospec: Include <asm/barrier.h> dependency
      dax: fix vma_is_fsdax() helper
      vfio: disable filesystem-dax page pinning
      memremap: fix softlockup reports at teardown

Daniel Díaz (2):
      selftests/android: Fix line continuation in Makefile
      selftests/futex: Fix line continuation in Makefile

Daniel Schultz (1):
      ARM: dts: rockchip: Remove 1.8 GHz operation point from phycore som

Daniele Ceraolo Spurio (1):
      drm/i915: Fix rsvd2 mask when out-fence is returned

Darrick J. Wong (1):
      xfs: reserve blocks for refcount / rmap log item recovery

Dave Airlie (1):
      virtio-gpu: fix ioctl and expose the fixed status to userspace.

Dave Jiang (1):
      libnvdimm: re-enable deep flush for pmem devices via fsync()

David Hildenbrand (5):
      KVM: s390: use switch vs jump table in interrupt.c
      KVM: s390: take care of clock-comparator sign control
      KVM: s390: consider epoch index on hotplugged CPUs
      KVM: s390: consider epoch index on TOD clock syncs
      KVM: s390: provide only a single function for setting the tod (fix SCK)

David Woodhouse (3):
      Revert "x86/retpoline: Simplify vmexit_fill_RSB()"
      x86/speculation: Use IBRS if available before calling into firmware
      x86/retpoline: Support retpoline builds with Clang

Dietmar Eggemann (1):
      cpufreq: scpi: invoke frequency-invariance setter function

Dominik Brodowski (9):
      selftest/vDSO: fix O=
      x86/entry: Reduce the code footprint of the 'idtentry' macro
      x86/entry/64: Use 'xorl' for faster register clearing
      x86/entry/64: Move PUSH_AND_CLEAR_REGS from interrupt macro to
helper function
      x86/entry/64: Move ENTER_IRQ_STACK from interrupt macro to interrupt_entry
      x86/entry/64: Move the switch_to_thread_stack() call to interrupt_entry()
      x86/entry/64: Remove 'interrupt' macro
      x86/entry/64: Move ASM_CLAC to interrupt_entry()
      x86/entry/64: Open-code switch_to_thread_stack()

Dong Aisheng (1):
      dt-bindings: thermal: imx: update the binding to new method

Dou Liyang (1):
      x86/kvm: Make parse_no_xxx __init for kvm

Emily Deng (1):
      drm/amdgpu: Correct sdma_v4 get_wptr(v2)

Eric Biggers (2):
      KVM/x86: remove WARN_ON() for when vm_munmap() fails
      blktrace_api.h: fix comment for struct blk_user_trace_setup

Eric Huang (1):
      drm/amd/powerplay: fix power over limit on Fiji

Eric Sandeen (1):
      xfs: use memset to initialize xfs_scrub_agfl_info

Erik Veijola (1):
      ALSA: usb-audio: Add a quirck for B&W PX headphones

Eugeniy Paltsev (4):
      ARCv2: cache: fix slc_entire_op: flush only instead of flush-n-inv
      ARC: mcip: halt GFRC counter when ARC cores halt
      ARC: mcip: update MCIP debug mask when the new cpu came online
      ARC: setup cpu possible mask according to possible-cpus dts property

Felix Fietkau (1):
      clocksource/drivers/mips-gic-timer: Use correct shift count to
extract data

Filipe Manana (3):
      Btrfs: send, fix issuing write op when processing hole in no data mode
      Btrfs: fix log replay failure after linking special file and fsync
      Btrfs: fix log replay failure after unlink and link combination

Florian Fainelli (1):
      ARM: dts: NSP: Fix amount of RAM on BCM958625HR

Geert Uytterhoeven (5):
      ARM: OMAP1: clock: Fix debugfs_create_*() usage
      ARM: dts: OMAP5: uevm: Fix "debounce-interval" property misspelling
      dt-bindings: power: Fix "debounce-interval" property misspelling
      mmc: dw_mmc-k3: Fix out-of-bounds access through DT alias
      dt-bindings/irqchip/renesas-irqc: Document R-Car M3-N support

Gregory CLEMENT (1):
      MAINTAINERS: update email address for Gregory CLEMENT

Guoqing Jiang (1):
      raid10: change the size of resync window for clustered raid

Gustavo A. R. Silva (1):
      nbd: fix return value in error handling path

Hans de Goede (1):
      ALSA: hda: Add a power_save blacklist

Hans van Kranenburg (1):
      btrfs: alloc_chunk: fix DUP stripe size handling

Heinz Mauelshagen (1):
      md: fix md_write_start() deadlock w/o metadata devices

Helge Deller (4):
      parisc: Hide virtual kernel memory layout
      parisc: Check if secondary CPUs want own PDC calls
      parisc: Use cr16 interval timers unconditionally on qemu
      parisc: Reduce irq overhead when run in qemu

Hersen Wu (1):
      drm/amd/display: VGA black screen from s3 when attached to hook

Ilia Mirkin (1):
      drm/nouveau: prefer XBGR2101010 for addfb ioctl

Ingo Molnar (1):
      x86/speculation: Move firmware_restrict_branch_speculation_*()
from C to CPP

James Zhu (1):
      drm/amdgpu:Fixed wrong emit frame size for enc

Jan Beulich (7):
      x86/mm: Fix {pmd,pud}_{set,clear}_flags()
      x86/asm: Improve how GEN_*_SUFFIXED_RMWcc() specify clobbers
      x86/IO-APIC: Avoid warning in 32-bit builds
      x86/LDT: Avoid warning in 32-bit builds with older gcc
      x86-64/realmode: Add instruction suffix
      x86/entry/64: Add instruction suffix
      x86/asm: Add instruction suffixes to bitops

Jan Glauber (1):
      i2c: octeon: Prevent error message on bus error

Jan Kara (7):
      direct-io: Fix sleep in atomic due to sync AIO
      genhd: Fix leaked module reference for NVME devices
      genhd: Rename get_disk() to get_disk_and_module()
      genhd: Add helper put_disk_and_module()
      genhd: Fix use after free in __blkdev_get()
      genhd: Fix BUG in blkdev_open()
      blockdev: Avoid two active bdev inodes for one device

Jani Nikula (1):
      drm/i915/audio: fix check for av_enc_map overflow

Jann Horn (1):
      x86/mm: Remove stale comment about KMEMCHECK

Jason Andryuk (1):
      xen-netfront: Fix hang on device removal

Jeff Mahoney (1):
      btrfs: use kvzalloc to allocate btrfs_fs_info

Jeremy Boone (5):
      tpm_tis: fix potential buffer overruns caused by bit glitches on the bus
      tpm_i2c_nuvoton: fix potential buffer overruns caused by bit
glitches on the bus
      tpm_i2c_infineon: fix potential buffer overruns caused by bit
glitches on the bus
      tpm: st33zp24: fix potential buffer overruns caused by bit
glitches on the bus
      tpm: fix potential buffer overruns caused by bit glitches on the bus

Jerome Brunet (1):
      ARM64: dts: meson-gxl: add internal ethernet PHY irq

Jianchao Wang (1):
      nvme-pci: Fix nvme queue cleanup if IRQ setup fails

Jiufei Xue (3):
      block: fix the count of PGPGOUT for WRITE_SAME
      block: display the correct diskname for bio
      block: fix a typo

Joe Perches (1):
      platform/x86: wmi: Fix misuse of vsprintf extension %pULL

John David Anglin (1):
      parisc: Fix ordering of cache and TLB flushes

Josh Poimboeuf (5):
      jump_label: Explicitly disable jump labels in __init code
      jump_label: Warn on failed jump_label patching attempt
      extable: Make init_kernel_text() global
      x86/entry/64: Simplify ENCODE_FRAME_POINTER
      objtool: Fix another switch table detection issue

Juergen Gross (2):
      x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend
      x86/xen: add tty0 and hvc0 as preferred consoles for dom0

Kamil Trzciński (1):
      arm64: dts: rockchip: fix rock64 gmac2io stability issues

Kees Cook (1):
      x86/refcounts: Switch to UD2 for exceptions

Li RongQing (1):
      Documentation, x86, resctrl: Make text and sample command match

Lidong Zhong (1):
      md-cluster: choose correct label when clustered layout is not supported

Lingutla Chandrasekhar (1):
      timers: Forward timer base before migrating timers

Linus Torvalds (1):
      Linux 4.16-rc4

Linus Walleij (1):
      ARM: dts: Set D-Link DNS-313 SATA to muxmode 0

Luc Van Oostenryck (1):
      kbuild: disable sparse warnings about unknown attributes

Luis de Bethencourt (3):
      ARC: dw2 unwind: Fix trailing semicolon
      ARC: boot log: Fix trailing semicolon
      md/raid1: Fix trailing semicolon

Mahesh Kumar (1):
      drm/i915/cnl: Fix PORT_TX_DW5/7 register address

Marc Hartmayer (4):
      tools/kvm_stat: simplify the sortkey function
      tools/kvm_stat: use a namedtuple for storing the values
      tools/kvm_stat: use a more pythonic way to iterate over dictionaries
      tools/kvm_stat: avoid 'is' for equality checks

Mario Limonciello (1):
      platform/x86: intel-vbtn: Only activate tablet mode switch on 2-in-1's

Markus Elfring (1):
      md-multipath: Use seq_putc() in multipath_status()

Markus Mayer (3):
      memory: brcmstb: dpfe: properly mask vendor error bits
      memory: brcmstb: dpfe: fix type declaration of variable "ret"
      memory: brcmstb: dpfe: support new way of passing data from the DCPU

Masahiro Yamada (7):
      kconfig: add xstrdup() helper
      kconfig: set SYMBOL_AUTO to the symbol marked with defconfig_list
      sh: fix build error for empty CONFIG_BUILTIN_DTB_SOURCE
      kconfig: Don't leak choice names during parsing
      kbuild: test --build-id linker flag by ld-option instead of cc-ldoption
      kconfig: fix line number in recursive inclusion error message
      MAINTAINERS: take over Kconfig maintainership

Mathieu Malaterre (3):
      arm64: dts: Remove leading 0x and 0s from bindings notation
      arm: zx: dts: Remove leading 0x and 0s from bindings notation
      ARM: BCM: dts: Remove leading 0x and 0s from bindings notation

Matteo Croce (1):
      watchdog: i6300esb: fix build failure

Matthew Wilcox (2):
      radix tree test suite: Fix build
      idr: Fix handling of IDs above INT_MAX

Mauro Carvalho Chehab (8):
      media: videobuf2: fix build issues with vb2-trace
      media: m88ds3103: don't call a non-initalized function
      media: dmxdev: fix error code for invalid ioctls
      media: dmxdev: Fix the logic that enables DMA mmap support
      media: dvb: add continuity error indicators for memory mapped buffers
      media: dvb: update buffer mmaped flags and frame counter
      media: Don't let tvp5150_get_vbi() go out of vbi_ram_default array
      media: vb2: Makefile: place vb2-trace together with vb2-core

Max Gurtovoy (1):
      nvmet: fix PSDT field check in command format

Maxime Ripard (2):
      drm/sun4i: Protect the TCON pixel clocks
      gpiolib: Keep returning EPROBE_DEFER when we should

Michal Hocko (1):
      samples/seccomp: do not compile when cross compiled

Mikita Lipski (2):
      drm/amdgpu: Add a missing lock for drm_mm_takedown
      drm/amdgpu: Unify the dm resume calls into one

Miles Chen (1):
      dma-debug: fix memory leak in debug_dma_alloc_coherent

Ming Lei (3):
      block: pass inclusive 'lend' parameter to truncate_inode_pages_range
      blk-mq: don't call io sched's .requeue_request when requeueing
rq to ->dispatch
      block: kyber: fix domain token leak during requeue

Monk Liu (4):
      drm/amdgpu: only flush hotplug work without DC
      drm/amdgpu: move WB_FREE to correct place
      drm/amdgpu: fix&cleanups for wb_clear
      drm/amdgpu: skip ECC for SRIOV in gmc late_init

Naresh Kamboju (1):
      selftests: pstore: Adding config fragment CONFIG_PSTORE_RAM=m

NeilBrown (2):
      md: document lifetime of internal rdev pointer.
      md: only allow remove_and_add_spares when no sync_thread running.

Nikolay Borisov (2):
      btrfs: handle failure of add_pending_csums
      btrfs: Handle btrfs_set_extent_delalloc failure in
relocate_file_extent_cluster

Ondrej Jirman (1):
      drm/sun4i: Enable the output on the pins (tcon0)

Paolo Bonzini (3):
      KVM/x86: Remove indirect MSR op calls from SPEC_CTRL
      KVM/VMX: Optimize vmx_vcpu_run() and svm_vcpu_run() by marking
the RDMSR path as unlikely()
      KVM: x86: move LAPIC initialization after VMCS creation

Peter Rosin (1):
      dt-bindings: at24: sort manufacturers alphabetically

Peter Zijlstra (8):
      x86/speculation, objtool: Annotate indirect calls/jumps for objtool
      x86/paravirt, objtool: Annotate indirect calls
      x86/boot, objtool: Annotate indirect jump in secondary_startup_64()
      x86/mm/sme, objtool: Annotate indirect call in sme_encrypt_execute()
      objtool: Use existing global variables for options
      objtool: Add retpoline validation
      objtool: Add module specific retpoline rules
      objtool, retpolines: Integrate objtool with retpoline support more closely

Petr Mladek (1):
      printk: Wake klogd when passing console_lock owner

Qi Hou (1):
      ARM: OMAP2+: timer: fix a kmemleak caused in omap_get_timer_dt

Radim Krčmář (3):
      KVM: nVMX: preserve SECONDARY_EXEC_DESC without UMIP
      KVM: x86: fix backward migration with async_PF
      KVM: x86: fix vcpu initialization with userspace lapic

Radu Rendec (1):
      watchdog: xen_wdt: fix potential build failure

Rafael J. Wysocki (2):
      platform/x86: intel-vbtn: Reset wakeup capable flag on removal
      platform/x86: intel-hid: Reset wakeup capable flag on removal

Randy Dunlap (1):
      PCI: Update location of pci.ids file

Rasmus Villemoes (1):
      nospec: Allow index argument to have const-qualified type

Richard Fitzgerald (1):
      ALSA: control: Fix memory corruption risk in snd_ctl_elem_read

Rob Herring (1):
      arm64: dts: cavium: fix PCI bus dtc warnings

Robin Murphy (2):
      arm64: dts: rockchip: Fix DWMMC clocks
      ARM: dts: rockchip: Fix DWMMC clocks

Roger Pau Monne (1):
      xen/pirq: fix error path cleanup when binding MSIs

Sakari Ailus (1):
      media: videobuf2: Add VIDEOBUF2_V4L2 Kconfig option for VB2 V4L2 part

Sebastian Ott (2):
      kvm: fix warning for CONFIG_HAVE_KVM_EVENTFD builds
      kvm: fix warning for non-x86 builds

Sebastian Panceac (1):
      x86/platform/intel-mid: Handle Intel Edison reboot correctly

Shawn Lin (4):
      arm64: dts: rockchip: correct ep-gpios for rk3399-sapphire
      mmc: dw_mmc: Factor out dw_mci_init_slot_caps
      mmc: dw_mmc: Fix out-of-bounds access for slot's caps
      mmc: dw_mmc: Avoid accessing registers in runtime suspended state

Shirish S (1):
      drm/amd/display: check for ipp before calling cursor operations

Shuah Khan (2):
      selftests: memory-hotplug: silence test command echo
      selftests: vm: update .gitignore with new test

Shyam Saini (1):
      ARM: dts: imx6dl: Include correct dtsi file for Engicam i.CoreM6
DualLite/Solo RQS

Stefan Agner (2):
      MAINTAINERS: add Freescale pin controllers
      soc: imx: gpc: de-register power domains only if initialized

Stefan Raspl (8):
      tools/kvm_stat: fix crash when filtering out all non-child trace events
      tools/kvm_stat: print error on invalid regex
      tools/kvm_stat: fix debugfs handling
      tools/kvm_stat: mark private methods as such
      tools/kvm_stat: eliminate extra guest/pid selection dialog
      tools/kvm_stat: separate drilldown and fields filtering
      tools/kvm_stat: group child events indented after parent
      tools/kvm_stat: print 'Total' line for multiple events only

Stefan Wahren (2):
      ARM: dts: bcm283x: Fix unit address of local_intc
      ARM: dts: bcm283x: Move arm-pmu out of soc node

Stefano Stabellini (1):
      pvcalls-front: 64-bit align flags

Sudeep Holla (1):
      cpufreq: scpi: Fix incorrect arm_big_little config dependency

Takashi Iwai (4):
      ALSA: x86: hdmi: Add single_port option for compatible behavior
      ALSA: hda - Fix pincfg at resume on Lenovo T470 dock
      ALSA: x86: Fix missing spinlock and mutex initializations
      ALSA: x86: Fix potential crash at error path

Tang Junhui (1):
      bcache: fix kcrashes with fio in RAID5 backend dev

Tero Kristo (1):
      ARM: OMAP2+: hwmod_core: enable optional clocks before main clock

Thomas Gleixner (1):
      x86/cpu_entry_area: Sync cpu_entry_area to initial_page_table

Tom Lendacky (2):
      KVM: x86: Add a framework for supporting MSR-based features
      KVM: SVM: Add MSR-based feature support for serializing LFENCE

Tom St Denis (1):
      drm/amd/amdgpu: Correct VRAM width for APUs with GMC9

Tony Lindgren (3):
      ARM: OMAP3: Fix prm wake interrupt for resume
      ARM: OMAP2+: Fix sar_base inititalization for HS omaps
      bus: ti-sysc: Fix checking of no-reset-on-init quirk

Tvrtko Ursulin (1):
      drm/i915: Make global seqno known in i915_gem_request_execute tracepoint

Ulf Hansson (1):
      mmc: core: Avoid hanging to claim host for mmc via some nested calls

Ulf Magnusson (3):
      ARC: Fix malformed ARC_EMUL_UNALIGNED default
      ARM: mvebu: Fix broken PL310_ERRATA_753970 selects
      Makefile: Fix lying comment re. silentoldconfig

Vineet Gupta (2):
      clocksource/drivers/arc_timer: Update some comments
      ARCv2: boot log: fix HS48 release number

Viresh Kumar (1):
      cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()

Wanpeng Li (5):
      KVM: mmu: Fix overlap between public and private memslots
      KVM: X86: Fix SMRAM accessing even if VM is shutdown
      KVM: X86: Avoid traversing all the cpus for pv tlb flush when
steal time is disabled
      KVM: X86: Introduce kvm_get_msr_feature()
      KVM: X86: Allow userspace to define the microcode version

Wim Van Sebroeck (1):
      watchdog: sp5100_tco.c: fix potential build failure

Xiao Ni (1):
      MD: Free bioset when md_run fails

Yakir Yang (1):
      arm64: dts: rockchip: introduce pclk_vio_grf in rk3399-eDP device node

Yixun Lan (2):
      pinctrl: meson-axg: adjust uart_ao_b pin group naming
      ARM64: dts: meson: uart: fix address space range

Yufen Yu (2):
      md raid10: fix NULL deference in handle_write_completed()
      md/raid1: fix NULL pointer dereference

Zhi Zhang (1):
      ceph: flush dirty caps of unlinked inode ASAP
