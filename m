Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F37C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE902086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViArx3uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE902086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeJOOdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbeJOOdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 10:33:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D2122086A;
        Mon, 15 Oct 2018 06:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539586157;
        bh=ptYhKDL7kEC8D+XKgvYXxyRJJoprg4uGIWnzWkTQxrU=;
        h=Date:From:To:Cc:Subject:From;
        b=ViArx3uZ7UMA1Jz6yCH0LiQqakYhd4+U6scmBGlNTHcCIGdFTajjTXidBR9SiY8HU
         kJzzXodZ/VrKC0PuQr4FqX1jS24y0+g6o4zHY1hEmj/+pIrPI6nmXaGEgTAHZph2rm
         NJURD1lH8aDeO7ETUx6/OQnzTxaN2Wzi/Vm07S+E=
Date:   Mon, 15 Oct 2018 08:49:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: Linux 4.19-rc8
Message-ID: <20181015064915.GA10710@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

As mentioned last week, here's a -rc8 release as it seems needed.

There were a lot of "little" pull requests this week, semi-normal for
this late in the cycle, but a lot of them were "fix up the previous fix
I just sent" which implies that people are having a few issues still.

I also know of at least one "bad" bug that finally has a proposed fix,
so that should hopefully get merged this week.  And there are some
outstanding USB fixes I know of that have not yet landed in the tree (I
blame me for that...)

Anyway, the full shortlog is below, lots of tiny things all over the
tree.  Please go and test and ensure that all works well for you.
Hopefully this should be the last -rc release.

thanks,

greg k-h

Adrian Hunter (2):
      perf script python: Fix export-to-postgresql.py occasional failure
      perf script python: Fix export-to-sqlite.py sample columns

Al Viro (1):
      net: sched: cls_u32: fix hnode refcounting

Alexey Brodkin (2):
      ARC: build: Get rid of toolchain check
      ARC: build: Don't set CROSS_COMPILE in arch's Makefile

Andreas Gruenbacher (2):
      gfs2: Fix iomap buffered write support for journaled files
      gfs2: Fix iomap buffered write support for journaled files (2)

Arnaldo Carvalho de Melo (1):
      perf python: Use -Wno-redundant-decls to build with PYTHON=python3

Arnd Bergmann (1):
      lib/bch: fix possible stack overrun

Arthur Kiyanovski (4):
      net: ena: fix warning in rmmod caused by double iounmap
      net: ena: fix rare bug when failed restart/resume is followed by driver removal
      net: ena: fix NULL dereference due to untimely napi initialization
      net: ena: fix auto casting to boolean

Chris Boot (1):
      mmc: block: avoid multiblock reads for the last sector in SPI mode

Colin Ian King (2):
      ARC: fix spelling mistake "entires" -> "entries"
      oradax: remove redundant null check before kfree

Damien Le Moal (2):
      dm: fix report zone remapping to account for partition offset
      dm linear: fix linear_end_io conditional definition

Dan Williams (1):
      filesystem-dax: Fix dax_layout_busy_page() livelock

Daniel Drake (1):
      Input: i8042 - enable keyboard wakeups by default when s2idle is used

Daniel Mack (1):
      libertas: call into generic suspend code before turning off power

Darrick J. Wong (3):
      xfs: refactor clonerange preparation into a separate helper
      xfs: zero posteof blocks when cloning above eof
      xfs: update ctime and remove suid before cloning files

Dave Chinner (2):
      xfs: fix data corruption w/ unaligned dedupe ranges
      xfs: fix data corruption w/ unaligned reflink ranges

David Howells (12):
      rxrpc: Fix some missed refs to init_net
      rxrpc: Fix the data_ready handler
      rxrpc: Use the UDP encap_rcv hook
      rxrpc: Don't need to take the RCU read lock in the packet receiver
      rxrpc: Don't check RXRPC_CALL_TX_LAST after calling rxrpc_rotate_tx_window()
      rxrpc: Carry call state out of locked section in rxrpc_rotate_tx_window()
      rxrpc: Only take the rwind and mtu values from latest ACK
      rxrpc: Fix connection-level abort handling
      rxrpc: Fix the rxrpc_tx_packet trace line
      rxrpc: Fix the packet reception routine
      afs: Fix cell proc list
      afs: Fix afs_server struct leak

Dmitry Torokhov (2):
      Input: evdev - add a schedule point in evdev_write()
      Input: uinput - add a schedule point in uinput_inject_events()

Emil Karlson (1):
      mfd: cros-ec: copy the whole event in get_next_event_xfer

Eric Dumazet (2):
      Input: mousedev - add a schedule point in mousedev_write()
      net: make skb_partial_csum_set() more robust against overflows

Eric Farman (3):
      s390/cio: Convert ccw_io_region to pointer
      s390/cio: Refactor alloc of ccw_io_region
      s390/cio: Fix how vfio-ccw checks pinned pages

Eugene Syromiatnikov (2):
      net/smc: use __aligned_u64 for 64-bit smc_diag fields
      net/smc: retain old name for diag_mode field

Florian Fainelli (2):
      net: dsa: bcm_sf2: Fix unbind ordering
      net: dsa: bcm_sf2: Call setup during switch resume

Gerald Schaefer (1):
      s390/hibernate: fix error handling when suspend cpu != resume cpu

Giacinto Cifelli (1):
      qmi_wwan: Added support for Gemalto's Cinterion ALASxx WWAN interface

Greg Kroah-Hartman (1):
      Linux 4.19-rc8

Guenter Roeck (1):
      of: unittest: Disable interrupt node tests for old world MAC systems

Gustavo A. R. Silva (2):
      sparc32: fix fall-through annotation
      sparc64: fix fall-through annotation

Ilias Apalodimas (1):
      net: socionext: clear rx irq correctly

Jan Kara (1):
      mm: Preserve _PAGE_DEVMAP across mprotect() calls

Jann Horn (1):
      mm/mmap.c: don't clobber partially overlapping VMA with MAP_FIXED_NOREPLACE

Jiri Kosina (1):
      udp: Unbreak modules that rely on external __skb_recv_udp() availability

Joe Perches (1):
      MAINTAINERS: MIPS/LOONGSON2 ARCHITECTURE - Use the normal wildcard style

Joel Stanley (1):
      ftrace: Build with CPPFLAGS to get -Qunused-arguments

Jon Maloy (1):
      tipc: set link tolerance correctly in broadcast link

Josef Bacik (1):
      blk-wbt: wake up all when we scale up, not down

Jérôme Glisse (1):
      mm/thp: fix call to mmu_notifier in set_pmd_migration_entry() v2

Ka-Cheong Poon (1):
      rds: RDS (tcp) hangs on sendto() to unresponding address

Kees Cook (3):
      treewide: Replace more open-coded allocation size multiplications
      sparc64: viohs: Remove VLA usage
      x86/mm: Avoid VLA in pgd_alloc()

Khazhismel Kumykov (1):
      fs/fat/fatent.c: add cond_resched() to fat_count_free_clusters()

Laurentiu Tudor (2):
      soc: fsl: qbman: add APIs to retrieve the probing status
      soc: fsl: qman_portals: defer probe after qman's probe

Lyude Paul (1):
      drm/nouveau/drm/nouveau: Grab runtime PM ref in nv50_mstc_detect()

Maciej S. Szmigiero (1):
      r8169: set RX_MULTI_EN bit in RxConfig for 8168F-family chips

Maciej W. Rozycki (1):
      MIPS: memset: Fix CPU_DADDI_WORKAROUNDS `small_fixup' regression

Marc Zyngier (1):
      ARM: KVM: Correctly order SGI register entries in the cp15 array

Marco Felsch (1):
      pinctrl: mcp23s08: fix irq and irqchip setup order

Masahiro Yamada (2):
      sparc: vdso: clean-up vdso Makefile
      samples: disable CONFIG_SAMPLES for UML

Mike Rapoport (2):
      percpu: stop leaking bitmap metadata blocks
      net/ipv6: stop leaking percpu memory in fib6 info

Mike Snitzer (1):
      dm linear: eliminate linear_end_io call if CONFIG_DM_ZONED disabled

Mikulas Patocka (1):
      mach64: detect the dot clock divider correctly on sparc

Milian Wolff (2):
      perf report: Don't try to map ip to invalid map
      perf record: Use unmapped IP for inline callchain cursors

Moshe Shemesh (4):
      devlink: Fix param set handling for string type
      devlink: Fix param cmode driverinit for string type
      devlink: Add helper function for safely copy string param
      net/mlx4_core: Fix warnings during boot on driverinit param set failures

Paolo Abeni (2):
      selftests: rtnetlink.sh explicitly requires bash.
      selftests: udpgso_bench.sh explicitly requires bash

Paolo Bonzini (1):
      KVM: x86: support CONFIG_KVM_AMD=y with CONFIG_CRYPTO_DEV_CCP_DD=m

Parthasarathy Bhuvaragan (1):
      tipc: queue socket protocol error messages into socket receive buffer

Paul Burton (2):
      MIPS: VDSO: Always map near top of user memory
      MIPS: Fix CONFIG_CMDLINE handling

Peter Oberparleiter (2):
      vmlinux.lds.h: Fix incomplete .text.exit discards
      vmlinux.lds.h: Fix linker warnings about orphan .LPBX sections

Peter Rosin (2):
      mux: adgs1408: use the correct MODULE_LICENSE
      MAINTAINERS: use the correct location for dt-bindings includes for mux

Ramses Ramírez (1):
      Input: xpad - add support for Xbox1 PDP Camo series gamepad

Reinette Chatre (1):
      x86/intel_rdt: Fix out-of-bounds memory access in CBM tests

Richard Weinberger (1):
      ubifs: Fix WARN_ON logic in exit path

Rob Herring (2):
      sparc: Convert to using %pOFn instead of device_node.name
      sbus: Use of_get_child_by_name helper

Sabrina Dubroca (2):
      net: ipv4: update fnhe_pmtu when first hop's MTU changes
      net: ipv4: don't let PMTU updates increase route MTU

Sascha Hauer (1):
      ARM: dts: imx53-qsb: disable 1.2GHz OPP

Sebastian Andrzej Siewior (1):
      net: phy: sfp: remove sfp_mutex's definition

Shenghui Wang (1):
      dm cache: destroy migration_cache if cache target registration failed

Srikar Dronamraju (1):
      mm, sched/numa: Remove remaining traces of NUMA rate-limiting

Stefan Agner (1):
      kbuild: allow to use GCC toolchain not in Clang search path

Stephen Boyd (2):
      gpio: Assign gpio_irq_chip::parents to non-stack pointer
      i2c: Fix kerneldoc for renamed i2c dma put function

Steven Rostedt (VMware) (1):
      vsprintf: Fix off-by-one bug in bstr_printf() processing dereferenced pointers

Tejun Heo (1):
      cgroup: Fix dom_cgrp propagation when enabling threaded mode

Valentine Fatiev (1):
      IB/mlx5: Unmap DMA addr from HCA before IOMMU

Vineet Gupta (2):
      ARCv2: build: use mcpu=hs38 iso generic mcpu=archs
      ARC: clone syscall to setp r25 as thread pointer

Vitaly Kuznetsov (1):
      KVM: vmx: hyper-v: don't pass EPT configuration info to vmx_hv_remote_flush_tlb()

Will Deacon (2):
      arm64: Fix /proc/iomem for reserved but not memory regions
      arm64: perf: Reject stand-alone CHAIN events for PMUv3

Ying Xue (1):
      tipc: eliminate possible recursive locking detected by LOCKDEP

zhong jiang (1):
      ocfs2: fix a GCC warning

