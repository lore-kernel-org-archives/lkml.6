Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7138AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABB2206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KkS77HDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeLPX7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:59:07 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:39680 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbeLPX7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 18:59:07 -0500
Received: by mail-lf1-f51.google.com with SMTP id n18so8125164lfh.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 15:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4EWYb1eIZ8gioFR0uy12SmAQahvLAS9UUk/qyLJEMCM=;
        b=KkS77HDBWi760/6n2XxrJ19cY705PYKGVjMS8wlDhXH4dWwEVgIqlD8t5hHs0nMInv
         LAn4/BYbVS3a+xoB3a20VL06hocdOnDs8wZ5CHYLEkPa+mEqrKjBVapOHzi1FW/bw6PQ
         NOPA3XLsv+08KndqbbCGQTCgTTV2dz5rd2rG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4EWYb1eIZ8gioFR0uy12SmAQahvLAS9UUk/qyLJEMCM=;
        b=iS8f1ExgexNF/wbgYqA2fsEFLbZE/ldefCzcOMxSrAIeUwgMlhOKr1E5zn97UeDMjC
         UQYiLxzNdMpEPrgsmutzHstJieCcHZ8Zuc62OtiRYpAO6y/DA+NJ+9wHgBSCsIR5P6Jd
         j0xP3BvJYB12vT762RLb/xHqNdTeb7+FEwf/gyNI+Vr8WxulCoFrRuxkp6OKSAj3gpQL
         eHV3runTnlM6HhEYOOPOS1TOwjIZW0TUnHmwFpjnwxoZx6Ao6fSyXGsuTCHqW+PIA6Nb
         AXyFraG8iHO+px3LKZmv5gxVPtFf5RpXIyGlK89hZJLen0Y3M8Ck0c7d6hCcZFk45JY6
         uUxg==
X-Gm-Message-State: AA+aEWaZTkGy/SKkoK8f4kx/kibbI+n7F6+bww2Jz3a1RYPa+55olt2z
        MjUOzMzjeJS0mS+PcYHCBpWTomTSaq0=
X-Google-Smtp-Source: AFSGD/WfKVaUG9HHvfkP8yTsxXtGJWCtyZppbrNVjhrqol4tUb6mt6u/UCH3TXVjCKTgkoAzcYtsGg==
X-Received: by 2002:a19:9781:: with SMTP id z123mr6526093lfd.80.1545004743428;
        Sun, 16 Dec 2018 15:59:03 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id r76-v6sm2228111ljr.83.2018.12.16.15.59.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 15:59:02 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id v5so8128753lfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 15:59:02 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr5761283lfa.106.1545004742085;
 Sun, 16 Dec 2018 15:59:02 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Dec 2018 15:58:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whv9u9aTEPoCz8h83JJbVK4fmHELJF=GG01ht9=1_MaCQ@mail.gmail.com>
Message-ID: <CAHk-=whv9u9aTEPoCz8h83JJbVK4fmHELJF=GG01ht9=1_MaCQ@mail.gmail.com>
Subject: Linux 4.20--rc76
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, that's more like it.

This is a *tiny* rc7, just how I like it. Maybe it's because everybody
is too busy prepping for the holidays, and maybe it's because we
simply are doing well. Regardless, it's been a quiet week, and I hope
the trend continues.

The patch looks pretty small too, although it's skewed by a couple of
bigger fixes (re-apply i915 workarounds after reset, and dm zoned bio
completion fix). Other than that it's mainly all pretty small, and
spread out (usual bulk of drivers, but some arch updates, filesystem
fixes, core fixes, test updates..)

The plan remains the same: if everything continues normally, I'll
release 4.20 just before christmas, and then just have a more
leisurely merge window than normal. I already have a few early pull
requests, and I continue to encourage people to take that approach,
instead of sending things in during the holiday season.

                Linus


---

Aaro Koskinen (1):
      MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310

Alek Du (1):
      mmc: sdhci: fix the timeout check window for clock and reset

Alex Deucher (5):
      drm/amdgpu: update smu firmware images for VI variants (v2)
      drm/amdgpu: add some additional vega10 pci ids
      drm/amdgpu: add some additional vega20 pci ids
      drm/amdkfd: add new vega10 pci ids
      drm/amdkfd: add new vega20 pci id

Amir Goldstein (2):
      ovl: fix missing override creds in link of a metacopy upper
      ovl: fix decode of dir file handle with multi lower layers

Andrea Arcangeli (1):
      userfaultfd: check VM_MAYWRITE was set after verifying the uffd
is registered

Andrey Grodzovsky (1):
      drm/amdgpu: Fix DEBUG_LOCKS_WARN_ON(depth <=3D 0) in amdgpu_ctx.lock

Anson Huang (1):
      ARM: imx: update the cpu power up timing setting on i.mx6sx

Artemy Kovalyov (1):
      IB/mlx5: Fix implicit ODP interrupted page fault

Baruch Siach (2):
      Revert "arm64: dts: marvell: add CPU Idle power state support on
Armada 7K/8K"
      psi: fix reference to kernel commandline enable

Ben Skeggs (1):
      drm/nouveau/kms/nv50-: also flush fb writes when rewinding push buffe=
r

Benjamin Herrenschmidt (1):
      powerpc: Look for "stdout-path" when setting up legacy consoles

Brian Norris (1):
      Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"

Chad Austin (1):
      fuse: continue to send FUSE_RELEASEDIR when FUSE_OPEN returns ENOSYS

Chen-Yu Tsai (1):
      pinctrl: sunxi: a83t: Fix IRQ offset typo for PH11

Chris Chiu (1):
      ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN

Chris Wilson (3):
      drm/i915/execlists: Apply a full mb before execution for Braswell
      drm/i915: Allocate a common scratch page
      drm/i915: Flush GPU relocs harder for gen3

Colin Ian King (1):
      drm/vmwgfx: remove redundant return ret statement

Corentin Labbe (1):
      ARM: dts: sun8i: a83t: bananapi-m3: increase vcc-pd voltage to 3.3V

Craig Tatlor (1):
      pinctrl: sdm660: Set tile property for pingroups

Damien Le Moal (1):
      dm zoned: Fix target BIO completion handling

Dan Carpenter (1):
      media: cedrus: Fix a NULL vs IS_ERR() check

Daniel Lezcano (2):
      thermal/drivers/hisi: Fix wrong platform_get_irq_byname()
      thermal/drivers/hisi: Fix number of sensors on hi3660

Daniel Vetter (1):
      MAINTAINERS: Daniel for drm co-maintainer

David HERNANDEZ SANCHEZ (2):
      thermal: stm32: read factory settings inside stm_thermal_prepare
      thermal: stm32: Fix stm_thermal_read_factory_settings

Elvira Khabirova (1):
      powerpc/ptrace: replace ptrace_report_syscall() with a tracehook call

Enric Balletbo i Serra (1):
      backlight: pwm_bl: Fix brightness levels for non-DT case.

Evan Quan (1):
      drm/amdgpu: drop fclk/gfxclk ratio setting

Fabio Estevam (2):
      ARM: dts: imx7d-pico: Describe the Wifi clock
      ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi clock

Faiz Abbas (1):
      mmc: sdhci-omap: Fix DCRC error handling during tuning

Hans Verkuil (8):
      media: vb2: don't call __vb2_queue_cancel if vb2_start_streaming fail=
ed
      media: vb2: skip request checks for VIDIOC_PREPARE_BUF
      media: vb2: keep a reference to the request until dqbuf
      media: vb2: don't unbind/put the object when going to state QUEUED
      media: vivid: drop v4l2_ctrl_request_complete() from start_streaming
      media: vicodec: set state resolution from raw format
      media: mpeg2-ctrls.h: move MPEG2 state controls to non-public header
      media: extended-controls.rst: add note to the MPEG2 state controls

Hans de Goede (1):
      HID: ite: Add USB id match for another ITE based keyboard rfkill key =
quirk

Hui Wang (1):
      ALSA: hda/realtek - Fix the mute LED regresion on Lenovo X1 Carbon

Jeff Moyer (1):
      aio: fix spectre gadget in lookup_ioctx

Jerome Brunet (1):
      pinctrl: meson: fix pull enable register calculation

Jian-Hong Pan (2):
      ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294
      ALSA: hda/realtek: Enable audio jacks of ASUS UX433FN/UX333FA with AL=
C294

Junwei Zhang (1):
      drm/amdgpu: update SMC firmware image for polaris10 variants

Kailang Yang (1):
      ALSA: hda/realtek - Fixed headphone issue for ALC700

Kees Cook (1):
      selftests/seccomp: Remove SIGSTOP si_pid check

Keith Busch (1):
      block/bio: Do not zero user pages

Kenneth Feng (1):
      drm/amdgpu/powerplay: Apply avfs cks-off voltages on VI

Laurent Pinchart (1):
      media: vsp1: Fix LIF buffer thresholds

Linus Torvalds (1):
      Linux 4.20-rc7

Logan Gunthorpe (2):
      mm: introduce common STRUCT_PAGE_MAX_SHIFT define
      mm/sparse: add common helper to mark all memblocks present

Lubomir Rintel (2):
      ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt
      MAINTAINERS: update entry for MMP platform

Luis Henriques (1):
      ceph: make 'nocopyfrom' a default mount option

Lyude Paul (1):
      drm/nouveau/kms: Fix memory leak in nv50_mstm_del()

Mark Brown (1):
      arch/sh/include/asm/io.h: provide prototypes for PCI I/O mapping
in asm/io.h

Mark Zhang (1):
      IB/core: Fix oops in netdev_next_upper_dev_rcu()

Matthew Wilcox (5):
      radix tree: Don't return retry entries from lookup
      XArray: Add xa_cmpxchg_irq and xa_cmpxchg_bh
      XArray tests: Handle larger indices more elegantly
      XArray tests: Check iterating over multiorder entries
      XArray: Fix xa_alloc when id exceeds max

Matthias Brugger (1):
      MAINTAINERS: mediatek: Update SoC entry

Michael Ellerman (2):
      powerpc/mm: Fix linux page tables build with some configs
      powerpc/boot: Fix build failures with -j 1

Michael J. Ruhl (1):
      IB/hfi1: Fix a latency issue for small messages

Mike Rapoport (1):
      alpha: fix hang caused by the bootmem removal

Mike Snitzer (4):
      dm cache metadata: verify cache has blocks in
blocks_are_clean_separate_dirty()
      dm: call blk_queue_split() to impose device limits on bios
      dm thin: send event about thin-pool state change _after_ making it
      dm thin: bump target version

Miklos Szeredi (3):
      fuse: fix fsync on directory
      fuse: fix revalidation of attributes for permission check
      Revert "ovl: relax permission checking on underlying layers"

Myungho Jung (1):
      fuse: Add bad inode check in fuse_destroy_inode()

Nic Soud=C3=A9e (1):
      HID: quirks: fix RetroUSB.com devices

Nicolas Boichat (1):
      drm/mediatek: Only try to attach bridge if there is one

Oliver O'Halloran (7):
      powerpc/papr_scm: Use depend instead of select
      powerpc/papr_scm: Fix resource end address
      powerpc/papr_scm: Update DT properties
      powerpc/papr_scm: Remove endian conversions
      powerpc/papr_scm: Fix DIMM device registration race
      powerpc/papr_scm: Use ibm,unit-guid as the iset cookie
      powerpc/mm: Fallback to RAM if the altmap is unusable

Paul Mackerras (1):
      powerpc: Fix COFF zImage booting on old powermacs

Peter Hutterer (1):
      Input: restore EV_ABS ABS_RESERVED

Piotr Jaroszynski (1):
      fs/iomap.c: get/put the page in iomap_page_create/release()

Piotr Stankiewicz (1):
      IB/hfi1: Fix an out-of-bounds access in get_hw_stats

Qian Cai (1):
      checkstack.pl: fix for aarch64

Radu Rendec (1):
      powerpc/msi: Fix NULL pointer access in teardown code

Rob Herring (1):
      ARM: dts: realview: Fix some more duplicate regulator nodes

Robin Murphy (1):
      arm64: dma-mapping: Fix FORCE_CONTIGUOUS buffer clearing

Ryder Lee (3):
      arm64: dts: mt7622: fix no more console output on rfb1
      arm64: dts: mt7622: fix no more console output on BPI-R64 board
      arm64: dts: mt7622: Drop the general purpose timer node

Sakari Ailus (1):
      media: Add a Kconfig option for the Request API

Sandipan Das (1):
      powerpc/bpf: Fix broken uapi for BPF_PROG_TYPE_PERF_EVENT

Shin'ichiro Kawasaki (1):
      block: Fix null_blk_zoned creation failure with small number of zones

Srinivas Kandagatla (1):
      clk: qcom: qcs404: Fix gpll0_out_main parent

Stefan Wahren (1):
      ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs

Steven Rostedt (VMware) (3):
      tracing: Fix memory leak in create_filter()
      tracing: Fix memory leak in set_trigger_filter()
      tracing: Fix memory leak of instance function hash filters

Takashi Sakamoto (1):
      ALSA: fireface: fix reference to wrong register for clock configurati=
on

Takeshi Misawa (1):
      fuse: Fix memory leak in fuse_dev_free()

Thierry Reding (2):
      drm/nouveau/drm/nouveau: tegra: Call nouveau_drm_device_init()
      scripts/spdxcheck.py: always open files in binary mode

Thomas Hellstrom (1):
      drm/vmwgfx: Protect from excessive execbuf kernel memory allocations =
v3

Tina Zhang (1):
      drm/i915/gvt: Fix tiled memory decoding bug on BDW

Tvrtko Ursulin (2):
      drm/i915: Record GT workarounds in a list
      drm/i915: Introduce per-engine workarounds

Wolfram Sang (1):
      mmc: core: use mrq->sbc when sending CMD23 for RPMB

Yishai Hadas (1):
      IB/mlx5: Block DEVX umem from the non applicable cases

Yongkai Wu (1):
      hugetlbfs: call VM_BUG_ON_PAGE earlier in free_huge_page()

Yueyi Li (1):
      memblock: annotate memblock_is_reserved() with __init_memblock
