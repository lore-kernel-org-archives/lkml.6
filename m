Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8716AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2E02075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KxOmqLna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2E02075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeKSI3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:29:01 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41755 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeKSI3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:29:00 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so19952644lfj.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 14:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9EpbFqdP3apj9FjYRe5Z1g4wbjAZe+cg+jIxtauc+Ns=;
        b=KxOmqLnauljM3eb4CotgT8fXor3HkLLIsYq38nLLiEDi67HTDPxO4xe7htaXMaoeJT
         jyrtwov//zq+Ii33bhjoqyXcNfNlreBrkkmoD6s2gLd/KHhaDish8PAU7pWHSsdOjzsR
         tbUIWGrcQaVACZk0yEEcoNX42tvAIcbM0Eoxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9EpbFqdP3apj9FjYRe5Z1g4wbjAZe+cg+jIxtauc+Ns=;
        b=X264P00c1j+g3IeKTHe5TLe+5f+hLzE5ZU48O4Bbn6/otA+kwN2b9/TBsb8gS/Zuu3
         Pw9dqByqv2Mt86N70HzPxyF4ZWv19iCZ6Ct4PJhM0GLY8NT0FsDzMAZ/L/rTMhoepOJf
         YW0VCYIG1XuU649YALStxjq7+sxTLqWqj2Fl5gmaaKQuoLqfRCi+Uu1NfYnJvaU4LfHq
         LAkN4M4DKrH/4MZVwfEq+Zze06jKm1dFw+8wTvX+CM21MSrjA2vKl/ndYBhag3aXO333
         KkCXGWy12VT2bEaSoQkqvKtwZDFdqjxheUPp7MYB+RnZ4QWNKsmFmQLi0G3fp7nEcJ9/
         ozmw==
X-Gm-Message-State: AGRZ1gIjIAJ71qOx/0GxMeVVY8itPAnSU0+vj2bOOtLFdgEjZgJQwT6B
        poZbDg9bVp9WMTZwAZ1sTCaU2a/aH78=
X-Google-Smtp-Source: AJdET5f5jAa7aYYJBg5aWLR4YsW8e0ixiOwvB63yO1XxDddbaIfiTkYa7lSQHbj9jsZYfFwU+VUSvQ==
X-Received: by 2002:a19:2d16:: with SMTP id k22mr9083996lfj.12.1542578846683;
        Sun, 18 Nov 2018 14:07:26 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id g15sm5403213lfb.1.2018.11.18.14.07.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 14:07:25 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id p86so19978578lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 14:07:25 -0800 (PST)
X-Received: by 2002:a19:7013:: with SMTP id h19mr10271396lfc.147.1542578845203;
 Sun, 18 Nov 2018 14:07:25 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Nov 2018 14:07:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZmPvR64hDy-pcVJqcxoAwMRd4GrRhRjK04Mhng4nL4g@mail.gmail.com>
Message-ID: <CAHk-=wiZmPvR64hDy-pcVJqcxoAwMRd4GrRhRjK04Mhng4nL4g@mail.gmail.com>
Subject: Linux 4.20-rc3
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only unusual thing last week was my travel - not any code issues.
That caused a few pulls to be delayed by a day or two, but nothing
else.

And now I'm back home, and 4.20-rc3 is out there.

The changes in rc3 are pretty tiny, which means that the statistics
look slightly different from the uysual ones - drivers only account
for less than a third of the patch, for example. But that really isn't
because of anything odd going on anywhere else, it all looks like just
random noise in the distribution of patches. So we have about one
third driver updates, one third arch updates, and one third "core"
(kernel, mm, fs, networking).

Shortlog appended for some flavor of the details,

                Linus

---

Aaro Koskinen (1):
      MAINTAINERS: update OMAP MMC entry

Alistair Popple (1):
      powerpc/powernv/npu: Remove NPU DMA ops

Amir Goldstein (1):
      fanotify: fix handling of events on child sub-directory

Andreas Gruenbacher (3):
      gfs2: Put bitmap buffers in put_super
      gfs2: Fix metadata read-ahead during truncate (2)
      gfs2: Fix iomap buffer head reference counting bug

Andy Shevchenko (1):
      MAINTAINERS: Add tree link for Intel pin control driver

Anson Huang (1):
      cpufreq: imx6q: add return value check for voltage scale

Anup Patel (1):
      RISC-V: defconfig: Enable printk timestamps

Ard Biesheuvel (5):
      crypto: simd - correctly take reqsize of wrapped skcipher into accoun=
t
      efi/arm: Revert deferred unmap of early memmap mapping
      efi/arm/libstub: Pack FDT after populating it
      efi/arm: Defer persistent reservations until after paging_init()
      efi: Permit calling efi_mem_reserve_persistent() from atomic context

Arnd Bergmann (6):
      scsi: myrb: fix sprintf buffer overflow warning
      scsi: lpfc: fix remoteport access
      scsi: myrs: avoid stack overflow warning
      scsi: myrs: only build on little-endian platforms
      ACPI / PMIC: xpower: fix IOSF_MBI dependency
      lib/ubsan.c: don't mark __ubsan_handle_builtin_unreachable as noretur=
n

Bart Van Assche (1):
      scsi: target/core: Avoid that a kernel oops is triggered when
COMPARE AND WRITE fails

Benjamin Coddington (1):
      mnt: fix __detach_mounts infinite loop

Bjorn Helgaas (1):
      Revert "ACPI/PCI: Pay attention to device-specific _PXM node values"

Chen Chang (1):
      mm/memblock.c: fix a typo in __next_mem_pfn_range() comments

Chris Wilson (2):
      drm/i915/ringbuffer: Delay after EMIT_INVALIDATE for gen4/gen5
      drm/i915/execlists: Force write serialisation into context image
vs execution

Christian K=C3=B6nig (1):
      drm/amdgpu: fix huge page handling on Vega10

Christophe Leroy (2):
      kdb: use correct pointer when 'btc' calls 'btt'
      kdb: print real address of pointers instead of hashed addresses

Corentin Labbe (1):
      crypto: user - Zeroize whole structure given to user space

Dan Williams (2):
      acpi, nfit: Fix ARS overflow continuation
      Revert "acpi, nfit: Further restrict userspace ARS start requests"

Dave Chinner (1):
      block: fix 32 bit overflow in __blkdev_issue_discard()

David Abdurachmanov (2):
      riscv: fix spacing in struct pt_regs
      riscv: add missing vdso_install target

Diego Viola (1):
      libata: blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD

Eric Biggers (1):
      crypto: user - fix leaking uninitialized memory to userspace

Finn Thain (1):
      scsi: NCR5380: Return false instead of NULL

Frank Sorenson (1):
      sunrpc: correct the computation for page_ptr when truncating

Gustavo A. R. Silva (3):
      kdb: kdb_main: refactor code in kdb_md_line
      kdb: kdb_keyboard: mark expected switch fall-throughs
      kdb: kdb_support: mark expected switch fall-throughs

Gustavo Romero (1):
      selftests/powerpc: Adjust wild_bctr to build with old binutils

Hannes Reinecke (1):
      block: copy ioprio in __bio_clone_fast() and bounce

Hans de Goede (1):
      rtc: cmos: Do not export alarm rtc_ops when we do not support alarms

Imre Deak (1):
      drm/i915/icl: Fix power well 2 wrt. DC-off toggling order

Janne Huttunen (1):
      mm/vmstat.c: fix NUMA statistics updates

Jens Axboe (1):
      floppy: fix race condition in __floppy_read_block_0()

Jerome Brunet (5):
      pinctrl: meson: fix pinconf bias disable
      pinctrl: meson: fix gxbb ao pull register bits
      pinctrl: meson: fix gxl ao pull register bits
      pinctrl: meson: fix meson8 ao pull register bits
      pinctrl: meson: fix meson8b ao pull register bits

John David Anglin (1):
      parisc: Revert "Release spinlocks using ordered store"

John Garry (2):
      crypto: hisilicon - Fix NULL dereference for same dst and src
      crypto: hisilicon - Fix reference after free of memories on error pat=
h

Jorge Ramirez-Ortiz (1):
      drm/meson: venc: dmt mode must use encp

Julien Thierry (1):
      ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc

Kan Liang (2):
      perf/x86/intel/uncore: Add more IMC PCI IDs for KabyLake and
CoffeeLake CPUs
      perf/x86/intel/uncore: Support CoffeeLake 8th CBOX

Laurent Pinchart (4):
      drm/omap: Populate DSS children in omapdss driver
      drm/omap: hdmi4: Ensure the device is active during bind
      drm/omap: dsi: Ensure the device is active during probe
      drm/omap: Move DISPC runtime PM handling to omapdrm

Linus Torvalds (1):
      Linux 4.20-rc3

Lionel Landwerlin (1):
      drm/i915: fix broadwell EU computation

Lukas Czerner (1):
      fuse: fix use-after-free in fuse_direct_IO()

Lyude Paul (2):
      drm/i915: Fix possible race in intel_dp_add_mst_connector()
      drm/i915: Fix NULL deref when re-enabling HPD IRQs on systems with MS=
T

Maarten Lankhorst (1):
      drm/i915: Move programming plane scaler to its own function.

Maciej W. Rozycki (1):
      rtc: hctosys: Add missing range error reporting

Martin K. Petersen (1):
      Revert "scsi: ufs: Disable blk-mq for now"

Masanari Iida (1):
      scsi: qla2xxx: Fix a typo in MODULE_PARM_DESC

Masayoshi Mizuma (1):
      tools/testing/nvdimm: Fix the array size for dimm devices.

Max Filippov (2):
      xtensa: make sure bFLT stack is 16 byte aligned
      xtensa: fix boot parameters address translation

Michael Ellerman (6):
      powerpc/mm/64s: Consolidate SLB assertions
      powerpc/mm/64s: Use PPC_SLBFEE macro
      powerpc/mm/64s: Only use slbfee on CPUs that support it
      powerpc/mm/64s: Fix preempt warning in slb_allocate_kernel()
      powerpc/io: Fix the IO workarounds code to work with Radix
      selftests/powerpc: Fix wild_bctr test to work on ppc64

Michal Hocko (2):
      mm, memory_hotplug: check zone_movable in has_unmovable_pages
      mm, page_alloc: check for max order in hot path

Mika Kuoppala (1):
      drm/i915/icl: Drop spurious register read from icl_dbuf_slices_update

Mike Kravetz (1):
      hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!

Mike Rapoport (1):
      mm/gup.c: fix follow_page_mask() kerneldoc comment

Miklos Szeredi (2):
      fuse: fix leaked notify reply
      fuse: fix possibly missed wake-up after abort

Mimi Zohar (1):
      integrity: support new struct public_key_signature encoding field

Ming Lei (1):
      SCSI: fix queue cleanup race before queue initialization is done

Nicholas Piggin (1):
      powerpc/64: Fix kernel stack 16-byte alignment

Olof Johansson (3):
      RISC-V: lib: Fix build error for 64-bit
      RISC-V: Silence some module warnings on 32-bit
      kernel/sched/psi.c: simplify cgroup_move_task()

Omar Sandoval (1):
      kyber: fix wrong strlcpy() size in trace_kyber_latency()

Ondrej Mosnacek (1):
      selinux: check length properly in SCTP bind hook

Patrick Bellasi (1):
      sched/fair: Fix cpu_util_wake() for 'execl' type workloads

Paul Moore (1):
      selinux: fix non-MLS handling in mls_context_to_sid()

Philip Yang (1):
      drm/amdgpu: fix bug with IH ring setup

Prarit Bhargava (1):
      kdb: Use strscpy with destination buffer size

Quinn Tran (1):
      scsi: qla2xxx: Initialize port speed to avoid setting lower speed

Randy Dunlap (1):
      scripts/faddr2line: fix location of start_kernel in comment

Rex Zhu (1):
      drm/amd/pp: Fix truncated clock value when set watermark

Roman Gushchin (1):
      mm: don't reclaim inodes with many attached pages

Russell King (5):
      ARM: make lookup_processor_type() non-__init
      ARM: split out processor lookup
      ARM: clean up per-processor check_bugs method call
      ARM: add PROC_VTABLE and PROC_TABLE macros
      ARM: spectre-v2: per-CPU vtables to work around big.Little systems

Satheesh Rajendran (1):
      powerpc/numa: Suppress "VPHN is not supported" messages

Scott Mayhew (1):
      nfsd: COPY and CLONE operations require the saved filehandle to be se=
t

Scott Wood (1):
      KVM: PPC: Move and undef TRACE_INCLUDE_PATH/FILE

Sean Paul (1):
      drm: Fix htmldocs warnings in drm_fourcc.c

Stanislav Lisovskiy (1):
      drm/dp_mst: Check if primary mstb is null

Sudeep Holla (1):
      dt-bindings: cpufreq: remove stale arm_big_little_dt entry

Tony Lindgren (1):
      drm/omap: dsi: Fix missing of_platform_depopulate()

Trond Myklebust (5):
      NFSv4: Don't exit the state manager without clearing
NFS4CLNT_MANAGER_RUNNING
      NFSv4: Ensure that the state manager exits the loop on SIGKILL
      SUNRPC: Fix a Oops when destroying the RPCSEC_GSS credential cache
      SUNRPC: Fix a bogus get/put in generic_key_to_expire()
      NFSv4: Fix an Oops during delegation callbacks

Ulf Hansson (2):
      ARM: cpuidle: Don't register the driver when back-end init returns -E=
NXIO
      ARM: cpuidle: Convert to use cpuidle_register|unregister()

Uwe Kleine-K=C3=B6nig (1):
      scripts/spdxcheck.py: make python3 compliant

Vasily Averin (1):
      mm/swapfile.c: use kvzalloc for swap_info_struct allocation

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/i915: Fix hpd handling for pins with two encoders
      drm/i915: Clean up skl_program_scaler()
      drm/i915: Account for scale factor when calculating initial phase

Viresh Kumar (1):
      Documentation: cpu-freq: Frequencies aren't always sorted

Vitaly Wool (1):
      z3fold: fix possible reclaim races

Waiman Long (1):
      efi: Fix debugobjects warning on 'efi_rts_work'

Wengang Wang (1):
      ocfs2: free up write context when direct IO failed

Xulin Sun (1):
      rtc: pcf2127: fix a kmemleak caused in pcf2127_i2c_gather_write

YueHaibing (2):
      scsi: hisi_sas: Remove set but not used variable 'dq_list'
      SUNRPC: drop pointless static qualifier in xdr_get_next_encode_buffer=
()

Yufen Yu (1):
      tmpfs: make lseek(SEEK_DATA/SEK_HOLE) return ENXIO with a negative of=
fset

Zhao Wei Liew (1):
      Documentation: cpufreq: Correct a typo

shaoyunl (1):
      drm/amdgpu: set system aperture to cover whole FB region
