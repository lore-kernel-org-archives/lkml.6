Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB70BC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 23:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514DD256D3
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 23:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NafoQF4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514DD256D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeGAXqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 19:46:55 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:40040 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbeGAXqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 19:46:52 -0400
Received: by mail-it0-f41.google.com with SMTP id 188-v6so9770420ita.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 16:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RPUdBCzvoQq4EmT/uMUjItD7u5it86h+1dpOBJpcMcU=;
        b=NafoQF4W8elZl013hMVeW1PIwJs/rXbtwVLF2owKV6+nlPCWFJb7A3b+3V7TRJtXzr
         srED1226Hs2Gvp+jTzWwRBFa86j64qatJXyWP73hirtTNPnFDXdEP7/akcinKUyVF1sP
         gz9lNn2WkDGTz7KJcnU+PzAhhfPTDF8+bSbBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RPUdBCzvoQq4EmT/uMUjItD7u5it86h+1dpOBJpcMcU=;
        b=NJ8Z3KhmbAkyEVCdIkoWW0te3EOCI816WgoiO9f2e9BIz5LzoCAPgu11VnmR6TeS3B
         X7nsOs4AYIssmFTZaH/rXbY0pUTST3yvguiLGAHIQdt8JBDIa++Aa8iGTX91pnOL5IOy
         rzhUywzjG6Qj8U+T2KKmXrSG7vzyRplpiiRFc6XKhCiSgkJ7IGlmnkgQV8vIo490S9Ln
         L008mG3hr1KFXDZWs6/LuptjDBQ9Zd8UVgAdV/yRIXk2KLmBnbiD+OvV3wZ37jbt/Kv0
         qgXsZJx019ArHBdA7O+2Rb/hnziDmup8/pzdEC11NCe3ORY+RO/PkFGRPuXl1JFjdgOl
         LJLw==
X-Gm-Message-State: APt69E0XwI+i++pJvb1gLGiZGXWuQuDqK4THmyrbxxocW31fpxkRNCY3
        WST/768RLWbIyPgmygK2p8vDLL7LgSgjOFPKharXpEux
X-Google-Smtp-Source: AAOMgpdKdQf/7tWQPAQqOE3pkfdHUmFiz92wkyrPGvgxcx5t7lMD4PYCLRQO2FFI11LcXRPNaYiI3TqnqgZD7kHyzac=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr18804067jas.72.1530488811125;
 Sun, 01 Jul 2018 16:46:51 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Jul 2018 16:46:40 -0700
Message-ID: <CA+55aFwGk-pWKKCtp+kQUN_hov9tW+vUo6Wgob91bewwBL17fA@mail.gmail.com>
Subject: Linux 4.18-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm back at home, over jetlag, and back to the usual "Sunday
afternoon" release schedule.

So there it is, in all the usual places.

And things look fairly normal - a bit over a third is drivers (various
parts: input, usb, sound, gpu, mtd, networking, ...), with the rest
being arch updates (arm/arm64 - dts files dominating, microblaze,
powerpc, x86), filesystems (xfs, some btrfs, some minor core vfs),
networking, documentation updates and tooling.

The shortlog is appended, nothing really stands out that much. Mostly
it really is just one- and few-liners spread out all over.

Go forth and test.

             Linus

PS. And on a personal note - it so happens that today is the 15th
anniversary of me working for the Linux Foundation (n=C3=A9e OSDL). How
time flies.

---

=E5=BB=96=E5=B4=87=E6=A6=AE (1):
      Input: elantech - fix V4 report decoding for module with middle key

Aaron Ma (1):
      Input: elantech - enable middle button of touchpads on ThinkPad P52

Abhishek Sahu (1):
      mtd: rawnand: fix return value check for bad block status

Adam Ford (1):
      ARM: davinci: board-da850-evm: fix WP pin polarity for MMC/SD

Adrian Hunter (1):
      perf intel-pt: Fix packet decoding of CYC packets

Ajay Gupta (1):
      usb: xhci: increase CRS timeout value

Alan Douglas (1):
      PCI: Initialize endpoint library before controllers

Alastair Bridgewater (6):
      ALSA: hda/ca0132: Delete pointless assignments to struct
auto_pin_cfg fields
      ALSA: hda/ca0132: Delete redundant UNSOL event requests
      ALSA: hda/ca0132: Restore behavior of QUIRK_ALIENWARE
      ALSA: hda/ca0132: Don't test for QUIRK_NONE
      ALSA: hda/ca0132: Restore PCM Analog Mic-In2
      ALSA: hda/ca0132: Fix DMic data rate for Alienware M17x R4

Aleksander Morgado (1):
      qmi_wwan: add support for the Dell Wireless 5821e module

Alexander Potapenko (1):
      vt: prevent leaking uninitialized data to userspace via /dev/vcs*

Alexandr Savca (1):
      Input: elan_i2c - add ELAN0618 (Lenovo v330 15IKB) ACPI ID

Alexey Dobriyan (1):
      proc: add Alexey to MAINTAINERS

Alison Wang (1):
      drm: mali-dp: Enable Global SE interrupts mask for DP500

Anders Roxell (2):
      selftests: net: add config fragments
      selftests: net: add tcp_inq to gitignore

Andrey Ryabinin (1):
      x86/mm: Don't free P4D table when it is folded at runtime

Andy Lutomirski (3):
      x86/entry/64/compat: Fix "x86/entry/64/compat: Preserve r8-r11
in int $0x80"
      selftests/x86/sigreturn/64: Fix spurious failures on AMD CPUs
      selftests/x86/sigreturn: Do minor cleanups

Andy Shevchenko (2):
      serial: 8250_pci: Remove stalled entries in blacklist
      parisc: Convert printk(KERN_LEVEL) to pr_lvl()

Aneesh Kumar K.V (1):
      powerpc/mm/32: Fix pgtable_page_dtor call

Anson Huang (1):
      soc: imx: gpcv2: correct PGC offset

Antoine Tenart (3):
      net: mscc: fix the injection header
      net: mvneta: fix the Rx desc DMA address in the Rx path
      net: mscc: make sparse happy

Arnaldo Carvalho de Melo (5):
      tools headers uapi: Synchronize drm/drm.h
      perf tools: Update x86's syscall_64.tbl, adding 'io_pgetevents' and '=
rseq'
      tools include powerpc: Update
arch/powerpc/include/uapi/asm/unistd.h copy to get 'rseq' syscall
      tools include uapi: Update if_link.h to pick
IFLA_{BRPORT_ISOLATED,VXLAN_TTL_INHERIT}
      tools include uapi: Synchronize bpf.h with the kernel

Arnd Bergmann (7):
      scsi: ipr: Eliminate duplicate barriers
      usb: dwc3: qcom: mark PM functions as __maybe_unused
      dm raid: don't use 'const' in function return
      kbuild: add macro for controlling warnings to linux/compiler.h
      disable -Wattribute-alias warning for SYSCALL_DEFINEx()
      qcom: cmd-db: enforce CONFIG_OF_RESERVED_MEM dependency
      powerpc/powermac: Fix rtc read/write functions

Artur Petrosyan (1):
      usb: dwc2: Fix host exit from hibernation flow.

Avi Kivity (1):
      aio: mark __aio_sigset::sigmask const

Ayan Kumar Halder (3):
      drm/arm/malidp: Ensure that the crtcs are shutdown before
removing any encoder/connector
      drm/arm/malidp: Preserve LAYER_FORMAT contents when setting format
      drm/mali-dp: Rectify the width and height passed to rotmem_required()

Bart Van Assche (3):
      dm zoned: avoid triggering reclaim from inside dmz_map()
      block: Fix cloning of requests with a special payload
      drbd: Fix drbd_request_prepare() discard handling

Bartosz Golaszewski (1):
      net: davinci_emac: match the mdio device against its compatible
if possible

Ben Hutchings (1):
      Input: elan_i2c_smbus - fix more potential stack buffer overflows

Bjorn Helgaas (1):
      PCI: shpchp: Manage SHPC unconditionally on non-ACPI systems

Breno Leitao (1):
      powerpc: Wire up io_pgetevents

Casey Schaufler (1):
      Smack: Mark inode instant in smack_task_to_inode

Chris Mason (1):
      Btrfs: fix regression in btrfs_page_mkwrite() from vm_fault_t convers=
ion

Chris Packham (1):
      mtd: rawnand: micron: add ONFI_FEATURE_ON_DIE_ECC to supported featur=
es

Christoph Hellwig (3):
      xfs: simplify xfs_bmap_punch_delalloc_range
      swiotlb: export swiotlb_dma_ops
      net: handle NULL ->poll gracefully

Christophe JAILLET (1):
      drm/meson: Fix an un-handled error path in 'meson_drv_bind_master()'

Chunfeng Yun (1):
      usb: gadget: composite: fix delayed_status race condition when
set_interface

Chunyu Hu (1):
      proc: add proc_seq_release

Claudio Imbrenda (1):
      VSOCK: fix loopback on big-endian systems

Colin Ian King (4):
      ALSA: hda/ca0132: make array ca0132_alt_chmaps static
      net: ethernet: ti: davinci_cpdma: make function
cpdma_desc_pool_create static
      iio: tsl2x7x/tsl2772: avoid potential division by zero
      sfc: make function efx_rps_hash_bucket static

Cong Wang (1):
      net_sched: remove a bogus warning in hfsc

Dan Carpenter (4):
      ALSA: lx6464es: Missing error code in snd_lx6464es_create()
      cpufreq: qcom-kryo: Fix error handling in probe()
      typec: tcpm: Fix a msecs vs jiffies bug
      staging: comedi: quatech_daqp_cs: fix no-op loop daqp_ao_insn_write()

Darrick J. Wong (8):
      xfs: allow empty transactions while frozen
      xfs: don't trip over negative free space in xfs_reserve_blocks
      xfs: don't allow insert-range to shift extents past the maximum offse=
t
      xfs: recheck reflink state after grabbing ILOCK_SHARED for a write
      xfs: fix uninitialized field in rtbitmap fsmap backend
      xfs: fix off-by-one error in xfs_rtalloc_query_range
      xfs: ensure post-EOF zeroing happens after zeroing part of a file
      xfs: fix fdblocks accounting w/ RMAPBT per-AG reservation

Dave Chinner (2):
      xfs: More robust inode extent count validation
      xfs: xfs_iflush_abort() can be called twice on cluster writeback fail=
ure

Dinh Nguyen (1):
      ARM: dts: socfpga: Fix NAND controller node compatible for Arria10

Dirk Gouders (2):
      kconfig: fix line numbers for if-entries in menu tree
      kconfig: handle P_SYMBOL in print_symbol()

Dmitry Torokhov (3):
      Input: make input_report_slot_state() return boolean
      Input: do not assign new tracking ID when changing tool type
      Input: psmouse - fix button reporting for basic protocols

Dmitry Vyukov (2):
      x86/mm: Get rid of KERN_CONT in show_fault_oops()
      x86/mm: Clean up the printk()s in show_fault_oops()

Dongjiu Geng (1):
      usb: xhci: remove the code build warning

Enno Boland (1):
      Input: xpad - fix GPD Win 2 controller name

Eric Biggers (1):
      dh key: fix rounding up KDF output length

Eric Dumazet (4):
      bpf: enforce correct alignment for instructions
      net/packet: fix use-after-free
      net: dccp: avoid crash in ccid3_hc_rx_send_feedback()
      net: dccp: switch rx_tstamp_last_feedback to monotonic clock

Filipe Manana (3):
      Btrfs: fix physical offset reported by fiemap for inline extents
      Btrfs: fix return value on rename exchange failure
      Btrfs: fix mount failure when qgroup rescan is in progress

Florian Fainelli (6):
      MAINAINTERS: Corrected Broadcom Northstar2 entry
      MAINTAINERS: Update Broadcom iProc entry with Stingray
      ARM: dts: NSP: Fix i2c controller interrupt type
      ARM: dts: NSP: Fix PCIe controllers interrupt types
      ARM: dts: HR2: Fix interrupt types for i2c and PCIe
      ARM: dts: BCM5301x: Fix i2c controller interrupt type

Ganesh Goudar (1):
      cxgb4: when disabling dcb set txq dcb priority to 0

Geert Uytterhoeven (5):
      soc: renesas: rcar-sysc: Make PM domain initialization more robust
      mtd: dataflash: Use ULL suffix for 64-bit constants
      MAINTAINERS: Add file patterns for dsa device tree bindings
      net: Remove depends on HAS_DMA in case of platform dependency
      ARM: Always build secure_cntvoff.S on ARM V7 to fix shmobile !SMP bui=
ld

Grigor Tovmasyan (1):
      usb: gadget: dwc2: fix memory leak in gadget_init()

Hangbin Liu (1):
      ipv6: mcast: fix unsolicited report interval after receiving querys

Hans de Goede (4):
      Input: silead - add MSSL0002 ACPI HID
      usb: dwc3: Only call clk_bulk_get() on devicetree instantiated device=
s
      iio: imu: inv_mpu6050: Fix probe() failure on older ACPI based machin=
es
      NFC: pn533: Fix wrong GFP flag usage

Harini Katakam (1):
      net: macb: Fix ptp time adjustment for large negative delta

Heikki Krogerus (4):
      usb: dwc3: pci: add support for Intel IceLake
      acpi: Add helper for deactivating memory region
      usb: typec: ucsi: acpi: Workaround for cache mode issue
      usb: typec: ucsi: Fix for incorrect status data issue

Helge Deller (6):
      parisc: Drop struct sigaction from not exported header file
      parisc: Mark 16kB and 64kB page sizes BROKEN
      parisc: Default to 4 SMP CPUs
      parisc: Wire up io_pgetevents syscall
      parisc: Reduce debug output in unwind code
      parisc: Build kernel without -ffunction-sections

Hoan Tran (1):
      drivers/perf: xgene_pmu: Fix IOB SLOW PMU parser error

Houston Yaroschoff (1):
      usb: cdc_acm: Add quirk for Uniden UBC125 scanner

Hui Wang (1):
      ALSA: hda/realtek - Fix the problem of two front mics on more machine=
s

Ingo Molnar (1):
      tools/headers: Pick up latest kernel ABIs

Jaejoong Kim (1):
      doc: usb: Fix typo in gadget_configfs documentation

James Zhu (1):
      drm/amdgpu:Support new VCN FW version naming convention

Jan Beulich (1):
      x86/entry/32: Add explicit 'l' instruction suffix

Jann Horn (1):
      selinux: move user accesses in selinuxfs out of locked regions

Jason A. Donenfeld (1):
      kasan: depend on CONFIG_SLUB_DEBUG

Jason Wang (1):
      vhost_net: validate sock before trying to put its fd

Jens Axboe (2):
      blk-mq: don't queue more if we get a busy return
      sg: remove ->sg_magic member

Jerome Brunet (2):
      ARM64: dts: meson: disable sd-uhs modes on the libretech-cc
      ARM64: dts: meson-axg: fix ethernet stability issue

Jerry James (1):
      kconfig: loop boundary condition fix

Jiri Olsa (3):
      perf tests: Add event parsing error handling to parse events test
      perf tests: Add valid callback for parse-events test
      perf bench: Fix numa report output code

Joakim Tjernlund (4):
      mtd: cfi_cmdset_0002: Use right chip in do_ppb_xxlock()
      mtd: cfi_cmdset_0002: fix SEGV unlocking multiple chips
      mtd: cfi_cmdset_0002: Fix unlocking requests crossing a chip boudary
      mtd: cfi_cmdset_0002: Avoid walking all chips when unlocking.

Johan Hovold (3):
      USB: serial: cp210x: add CESINEL device ids
      usb: dwc3: of-simple: fix use-after-free on remove
      serdev: fix memleak on module unload

Karoly Pados (1):
      USB: serial: cp210x: add Silicon Labs IDs for Windows Update

Katsuhiro Suzuki (1):
      arm64: dts: uniphier: fix widget name of headphone for LD11/LD20 boar=
ds

Keerthy (1):
      ARM: dts: da850: Fix interrups property for gpio

Kees Cook (1):
      dm writecache: use 2-factor allocator arguments

Keith Busch (1):
      block: Fix transfer when chunk sectors exceeds max

Kevin Hilman (2):
      ARM64: dts: meson: fix register ranges for SD/eMMC
      ARM64: dts: meson-gx: fix ATF reserved memory region

Kirill A. Shutemov (2):
      x86/efi: Fix efi_call_phys_epilog() with CONFIG_X86_5LEVEL=3Dy
      x86/mm: Drop unneeded __always_inline for p4d page table helpers

Laura Abbott (1):
      staging: android: ion: Return an ERR_PTR in ion_map_kernel

Leo Liu (1):
      drm/amdgpu: fix UBSAN: Undefined behaviour for amdgpu_fence.c

Leonard Crestez (1):
      iio: mma8452: Fix ignoring MMA8452_INT_DRDY

Linus Torvalds (3):
      checkpatch: remove warning for 'old' stable@kernel.org address
      Revert changes to convert to ->poll_mask() and aio IOCB_CMD_POLL
      Linux 4.18-rc3

Lorenzo Pieralisi (1):
      PCI: controller: Move PCI_DOMAINS selection to arch Kconfig

Lu Fengqi (1):
      btrfs: fix invalid-free in btrfs_extent_same

Lucas Stach (1):
      Input: synaptics-rmi4 - fix axis-swap behavior

Luis Henriques (1):
      scsi: scsi_debug: Fix memory leak on module unload

Lyude Paul (1):
      drm/amdgpu: Count disabled CRTCs in commit tail earlier

Maciej S. Szmigiero (1):
      X.509: unpack RSA signatureValue field from BIT STRING

Marcelo Ricardo Leitner (1):
      sctp: fix erroneous inc of snmp SctpFragUsrMsgs

Marek Vasut (2):
      ARM: dts: socfpga: Fix NAND controller clock supply
      ARM: dts: socfpga: Fix NAND controller node compatible

Martin Blumenstingl (1):
      ARM64: dts: meson-gxl: fix Mali GPU compatible string

Martin Kaiser (1):
      mtd: rawnand: mxc: set spare area size register explicitly

Masahiro Yamada (2):
      mtd: rawnand: denali_dt: set clk_x_rate to 200 MHz unconditionally
      kbuild: reword help of LD_DEAD_CODE_DATA_ELIMINATION

Mason Yang (1):
      mtd: rawnand: All AC chips have a broken GET_FEATURES(TIMINGS).

Mathias Nyman (1):
      xhci: Fix perceived dead host due to runtime suspend race with
event handler

Mathieu Malaterre (1):
      perf/core: Move inline keyword at the beginning of declaration

Matteo Croce (1):
      bpfilter: fix user mode helper cross compilation

Michal Simek (2):
      microblaze: Remove architecture heart beat code
      microblaze: Add new syscalls io_pgetevents and rseq

Michel D=C3=A4nzer (1):
      drm/amdgpu: GPU vs CPU page size fixes in amdgpu_vm_bo_split_mapping

Mike Snitzer (3):
      dm: use bio_split() when splitting out the already processed bio
      dm thin metadata: remove needless work from __commit_transaction
      dm thin: handle running out of data space vs concurrent discard

Mikhail Malygin (1):
      scsi: qla2xxx: Spinlock recursion in qla_target

Mikulas Patocka (1):
      slub: fix failure when we delete and create a slab cache

Minas Harutyunyan (3):
      usb: dwc2: gadget: Fix issue in dwc2_gadget_start_isoc()
      usb: dwc2: gadget: fix packet drop issue for ISOC OUT transfers
      dwc2: gadget: Fix ISOC IN DDMA PID bitfield value calculation

Miquel Raynal (1):
      arm64: dts: marvell: fix CP110 ICU node size

Naoya Horiguchi (1):
      x86/e820: put !E820_TYPE_RAM regions into memblock.reserved

Neil Armstrong (1):
      ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0

Nick Desaulniers (1):
      certs/blacklist: fix const confusion

Nick Dyer (1):
      Input: synaptics-rmi4 - convert irq distribution to irq_domain

Oleksij Rempel (1):
      ARM: dts: imx6sx: fix irq for pcie bridge

Olof Johansson (2):
      arm64: defconfig: renormalize based on recent additions
      ARM: multi_v7_defconfig: renormalize based on recent additions

Paolo Abeni (1):
      cls_flower: fix use after free in flower S/W path

Paul Burton (2):
      MIPS: Add ksig argument to rseq_{signal_deliver,handle_notify_resume}
      powerpc: Remove -Wattribute-alias pragmas

Peter Chen (2):
      usb: typec: tcpm: fix logbuffer index is wrong if _tcpm_log is re-ent=
ered
      usb: chipidea: host: fix disconnection detect issue

Peter Rosin (1):
      i2c: smbus: kill memory leak on emulated and failed DMA SMBus xfers

Petr Mladek (1):
      Revert "lib/test_printf.c: call wait_for_random_bytes() before
plain %p tests"

Phil Reid (1):
      iio: buffer: fix the function signature to match implementation

Qu Wenruo (1):
      btrfs: quota: Set rescan progress to (u64)-1 if we hit last leaf

Rafael J. Wysocki (2):
      Documentation: admin-guide: intel_pstate: Fix sysfs path
      Documentation: intel_pstate: Describe hwp_dynamic_boost sysfs knob

Randy Dunlap (2):
      staging/typec: fix tcpci_rt1711h build errors
      kconfig: document Kconfig source file comments

Ravi Bangoria (3):
      perf script: Add missing output fields in a hint
      perf script: Fix crash because of missing evsel->priv
      perf tools: Fix crash caused by accessing feat_ops[HEADER_LAST_FEATUR=
E]

Ray Jui (5):
      ARM: dts: Cygnus: Fix I2C controller interrupt type
      ARM: dts: Cygnus: Fix PCIe controller interrupt type
      arm64: dts: ns2: Fix I2C controller interrupt type
      arm64: dts: ns2: Fix PCIe controller interrupt type
      arm64: dts: Stingray: Fix I2C controller interrupt type

Rob Herring (4):
      microblaze: heartbeat: fix missing prom.h include
      microblaze: remove unecessary of_platform_bus_probe call
      microblaze: consolidate GPIO reset handling
      arm64: dts: msm8916: fix Coresight ETF graph connections

Roman Kiryanov (1):
      Input: goldfish_events - fix checkpatch warnings

Ross Lagerwall (2):
      xen-netfront: Fix mismatched rtnl_unlock
      xen-netfront: Update features after registering netdev

Ross Zwisler (3):
      pmem: only set QUEUE_FLAG_DAX for fsdax mode
      dax: check for QUEUE_FLAG_DAX in bdev_dax_supported()
      dm: prevent DAX mounts if not supported

Sagi Grimberg (1):
      nvme-rdma: fix possible double free of controller async event buffer

Sandipan Das (1):
      perf report powerpc: Fix crash if callchain is empty

Scott Branden (2):
      arm64: dts: specify 1.8V EMMC capabilities for bcm958742k
      arm64: dts: specify 1.8V EMMC capabilities for bcm958742t

Sean Nyekjaer (1):
      ARM: dts: imx6q: Use correct SDMA script for SPI5 core

Sebastian Andrzej Siewior (2):
      lib/percpu_ida.c: don't do alloc from per-CPU list if there is none
      Revert mm/vmstat.c: fix vmstat_update() preemption BUG

Shirish S (1):
      drm/amd/display: release spinlock before committing updates to stream

Souptick Joarder (1):
      include/linux/dax.h: dax_iomap_fault() returns vm_fault_t

Srinivas Kandagatla (1):
      arm64: dts: apq8096-db820c: disable uart0 by default

Stefan Agner (1):
      usb: xhci: tegra: fix runtime PM error handling

Sven Joachim (1):
      stack-protector: Fix test with 32-bit userland and CONFIG_64BIT=3Dy

Takashi Iwai (5):
      ALSA: hda/realtek - Fix pop noise on Lenovo P50 & co
      ALSA: hda - Force to link down at runtime suspend on ATI/AMD HDMI
      ALSA: hda/realtek - Add a quirk for FSC ESPRIMO U9210
      ALSA: timer: Fix UBSAN warning at SNDRV_TIMER_IOCTL_NEXT_DEVICE ioctl
      ALSA: seq: Fix UBSAN warning at SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT ioc=
tl

Tetsuo Handa (2):
      n_tty: Fix stall at n_tty_receive_char_special().
      n_tty: Access echo_* variables carefully.

Thomas Richter (5):
      perf record: Support s390 random socket_id assignment
      perf test session topology: Fix test on s390
      perf alias: Remove trailing newline when reading sysfs files
      perf alias: Rebuild alias expression string to make it comparable
      perf stat: Remove duplicate event counting

Thor Thayer (2):
      arm64: dts: stratix10: Fix SPI nodes for Stratix10
      ARM: dts: Fix SPI node for Arria10

Timur Tabi (1):
      MAINTAINERS: Timur has a kernel.org address

Tobin C. Harding (4):
      Documentation: e100: Use correct heading adornment
      Documentation: e1000: Use correct heading adornment
      Documentation: e100: Fix docs build error
      Documentation: e1000: Fix docs build error

Tomasz Duszynski (1):
      iio: pressure: bmp280: fix relative humidity unit

Vakul Garg (2):
      strparser: Don't schedule in workqueue in paused state
      strparser: Corrected typo in documentation.

Ville Syrj=C3=A4l=C3=A4 (1):
      r8169: Fix netpoll oops

Vincent Pelletier (1):
      usb: gadget: ffs: Fix BUG when userland exits with submitted AIO tran=
sfers

Viresh Kumar (3):
      arm: dts: armada: Fix "#cooling-cells" property's name
      PM / Domains: Fix return value of of_genpd_opp_to_performance_state()
      PM / Domains: Rename opp_node to np

Wei Yongjun (2):
      Input: synaptics-rmi4 - fix the error return code in
rmi_probe_interrupts()
      usb: dwc3: Fix error return code in dwc3_qcom_probe()

Will Deacon (2):
      arm64: Avoid flush_icache_range() in alternatives patching code
      arm64: Remove unnecessary ISBs from set_{pte,pmd,pud}

William Wu (3):
      usb: dwc2: fix the incorrect bitmaps for the ports of multi_tt hub
      usb: dwc2: alloc dma aligned buffer for isoc split in
      usb: dwc2: fix isoc split in transfer with no data

Wolfram Sang (3):
      Revert "i2c: algo-bit: init the bus to a known state"
      i2c: algos: bit: mention our experience about initial states
      i2c: gpio: initialize SCL to HIGH again

Xiaotong Lu (1):
      Input: add Spreadtrum vibrator driver

Xin Long (1):
      ipvlan: fix IFLA_MTU ignored on NEWLINK

Yan, Zheng (1):
      ceph: fix dentry leak in splice_dentry()

Yonghong Song (1):
      perf tools: Fix a clang 7.0 compilation error

Zeng Tao (1):
      usb: dwc2: gadget: fix packet drop issue in dwc2_gadget_handle_nak

Zhengjun Xing (1):
      xhci: Fix kernel oops in trace_xhci_free_virt_device

bstroesser@ts.fujitsu.com (1):
      scsi: target: tcmu: add read length support

oscardagrach (2):
      arm64: dts: hikey: Define wl1835 power capabilities
      arm64: dts: hikey960: Define wl1837 power capabilities
