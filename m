Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754959AbeCSBOz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:14:55 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:37976 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754258AbeCSBOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:14:51 -0400
X-Google-Smtp-Source: AG47ELuPAYhoyM6RxMKEa72a4S7y8/xVbAQrYIdsjqOqHDYzsdgm+bY/SdhcIDO/wKQFRrMidbBKe3oxaSdHklreIhk=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 18 Mar 2018 18:14:50 -0700
X-Google-Sender-Auth: 3RmNzPVjhuhzbuyYWu5mJed8bJo
Message-ID: <CA+55aFzV1nffUeriZLksK90noD49T+w+WmgBsYMAO13rTbn3Pg@mail.gmail.com>
Subject: Linux 4.16-rc6
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2J1F3KS021530

This has been a nice quiet week, so rc6 is pretty tiny. Everything
looks like we're on a usual schedule - I'll make an rc7, but hopefully
that will be it.

Mostly driver changes (usb, gpu, sound, scsi, md), but it's all tiny.
Some arch fixes (x86 and microblaze, tiny changes to others), and some
filesystem fixes (a couple of small core vfs fixlets, and some btrfs
and nfs fixes).

Go test, things are stable and there's no reason to worry, but all the
usual reasons to just do a quick build and verification that
everything works for everybody. Ok?

                  Linus

---

Al Viro (1):
      lock_parent() needs to recheck if dentry got __dentry_kill'ed under it

Alex Deucher (1):
      drm/amdgpu: save/restore backlight level in legacy dce code

Alexander Sergeyev (1):
      x86/speculation: Remove Skylake C2 from Speculation Control
microcode blacklist

Amelie Delaunay (2):
      dt-bindings: usb: fix the STM32F7 DWC2 OTG HS core binding
      usb: dwc2: fix STM32F7 USB OTG HS compatible

Andre Przywara (1):
      KVM: arm/arm64: vgic: Add missing irq_lock to vgic_mmio_read_pending

Andy Lutomirski (3):
      selftests/x86/entry_from_vm86: Exit with 1 if we fail
      selftests/x86/entry_from_vm86: Add test cases for POPF
      x86/vm86/32: Fix POPF emulation

Andy Shevchenko (1):
      serial: 8250_pci: Don't fail on multiport card class

Andy Whitcroft (1):
      x86/speculation, objtool: Annotate indirect calls/jumps for
objtool on 32-bit kernels

Ard Biesheuvel (4):
      irqchip/gic-v3-its: Ensure nr_ites >= nr_lpis
      efi/libstub/tpm: Initialize pointer variables to zero for mixed mode
      KVM: arm/arm64: Reduce verbosity of KVM init log
      Revert "mm/page_alloc: fix memmap_init_zone pageblock alignment"

Arnd Bergmann (1):
      phy: qcom-ufs: add MODULE_LICENSE tag

Bill Kuzeja (1):
      scsi: qla2xxx: Fix crashes in qla2x00_probe_one on probe failure

Borislav Petkov (2):
      x86/microcode: Attempt late loading only when new microcode is present
      x86/microcode: Fix CPU synchronization routine

Chris Wilson (2):
      drm/i915: Only prune fences after wait-for-all
      drm/i915: Kick the rps worker when changing the boost frequency

Christian König (2):
      drm/amdgpu: fix prime teardown order
      drm/radeon: fix prime teardown order

Christoffer Dall (2):
      KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls than KVM_RUN
      KVM: arm/arm64: Reset mapped IRQs on VM reset

Colin Ian King (1):
      usbip: vudc: fix null pointer dereference on udc->lock

Damien Le Moal (1):
      scsi: sd_zbc: Fix potential memory leak

Danilo Krummrich (1):
      usb: quirks: add control message delay for 1b1c:1b20

Darren Hart (1):
      platform/x86: dell-smbios: Resolve dependency error on ACPI_WMI

Darren Hart (VMware) (1):
      platform/x86: Fix dell driver init order

David S. Miller (1):
      sparc64: Fix regression in pmdp_invalidate().

David Sterba (1):
      Revert "btrfs: use proper endianness accessors for super_copy"

Dmitriy Gorokh (1):
      btrfs: Fix NULL pointer exception in find_bio_stripe

Edmund Nadolski (1):
      btrfs: add missing initialization in btrfs_check_shared

Eric W. Biederman (1):
      fs: Teach path_connected to handle nfs filesystems with multiple roots.

Fabio Estevam (3):
      MAINTAINERS: Add myself as sgtl5000 maintainer
      ASoC: sgtl5000: Fix suspend/resume
      irqchip/irq-imx-gpcv2: Remove unused function

Frank Mori Hess (1):
      staging: comedi: fix comedi_nsamples_left.

Fredrik Noring (1):
      USB: OHCI: Fix NULL dereference in HCDs using HCD_LOCAL_MEM

Greentime Hu (1):
      earlycon: add reg-offset to physical address before mapping

Hannes Reinecke (1):
      scsi: mpt3sas: Do not mark fw_event workqueue as WQ_MEM_RECLAIM

Hans de Goede (3):
      ASoC: rt5651: Fix regcache sync errors on resume
      Revert "typec: tcpm: Only request matching pdos"
      usb: typec: tcpm: fusb302: Do not log an error on -EPROBE_DEFER

Jeremy Cline (1):
      scsi: sd: Keep disk read-only when re-reading partition

Joel Fernandes (1):
      staging: android: ashmem: Fix lockdep issue during llseek

Joern Engel (1):
      btree: avoid variable-length allocations

John David Anglin (1):
      parisc: Handle case where flush_cache_range is called with no context

Jonas Danielsson (1):
      tty/serial: atmel: add new version check for usart

Josh Poimboeuf (1):
      jump_label: Fix sparc64 warning

Kai-Heng Feng (1):
      xhci: Fix front USB ports on ASUS PRIME B350M-A

Karol Herbst (1):
      drm/nouveau/bl: fix backlight regression

Kirill A. Shutemov (2):
      x86/cpufeatures: Add Intel Total Memory Encryption cpufeature
      x86/cpufeatures: Add Intel PCONFIG cpufeature

Linus Torvalds (1):
      Linux 4.16-rc6

Lu Baolu (1):
      usb: xhci: dbc: Fix lockdep warning

Lukas Wunner (1):
      drm/nouveau/bl: Fix oops on driver unbind

Marc Zyngier (2):
      KVM: arm/arm64: vgic: Don't populate multiple LRs with the same vintid
      kvm: arm/arm64: vgic-v3: Tighten synchronization for guests using v2 on v3

Mathias Nyman (1):
      xhci: fix endpoint context tracer output

Merlijn Wajer (2):
      usb: musb: call pm_runtime_{get,put}_sync before reading vbus registers
      usb: musb: Fix external abort in musb_remove on omap2430

Michal Oleszczyk (1):
      sgtl5000: change digital_mute policy

Michal Simek (1):
      microblaze: Setup dependencies for ASM optimized lib functions

Michel Dänzer (1):
      drm/amdgpu/dce: Don't turn off DP sink when disconnected

Miguel Ojeda (3):
      auxdisplay: panel: Change comments to silence fallthrough warnings
      auxdisplay: img-ascii-lcd: Fix doc comment to silence warnings
      auxdisplay: img-ascii-lcd: Silence 2 uninitialized warnings

Mike Snitzer (2):
      dm mpath: fix uninitialized 'pg_init_wait' waitqueue_head NULL pointer
      dm mpath: eliminate need to use scsi_device_from_queue

Min He (1):
      drm/i915/gvt: keep oa config in shadow ctx

Mustamin B Mustaffa (1):
      drm/i915: Enable VBT based BL control for DP

Māris Nartišs (1):
      drm/nouveau/mmu: ALIGN_DOWN correct variable

Nikola Ciprich (1):
      serial: 8250_pci: Add Brainboxes UC-260 4 port serial device

Oliver Neukum (1):
      uas: fix comparison for error code

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Fix trap number return from __kvmppc_vcore_entry

Pete Zaitcev (1):
      usb: usbmon: Read text within supplied buffer size

Peter Ujfalusi (1):
      ASoC: hdmi-codec: Fix module unloading caused kernel crash

Richard Fitzgerald (1):
      ASoC: wm_adsp: For TLV controls only register TLV get/set

Rob Herring (2):
      microblaze: remove unused alloc_maybe_bootmem
      microblaze: switch to NO_BOOTMEM

Robin Murphy (1):
      irqchip/gic-v3-its: Fix misplaced __iomem annotations

Roger Quadros (1):
      usb: dwc3: Fix lock-up on ID change during system suspend/resume

Sebastian Andrzej Siewior (1):
      serial: core: mark port as initialized in autoconfig

Steffen Maier (1):
      dm mpath: fix passing integrity data

Sylwester Nawrocki (1):
      ASoC: samsung: Add the DT binding files entry to MAINTAINERS

Takashi Iwai (4):
      ALSA: seq: Fix possible UAF in snd_seq_check_queue()
      ALSA: seq: Clear client entry before deleting else at closing
      ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()
      ALSA: hda - Revert power_save option default value

Teijo Kinnunen (1):
      USB: storage: Add JMicron bridge 152d:2567 to unusual_devs.h

Tejun Heo (4):
      tty: make n_tty_read() always abort if hangup is in progress
      fs/aio: Add explicit RCU grace period when freeing kioctx
      fs/aio: Use RCU accessors for kioctx_table->table[]
      RDMAVT: Fix synchronization around percpu_ref

Tom Lendacky (1):
      KVM: x86: Fix device passthrough when SME is active

Toshi Kani (1):
      x86/mm: Fix vmalloc_fault to use pXd_large

Trond Myklebust (3):
      NFS: Fix an incorrect type in struct nfs_direct_req
      pNFS: Prevent the layout header refcount going to zero in pnfs_roc()
      NFS: Fix unstable write completion

Ulrich Hecht (1):
      serial: sh-sci: prevent lockup on full TTY buffers

Vijendar Mukunda (1):
      ASoC: amd: 16bit resolution support for i2s sp instance

Will Deacon (2):
      fs: dcache: Avoid livelock between d_alloc_parallel and __d_add
      fs: dcache: Use READ_ONCE when accessing i_dir_seq

Xinyong (1):
      usb: gadget: f_fs: Fix use-after-free in ffs_fs_kill_sb()

Xiong Zhang (1):
      drm/i915/gvt: Add runtime_pm_get/put into gvt_switch_mmio

Yisheng Xie (1):
      staging: android: ashmem: Fix possible deadlock in ashmem_ioctl

Yong Deng (1):
      ASoC: sun4i-i2s: Fix RX slot number of SUN8I

Yoshihiro Shimoda (4):
      usb: renesas_usbhs: add binding for r8a77965
      usb: gadget: udc: renesas_usb3: add binging for r8a77965
      usb: host: xhci-rcar: add support for r8a77965
      usb: host: xhci-plat: revert "usb: host: xhci-plat: enable clk
in resume timing"

Zhenyu Wang (1):
      drm/i915/gvt: fix user copy warning by whitelist workload rb_tail field

fred gao (1):
      drm/i915/gvt: Correct the privilege shadow batch buffer address

phil eichinger (1):
      serial: imx: fix bogus dev_err
