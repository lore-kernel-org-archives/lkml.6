Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeD2V2w (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 17:28:52 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:45632 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeD2V2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 17:28:49 -0400
X-Google-Smtp-Source: AB8JxZol8Pl1IUbEdxu27Fs399C/RsMVFMowHcJnvKxNm+qKNbrCcE3M0G1DivyRt2jla44bYeVllG+dc+4Df9AlNLY=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 29 Apr 2018 21:28:37 +0000
Message-ID: <CA+55aFyu=y0SBesB+vx3JZFGcOhP+tuVG7sjfrkfBhXHTe0Skg@mail.gmail.com>
Subject: Linux 4.17-rc3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3TLSx35009971

You all know the drill by now, and everything looks pretty normal. As
usual, we have an rc3 that is noticeably bigger than rc2 was. Whatever the
reason for the pattern (whether it just be "people have had time to find
bugs" or "people took a breather after the merge window"), the pattern is
alive and well.

And by now, I think we've fixed all the nastiest fall-out from the merge
window. In particular, the PTI large-page fallout that hit some people with
particular configurations should all be good.

But another marker of "things look normal" is that almost 60% of the patch
is driver fixes all over: networking, gpu, sound, scsi, usb, you name it.

Outside of drivers, we've got the usual architecture suspects: x86, arm64,
powerpc. Some generic networking fixes, and misc tooling (perf and
selftests). With some core kernel fixes in there too (mainly timers and
tracing, the first mainly because we sadly had to revert the nice
CLOCK_{MONOTONIC,BOOTTIME} unification because it turns out people really
do care about the differences).

Shortlog appended for the details.

Go out and test,

               Linus

---

Abhay Kumar (1):
       drm/i915/audio: set minimum CD clock to twice the BCLK

Abhinav Kumar (3):
       drm/msm/dsi: check return value for video done waits
       drm/msm/dsi: check video mode engine status before waiting
       drm/msm/dsi: implement auto PHY timing calculator for 10nm PHY

Ahbong Chang (1):
       tracing: Add missing forward declaration

Ahmed Abdelsalam (1):
       ipv6: sr: fix NULL pointer dereference in seg6_do_srh_encap()- v4 pkts

Ajay Singh (1):
       staging: wilc1000: fix NULL pointer exception in
host_int_parse_assoc_resp_info()

Alan Jenkins (1):
       block: do not use interruptible wait anywhere

Alexander Aring (3):
       net: sched: ife: signal not finding metaid
       net: sched: ife: handle malformed tlv length
       net: sched: ife: check on metadata length

Alexander Popov (1):
       i2c: dev: prevent ZERO_SIZE_PTR deref in i2cdev_ioctl_rdwr()

Alistair Popple (3):
       powerpc/powernv/npu: Add lock to prevent race in concurrent context
init/destroy
       powerpc/powernv/npu: Prevent overwriting of pnv_npu2_init_contex()
callback parameters
       powerpc/powernv/npu: Do a PID GPU TLB flush when invalidating a large
address range

Amir Goldstein (1):
       <linux/stringhash.h>: fix end_name_hash() for 64bit long

Anatolij Gustschin (1):
       fpga-manager: altera-ps-spi: preserve nCONFIG state

Anders Roxell (1):
       selftests: bpf: update .gitignore with missing generated files

Andre Przywara (1):
       KVM: arm/arm64: vgic: Kick new VCPU on interrupt migration

Andres Rodriguez (2):
       drm/amdkfd: fix clock counter retrieval for node without GPU
       firmware: some documentation fixes

André Wild (1):
       s390/cpum_cf: rename IBM z13/z14 counter names

Andy Lutomirski (1):
       x86/entry/64/compat: Preserve r8-r11 in int $0x80

Anirudh Venkataramanan (2):
       ice: Fix initialization for num_nodes_added
       ice: Fix incorrect comment for action type

Ard Biesheuvel (1):
       ACPI / button: make module loadable when booted in non-ACPI mode

Arend van Spriel (1):
       drivers: change struct device_driver::coredump() return type to void

Arnd Bergmann (4):
       ASoC: rsnd: mark PM functions __maybe_unused
       netfilter: fix CONFIG_NF_REJECT_IPV6=m link error
       usb: select USB_COMMON for usb role switch config
       x86/ipc: Fix x32 version of shmid64_ds and msqid64_ds

Aurelien Jarno (1):
       RISC-V: build vdso-dummy.o with -no-pie

Balbir Singh (2):
       powerpc/mm: Flush cache on memory hot(un)plug
       powerpc/powernv/memtrace: Let the arch hotunplug code flush cache

Baolin Wang (2):
       i2c: sprd: Prevent i2c accesses after suspend is called
       i2c: sprd: Fix the i2c count issue

Bart Van Assche (1):
       scsi: sd_zbc: Avoid that resetting a zone fails sporadically

Ben Hutchings (3):
       drm/msm: Fix possible null dereference on failure of get_pages()
       test_firmware: Install all scripts
       test_firmware: fix setting old custom fw path back on exit, second try

Ben Shelton (1):
       ice: Do not check INTEVENT bit for OICR interrupts

Bernat, Yehezkel (1):
       MAINTAINERS: update my email address

Biju Das (1):
       serial: sh-sci: Document r8a77470 bindings

Boris Brezillon (1):
       mtd: nand: Fix nanddev_mtd_erase()

Borislav Petkov (2):
       x86/microcode/intel: Save microcode patch unconditionally
       x86/microcode: Do not exit early from __reload_late()

Chen Yu (1):
       ACPI / PM: Blacklist Low Power S0 Idle _DSM for ThinkPad X1
Tablet(2016)

Chris Leech (1):
       scsi: iscsi: respond to netlink with unicast when appropriate

Christoffer Dall (1):
       MAINTAINERS: Update e-mail address for Christoffer Dall

Christoph Hellwig (2):
       riscv: select DMA_DIRECT_OPS instead of redefining it
       riscv: there is no <asm/handle_irq.h>

Colin Ian King (3):
       firmware: arm_scmi: remove redundant null check on array
       scsi: fnic: fix spelling mistake in fnic stats "Abord" -> "Abort"
       ixgbevf: ensure xdp_ring resources are free'd on error exit

Collin May (1):
       USB: serial: simple: add libtransistor console

Cong Wang (3):
       netfilter: conntrack: silent a memory leak warning
       llc: delete timers synchronously in llc_sk_free()
       llc: fix NULL pointer deref for SOCK_ZAPPED

Cornelia Huck (1):
       vfio: ccw: process ssch with interrupts disabled

Dan Carpenter (2):
       ASoC: topology: fix some tiny memory leaks
       cdrom: information leak in cdrom_ioctl_media_changed()

Daniel Kurtz (1):
       earlycon: Use a pointer table to fix __earlycon_table stride

Daniel Vetter (1):
       MAINTAINERS: add dri-devel&linaro-mm for Android ION

Danny Smith (1):
       ASoC: adau17x1: Handling of DSP_RUN register during fw setup

Dave Chinner (1):
       block: add blk_queue_fua() helper function

Dave Gerlach (1):
       ARM: OMAP2+: Fix build when using split object directories

Dave Hansen (5):
       x86/pti: Fix boot problems from Global-bit setting
       x86/pti: Fix boot warning from Global-bit setting
       x86/pti: Reduce amount of kernel text allowed to be Global
       x86/pti: Disallow global kernel text with RANDSTRUCT
       x86/pti: Filter at vma->vm_page_prot population

David Henningsson (1):
       ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr

David Sterba (1):
       MAINTAINERS: add myself as maintainer of AFFS

Dmitry Vyukov (1):
       kobject: don't use WARN for registration failures

Doron Roberts-Kedes (1):
       strparser: Do not call mod_delayed_work with a timeout of LONG_MAX

Dou Liyang (2):
       x86/vector: Remove the macro VECTOR_OFFSET_START
       x86/vector: Remove the unused macro FPU_IRQ

Douglas Gilbert (1):
       scsi: scsi_debug: IMMED related delay adjustments

Edward Cree (1):
       sfc: ARFS filter IDs

Emil Velikov (1):
       drm/msm: don't deref error pointer in the msm_fbdev_create error path

Eric Biggers (2):
       ext4: prevent right-shifting extents beyond EXT_MAX_BLOCKS
       crypto: api - fix finding algorithm currently being tested

Eric Dumazet (1):
       ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy

Evan Wang (1):
       PCI: aardvark: Fix PCIe Max Read Request Size setting

Fenghua Yu (1):
       x86/cpufeatures: Enumerate cldemote instruction

Finn Thain (8):
       m68k/mac: Don't remap SWIM MMIO region
       block/swim: Fix array bounds check
       block/swim: Remove extra put_disk() call from error path
       block/swim: Don't log an error message for an invalid ioctl
       block/swim: Rename macros to avoid inconsistent inverted logic
       block/swim: Check drive type
       block/swim: Fix IO error at end of medium
       block/swim: Select appropriate drive on device open

Florian Fainelli (2):
       soc: bcm: raspberrypi-power: Fix use of __packed
       net: ethtool: Add missing kernel doc for FEC parameters

Florian Westphal (4):
       netfilter: nf_conntrack_sip: allow duplicate SDP expectations
       netfilter: ebtables: don't attempt to allocate 0-sized compat array
       netfilter: nf_tables: can't fail after linking rule into active rule
list
       netfilter: nf_tables: free set name in error path

Geert Uytterhoeven (9):
       soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies return failure
       i2c: Remove depends on HAS_DMA in case of platform dependency
       dt-bindings: meson-uart: DT fix s/clocks-names/clock-names/
       dt-bindings: mvebu-uart: DT fix s/interrupts-names/interrupt-names/
       slimbus: Fix out-of-bounds access in slim_slicesize()
       ARM: amba: Fix race condition with driver_override
       ARM: amba: Don't read past the end of sysfs "driver_override" buffer
       ARM: amba: Make driver_override output consistent with other buses
       ARM: amba: Fix race condition with driver_override

Gerd Hoffmann (3):
       qxl: fix qxl_release_{map,unmap}
       qxl: keep separate release_bo pointer
       drm/virtio: fix vq wait_event condition

Greg Kroah-Hartman (3):
       staging: irda: remove remaining remants of irda code removal
       Revert "xhci: plat: Register shutdown for xhci_plat"
       Revert "ARM: amba: Fix race condition with driver_override"

Gregory CLEMENT (2):
       usb: host: xhci-plat: Remove useless test before clk_disable_unprepare
       usb: host: xhci-plat: Fix clock resource by adding a register clock

Guenter Roeck (3):
       hwmon: (nct6683) Enable EC access if disabled at boot
       hwmon: (k10temp) Add temperature offset for Ryzen 2700X
       hwmon: (k10temp) Add support for AMD Ryzen w/ Vega graphics

Guillaume Nault (3):
       l2tp: fix {pppol2tp, l2tp_dfs}_seq_stop() in case of seq_file overflow
       l2tp: check sockaddr length in pppol2tp_connect()
       pppoe: check sockaddr length in pppoe_connect()

Hans de Goede (6):
       firmware: Fix firmware documentation for recent file renames
       virt: vbox: Move declarations of vboxguest private functions to
private header
       virt: vbox: Add vbg_req_free() helper function
       virt: vbox: Use __get_free_pages instead of kmalloc for DMA32 memory
       virt: vbox: Log an error when we fail to get the host version
       ACPI / video: Only default only_lcd to true on Win8-ready _desktops_

Harry Wentland (2):
       drm/amd/display: Disallow enabling CRTC without primary plane with FB
       drm/amd/display: Don't read EDID in atomic_check

Heikki Krogerus (2):
       Documentation: typec.rst: Use literal-block element with ascii art
       usb: typec: ucsi: Increase command completion timeout value

Heiko Carstens (1):
       s390/uprobes: implement arch_uretprobe_is_alive()

Ilya Dryomov (3):
       libceph: un-backoff on tick when we have a authenticated session
       libceph: reschedule a tick in finish_hunting()
       libceph: validate con->state at the top of try_write()

Imre Deak (1):
       drm/i915: Enable display WA#1183 from its correct spot

Ivan Khoronzhuk (1):
       net: ethernet: ti: cpsw: fix tx vlan priority mapping

Jack Ma (1):
       netfilter: xt_connmark: Add bit mapping for bit-shift operation.

Jacopo Mondi (1):
       dma-mapping: postpone cpu addr translation on mmap

Jakub Kicinski (1):
       PCI: Add "PCIe" to pcie_print_link_status() messages

Jann Horn (2):
       bpf: sockmap remove dead check
       tcp: don't read out-of-bounds opsize

Jason A. Donenfeld (1):
       arm64: support __int128 with clang

Jeffery Miller (1):
       ALSA: pcm: Return negative delays from SNDRV_PCM_IOCTL_DELAY.

Jeffrin Jose T (1):
       selftests:firmware: fixes a call to a wrong function name

Jens Axboe (4):
       loop: remove cmd->rq member
       loop: handle short DIO reads
       bfq-iosched: ensure to clear bic/bfqq pointers when preparing request
       bcache: mark Coly Li as bcache maintainer

Jerry (Fangzhi) Zuo (2):
       drm/amd/display: Update MST edid property every time
       drm/amd/display: Check dc_sink every time in MST hotplug

Jeykumar Sankaran (1):
       drm/msm: Add modifier to mdp_get_format arguments

Jianchao Wang (1):
       blk-mq: start request gstate with gen 1

Jiang Biao (3):
       blkcg: don't hold blkcg lock when deactivating policy
       blkcg: small fix on comment in blkcg_init_queue
       blkcg: init root blkcg_gq under lock

Jingju Hou (1):
       net: phy: marvell: clear wol event before setting it

Jiri Kosina (1):
       x86/mm: Make vmemmap and vmalloc base address constants unsigned long

Jiri Olsa (3):
       perf stat: Keep the / modifier separator in fallback
       perf pmu: Fix pmu events parsing rule
       perf evsel: Disable write_backward for leader sampling group events

Joakim Tjernlund (3):
       mtd: cfi: cmdset_0001: Do not allow read/write to suspend erase block.
       mtd: cfi: cmdset_0001: Workaround Micron Erase suspend bug.
       mtd: cfi: cmdset_0002: Do not allow read/write to suspend erase block.

Johan Hovold (2):
       USB: musb: host: prevent core phy initialisation
       USB: musb: dsps: drop duplicate phy initialisation

John Garry (1):
       HISI LPC: Add Kconfig MFD_CORE dependency

John Pittman (1):
       scsi: core: remove reference to scsi_show_extd_sense()

José Roberto de Souza (1):
       drm/i915/fbdev: Enable late fbdev initial configuration

Julian Anastasov (1):
       ipvs: fix rtnl_lock lockups caused by start_sync_thread

Julian Wiedmann (6):
       s390/qeth: fix error handling in adapter command callbacks
       s390/qeth: avoid control IO completion stalls
       s390/qeth: handle failure on workqueue creation
       s390/qeth: fix MAC address update sequence
       s390/qeth: fix request-side race during cmd IO timeout
       s390/qeth: use Read device to query hypervisor for MAC

Junaid Shahid (1):
       kvm: apic: Flush TLB after APIC mode/address change if VPIDs are in
use

Kai-Heng Feng (1):
       xhci: Fix USB ports for Dell Inspiron 5775

Kailang Yang (3):
       ALSA: hda/realtek - Add some fixes for ALC233
       ALSA: hda/realtek - Update ALC255 depop optimize
       ALSA: hda/realtek - change the location for one of two front mics

Kamil Lulko (1):
       usb: core: Add quirk for HP v222w 16GB Mini

Kan Liang (5):
       perf pmu: Fix core PMU alias list for X86 platform
       perf stat: Print out hint for mixed PMU group error
       perf evsel: Only fall back group read for leader
       perf stat: Fix duplicate PMU name for interval print
       perf/x86/intel: Don't enable freeze-on-smi for PerfMon V1

KarimAllah Ahmed (1):
       x86/headers/UAPI: Move DISABLE_EXITS KVM capability bits to the UAPI

Karthikeyan Ramasubramanian (1):
       tty: serial: qcom_geni_serial: Use signed variable to get IRQ

Kim Phillips (1):
       arm64/kernel: rename
module_emit_adrp_veneer->module_emit_veneer_for_adrp

Kyle Roeschley (1):
       USB: serial: cp210x: add ID for NI USB serial console

Laurentiu Tudor (1):
       powerpc/kvm/booke: Fix altivec related build break

Liam Girdwood (1):
       ASoC: topology: Check widget kcontrols before deref

Linus Torvalds (1):
       Linux v4.17-rc3

Linus Walleij (4):
       block: mq: Add some minor doc for core structs
       ARM: dts: Fix NAS4220B pin config
       ARM: s3c24xx: jive: Fix some GPIO names
       ARM: defconfig: Update Gemini defconfig

Loic Poulain (1):
       PCI: kirin: Fix reset gpio name

Long Li (2):
       cifs: smbd: Don't use RDMA read/write when signing is used
       cifs: smbd: Avoid allocating iov on the stack

Lukas Czerner (1):
       ext4: fix bitmap position validation

Mahesh Rajashekhara (1):
       scsi: sd: Defer spinning up drive while SANITIZE is in progress

Mahesh Salgaonkar (1):
       powerpc/mce: Fix a bug where mce loops on memory UE.

Marc Gonzalez (1):
       mtd: rawnand: tango: Fix struct clk memory leak

Marc Zyngier (4):
       KVM: arm/arm64: Close VMID generation race
       arm64: KVM: Demote SVE and LORegion warnings to debug only
       arm/arm64: KVM: Add PSCI version selection API
       serial: mvebu-uart: Fix local flags handling on termios update

Mark Rutland (7):
       arm64: add sentinel to kpti_safe_list
       arm64: ptrace: remove addr_limit manipulation
       arm64: only advance singlestep for user instruction traps
       arm64: fix possible spectre-v1 in ptrace_hbp_get_event()
       KVM: arm/arm64: vgic: fix possible spectre-v1 in vgic_get_irq()
       KVM: arm/arm64: vgic: fix possible spectre-v1 in vgic_mmio_read_apr()
       arm64: avoid instrumenting atomic_ll_sc.o

Markus Mayer (1):
       cpufreq: brcmstb-avs-cpufreq: remove development debug support

Martijn Coenen (1):
       ANDROID: binder: prevent transactions into own process.

Martin Blumenstingl (13):
       ARM64: dts: meson-gxl: add USB host support
       ARM64: dts: meson-gxm: add GXM specific USB host configuration
       ARM64: dts: meson-gxl-s905x-p212: enable the USB controller
       ARM64: dts: meson-gx-p23x-q20x: enable the USB controller
       ARM64: dts: meson-gxl-s905x-libretech-cc: enable the USB controller
       ARM64: dts: meson-gxl-nexbox-a95x: enable the USB controller
       ARM64: dts: meson-gxm-khadas-vim2: enable the USB controller
       usb: core: phy: fix return value of usb_phy_roothub_exit()
       usb: core: split usb_phy_roothub_{init,alloc}
       usb: core: use phy_exit during suspend if wake up is not supported
       usb: core: phy: make it a no-op if CONFIG_GENERIC_PHY is disabled
       usb: core: phy: add missing forward declaration for "struct device"
       usb: core: phy: add the SPDX-License-Identifier and include guard

Martin K. Petersen (1):
       scsi: mptsas: Disable WRITE SAME

Martin Schwidefsky (2):
       s390: update sampling tag after task pid change
       s390: correct module section names for expoline code revert

Masami Hiramatsu (2):
       selftests: ftrace: Fix trigger extended error testcase
       selftests: ftrace: Add a testcase for multiple actions on trigger

Md Fahad Iqbal Polash (1):
       ice: Fix insufficient memory issue in ice_aq_manage_mac_read

Michael Drake (1):
       ALSA: usb-audio: ADC3: Fix channel mapping conversion for ADC3.

Michael Lyle (1):
       MAINTAINERS: Remove me as maintainer of bcache

Michael S. Tsirkin (7):
       virtio_balloon: add array of stat names
       virtio_console: don't tie bufs to a vq
       virtio: add ability to iterate over vqs
       virtio_console: free buffers after reset
       virtio_console: drop custom control queue cleanup
       virtio_console: move removal code
       virtio_console: reset on out of memory

Michal Simek (1):
       tty: serial: xuartps: Setup early console when uartclk is also passed

Mika Kuoppala (1):
       drm/i915: Use ktime on wait_for

Mika Westerberg (3):
       ACPI / scan: Initialize watchdog before PNP
       PCI / PM: Do not clear state_saved in pci_pm_freeze() when smart
suspend is set
       ACPI / watchdog: Prefer iTCO_wdt on Lenovo Z50-70

Mikita Lipski (1):
       drm/amd/display: Fix deadlock when flushing irq

Ming Lei (2):
       scsi: target: fix crash with iscsi target and dvd
       Revert "blk-mq: remove code for dealing with remapping queue"

Miquel Raynal (1):
       mtd: rawnand: marvell: fix the chip-select DT parsing logic

Namhyung Kim (1):
       perf machine: Set main kernel end address properly

Nicholas Piggin (3):
       rtc: opal: Fix OPAL RTC driver OPAL_BUSY loops
       powerpc: Fix smp_send_stop NMI IPI handling
       powerpc: Fix deadlock with multiple calls to smp_send_stop

Nicolai Hähnle (1):
       drm/amdgpu: set COMPUTE_PGM_RSRC1 for SGPR/VGPR clearing shaders

Nicolin Chen (2):
       ASoC: fsl_esai: Fix divisor calculation failure at lower ratio
       ASoC: fsl_ssi: Fix mode setting when changing channel number

Niklas Cassel (1):
       MAINTAINERS: Remove myself as maintainer

Ohad Sharabi (1):
       scsi: ufs: add trace event for ufs upiu

Ondrej Jirman (1):
       Revert "drm/sun4i: add lvds mode_valid function"

Pablo Neira Ayuso (2):
       netfilter: nf_tables: NAT chain and extensions require NF_TABLES
       netfilter: xt_connmark: do not cast xt_connmark_tginfo1 to
xt_connmark_tginfo2

Peter Xu (1):
       tracing: Fix missing tab for hwlat_detector print format

Petr Tesarik (1):
       x86/setup: Do not reserve a crash kernel region if booted on Xen PV

Pierre-Louis Bossart (1):
       ASoC: Intel: atom: fix ACPI/PCI Kconfig

Randy Dunlap (1):
       drm/amdkfd: fix build, select MMU_NOTIFIER

Ravi Bangoria (1):
       tracing: Fix kernel crash while using empty filter with perf

Ravi Chandra Sadineni (1):
       USB: Increment wakeup count on remote wakeup.

Robert Kolchmeyer (1):
       fsnotify: Fix fsnotify_mark_connector race

Robin Murphy (1):
       dma-coherent: clarify dma_mmap_from_dev_coherent documentation

Sam Hansen (3):
       Documentation/i2c: whitespace cleanup
       Documentation/i2c: sync docs with current state of i2c-tools
       Documentation/i2c: adopt kernel commenting style in examples

Sangwon Hong (1):
       perf mem: Document incorrect and missing options

Sean Paul (1):
       drm/msm: Mark the crtc->state->event consumed

Sebastian Ott (1):
       s390/cio: update chpid descriptor after resource accessibility event

Shaokun Zhang (1):
       arm64: mm: drop addr parameter from sync icache and dcache

Shilpasri G Bhat (1):
       cpufreq: powernv: Fix hardlockup due to synchronous smp_call in timer
interrupt

Shuah Khan (4):
       usbip: vhci_hcd: check rhport before using in vhci_hub_control()
       usbip: vhci_hcd: Fix usb device and sockfd leaks
       usbip: usbip_host: fix to hold parent lock for device_attach() calls
       usbip: usbip_event: fix to not print kernel pointer address

Souptick Joarder (2):
       ALSA: usx2y: Change return type to vm_fault_t
       ALSA: pcm: Change return type to vm_fault_t

Srinath Mannam (1):
       arm64: dts: correct SATA addresses for Stingray

Srinivas Kandagatla (1):
       ASoC: msm8916-wcd-analog: use threaded context for mbhc events

Stefan Agner (3):
       drm/msm/dsi: use correct enum in dsi_get_cmd_fmt
       serial: imx: warn user when using unsupported configuration
       serial: imx: fix cached UCR2 read on software reset

Stefan Haberland (1):
       s390/dasd: fix IO error for newly defined devices

Stephan Mueller (1):
       crypto: drbg - set freed buffers to NULL

Stephen Hemminger (4):
       uio_hv_generic: set size of ring buffer attribute
       uio_hv_generic: make ring buffer attribute for primary channel
       uio_hv_generic: use correct channel in isr
       uio_hv_generic: fix subchannel ring mmap

Stephen Rothwell (1):
       netfilter: conntrack: include kmemleak.h for kmemleak_not_leak()

Steve French (3):
       CIFS: set *resp_buf_type to NO_BUFFER on error
       SMB3: Fix 3.11 encryption to Windows and handle encrypted smb3 tcon
       SMB311: Fix reconnect

Steven Rostedt (VMware) (1):
       tracing/x86: Update syscall trace events to handle new prefixed
syscall func names

Sudeep Holla (2):
       arm64: dts: juno: drop unnecessary address-cells and size-cells
properties
       hwmon: (scmi) handle absence of few types of sensors

Taehee Yoo (1):
       netfilter: nf_tables: fix out-of-bounds in nft_chain_commit_update

Takashi Iwai (14):
       dma-direct: don't retry allocation for no-op GFP_DMA
       ALSA: control: Fix missing __user annotation
       ALSA: usb-audio: Fix forgotten conversion of control query functions
       ALSA: usb-audio: Fix missing endian conversion
       ALSA: usb-audio: Skip broken EU on Dell dock USB-audio
       ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device
       ALSA: seq: oss: Hardening for potential Spectre v1
       ALSA: control: Hardening for potential Spectre v1
       ALSA: hda: Hardening for potential Spectre v1
       ALSA: opl3: Hardening for potential Spectre v1
       ALSA: asihpi: Hardening for potential Spectre v1
       ALSA: hdspm: Hardening for potential Spectre v1
       ALSA: rme9652: Hardening for potential Spectre v1
       ALSA: hda - Skip jack and others for non-existing PCM streams

Takashi Sakamoto (2):
       ALSA: dice: fix OUI for TC group
       ALSA: dice: fix error path to destroy initialized stream data

Tero Kristo (1):
       ASoC: dmic: Fix clock parenting

Tetsuo Handa (4):
       commoncap: Handle memory allocation failure.
       tty: Avoid possible error pointer dereference at tty_ldisc_restore().
       tty: Don't call panic() at tty_ldisc_init()
       tty: Use __GFP_NOFAIL for tty_ldisc_get()

Theodore Ts'o (4):
       ext4: set h_journal if there is a failure starting a reserved handle
       random: fix possible sleeping allocation from irq context
       random: rate limit unseeded randomness warnings
       ext4: add MODULE_SOFTDEP to ensure crc32c is included in the initramfs

Thomas Falcon (1):
       ibmvnic: Clean actual number of RX or TX pools

Thomas Gleixner (3):
       x86/jailhouse: Fix incorrect SPDX identifier
       tick/sched: Do not mess with an enqueued hrtimer
       Revert: Unify CLOCK_MONOTONIC and CLOCK_BOOTTIME

Thomas Richter (5):
       module: Fix display of wrong module .text address
       perf list: Remove s390 specific strcmp_cpuid_cmp function
       perf test: Adapt test case record+probe_libc_inet_pton.sh for s390
       perf record: Fix s390 undefined record__auxtrace_init() return value
       kprobes: Fix random address output of blacklist file

Thor Thayer (2):
       ARM: socfpga_defconfig: Remove QSPI Sector 4K size force
       mtd: spi-nor: cadence-quadspi: Fix page fault kernel panic

Tobias Regnery (1):
       usb: typec: ucsi: fix tracepoint related build error

Tom Lendacky (3):
       amd-xgbe: Add pre/post auto-negotiation phy hooks
       amd-xgbe: Improve KR auto-negotiation and training
       amd-xgbe: Only use the SFP supported transceiver signals

Tony Lindgren (3):
       ARM: dts: Fix cm2 and prm sizes for omap4
       tty: n_gsm: Fix long delays with control frame timeouts in ADM mode
       tty: n_gsm: Fix DLCI handling for ADM mode if debug & 2 is not set

Vasyl Vavrychuk (1):
       USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster

Victor Gu (3):
       PCI: aardvark: Fix logic in advk_pcie_{rd,wr}_conf()
       PCI: aardvark: Set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
       PCI: aardvark: Use ISR1 instead of ISR0 interrupt in legacy irq mode

Ville Syrjälä (1):
       drm/edid: Reset more of the display info

Vinicius Costa Gomes (1):
       igb: Fix the transmission mode of queue 0 for Qav mode

Vinson Lee (1):
       scsi: megaraid_sas: Do not log an error if FW successfully
initializes.

Wei Yongjun (2):
       ASoC: amd: acp-da7219-max98357: Make symbol da7219_dai_clk static
       drm/amdkfd: Fix the error return code in
kfd_ioctl_unmap_memory_from_gpu()

Willem de Bruijn (1):
       packet: fix bitfield update race

Xin Long (2):
       bonding: do not set slave_dev npinfo before slave_enable_netpoll in
bond_enslave
       team: fix netconsole setup over team

Yan Wang (1):
       ASoC: topology: Fix bugs of freeing soc topology

Yan, Zheng (1):
       ceph: check if mds create snaprealm when setting quota

Yazen Ghannam (1):
       x86/smpboot: Don't use mwait_play_dead() on AMD systems

Yonghong Song (2):
       bpf/tracing: fix a deadlock in perf_event_detach_bpf_prog
       tools/bpf: fix test_sock and test_sock_addr.sh failure

Zhengjun Xing (1):
       xhci: Fix Kernel oops in xhci dbgtty

jacek.tomaka@poczta.fm (1):
       x86/cpu/intel: Add missing TLB cpuid values

kbuild test robot (1):
       drm/amdkfd: kfd_dev_is_large_bar() can be static

oder_chiou@realtek.com (1):
       ASoC: rt5514: Add the missing register in the readable table
