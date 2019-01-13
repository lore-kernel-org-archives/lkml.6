Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AA6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCC920842
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c+sQO5Tg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfAMXFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 18:05:55 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:43459 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbfAMXFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 18:05:54 -0500
Received: by mail-lf1-f48.google.com with SMTP id u18so14299915lff.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 15:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ocfiZO9dgL6y4kP/nI1bhg/65/0dUnZS9ejii987JY0=;
        b=c+sQO5TgSjTDWgSHL8xzSUMYerfI7JRtZjH9KJAioN63mBlaCqdzo3DbSzJNyDQR8U
         Wgk7s4dxlfl5HMADPwagwcBaLUbhgp2vsIhwLH0rKWvAlrZScsLBw4tedTmCSjK9J0SZ
         CWOxlgL6TQzHWIZ5FR6Bfc01ADl+4VMVWy0Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ocfiZO9dgL6y4kP/nI1bhg/65/0dUnZS9ejii987JY0=;
        b=XWYQ4H3r1q232KDSY/FOObo3MWhaTanKyUEco9L3Ps+KgoBf2TMfMv3nQow4TcCCnU
         9WKmWZ+8OmZLX2BZREomtOdjMN5SrXv0THCOToUaBxZPTFoF1zOk/UR/Ge6504CHdWEC
         C43remtmXG5p2pWxDXfqkXla5G+XUUxoC0pTCJ7Ilj4MyqDwg42Fjwp3PDgaCqD9a2Bv
         j9rQkFSwrGbdMx5DULqpUzHu6cRvOZTmv1raPyzBGy7uYEj38DK9DD/TJvcrNLGe3ZYa
         KW3ndNYseRbnX1ynWoEl36qvl1mhY0bl8sq4yYM9GFM6dQjJ76PyeKl9HTeNg+IUuHcg
         L/6w==
X-Gm-Message-State: AJcUukesP0DoTgcsWfxuZvn9KFwpBNY7t8GwDYcYg/+tGfxwtjGvCnZV
        vPCmKxJdk5GH20eo+1vYPCqueEPyysI=
X-Google-Smtp-Source: ALg8bN4viI8VaGOceJGCJspYQiTa4hGijQp/7Wk5V6jZ4KQp+1TYflNkCAKgmIj/vBGSYln4DPgXcw==
X-Received: by 2002:a19:280f:: with SMTP id o15mr2206387lfo.0.1547420750317;
        Sun, 13 Jan 2019 15:05:50 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 67-v6sm17170215ljc.26.2019.01.13.15.05.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 15:05:49 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id v15-v6so17381520ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 15:05:49 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr13940449lji.133.1547420748787;
 Sun, 13 Jan 2019 15:05:48 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Jan 2019 11:05:31 +1200
X-Gmail-Original-Message-ID: <CAHk-=wicCXd7nALwEz+022iNesJV3DUmejS+dzVRE0D3UGzs_g@mail.gmail.com>
Message-ID: <CAHk-=wicCXd7nALwEz+022iNesJV3DUmejS+dzVRE0D3UGzs_g@mail.gmail.com>
Subject: Linux 5.0-rc2
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So the merge window had somewhat unusual timing with the holidays, and
I was afraid that would affect stragglers in rc2, but honestly, that
doesn't seem to have happened much. rc2 looks pretty normal.

Were there some missing commits that missed the merge window? Yes. But
no more than usual. Things look pretty normal.

What's a bit abnormal is that I'm traveling again, and so for me it's
a Monday release, but it's (intentionally) the usual "Sunday
afternoon" release schedule back home. I'm trying to not surprise
people too much.

As to actual changes: all looks fairly normal.  Yes, there's a fair
number of perf tooling updates, so that certainly stands out in the
diffstat, but if you ignore the tooling and just look at the kernel,
it's about two thirds drivers (networking, gpu, block, scsi..), with
the rest being the usual mix of arch updates (ARM, RISC-V, x86, csky),
with some filesystem (btrfs, cifs) and vm fixes.

Go test,

              Linus

---

AKASHI Takahiro (1):
      arm64: kexec_file: return successfully even if kaslr-seed doesn't exi=
st

Alex Williamson (1):
      vfio/type1: Fix unmap overflow off-by-one

Amadeusz S=C5=82awi=C5=84ski (1):
      ALSA: usb-audio: fix CM6206 register definitions

Andreas Schwab (1):
      riscv: don't stop itself in smp_send_stop

Andrey Konovalov (3):
      kasan, arm64: use ARCH_SLAB_MINALIGN instead of manual aligning
      kasan: make tag based mode work with CONFIG_HARDENED_USERCOPY
      kasan: fix krealloc handling for tag-based mode

Andrey Smirnov (1):
      nvme: don't initlialize ctrl->cntlid twice

Anup Patel (2):
      RISC-V: Make BSS section as the last section in vmlinux.lds.S
      tty/serial: Add RISC-V SBI earlycon support

Arnaldo Carvalho de Melo (19):
      tools headers x86: Sync disabled-features.h
      tools headers uapi: Sync prctl.h with the kernel sources
      tools beauty: Make the prctl option table generator catch all PR_ opt=
ions
      tools headers uapi: Update i915_drm.h
      tools headers uapi: Sync linux/in.h copy from the kernel sources
      tools headers uapi: Sync linux/kvm.h with the kernel sources
      tools headers uapi: Sync copy of asm-generic/unistd.h with the
kernel sources
      tools headers x86: Sync asm/cpufeatures.h copy with the kernel source=
s
      perf python: Make sure the python binding output directory is in plac=
e
      perf test shell: Use a fallback to get the pathname in vfs_getname
      perf trace: Fix ')' placement in "interrupted" syscall lines
      perf trace: Fix alignment for [continued] lines
      perf top: Lift restriction on using callchains without "sym" in --sor=
t
      tools include uapi: Grab a copy of linux/mount.h
      perf beauty: Switch from using uapi/linux/fs.h to uapi/linux/mount.h
      tools include uapi: Sync linux/fs.h copy with the kernel sources
      tools include uapi: Sync linux/vhost.h with the kernel sources
      tools include uapi: Sync linux/if_link.h copy with the kernel sources
      perf symbols: Add 'arch_cpu_idle' to the list of kernel idle symbols

Arnd Bergmann (1):
      ARM: shmobile: fix build regressions

Aurelien Aptel (1):
      cifs: move large array from stack to heap

Aurelien Jarno (1):
      tools uapi: fix RISC-V 64-bit support

Bartosz Golaszewski (5):
      ARM: davinci: da830-evm: fix label names in GPIO lookup entries
      ARM: davinci: da850-evm: fix label names in GPIO lookup entries
      ARM: davinci: dm355-evm: fix label names in GPIO lookup entries
      ARM: davinci: dm644x-evm: fix label names in GPIO lookup entries
      ARM: davinci: omapl138-hawk: fix label names in GPIO lookup entries

Baruch Siach (1):
      arm64: dts: marvell: mcbin: fix PCIe reset signal

Ben Skeggs (1):
      drm/nouveau: register backlight on pascal and newer

Biju Das (1):
      soc: renesas: r8a774c0-sysc: Fix initialization order of 3DG-{A,B}

Boris Brezillon (2):
      mtd: Fix the check on nvmem_register() ret code
      mtd: Check add_mtd_device() ret code

Borislav Petkov (1):
      x86/cache: Rename config option to CONFIG_X86_RESCTRL

Chao Fan (1):
      ACPI: NUMA: Use correct type for printing addresses on i386-PAE

Chris Wilson (2):
      drm/i915: Skip the ERR_PTR error state
      drm/i915: Unwind failure on pinning the gen7 ppgtt

Christian K=C3=B6nig (1):
      drm/amdgpu: disable system memory page tables for now

Christian Lamparter (1):
      mtd: rawnand: qcom: fix memory corruption that causes panic

Christoph Lameter (1):
      slab: alien caches must not be initialized if the allocation of
the alien cache failed

Christophe de Dinechin (1):
      Documentation/virtual/kvm: Update URL for AMD SEV API specification

Colin Ian King (1):
      reset: fix null pointer dereference on dev by dev_name

Corentin Labbe (1):
      PCI: amlogic: Fix build failure due to missing gpio header

Dan Carpenter (3):
      ALSA: cs46xx: Potential NULL dereference in probe
      cifs: Fix a debug message
      cifs: Fix a tiny potential memory leak

Daniele Ceraolo Spurio (1):
      drm/i915: init per-engine WAs for all engines

Daniele Palmas (1):
      usb: cdc-acm: send ZLP for Telit 3G Intel based modems

David Abdurachmanov (6):
      riscv: add audit support
      riscv: audit: add audit hook in do_syscall_trace_enter/exit()
      riscv: define NR_syscalls in unistd.h
      riscv: define CREATE_TRACE_POINTS in ptrace.c
      riscv: fix trace_sys_exit hook
      riscv: add HAVE_SYSCALL_TRACEPOINTS to Kconfig

David Brown (1):
      usb: storage: Remove outdated URL from MAINTAINERS

David Herrmann (1):
      fork: record start_time late

David Rientjes (1):
      kvm: sev: Fail KVM_SEV_INIT if already initialized

Dinh Nguyen (2):
      reset: socfpga: add an early reset driver for SoCFPGA
      ARM: socfpga: dts: document "altr,stratix10-rst-mgr" binding

Dmitry Safonov (1):
      tty: Don't hold ldisc lock in tty_reopen() if ldisc present

Dongsheng Yang (1):
      libceph: allow setting abort_on_full for rbd

Emily Deng (3):
      drm/amdgpu/virtual_dce: No need to pin the fb's bo
      drm/amdgpu/virtual_dce: No need to pin the cursor bo
      drm/amdgpu/sriov:Correct pfvf exchange logic

Eugeniy Paltsev (1):
      ARC: HSDK: improve reset driver

Evan Quan (5):
      drm/amd/powerplay: support BOOTUP_DEFAULT power profile mode
      drm/amd/powerplay: update OD support flag for SKU with no OD capabili=
ties
      drm/amd/powerplay: create pp_od_clk_voltage device file under OD supp=
ort
      drm/amd/powerplay: avoid possible buffer overflow
      drm/amd/powerplay: drop the unnecessary uclk hard min setting

Fabio Estevam (1):
      qcom-scm: Include <linux/err.h> header

Filipe Manana (3):
      Btrfs: fix race between cloning range ending at eof and writeback
      Btrfs: fix race between reflink/dedupe and relocation
      Btrfs: fix deadlock when using free space tree due to block group cre=
ation

Florian Fainelli (2):
      perf tools: Make find_vdso_map() more modular
      perf tests: Add a test for the ARM 32-bit [vectors] page

Geert Uytterhoeven (2):
      reset: Improve reset controller kernel docs
      reset: Add reset_control_get_count()

Greg Kroah-Hartman (3):
      sysfs: convert BUG_ON to WARN_ON
      Documentation: driver core: remove use of BUS_ATTR
      Revert "staging: rtl8723bs: Mark ACPI table declaration as used"

Guo Ren (6):
      Documentation/features: Add csky kernel features
      csky: fixup relocation error with 807 & 860
      csky: fixup CACHEV1 store instruction fast retire
      csky: fixup compile error with pte_alloc
      irqchip/csky: fixup handle_irq_perbit break irq
      csky: fixup compile error with CPU 810.

Gustavo A. R. Silva (2):
      ARM: integrator: impd1: use struct_size() in devm_kzalloc()
      KVM: x86: Fix bit shifting in update_intel_pt_cfg

Hannes Reinecke (1):
      nvme-multipath: zero out ANA log buffer

Hans de Goede (2):
      ACPI: power: Skip duplicate power resource references in _PRx
      ACPI / PMIC: xpower: Fix TS-pin current-source handling

Hauke Mehrtens (1):
      serial: lantiq: Do not swap register read/writes

Heinrich Schuchardt (1):
      arm64: dts: marvell: armada-ap806: reserve PSCI area

Hongbo Yao (1):
      nvme-pci: fix out of bounds access in nvme_cqe_pending

Hui Peng (1):
      ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks

Icenowy Zheng (2):
      USB: storage: don't insert sane sense for SPC3+ when bad sense specif=
ied
      USB: storage: add quirk for SMI SM3350

Ilia Mirkin (1):
      drm/nouveau/falcon: avoid touching registers if engine is off

Ilya Dryomov (1):
      rbd: don't return 0 on unmap if RBD_DEV_FLAG_REMOVING is set

Ivan Krylov (1):
      perf annotate: Pass filename to objdump via execl

Ivan Mironov (2):
      drm/fb-helper: Partially bring back workaround for bugs of SDL 1.2
      drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock

Jack Stocker (1):
      USB: Add USB_QUIRK_DELAY_CTRL_MSG quirk for Corsair K70 RGB

Jaegeuk Kim (1):
      loop: drop caches if offset or block_size are changed

James Dingwall (1):
      nvme: introduce NVME_QUIRK_IGNORE_DEV_SUBNQN

Jan Stancek (1):
      mm: page_mapped: don't assume compound page is huge or THP

Jean-Philippe Brucker (1):
      ACPI/IORT: Fix rc_dma_get_range()

Jeff Moyer (1):
      block: clarify documentation for blk_{start|finish}_plug

Jerome Brunet (1):
      arm64: defconfig: enable modules for amlogic s400 sound card

Jianchao Wang (1):
      nvme-pci: fix the wrong setting of nr_maps

Jim Qu (1):
      drm/amdgpu: set WRITE_BURST_LENGTH to 64B to workaround SDMA1 hang

Jin Yao (2):
      perf stat: Fix endless wait for child process
      perf report: Fix wrong iteration count in --branch-history

Jiri Olsa (2):
      tools thermal tmon: Use -O3 instead of -O1 if available
      tools iio: Override CFLAGS assignments

John Hubbard (1):
      phy: fix build breakage: add PHY_MODE_SATA

John Pittman (2):
      null_blk: add zoned config support information
      block: doc: add slice_idle_us to bfq documentation

Jonathan Corbet (1):
      block: fix kerneldoc comment for blk_attempt_plug_merge()

Jonathan Neusch=C3=A4fer (1):
      kernel/sys.c: Clarify that UNAME26 does not generate unique
versions anymore

Jos=C3=A9 Roberto de Souza (2):
      drm/i915: Disable PSR in Apple panels
      drm: Fix documentation generation for DP_DPCD_QUIRK_NO_PSR

Kailang Yang (3):
      ALSA: hda/realtek - Support Dell headset mode for New AIO platform
      ALSA: hda/realtek - Add unplug function into unplug state of
Headset Mode for ALC225
      ALSA: hda/realtek - Disable headset Mic VREF for headset mode of ALC2=
25

Keith Busch (2):
      nvme-pci: rerun irq setup on IO queue init errors
      nvme: pad fake subsys NQN vid and ssvid with zeros

Kent Russell (1):
      drm/amdgpu: Cleanup 2 compiler warnings

Kunihiko Hayashi (4):
      dt-bindings: reset: uniphier: Replace the expression of USB3
with generic peripherals
      reset: uniphier-usb3: Rename to reset-uniphier-glue
      dt-bindings: reset: uniphier: Add AHCI core reset description
      reset: uniphier-glue: Add AHCI reset control support in glue layer

Ladislav Michl (1):
      PM-runtime: Fix 'jiffies' in comments after switch to hrtimers

Lan Tianyu (1):
      KVM/VMX: Avoid return error when flush tlb successfully in the
hv_remote_flush_tlb_with_range()

Larry Finger (3):
      MAINTAINERS: Add entry for staging driver r8188eu
      staging: rtl8188eu: Fix module loading from tasklet for CCMP encrypti=
on
      staging: rtl8188eu: Fix module loading from tasklet for WEP encryptio=
n

Likun Gao (1):
      drm/amdgpu: make gfx9 enter into rlc safe mode when set MGCG

Linus Torvalds (1):
      Linux 5.0-rc2

Linus Walleij (1):
      ARM: dts: kirkwood: Fix polarity of GPIO fan lines

Liviu Dudau (1):
      nvme-pci: use the same attributes when freeing host_mem_desc_bufs.

Luis Chamberlain (3):
      cross-tree: phase out dma_zalloc_coherent()
      cross-tree: phase out dma_zalloc_coherent() on headers
      dma-mapping: remove dma_zalloc_coherent()

Lukasz Luba (1):
      PM: sleep: call devfreq suspend/resume

Lyude Paul (3):
      drm/amdgpu: Don't ignore rc from drm_dp_mst_topology_mgr_resume()
      drm/amdgpu: Don't fail resume process if resuming atomic state fails
      drm/dp_mst: Add __must_check to drm_dp_mst_topology_mgr_resume()

Masahiro Yamada (2):
      arch: restore generic-y +=3D shmparam.h for some architectures
      vfio/pci: set TRACE_INCLUDE_PATH to fix the build error

Matthew Wilcox (1):
      mm/memory.c: initialise mmu_notifier_range correctly

Mattias Jacobsson (1):
      perf strbuf: Remove redundant va_end() in strbuf_addv()

Mel Gorman (1):
      mm, page_alloc: do not wake kswapd with zone lock held

Michal Hocko (1):
      mm, memcg: fix reclaim deadlock with writeback

Mike Kravetz (2):
      hugetlbfs: revert "Use i_mmap_rwsem to fix page fault/truncate race"
      hugetlbfs: revert "use i_mmap_rwsem for more pmd sharing synchronizat=
ion"

Miles Chen (1):
      tools/vm/page_owner: use page_owner_sort in the use example

Minchan Kim (1):
      zram: idle writeback fixes and cleanup

Miquel Raynal (5):
      ata: libahci_platform: comply to PHY framework
      ata: ahci: mvebu: remove stale comment
      ata: ahci: mvebu: do Armada 38x configuration only on relevant SoCs
      ata: ahci: mvebu: add Armada 3700 initialization needed for S2RAM
      ata: ahci: mvebu: request PHY suspend/resume for Armada 3700

Nicholas Mc Guire (1):
      gpio: pl061: handle failed allocations

Otto Sabart (1):
      doc: trace: fix reference to cpuidle documentation file

Paul Walmsley (3):
      arch: riscv: support kernel command line forcing when no DTB passed
      MAINTAINERS: SiFive drivers: change the git tree to a SiFive git tree
      MAINTAINERS: SiFive drivers: add myself as a SiFive driver maintainer

Pavel Shilovsky (7):
      CIFS: Fix adjustment of credits for MTU requests
      CIFS: Do not set credits to 1 if the server didn't grant anything
      CIFS: Fix credit computation for compounded requests
      CIFS: Do not hide EINTR after sending network packets
      CIFS: Fix credits calculation for cancelled requests
      CIFS: Move credit processing to mid callbacks for SMB3
      CIFS: Fix error paths in writeback code

Peter Ujfalusi (4):
      ARM: dts: da850-evm: Correct the audio codec regulators
      ARM: dts: da850-evm: Correct the sound card name
      ARM: dts: da850-lcdk: Correct the audio codec regulators
      ARM: dts: da850-lcdk: Correct the sound card name

Qian Cai (2):
      ACPI/IORT: Fix build when CONFIG_IOMMU_API=3Dn
      mm/usercopy.c: no check page span for stack objects

Qu Wenruo (1):
      btrfs: Use real device structure to verify dev extent

Quentin Perret (1):
      cpufreq: scmi: Fix frequency invariance in slow path

Rafael J. Wysocki (2):
      cpufreq / Documentation: Update cpufreq MAINTAINERS entry
      cpuidle / Documentation: Update cpuidle MAINTAINERS entry

Ravi Bangoria (2):
      perf powerpc: Rework syscall table generation
      tools headers powerpc: Remove unistd.h

Ross Lagerwall (2):
      cifs: Limit memory used by lock request calls to a page
      cifs: Fix potential OOB access of lock element array

Sagi Grimberg (3):
      nvme-tcp: remove dead code
      nvme-tcp: don't ask if controller is fabrics
      nvme-fabrics: unset write/poll queues for discovery controllers

Saranya Gopal (1):
      usbcore: Select only first configuration for non-UAC3 compliant devic=
es

Sean Christopherson (1):
      mm/mmu_notifier: mm/rmap.c: Fix a mmu_notifier range bug in
try_to_unmap_one

Shakeel Butt (1):
      fork, memcg: fix cached_stacks case

Sinan Kaya (1):
      ACPI: Fix build failure when CONFIG_NLS is set to 'n'

Souptick Joarder (1):
      ceph: use vmf_error() in ceph_filemap_fault()

Sowjanya Komatineni (1):
      i2c: tegra: Fix Maximum transfer size

Stafford Horne (1):
      arch/openrisc: Fix issues with access_ok()

Steve French (1):
      cifs: update internal module version number

Sudeep Holla (1):
      cpufreq: check if policy is inactive early in __cpufreq_get()

Takashi Iwai (4):
      ALSA: usb-audio: Avoid access before bLength check in
build_audio_procunit()
      ALSA: usb-audio: Check mixer unit descriptors more strictly
      ALSA: usb-audio: Always check descriptor sizes in parser code
      drm/nouveau: Don't disable polling in fallback mode

Tao Zhou (1):
      drm/amdgpu: fix CPDMA hang in PRT mode for VEGA20

Tetsuo Handa (1):
      gpu/drm: Fix lock held when returning to user space.

Tiecheng Zhou (1):
      drm/amdgpu/gfx_v8_0: Reorder the gfx, kiq and kcq rings test sequence

Tomas Bortoli (1):
      KVM: validate userspace input in kvm_clear_dirty_log_protect()

Tomi Valkeinen (7):
      drm/bridge: tc358767: add bus flags
      drm/bridge: tc358767: add defines for DP1_SRCCTRL & PHY_2LANE
      drm/bridge: tc358767: fix single lane configuration
      drm/bridge: tc358767: fix initial DP0/1_SRCCTRL value
      drm/bridge: tc358767: reject modes which require too much BW
      drm/bridge: tc358767: fix output H/V syncs
      drm/bridge: tc358767: use DP connector if no panel set

Tycho Andersen (1):
      samples/seccomp: Fix 32-bit build

Tzvetomir Stoyanov (7):
      tools lib traceevent: Introduce new libtracevent API: tep_override_co=
mm()
      tools lib traceevent: Initialize host_bigendian at tep_handle allocat=
ion
      tools lib traceevent: Rename struct cmdline to struct tep_cmdline
      tools lib traceevent: Changed return logic of trace_seq_printf()
and trace_seq_vprintf() APIs
      tools lib traceevent: Changed return logic of
tep_register_event_handler() API
      tools lib traceevent: Rename tep_is_file_bigendian() to
tep_file_bigendian()
      tools lib traceevent: Remove tep_data_event_from_type() API

Vincent Guittot (1):
      PM-runtime: Fix autosuspend_delay on 32bits arch

Viresh Kumar (1):
      cpufreq: scpi/scmi: Fix freeing of dynamic OPPs

Vitaly Kuznetsov (1):
      x86/kvm/nVMX: don't skip emulated instruction twice when vmptr
address is not backed

WANG Chao (1):
      x86, modpost: Replace last remnants of RETPOLINE with CONFIG_RETPOLIN=
E

Weiping Zhang (1):
      block: add documentation for io_timeout

Will Deacon (2):
      arm64: asm-prototypes: Fix fat-fingered typo in comment
      arm64: kpti: Avoid rewriting early page tables when KASLR is enabled

Yi Zeng (1):
      i2c: dev: prevent adapter retries and timeout being set as minus valu=
e

Yu Zhao (2):
      drm/amdgpu: validate user pitch alignment
      drm/amdgpu: validate user GEM object size

Zhenyu Wang (1):
      drm/i915/gvt: Fix workload request allocation before request add

Zong Li (1):
      RISC-V: Support MODULE_SECTIONS mechanism on RV32
