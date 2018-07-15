Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06238ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD6220882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Nw3mrChM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD6220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeGOUxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:53:07 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:37739 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeGOUxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:53:07 -0400
Received: by mail-io0-f178.google.com with SMTP id z19-v6so35861540ioh.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=j+nTDDTxGO3PZIw+4GEdUIsWweLOzH5Nq7LsWJS5bsA=;
        b=Nw3mrChMTZo+MB1bDBsoRyvBp9TUaRVl4C02F+GMMvdTdPUXiJZ1iDhdvtLUgWzatr
         6aYN1M3AKwVZyGO6qt7WjyP7fXX/b2Vr603z0xU8kdViDwRRrX6Q8aG0kHj9fS3Iv3F2
         Uzen93hIm7BfMlyyd6NnlumHJ7waq0NGV4OOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j+nTDDTxGO3PZIw+4GEdUIsWweLOzH5Nq7LsWJS5bsA=;
        b=fe+aP3SPjJ3ZcD0pnbh/pOaST0UhwHzgt219WT8jJWxo6WsSp9KjtryYGCG+ibVB4t
         YctssQlK0/gpl6bCfk+QvyrQX0FR87FuobT0//riUpnmRM0j2nLdiy/HAdWa0/kkjbhW
         5sJN2vq6YpEoQ1QA6mI9DQxY9Ddh10J2/w7pI8Kz5bq9mfTOBWYy45xn6JO+5HX815gF
         f9E8vohG2xIEnSnJdRSQFsiQBocjMwvxILX36NpKyD89NkCWPn1zbX3b6c4++oBCkmiL
         37ySUt2NgeLHxRQoLD2xLT27ud6qO3YVp5bk7P5F3NtcG0mEF2Q3ba0D1km/Tb1ZFkOs
         nztg==
X-Gm-Message-State: APt69E2p/Ye0TM0HuxmwaBs/z+hWx9X40Ikuypi5nabnuZwhxI06R8RC
        NKJo0PLYEqWxI8y3m1Xpg+Qerq2IcSwG/WX/Q2l3jzfG
X-Google-Smtp-Source: AAOMgpdhZBW9S4qUnTK92fISsjuqPd9hTSBsAYqByaF5/if5KDA3HMV8Y0I92xjpCeWUKTF6N/aQucA8Yp7NjGLNqfI=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr39771256iov.203.1531686539937;
 Sun, 15 Jul 2018 13:28:59 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Jul 2018 13:28:48 -0700
Message-ID: <CA+55aFwfMr2D2A_yesUyt_Lo3XMRk9epzgeBMt2HxMHiXMDYcg@mail.gmail.com>
Subject: Linux 4.18-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason this week actually felt very busy, but the rc5 numbers
show otherwise. It's all small and calm, and things are progressing
nicely.

I think the "it felt busy" was partly due to me stressing out over a
nasty VM bug that turned out to have a trivial two-liner fix. But
there were also a fair amount of email threads for future stuff, so
that probably also made me feel last week was busier than the actual
rc5 tree shows.

Anyway, of what little happened in rc5 (see appended shortlog for
details), it's just a fairly random collection of smallish fixes all
over. About a third drivers (nothing in particular stands out - rdma,
usb, ata, mmc, sound) with the rest being some tooling (mostly perf),
some arch updates, some filesystem stuff (mostly reiserfs), some arch
fixlets (mips, arm[64], x86) and some misc core kernel (tracing, VM
fixes, timers, yadda yadda).

And we had a few more interface cleanups for rseq.

Go out and test. The VM thing that annoyed me so much this week isn't
actually triggerable for most people (and only happened in rc3 and
rc4), but if you hit a "kernel BUG in mm/page_alloc.c" during earlier
rc testing, it's fixed (although for most people, if it hit you, it
probably just showed as unexplained hung machine under moderate memory
pressure).

            Linus

---

Adam Borowski (1):
      scripts: teach extract-vmlinux about LZ4 and ZSTD

Adam Ford (1):
      ARM: dts: am3517.dtsi:  Disable reference to OMAP3 OTG controller

Alastair Bridgewater (2):
      ALSA: hda/ca0132: Add Recon3Di quirk for Gigabyte G1.Sniper Z97
      ALSA: hda/ca0132: Update a pci quirk device name

Alexander Usyskin (1):
      mei: discard messages from not connected client during power down.

Alexandre Belloni (1):
      rtc: fix alarm read and set offset

Alexey Khoroshilov (1):
      sample: vfio-mdev: avoid deadlock in mdev_access()

Anson Huang (1):
      mmc: core: cd_label must be last entry of mmc_gpio struct

Ard Biesheuvel (1):
      efi/x86: Fix mixed mode reboot loop by removing pointless call
to PciIo->Attributes()

Arnd Bergmann (1):
      usb/gadget: aspeed-vhub: add USB_LIBCOMPOSITE dependency

Baruch Siach (1):
      ARM: dts: armada-38x: use the new thermal binding

Benjamin Tissoires (1):
      HID: core: allow concurrent registration of drivers

Chris Wilson (1):
      ALSA: hda - Handle pm failure during hotplug

Christian Borntraeger (1):
      mm: do not drop unused pages when userfaultd is running

Christophe Jaillet (1):
      fpga: altera-cvp: Fix an error handling path in 'altera_cvp_probe()'

Colin Ian King (1):
      sata_nv: remove redundant pointers sdev0 and sdev1

Constantine Shulyupin (1):
      scripts/tags.sh: add __ro_after_init

Damien Le Moal (2):
      ata: Fix ZBC_OUT command block check
      ata: Fix ZBC_OUT all bit handling

Dan Carpenter (3):
      rtc: mrst: fix error code in probe()
      USB: serial: ch341: fix type promotion bug in ch341_control_in()
      xhci: xhci-mem: off by one in xhci_stream_id_to_ring()

Dan Williams (2):
      libnvdimm, pmem: Fix memcpy_mcsafe() return code handling in
nsio_rw_bytes()
      acpi, nfit: Fix scrub idle detection

Daniel Mack (1):
      ARM: pxa: irq: fix handling of ICMR registers in suspend/resume

Daniel Rosenberg (1):
      HID: debug: check length before copy_to_user()

Daniel Vetter (1):
      MAINTAINERS: update drm tree

Dave Jiang (2):
      acpi/nfit: fix cmd_rc for acpi_nfit_ctl to always return a value
      nfit: fix unchecked dereference in acpi_nfit_ctl

Douglas Anderson (1):
      nvmem: Don't let a NULL cell_id for nvmem_cell_get() crash us

Eric Biggers (1):
      reiserfs: fix buffer overflow with long warning messages

Fabio Estevam (2):
      drm/etnaviv: Check for platform_device_register_simple() failure
      drm/etnaviv: Fix driver unregistering

Geert Uytterhoeven (1):
      ata: Remove depends on HAS_DMA in case of platform dependency

Gustavo A. R. Silva (1):
      HID: hiddev: fix potential Spectre v1

Hans de Goede (3):
      ahci: Disable LPM on Lenovo 50 series laptops with a too old BIOS
      typec: tcpm: Correctly report power_supply current and voltage
for non pd supply
      i2c-cht-wc: Fix bq24190 supplier

Hui Wang (1):
      ALSA: hda/realtek - two more lenovo models need fixup of MIC_LOCATION

Jann Horn (2):
      USB: yurex: fix out-of-bounds uaccess in read handler
      ibmasm: don't write out of bounds in read handler

Janne Huttunen (1):
      perf script python: Fix dict reference counting

Jason Andryuk (1):
      HID: i2c-hid: Fix "incomplete report" noise

Jason Gerecke (1):
      HID: wacom: Correct touch maximum XY of 2nd-gen Intuos

Jeff Moyer (1):
      dev-dax: check_vma: ratelimit dev_info-s

Jens Axboe (4):
      libata: add command iterator helpers
      libata: convert eh to command iterators
      sata_fsl: convert to command iterator
      sata_fsl: remove dead code in tag retrieval

Jeremy Cline (7):
      perf tools: Generate a Python script compatible with Python 2 and 3
      perf scripts python: Add Python 3 support to Core.py
      perf scripts python: Add Python 3 support to SchedGui.py
      perf scripts python: Add Python 3 support to Util.py
      perf scripts python: Add Python 3 support to sched-migration.py
      perf scripts python: Add Python 3 support to EventClass.py
      perf tools: Use python-config --includes rather than --cflags

Jiri Olsa (3):
      perf tools: Fix compilation errors on gcc8
      perf stat: Fix --interval_clear option
      tracing/kprobe: Release kprobe print_fmt properly

Joe Perches (1):
      checkpatch: fix duplicate invalid vsprintf pointer extension
'%p<foo>' messages

Joel Fernandes (Google) (1):
      tracing: Reorder display of TGID to be after PID

Johan Hovold (2):
      USB: serial: keyspan_pda: fix modem-status error handling
      USB: serial: mos7840: fix status-register error handling

John Garry (1):
      libahci: Fix possible Spectre-v1 pmp indexing in ahci_led_store()

Jon Hunter (1):
      i2c: tegra: Fix NACK error handling

Juergen Gross (2):
      xen: remove global bit from __default_kernel_pte_mask for pv guests
      xen: setup pv irq ops vector earlier

Kai-Heng Feng (1):
      usb: xhci: dbc: Don't decrement runtime PM counter if DBC is not started

Kamal Heib (1):
      RDMA/mlx5: Fix memory leak in mlx5_ib_create_srq() error path

Kim Phillips (4):
      perf test shell: Replace '|&' with '2>&1 |' to work with more shells
      perf test shell: Make perf's inet_pton test more portable
      perf llvm-utils: Remove bashism from kernel include fetch script
      perf test shell: Prevent temporary editor files from being
considered test scripts

Laura Abbott (3):
      Revert "arm64: Use aarch64elf and aarch64elfb emulation mode variants"
      tools: build: Fixup host c flags
      tools: build: Use HOSTLDFLAGS with fixdep

Laurentiu Tudor (1):
      docs: kernel-parameters.txt: document xhci-hcd.quirks parameter

Leon Romanovsky (3):
      RDMA/uverbs: Protect from attempts to create flows on unsupported QP
      RDMA/uverbs: Fix slab-out-of-bounds in ib_uverbs_ex_create_flow
      RDMA/uverbs: Don't fail in creation of multiple flows

Linus Torvalds (1):
      Linux 4.18-rc5

Lucas Stach (1):
      drm/etnaviv: bring back progress check in job timeout handler

Masahiro Yamada (3):
      kbuild: do not drop -I without parameter
      kbuild: remove duplicated comments about PHONY
      kbuild: suppress warnings from 'getconf LFS_*'

Mathieu Desnoyers (6):
      rseq: Use __u64 for rseq_cs fields, validate user inputs
      rseq: Use get_user/put_user rather than __get_user/__put_user
      rseq: uapi: Update uapi comments
      rseq: uapi: Declare rseq_cs field as union, update includes
      rseq: Remove unused types_32_64.h uapi header
      rseq/selftests: cleanup: Update comment above rseq_prepare_unload

Michael J. Ruhl (1):
      IB/hfi1: Fix incorrect mixing of ERR_PTR and NULL return values

Michal Hocko (2):
      mm/memblock.c: do not complain about top-down allocations for
!MEMORY_HOTREMOVE
      mm: do not bug_on on incorrect length in __mm_populate()

Mika Westerberg (2):
      ahci: Add Intel Ice Lake LP PCI ID
      thunderbolt: Notify userspace when boot_acl is changed

Murray McAllister (1):
      staging: rtl8723bs: Prevent an underflow in rtw_check_beacon_data().

Nadav Amit (1):
      vmw_balloon: fix inflation with batching

Nicholas Piggin (1):
      mm: allow arch to supply p??_free_tlb functions

Nico Sneck (1):
      usb: quirks: add delay quirks for Corsair Strafe

Nishanth Menon (1):
      ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of BTB) for
secondary cores

Olli Salonen (1):
      USB: serial: cp210x: add another USB ID for Qivicon ZigBee stick

Oscar Salvador (1):
      fs, elf: make sure to page align bss in load_elf_library

Paul Burton (3):
      MIPS: Call dump_stack() from show_regs()
      MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()
      MIPS: Fix ioremap() RAM check

Paul Menzel (1):
      tools build: fix # escaping in .cmd files for future Make

Pavel Tatashin (1):
      mm: zero unavailable pages before memmap init

Philipp Rudo (1):
      x86/purgatory: add missing FORCE to Makefile target

Ping-Ke Shih (1):
      staging: r8822be: Fix RTL8822be can't find any wireless AP

Qing Xia (1):
      mmc: dw_mmc: fix card threshold control configuration

Rafael J. Wysocki (2):
      MAINTAINERS: Add myself as driver core changes reviewer
      ACPICA: Clear status of all events when entering S5

Randy Dunlap (5):
      kbuild: update ARCH alias info for sh
      kbuild: update ARCH alias info for sparc
      kbuild: delete INSTALL_FW_PATH from kbuild documentation
      kconfig: update user kconfig tools doc.
      kbuild: document the KBUILD_KCONFIG env. variable

Russell King - ARM Linux (1):
      Update TDA998x maintainer entry

Stefan Agner (1):
      mmc: sdhci-esdhc-imx: allow 1.8V modes without 100/200MHz pinctrl states

Stefan Mavrodiev (1):
      mmc: sunxi: Disable irq during pm_suspend

Steve Wise (1):
      iw_cxgb4: correctly enforce the max reg_mr depth

Steven Rostedt (VMware) (1):
      ARM: 8780/1: ftrace: Only set kernel memory back to read-only after boot

Sudeep Holla (2):
      Revert "tick: Prefer a lower rating device only if it's CPU local device"
      clocksource: arm_arch_timer: Set arch_mem_timer cpumask to
cpu_possible_mask

Thadeu Lima de Souza Cascardo (1):
      i2c: stu300: use non-archaic spelling of failes

Tomas Bortoli (1):
      autofs: fix slab out of bounds read in getname_kernel()

Tony Battersby (1):
      bsg: fix bogus EINVAL on non-data commands

Ulf Magnusson (1):
      kbuild: .PHONY is not a variable, but PHONY is

Vignesh R (1):
      mtd: spi-nor: cadence-quadspi: Fix direct mode write timeouts

Vishal Verma (1):
      tools/testing/nvdimm: advertise a write cache for nfit_test

Vladimir Murzin (1):
      ARM: 8775/1: NOMMU: Use instr_sync instead of plain isb in common code

Vlastimil Babka (1):
      fs/proc/task_mmu.c: fix Locked field in /proc/pid/smaps*

Wei Yongjun (1):
      ata: ahci_mvebu: ahci_mvebu_stop_engine() can be static

Wolfram Sang (1):
      i2c: recovery: if possible send STOP with recovery pulses

Xiubo Li (3):
      uio: use request_threaded_irq instead
      uio: change to use the mutex lock instead of the spin lock
      uio: fix crash after the device is unregistered

Yandong Zhao (1):
      arm64: neon: Fix function may_use_simd() return error status

Yoshihiro Shimoda (2):
      mmc: renesas_sdhi_internal_dmac: Fix missing unmap in error patch
      mmc: renesas_sdhi_internal_dmac: Cannot clear the RX_IN_USE in abort

piaojun (1):
      net/9p/client.c: put refcount of trans_mod in error case in parse_opts()
