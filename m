Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeETWqu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 18:46:50 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:37121 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751614AbeETWqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 18:46:48 -0400
X-Google-Smtp-Source: AB8JxZpTv8CNh4TFamutq8Kc8wCDz9UQpYCEBmHJhxIaFh+tesB6sm0TmL8Dfkp+ToDjE6/oCAkdBxSHfkAV7G/7nuA=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 May 2018 15:46:36 -0700
Message-ID: <CA+55aFxxYQFL3mwsQcC+__R23ZmO8c3F0SThi6r44TdK0ePNDQ@mail.gmail.com>
Subject: Linux 4.17-rc6
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4KMkvRu016436

Things continue to be fairly calm. There's a couple of commits in here that
aren't "trivial few-liners", but most of it really is pretty small. And in
fact, a quarter of the full patch for the week is tooling - and the bulk of
that is the testing subdirectory.

In fact, drivers are in the minority here, because another 30% is arch
updates (arm, s390, x86), and we even have more lines of filesystem fixes
than we have driver fixes (admittedly mostly due to a few of the
more-than-a-few-liner patches being to filesystems: afs and btrfs).

We do have a few driver fixes (all over - hwmon, usb, sound, acpi, gpu),
but it's all really small.

So nothing special to report. Go read the shortlog, pull the changes,
build, and test.  It should all be good and pretty stable by this point.

                 Linus

---

Adam Ford (3):
       ARM: dts: logicpd-som-lv: Fix WL127x Startup Issues
       ARM: dts: logicpd-som-lv: Fix Audio Mute
       ARM: dts: logicpd-som-lv: Fix pinmux controller references

Alexander Monakov (1):
       i2c: designware: fix poll-after-enable regression

Alexander Potapenko (1):
       x86/boot/64/clang: Use fixup_pointer() to access
'__supported_pte_mask'

Alexei Starovoitov (1):
       x86/cpufeature: Guard asm_volatile_goto usage for BPF compilation

Alexey Kodanev (3):
       selinux: add AF_UNSPEC and INADDR_ANY checks to selinux_socket_bind()
       selinux: fix address family in bind() and connect() to match
address/port
       selinux: correctly handle sa_family cases in
selinux_sctp_bind_connect()

Anand Jain (1):
       btrfs: fix crash when trying to resume balance without the resume flag

Andre Przywara (4):
       KVM: arm/arm64: Properly protect VGIC locks from IRQs
       KVM: arm/arm64: VGIC/ITS: Promote irq_lock() in update_affinity
       KVM: arm/arm64: VGIC/ITS: protect kvm_read_guest() calls with SRCU
lock
       KVM: arm/arm64: VGIC/ITS save/restore: protect kvm_read_guest() calls

Andy Lutomirski (1):
       x86/selftests: Add mov_to_ss test

Andy Shevchenko (1):
       spi: pxa2xx: Allow 64-bit DMA

Ard Biesheuvel (1):
       efi: Avoid potential crashes, fix the 'struct efi_pci_io_protocol_32'
definition for mixed mode

Arnaldo Carvalho de Melo (1):
       perf tools: Add missing newline when parsing empty BPF proggie

Bartosz Golaszewski (1):
       eeprom: at24: fix retrieving the at24_chip_data structure

Ben Hutchings (1):
       mtd: Fix comparison in map_word_andequal()

Bhadram Varka (1):
       arm64: tegra: Make BCM89610 PHY interrupt as active low

Bob Moore (1):
       ACPICA: Add deferred package support for the Load and loadTable
operators

Boris Brezillon (1):
       mtd: rawnand: marvell: Fix read logic for layouts with ->nchunks > 2

Borislav Petkov (1):
       x86/MCE/AMD: Cache SMCA MISC block addresses

Chris Wilson (1):
       drm/i915/execlists: Use rmb() to order CSB reads

Clément Péron (1):
       ARM: dts: cygnus: fix irq type for arm global timer

Coly Li (1):
       bcache: return 0 from bch_debug_init() if CONFIG_DEBUG_FS=n

Dan Carpenter (2):
       firmware: arm_scmi: Use after free in scmi_create_protocol_device()
       drm/dumb-buffers: Integer overflow in drm_mode_create_ioctl()

Daniel Glöckner (1):
       usb: musb: fix remote wakeup racing with suspend

Darren Hart (1):
       platform/x86: DELL_WMI use depends on instead of select for
DELL_SMBIOS

Dave Airlie (1):
       drm: set FMODE_UNSIGNED_OFFSET for drm files

Dave Carroll (1):
       scsi: aacraid: Correct hba_send to include iu_type

Dave Hansen (13):
       x86/pkeys/selftests: Give better unexpected fault error messages
       x86/pkeys/selftests: Stop using assert()
       x86/pkeys/selftests: Remove dead debugging code, fix dprint_in_signal
       x86/pkeys/selftests: Avoid printf-in-signal deadlocks
       x86/pkeys/selftests: Allow faults on unknown keys
       x86/pkeys/selftests: Factor out "instruction page"
       x86/pkeys/selftests: Add PROT_EXEC test
       x86/pkeys/selftests: Fix pkey exhaustion test off-by-one
       x86/pkeys: Override pkey when moving away from PROT_EXEC
       x86/pkeys/selftests: Fix pointer math
       x86/pkeys/selftests: Save off 'prot' for allocations
       x86/pkeys/selftests: Add a test for pkey 0
       x86/pkeys: Do not special case protection key 0

David Howells (13):
       afs: Fix directory page locking
       afs: Fix address list parsing
       afs: Fix giving up callbacks on server destruction
       afs: Fix refcounting in callback registration
       afs: Fix server rotation's handling of fileserver probe failure
       afs: Fix AFSFetchStatus decoder to provide OpenAFS compatibility
       afs: Fix VNOVOL handling in address rotation
       afs: Fix the handling of CB.InitCallBackState3 to find the server by
UUID
       afs: Add a tracepoint to record callbacks from unlisted servers
       afs: Fix the handling of an unfound server in CM operations
       afs: Fix whole-volume callback handling
       afs: Fix CB.CallBack handling
       afs: Fix the non-encryption of calls

Deepak Rawat (1):
       drm/vmwgfx: Set dmabuf_size when vmw_dmabuf_init is successful

Dexuan Cui (1):
       tick/broadcast: Use for_each_cpu() specially on UP kernels

Dmitry Osipenko (1):
       ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20"

Dmitry Safonov (1):
       x86/mm: Drop TS_COMPAT on 64-bit exec() syscall

Eric Anholt (1):
       drm/vc4: Fix leak of the file_priv that stored the perfmon.

Etienne Carriere (1):
       tee: check shm references are consistent in offset/size

Fabio Estevam (1):
       ARM: dts: imx7s: Pass the 'fsl,sec-era' property

Federico Cuello (1):
       ALSA: usb: mixer: volume quirk for CM102-A+/102S+

Filipe Manana (2):
       Btrfs: fix xattr loss after power failure
       Btrfs: fix duplicate extents after fsync of file with prealloc extents

Gabriel Fernandez (1):
       clk: stm32: fix: stm32 clock drivers are not compiled by default

Geert Uytterhoeven (1):
       mtd: rawnand: Fix return type of __DIVIDE() when called with 32-bit

Graeme Smecher (1):
       ARM: dts: correct missing "compatible" entry for ti81xx SoCs

Guenter Roeck (3):
       hwmon: (k10temp) Fix reading critical temperature register
       x86/amd_nb: Add support for Raven Ridge CPUs
       hwmon: (k10temp) Use API function to access System Management Network

Halil Pasic (1):
       vfio: ccw: fix cleanup if cp_prefetch fails

Haneen Mohammed (1):
       drm: Match sysfs name in link removal to link creation

Hans de Goede (3):
       i2c: core: ACPI: Improve OpRegion read errors
       i2c: core: ACPI: Log device not acking errors at dbg loglevel
       ALSA: hda: Add Lenovo C50 All in one to the power_save blacklist

Harald Freudenberger (1):
       MAINTAINERS: update s390 zcrypt maintainers email address

Helge Deller (3):
       parisc: Move find_pa_parent_type() out of init section
       parisc: Move setup_profiling_timer() out of init section
       parisc: Move ccio_cujo20_fixup() into init section

Hendrik Brueckner (1):
       s390/cpum_sf: ensure sample frequency of perf event attributes is
non-zero

Ingo Molnar (3):
       objtool, kprobes/x86: Sync the latest <asm/insn.h> header with
tools/objtool/arch/x86/include/asm/insn.h
       x86/pkeys/selftests: Adjust the self-test to fresh distros that
export the pkeys ABI
       x86/mpx/selftests: Adjust the self-test to fresh distros that export
the MPX ABI

Jann Horn (1):
       tee: shm: fix use-after-free via temporarily dropped reference

Janusz Krzysztofik (1):
       ARM: OMAP1: ams-delta: fix deferred_fiq handler

Jeremy Soller (1):
       ALSA: hda/realtek - Clevo P950ER ALC1220 Fixup

Jim Gill (1):
       scsi: vmw-pvscsi: return DID_BUS_BUSY for adapter-initated aborts

Jin Yao (1):
       perf annotate: Display all available events on --stdio

Jorge Sanjuan (1):
       ALSA: usb-audio: Use Class Specific EP for UAC3 devices.

Josh Poimboeuf (5):
       objtool: Fix "noreturn" detection for recursive sibling calls
       objtool: Support GCC 8's cold subfunctions
       objtool: Support GCC 8 switch tables
       objtool: Detect RIP-relative switch table references
       objtool: Detect RIP-relative switch table references, part 2

Julian Wiedmann (2):
       s390/qdio: fix access to uninitialized qdio_q fields
       s390/qdio: don't release memory in qdio_setup_irq()

Junaid Shahid (1):
       kvm: x86: Suppress CR3_PCID_INVD bit only when PCIDs are enabled

Kamal Dasu (2):
       spi: bcm-qspi: Avoid setting MSPI_CDRAM_PCS for spi-nor master
       spi: bcm-qspi: Always read and set BSPI_MAST_N_BOOT_CTRL

Kirill A. Shutemov (2):
       x86/boot/compressed/64: Set up GOT for paging_prepare() and
cleanup_trampoline()
       x86/boot/compressed/64: Fix moving page table out of trampoline memory

Laurent Pinchart (3):
       ARM: dts: r8a7790: Convert to new LVDS DT bindings
       ARM: dts: r8a7791: Convert to new LVDS DT bindings
       ARM: dts: r8a7793: Convert to new LVDS DT bindings

Leo Yan (2):
       perf cs-etm: Support unknown_thread in cs_etm_auxtrace
       perf cs-etm: Remove redundant space

Linus Torvalds (2):
       mmap: relax file size limit for regular files
       Linux 4.17-rc6

Liu Bo (1):
       btrfs: fix reading stale metadata blocks after degraded raid1 mounts

Marc Dionne (1):
       afs: Fix afs_find_server search loop

Marek Szyprowski (1):
       arm64: dts: exynos: Fix interrupt type for I2S1 device on Exynos5433

Marian Rotariu (1):
       x86: Delay skip of emulated hypercall instruction

Mark Rutland (1):
       efi/libstub/arm64: Handle randomized TEXT_OFFSET

Martin Schwidefsky (9):
       s390: move expoline assembler macros to a header
       s390/crc32-vx: use expoline for indirect branches
       s390/lib: use expoline for indirect branches
       s390/ftrace: use expoline for indirect branches
       s390/kernel: use expoline for indirect branches
       s390: move spectre sysfs attribute code
       s390: remove indirect branch from do_softirq_own_stack
       s390: extend expoline to BC instructions
       s390: use expoline thunks in the BPF JIT

Masahiro Yamada (3):
       arm64: dts: uniphier: fix input delay value for legacy mode of eMMC
       reset: uniphier: fix USB clock line for LD20
       arm64: dts: uniphier: stabilize ethernet of LD20 reference board

Masami Hiramatsu (6):
       kprobes/x86: Prohibit probing on exception masking instructions
       uprobes/x86: Prohibit probing on MOV SS instruction
       ARM: 8769/1: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
       ARM: 8770/1: kprobes: Prohibit probing on optimized_callback
       ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr
       ARM: 8772/1: kprobes: Prohibit kprobes on get_user functions

Mathias Nyman (1):
       xhci: Fix USB3 NULL pointer dereference at logical disconnect.

Mathieu Malaterre (2):
       sched/debug: Move the print_rt_rq() and print_dl_rq() declarations to
kernel/sched/sched.h
       sched/deadline: Make the grub_reclaim() function static

Matthew Auld (1):
       drm/i915/userptr: reject zero user_size

Matthew Wilcox (1):
       lib/test_bitmap.c: fix bitmap optimisation tests to report errors
correctly

Maxime Chevallier (2):
       ARM64: dts: marvell: armada-cp110: Add clocks for the xmdio node
       ARM64: dts: marvell: armada-cp110: Add mg_core_clk for ethernet node

Michael S. Tsirkin (1):
       kvm: rename KVM_HINTS_DEDICATED to KVM_HINTS_REALTIME

Michel Thierry (1):
       drm/i915/gen9: Add WaClearHIZ_WM_CHICKEN3 for bxt and glk

Miquel Raynal (1):
       cpufreq: armada-37xx: driver relies on cpufreq-dt

Misono Tomohiro (1):
       btrfs: property: Set incompat flag if lzo/zstd compression is set

Nicholas Piggin (1):
       powerpc/powernv: Fix NVRAM sleep in invalid context when crashing

Nikita Yushchenko (1):
       ARM: dts: imx51-zii-rdu1: fix touchscreen bindings

Nikolay Borisov (2):
       btrfs: Split btrfs_del_delalloc_inode into 2 functions
       btrfs: Fix delalloc inodes invalidation during transaction abort

Paolo Bonzini (2):
       KVM: hyperv: idr_find needs RCU protection
       KVM: selftests: exit with 0 status code when tests cannot be run

Pavel Tatashin (1):
       mm: don't allow deferred pages with NEED_PER_CPU_KM

Peter Rosin (3):
       i2c: pmcmsp: return message count on master_xfer success
       i2c: pmcmsp: fix error return from master_xfer
       i2c: viperboard: return message count on master_xfer success

Philippe Bergheaud (2):
       cxl: Set the PBCQ Tunnel BAR register when enabling capi mode
       cxl: Report the tunneled operations status

Pierre-Yves MORDRET (1):
       MAINTAINERS: add entry for STM32 I2C driver

Rob Herring (1):
       spi: bcm2835aux: ensure interrupts are enabled for shared handler

Robbie Ko (1):
       Btrfs: send, fix invalid access to commit roots due to concurrent
snapshotting

Ross Zwisler (5):
       radix tree test suite: fix mapshift build target
       radix tree test suite: fix compilation issue
       radix tree test suite: add item_delete_rcu()
       radix tree test suite: multi-order iteration race
       radix tree: fix multi-order iteration race

Russell King (5):
       ARM: keystone: fix platform_domain_notifier array overrun
       ARM: kexec: fix kdump register saving on panic()
       ARM: kexec: record parent context registers for non-crash CPUs
       ARM: replace unnecessary perl with sed and the shell $(( )) operator
       ARM: fix kill( ,SIGFPE) breakage

Sean Christopherson (1):
       KVM: vmx: update sec exec controls for UMIP iff emulating UMIP

Sebastian Andrzej Siewior (1):
       sched/fair: Fix documentation file path

Sebastian Ott (2):
       s390: update defconfigs
       s390/kexec_file: add declaration of purgatory related globals

Sekhar Nori (11):
       ARM: dts: da850: get rid of skeleton.dtsi
       ARM: dts: da850-lcdk: add unit name for memory node
       ARM: dts: da850: fix W=1 warnings with pinmux node
       ARM: davinci: board-da830-evm: fix GPIO lookup for MMC/SD
       ARM: davinci: board-da850-evm: fix GPIO lookup for MMC/SD
       ARM: davinci: board-omapl138-hawk: fix GPIO numbers for MMC/SD lookup
       ARM: davinci: board-dm355-evm: fix broken networking
       ARM: davinci: fix GPIO lookup for I2C
       ARM: davinci: dm646x: fix timer interrupt generation
       ARM: davinci: board-dm646x-evm: pass correct I2C adapter id for VPIF
       ARM: davinci: board-dm646x-evm: set VPIF capture card name

Shuah Khan (1):
       usbip: usbip_host: refine probe and disconnect debug msgs to be useful

Shuah Khan (Samsung OSG) (5):
       usbip: usbip_host: delete device from busid_table after rebind
       usbip: usbip_host: run rebind from exit when module is removed
       usbip: usbip_host: fix NULL-ptr deref and use-after-free errors
       usbip: usbip_host: fix bad unlock balance during stub_probe()
       MAINTAINERS: add Q: entry to kselftest for patchwork project

Souptick Joarder (1):
       include/linux/mm.h: add new inline function vmf_error()

Srinivas Kandagatla (1):
       dmaengine: qcom: bam_dma: check if the runtime pm enabled

Stefan Agner (1):
       clk: imx6ull: use OSC clock during AXI rate change

Steven Rostedt (VMware) (2):
       tracing/x86/xen: Remove zero data size trace events
trace_xen_mmu_flush_tlb{_all}
       vsprintf: Replace memory barrier with static_key for random_ptr_key
update

Tero Kristo (1):
       ARM: OMAP2+: powerdomain: use raw_smp_processor_id() for trace

Tetsuo Handa (2):
       x86/kexec: Avoid double free_page() upon do_kexec_load() failure
       hfsplus: stop workqueue when fill_super() failed

Thomas Gleixner (1):
       x86/apic/x2apic: Initialize cluster ID properly

Thomas Richter (1):
       perf test: "probe libc's inet_pton" fails on s390 due to missing
inline

Tony Lindgren (1):
       Revert "ARM: dts: logicpd-som-lv: Fix pinmux controller references"

Vinod Koul (1):
       dmaengine: Update email address for Vinod

Vladimir Zapolskiy (1):
       spi: sh-msiof: Fix bit field overflow writes to TSCR/RSCR

Waiman Long (2):
       locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED flag
       locking/percpu-rwsem: Annotate rwsem ownership transfer by setting
RWSEM_OWNER_UNKNOWN

Wanpeng Li (2):
       KVM: Extend MAX_IRQ_ROUTES to 4096 for all archs
       KVM: X86: Lower the default timer frequency limit to 200us

Wenwen Wang (1):
       ALSA: control: fix a redundant-copy issue

Willy Tarreau (1):
       proc: do not access cmdline nor environ from file-backed areas

sxauwsk (1):
       spi: cadence: Add usleep_range() for cdns_spi_fill_tx_fifo()

wangbo (1):
       spi: imx: Update MODULE_DESCRIPTION to "SPI Controller driver"

Łukasz Stelmach (2):
       ARM: 8753/1: decompressor: add a missing parameter to the addruart
macro
       ARM: 8758/1: decompressor: restore r1 and r2 just before jumping to
the kernel
