Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbeBUXlC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:41:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeBUXk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:40:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FD721796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From: James Hogan <jhogan@kernel.org>
To: linux-metag@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 01/13] metag: Remove arch/metag/
Date: Wed, 21 Feb 2018 23:38:13 +0000
Message-Id: <20180221233825.10024-2-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180221233825.10024-1-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The earliest Meta architecture port of Linux I have a record of was an
import of a Meta port of Linux v2.4.1 in February 2004, which was worked
on significantly over the next few years by Graham Whaley, Will Newton,
Matt Fleming, myself and others.

Eventually the port was merged into mainline in v3.9 in March 2013, not
long after Imagination Technologies bought MIPS Technologies and shifted
its CPU focus over to the MIPS architecture.

As a result, though the port was maintained for a while, kept on life
support for a while longer, and useful for testing a few specific
drivers for which I don't have ready access to the equivalent MIPS
hardware, it is now essentially dead with no users.

It is also stuck using an out-of-tree toolchain based on GCC 4.2.4 which
is no longer maintained, now struggles to build modern kernels due to
toolchain bugs, and doesn't itself build with a modern GCC. The latest
buildroot port is still using an old uClibc snapshot which is no longer
served, and the latest uClibc doesn't build with GCC 4.2.4.

So lets call it a day and drop the Meta architecture port from the
kernel. RIP Meta.

Signed-off-by: James Hogan <jhogan@kernel.org>
Link: https://lkml.kernel.org/r/95906b76-6ce1-3f84-eaba-c29b4ae952eb@roeck-us.net
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-metag@vger.kernel.org
---
 arch/metag/Kconfig                       |  287 ------
 arch/metag/Kconfig.debug                 |   34 -
 arch/metag/Kconfig.soc                   |   69 --
 arch/metag/Makefile                      |   89 --
 arch/metag/boot/.gitignore               |    3 -
 arch/metag/boot/Makefile                 |   68 --
 arch/metag/boot/dts/Makefile             |   16 -
 arch/metag/boot/dts/skeleton.dts         |   10 -
 arch/metag/boot/dts/skeleton.dtsi        |   15 -
 arch/metag/boot/dts/tz1090.dtsi          |  108 ---
 arch/metag/boot/dts/tz1090_generic.dts   |   10 -
 arch/metag/configs/meta1_defconfig       |   39 -
 arch/metag/configs/meta2_defconfig       |   40 -
 arch/metag/configs/meta2_smp_defconfig   |   41 -
 arch/metag/configs/tz1090_defconfig      |   42 -
 arch/metag/include/asm/Kbuild            |   33 -
 arch/metag/include/asm/atomic.h          |   49 --
 arch/metag/include/asm/atomic_lnkget.h   |  204 -----
 arch/metag/include/asm/atomic_lock1.h    |  157 ----
 arch/metag/include/asm/barrier.h         |   85 --
 arch/metag/include/asm/bitops.h          |  127 ---
 arch/metag/include/asm/bug.h             |   13 -
 arch/metag/include/asm/cache.h           |   24 -
 arch/metag/include/asm/cacheflush.h      |  251 ------
 arch/metag/include/asm/cachepart.h       |   43 -
 arch/metag/include/asm/checksum.h        |   93 --
 arch/metag/include/asm/clock.h           |   59 --
 arch/metag/include/asm/cmpxchg.h         |   64 --
 arch/metag/include/asm/cmpxchg_irq.h     |   43 -
 arch/metag/include/asm/cmpxchg_lnkget.h  |   87 --
 arch/metag/include/asm/cmpxchg_lock1.h   |   49 --
 arch/metag/include/asm/core_reg.h        |   36 -
 arch/metag/include/asm/cpu.h             |   15 -
 arch/metag/include/asm/da.h              |   44 -
 arch/metag/include/asm/delay.h           |   30 -
 arch/metag/include/asm/div64.h           |   13 -
 arch/metag/include/asm/dma-mapping.h     |   12 -
 arch/metag/include/asm/elf.h             |  126 ---
 arch/metag/include/asm/fixmap.h          |   69 --
 arch/metag/include/asm/ftrace.h          |   24 -
 arch/metag/include/asm/global_lock.h     |  101 ---
 arch/metag/include/asm/highmem.h         |   62 --
 arch/metag/include/asm/hugetlb.h         |   75 --
 arch/metag/include/asm/hwthread.h        |   41 -
 arch/metag/include/asm/io.h              |  170 ----
 arch/metag/include/asm/irq.h             |   38 -
 arch/metag/include/asm/irqflags.h        |   94 --
 arch/metag/include/asm/l2cache.h         |  259 ------
 arch/metag/include/asm/linkage.h         |    8 -
 arch/metag/include/asm/mach/arch.h       |   86 --
 arch/metag/include/asm/metag_isa.h       |   81 --
 arch/metag/include/asm/metag_mem.h       | 1109 -----------------------
 arch/metag/include/asm/metag_regs.h      | 1184 -------------------------
 arch/metag/include/asm/mman.h            |   12 -
 arch/metag/include/asm/mmu.h             |   78 --
 arch/metag/include/asm/mmu_context.h     |  115 ---
 arch/metag/include/asm/mmzone.h          |   43 -
 arch/metag/include/asm/module.h          |   38 -
 arch/metag/include/asm/page.h            |  129 ---
 arch/metag/include/asm/perf_event.h      |    4 -
 arch/metag/include/asm/pgalloc.h         |   83 --
 arch/metag/include/asm/pgtable-bits.h    |  105 ---
 arch/metag/include/asm/pgtable.h         |  270 ------
 arch/metag/include/asm/processor.h       |  201 -----
 arch/metag/include/asm/ptrace.h          |   61 --
 arch/metag/include/asm/setup.h           |   10 -
 arch/metag/include/asm/smp.h             |   28 -
 arch/metag/include/asm/sparsemem.h       |   14 -
 arch/metag/include/asm/spinlock.h        |   19 -
 arch/metag/include/asm/spinlock_lnkget.h |  213 -----
 arch/metag/include/asm/spinlock_lock1.h  |  165 ----
 arch/metag/include/asm/spinlock_types.h  |   21 -
 arch/metag/include/asm/stacktrace.h      |   21 -
 arch/metag/include/asm/string.h          |   14 -
 arch/metag/include/asm/switch.h          |   21 -
 arch/metag/include/asm/syscall.h         |  104 ---
 arch/metag/include/asm/syscalls.h        |   40 -
 arch/metag/include/asm/tbx.h             | 1420 ------------------------------
 arch/metag/include/asm/tcm.h             |   31 -
 arch/metag/include/asm/thread_info.h     |  141 ---
 arch/metag/include/asm/tlb.h             |   37 -
 arch/metag/include/asm/tlbflush.h        |   78 --
 arch/metag/include/asm/topology.h        |   28 -
 arch/metag/include/asm/traps.h           |   48 -
 arch/metag/include/asm/uaccess.h         |  213 -----
 arch/metag/include/asm/unistd.h          |   12 -
 arch/metag/include/asm/user_gateway.h    |   45 -
 arch/metag/include/uapi/asm/Kbuild       |   31 -
 arch/metag/include/uapi/asm/byteorder.h  |    2 -
 arch/metag/include/uapi/asm/ech.h        |   16 -
 arch/metag/include/uapi/asm/ptrace.h     |  114 ---
 arch/metag/include/uapi/asm/sigcontext.h |   32 -
 arch/metag/include/uapi/asm/siginfo.h    |   16 -
 arch/metag/include/uapi/asm/swab.h       |   27 -
 arch/metag/include/uapi/asm/unistd.h     |   24 -
 arch/metag/kernel/.gitignore             |    1 -
 arch/metag/kernel/Makefile               |   40 -
 arch/metag/kernel/asm-offsets.c          |   15 -
 arch/metag/kernel/cachepart.c            |  132 ---
 arch/metag/kernel/clock.c                |  110 ---
 arch/metag/kernel/core_reg.c             |  118 ---
 arch/metag/kernel/da.c                   |   25 -
 arch/metag/kernel/devtree.c              |   57 --
 arch/metag/kernel/dma.c                  |  588 -------------
 arch/metag/kernel/ftrace.c               |  121 ---
 arch/metag/kernel/ftrace_stub.S          |   62 --
 arch/metag/kernel/head.S                 |   66 --
 arch/metag/kernel/irq.c                  |  293 ------
 arch/metag/kernel/kick.c                 |  110 ---
 arch/metag/kernel/machines.c             |   21 -
 arch/metag/kernel/metag_ksyms.c          |   55 --
 arch/metag/kernel/module.c               |  284 ------
 arch/metag/kernel/perf/Makefile          |    3 -
 arch/metag/kernel/perf/perf_event.c      |  879 ------------------
 arch/metag/kernel/perf/perf_event.h      |  106 ---
 arch/metag/kernel/perf_callchain.c       |   97 --
 arch/metag/kernel/process.c              |  448 ----------
 arch/metag/kernel/ptrace.c               |  427 ---------
 arch/metag/kernel/setup.c                |  622 -------------
 arch/metag/kernel/signal.c               |  336 -------
 arch/metag/kernel/smp.c                  |  668 --------------
 arch/metag/kernel/stacktrace.c           |  187 ----
 arch/metag/kernel/sys_metag.c            |  181 ----
 arch/metag/kernel/tbiunexp.S             |   23 -
 arch/metag/kernel/tcm.c                  |  152 ----
 arch/metag/kernel/time.c                 |   26 -
 arch/metag/kernel/topology.c             |   78 --
 arch/metag/kernel/traps.c                |  992 ---------------------
 arch/metag/kernel/user_gateway.S         |   98 ---
 arch/metag/kernel/vmlinux.lds.S          |   74 --
 arch/metag/lib/Makefile                  |   23 -
 arch/metag/lib/ashldi3.S                 |   34 -
 arch/metag/lib/ashrdi3.S                 |   34 -
 arch/metag/lib/checksum.c                |  167 ----
 arch/metag/lib/clear_page.S              |   18 -
 arch/metag/lib/cmpdi2.S                  |   33 -
 arch/metag/lib/copy_page.S               |   21 -
 arch/metag/lib/delay.c                   |   57 --
 arch/metag/lib/div64.S                   |  109 ---
 arch/metag/lib/divsi3.S                  |  101 ---
 arch/metag/lib/ip_fast_csum.S            |   33 -
 arch/metag/lib/lshrdi3.S                 |   34 -
 arch/metag/lib/memcpy.S                  |  186 ----
 arch/metag/lib/memmove.S                 |  346 --------
 arch/metag/lib/memset.S                  |   87 --
 arch/metag/lib/modsi3.S                  |   39 -
 arch/metag/lib/muldi3.S                  |   45 -
 arch/metag/lib/ucmpdi2.S                 |   28 -
 arch/metag/lib/usercopy.c                | 1257 --------------------------
 arch/metag/mm/Kconfig                    |  147 ----
 arch/metag/mm/Makefile                   |   20 -
 arch/metag/mm/cache.c                    |  521 -----------
 arch/metag/mm/extable.c                  |   15 -
 arch/metag/mm/fault.c                    |  247 ------
 arch/metag/mm/highmem.c                  |  122 ---
 arch/metag/mm/hugetlbpage.c              |  251 ------
 arch/metag/mm/init.c                     |  408 ---------
 arch/metag/mm/ioremap.c                  |   90 --
 arch/metag/mm/l2cache.c                  |  193 ----
 arch/metag/mm/maccess.c                  |   69 --
 arch/metag/mm/mmu-meta1.c                |  157 ----
 arch/metag/mm/mmu-meta2.c                |  208 -----
 arch/metag/mm/numa.c                     |   82 --
 arch/metag/oprofile/Makefile             |   18 -
 arch/metag/oprofile/backtrace.c          |   63 --
 arch/metag/oprofile/backtrace.h          |    7 -
 arch/metag/oprofile/common.c             |   66 --
 arch/metag/tbx/Makefile                  |   22 -
 arch/metag/tbx/tbicore.S                 |  136 ---
 arch/metag/tbx/tbictx.S                  |  366 --------
 arch/metag/tbx/tbictxfpu.S               |  190 ----
 arch/metag/tbx/tbidefr.S                 |  175 ----
 arch/metag/tbx/tbidspram.S               |  161 ----
 arch/metag/tbx/tbilogf.S                 |   48 -
 arch/metag/tbx/tbipcx.S                  |  451 ----------
 arch/metag/tbx/tbiroot.S                 |   87 --
 arch/metag/tbx/tbisoft.S                 |  237 -----
 arch/metag/tbx/tbistring.c               |  114 ---
 arch/metag/tbx/tbitimer.S                |  207 -----
 179 files changed, 25078 deletions(-)
 delete mode 100644 arch/metag/Kconfig
 delete mode 100644 arch/metag/Kconfig.debug
 delete mode 100644 arch/metag/Kconfig.soc
 delete mode 100644 arch/metag/Makefile
 delete mode 100644 arch/metag/boot/.gitignore
 delete mode 100644 arch/metag/boot/Makefile
 delete mode 100644 arch/metag/boot/dts/Makefile
 delete mode 100644 arch/metag/boot/dts/skeleton.dts
 delete mode 100644 arch/metag/boot/dts/skeleton.dtsi
 delete mode 100644 arch/metag/boot/dts/tz1090.dtsi
 delete mode 100644 arch/metag/boot/dts/tz1090_generic.dts
 delete mode 100644 arch/metag/configs/meta1_defconfig
 delete mode 100644 arch/metag/configs/meta2_defconfig
 delete mode 100644 arch/metag/configs/meta2_smp_defconfig
 delete mode 100644 arch/metag/configs/tz1090_defconfig
 delete mode 100644 arch/metag/include/asm/Kbuild
 delete mode 100644 arch/metag/include/asm/atomic.h
 delete mode 100644 arch/metag/include/asm/atomic_lnkget.h
 delete mode 100644 arch/metag/include/asm/atomic_lock1.h
 delete mode 100644 arch/metag/include/asm/barrier.h
 delete mode 100644 arch/metag/include/asm/bitops.h
 delete mode 100644 arch/metag/include/asm/bug.h
 delete mode 100644 arch/metag/include/asm/cache.h
 delete mode 100644 arch/metag/include/asm/cacheflush.h
 delete mode 100644 arch/metag/include/asm/cachepart.h
 delete mode 100644 arch/metag/include/asm/checksum.h
 delete mode 100644 arch/metag/include/asm/clock.h
 delete mode 100644 arch/metag/include/asm/cmpxchg.h
 delete mode 100644 arch/metag/include/asm/cmpxchg_irq.h
 delete mode 100644 arch/metag/include/asm/cmpxchg_lnkget.h
 delete mode 100644 arch/metag/include/asm/cmpxchg_lock1.h
 delete mode 100644 arch/metag/include/asm/core_reg.h
 delete mode 100644 arch/metag/include/asm/cpu.h
 delete mode 100644 arch/metag/include/asm/da.h
 delete mode 100644 arch/metag/include/asm/delay.h
 delete mode 100644 arch/metag/include/asm/div64.h
 delete mode 100644 arch/metag/include/asm/dma-mapping.h
 delete mode 100644 arch/metag/include/asm/elf.h
 delete mode 100644 arch/metag/include/asm/fixmap.h
 delete mode 100644 arch/metag/include/asm/ftrace.h
 delete mode 100644 arch/metag/include/asm/global_lock.h
 delete mode 100644 arch/metag/include/asm/highmem.h
 delete mode 100644 arch/metag/include/asm/hugetlb.h
 delete mode 100644 arch/metag/include/asm/hwthread.h
 delete mode 100644 arch/metag/include/asm/io.h
 delete mode 100644 arch/metag/include/asm/irq.h
 delete mode 100644 arch/metag/include/asm/irqflags.h
 delete mode 100644 arch/metag/include/asm/l2cache.h
 delete mode 100644 arch/metag/include/asm/linkage.h
 delete mode 100644 arch/metag/include/asm/mach/arch.h
 delete mode 100644 arch/metag/include/asm/metag_isa.h
 delete mode 100644 arch/metag/include/asm/metag_mem.h
 delete mode 100644 arch/metag/include/asm/metag_regs.h
 delete mode 100644 arch/metag/include/asm/mman.h
 delete mode 100644 arch/metag/include/asm/mmu.h
 delete mode 100644 arch/metag/include/asm/mmu_context.h
 delete mode 100644 arch/metag/include/asm/mmzone.h
 delete mode 100644 arch/metag/include/asm/module.h
 delete mode 100644 arch/metag/include/asm/page.h
 delete mode 100644 arch/metag/include/asm/perf_event.h
 delete mode 100644 arch/metag/include/asm/pgalloc.h
 delete mode 100644 arch/metag/include/asm/pgtable-bits.h
 delete mode 100644 arch/metag/include/asm/pgtable.h
 delete mode 100644 arch/metag/include/asm/processor.h
 delete mode 100644 arch/metag/include/asm/ptrace.h
 delete mode 100644 arch/metag/include/asm/setup.h
 delete mode 100644 arch/metag/include/asm/smp.h
 delete mode 100644 arch/metag/include/asm/sparsemem.h
 delete mode 100644 arch/metag/include/asm/spinlock.h
 delete mode 100644 arch/metag/include/asm/spinlock_lnkget.h
 delete mode 100644 arch/metag/include/asm/spinlock_lock1.h
 delete mode 100644 arch/metag/include/asm/spinlock_types.h
 delete mode 100644 arch/metag/include/asm/stacktrace.h
 delete mode 100644 arch/metag/include/asm/string.h
 delete mode 100644 arch/metag/include/asm/switch.h
 delete mode 100644 arch/metag/include/asm/syscall.h
 delete mode 100644 arch/metag/include/asm/syscalls.h
 delete mode 100644 arch/metag/include/asm/tbx.h
 delete mode 100644 arch/metag/include/asm/tcm.h
 delete mode 100644 arch/metag/include/asm/thread_info.h
 delete mode 100644 arch/metag/include/asm/tlb.h
 delete mode 100644 arch/metag/include/asm/tlbflush.h
 delete mode 100644 arch/metag/include/asm/topology.h
 delete mode 100644 arch/metag/include/asm/traps.h
 delete mode 100644 arch/metag/include/asm/uaccess.h
 delete mode 100644 arch/metag/include/asm/unistd.h
 delete mode 100644 arch/metag/include/asm/user_gateway.h
 delete mode 100644 arch/metag/include/uapi/asm/Kbuild
 delete mode 100644 arch/metag/include/uapi/asm/byteorder.h
 delete mode 100644 arch/metag/include/uapi/asm/ech.h
 delete mode 100644 arch/metag/include/uapi/asm/ptrace.h
 delete mode 100644 arch/metag/include/uapi/asm/sigcontext.h
 delete mode 100644 arch/metag/include/uapi/asm/siginfo.h
 delete mode 100644 arch/metag/include/uapi/asm/swab.h
 delete mode 100644 arch/metag/include/uapi/asm/unistd.h
 delete mode 100644 arch/metag/kernel/.gitignore
 delete mode 100644 arch/metag/kernel/Makefile
 delete mode 100644 arch/metag/kernel/asm-offsets.c
 delete mode 100644 arch/metag/kernel/cachepart.c
 delete mode 100644 arch/metag/kernel/clock.c
 delete mode 100644 arch/metag/kernel/core_reg.c
 delete mode 100644 arch/metag/kernel/da.c
 delete mode 100644 arch/metag/kernel/devtree.c
 delete mode 100644 arch/metag/kernel/dma.c
 delete mode 100644 arch/metag/kernel/ftrace.c
 delete mode 100644 arch/metag/kernel/ftrace_stub.S
 delete mode 100644 arch/metag/kernel/head.S
 delete mode 100644 arch/metag/kernel/irq.c
 delete mode 100644 arch/metag/kernel/kick.c
 delete mode 100644 arch/metag/kernel/machines.c
 delete mode 100644 arch/metag/kernel/metag_ksyms.c
 delete mode 100644 arch/metag/kernel/module.c
 delete mode 100644 arch/metag/kernel/perf/Makefile
 delete mode 100644 arch/metag/kernel/perf/perf_event.c
 delete mode 100644 arch/metag/kernel/perf/perf_event.h
 delete mode 100644 arch/metag/kernel/perf_callchain.c
 delete mode 100644 arch/metag/kernel/process.c
 delete mode 100644 arch/metag/kernel/ptrace.c
 delete mode 100644 arch/metag/kernel/setup.c
 delete mode 100644 arch/metag/kernel/signal.c
 delete mode 100644 arch/metag/kernel/smp.c
 delete mode 100644 arch/metag/kernel/stacktrace.c
 delete mode 100644 arch/metag/kernel/sys_metag.c
 delete mode 100644 arch/metag/kernel/tbiunexp.S
 delete mode 100644 arch/metag/kernel/tcm.c
 delete mode 100644 arch/metag/kernel/time.c
 delete mode 100644 arch/metag/kernel/topology.c
 delete mode 100644 arch/metag/kernel/traps.c
 delete mode 100644 arch/metag/kernel/user_gateway.S
 delete mode 100644 arch/metag/kernel/vmlinux.lds.S
 delete mode 100644 arch/metag/lib/Makefile
 delete mode 100644 arch/metag/lib/ashldi3.S
 delete mode 100644 arch/metag/lib/ashrdi3.S
 delete mode 100644 arch/metag/lib/checksum.c
 delete mode 100644 arch/metag/lib/clear_page.S
 delete mode 100644 arch/metag/lib/cmpdi2.S
 delete mode 100644 arch/metag/lib/copy_page.S
 delete mode 100644 arch/metag/lib/delay.c
 delete mode 100644 arch/metag/lib/div64.S
 delete mode 100644 arch/metag/lib/divsi3.S
 delete mode 100644 arch/metag/lib/ip_fast_csum.S
 delete mode 100644 arch/metag/lib/lshrdi3.S
 delete mode 100644 arch/metag/lib/memcpy.S
 delete mode 100644 arch/metag/lib/memmove.S
 delete mode 100644 arch/metag/lib/memset.S
 delete mode 100644 arch/metag/lib/modsi3.S
 delete mode 100644 arch/metag/lib/muldi3.S
 delete mode 100644 arch/metag/lib/ucmpdi2.S
 delete mode 100644 arch/metag/lib/usercopy.c
 delete mode 100644 arch/metag/mm/Kconfig
 delete mode 100644 arch/metag/mm/Makefile
 delete mode 100644 arch/metag/mm/cache.c
 delete mode 100644 arch/metag/mm/extable.c
 delete mode 100644 arch/metag/mm/fault.c
 delete mode 100644 arch/metag/mm/highmem.c
 delete mode 100644 arch/metag/mm/hugetlbpage.c
 delete mode 100644 arch/metag/mm/init.c
 delete mode 100644 arch/metag/mm/ioremap.c
 delete mode 100644 arch/metag/mm/l2cache.c
 delete mode 100644 arch/metag/mm/maccess.c
 delete mode 100644 arch/metag/mm/mmu-meta1.c
 delete mode 100644 arch/metag/mm/mmu-meta2.c
 delete mode 100644 arch/metag/mm/numa.c
 delete mode 100644 arch/metag/oprofile/Makefile
 delete mode 100644 arch/metag/oprofile/backtrace.c
 delete mode 100644 arch/metag/oprofile/backtrace.h
 delete mode 100644 arch/metag/oprofile/common.c
 delete mode 100644 arch/metag/tbx/Makefile
 delete mode 100644 arch/metag/tbx/tbicore.S
 delete mode 100644 arch/metag/tbx/tbictx.S
 delete mode 100644 arch/metag/tbx/tbictxfpu.S
 delete mode 100644 arch/metag/tbx/tbidefr.S
 delete mode 100644 arch/metag/tbx/tbidspram.S
 delete mode 100644 arch/metag/tbx/tbilogf.S
 delete mode 100644 arch/metag/tbx/tbipcx.S
 delete mode 100644 arch/metag/tbx/tbiroot.S
 delete mode 100644 arch/metag/tbx/tbisoft.S
 delete mode 100644 arch/metag/tbx/tbistring.c
 delete mode 100644 arch/metag/tbx/tbitimer.S

diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
deleted file mode 100644
index c7b62a339539..000000000000
diff --git a/arch/metag/Kconfig.debug b/arch/metag/Kconfig.debug
deleted file mode 100644
index ac4516c605db..000000000000
diff --git a/arch/metag/Kconfig.soc b/arch/metag/Kconfig.soc
deleted file mode 100644
index c521f0e00d8e..000000000000
diff --git a/arch/metag/Makefile b/arch/metag/Makefile
deleted file mode 100644
index 033a58214119..000000000000
diff --git a/arch/metag/boot/.gitignore b/arch/metag/boot/.gitignore
deleted file mode 100644
index 6c662ddb909a..000000000000
diff --git a/arch/metag/boot/Makefile b/arch/metag/boot/Makefile
deleted file mode 100644
index 5a1f88cf91e3..000000000000
diff --git a/arch/metag/boot/dts/Makefile b/arch/metag/boot/dts/Makefile
deleted file mode 100644
index f0a180f62766..000000000000
diff --git a/arch/metag/boot/dts/skeleton.dts b/arch/metag/boot/dts/skeleton.dts
deleted file mode 100644
index 7a49aeb365d0..000000000000
diff --git a/arch/metag/boot/dts/skeleton.dtsi b/arch/metag/boot/dts/skeleton.dtsi
deleted file mode 100644
index 43e2ffe73c27..000000000000
diff --git a/arch/metag/boot/dts/tz1090.dtsi b/arch/metag/boot/dts/tz1090.dtsi
deleted file mode 100644
index 24ea7d2e9138..000000000000
diff --git a/arch/metag/boot/dts/tz1090_generic.dts b/arch/metag/boot/dts/tz1090_generic.dts
deleted file mode 100644
index f96090955964..000000000000
diff --git a/arch/metag/configs/meta1_defconfig b/arch/metag/configs/meta1_defconfig
deleted file mode 100644
index 01cd67e4403d..000000000000
diff --git a/arch/metag/configs/meta2_defconfig b/arch/metag/configs/meta2_defconfig
deleted file mode 100644
index 643392ba7ed5..000000000000
diff --git a/arch/metag/configs/meta2_smp_defconfig b/arch/metag/configs/meta2_smp_defconfig
deleted file mode 100644
index f3306737da20..000000000000
diff --git a/arch/metag/configs/tz1090_defconfig b/arch/metag/configs/tz1090_defconfig
deleted file mode 100644
index 9f9316a6df27..000000000000
diff --git a/arch/metag/include/asm/Kbuild b/arch/metag/include/asm/Kbuild
deleted file mode 100644
index 913c779979df..000000000000
diff --git a/arch/metag/include/asm/atomic.h b/arch/metag/include/asm/atomic.h
deleted file mode 100644
index 97ae189c2dd8..000000000000
diff --git a/arch/metag/include/asm/atomic_lnkget.h b/arch/metag/include/asm/atomic_lnkget.h
deleted file mode 100644
index 17e8c61c946d..000000000000
diff --git a/arch/metag/include/asm/atomic_lock1.h b/arch/metag/include/asm/atomic_lock1.h
deleted file mode 100644
index 2ce8fa3a79c2..000000000000
diff --git a/arch/metag/include/asm/barrier.h b/arch/metag/include/asm/barrier.h
deleted file mode 100644
index 2661fec5696a..000000000000
diff --git a/arch/metag/include/asm/bitops.h b/arch/metag/include/asm/bitops.h
deleted file mode 100644
index 766ad43010ad..000000000000
diff --git a/arch/metag/include/asm/bug.h b/arch/metag/include/asm/bug.h
deleted file mode 100644
index ee07a943f931..000000000000
diff --git a/arch/metag/include/asm/cache.h b/arch/metag/include/asm/cache.h
deleted file mode 100644
index b5df02239c8d..000000000000
diff --git a/arch/metag/include/asm/cacheflush.h b/arch/metag/include/asm/cacheflush.h
deleted file mode 100644
index 2584a51eca1a..000000000000
diff --git a/arch/metag/include/asm/cachepart.h b/arch/metag/include/asm/cachepart.h
deleted file mode 100644
index 79411e977586..000000000000
diff --git a/arch/metag/include/asm/checksum.h b/arch/metag/include/asm/checksum.h
deleted file mode 100644
index 6533d14e9789..000000000000
diff --git a/arch/metag/include/asm/clock.h b/arch/metag/include/asm/clock.h
deleted file mode 100644
index ded4ab2e1fd0..000000000000
diff --git a/arch/metag/include/asm/cmpxchg.h b/arch/metag/include/asm/cmpxchg.h
deleted file mode 100644
index 68c4ab1466fd..000000000000
diff --git a/arch/metag/include/asm/cmpxchg_irq.h b/arch/metag/include/asm/cmpxchg_irq.h
deleted file mode 100644
index 5255e37f8496..000000000000
diff --git a/arch/metag/include/asm/cmpxchg_lnkget.h b/arch/metag/include/asm/cmpxchg_lnkget.h
deleted file mode 100644
index c69be00a4739..000000000000
diff --git a/arch/metag/include/asm/cmpxchg_lock1.h b/arch/metag/include/asm/cmpxchg_lock1.h
deleted file mode 100644
index 5976e39db2b4..000000000000
diff --git a/arch/metag/include/asm/core_reg.h b/arch/metag/include/asm/core_reg.h
deleted file mode 100644
index ca70a0a29b61..000000000000
diff --git a/arch/metag/include/asm/cpu.h b/arch/metag/include/asm/cpu.h
deleted file mode 100644
index 9dac67de4748..000000000000
diff --git a/arch/metag/include/asm/da.h b/arch/metag/include/asm/da.h
deleted file mode 100644
index 901daa540e6e..000000000000
diff --git a/arch/metag/include/asm/delay.h b/arch/metag/include/asm/delay.h
deleted file mode 100644
index fd73d3d5d294..000000000000
diff --git a/arch/metag/include/asm/div64.h b/arch/metag/include/asm/div64.h
deleted file mode 100644
index e3686d2ae20e..000000000000
diff --git a/arch/metag/include/asm/dma-mapping.h b/arch/metag/include/asm/dma-mapping.h
deleted file mode 100644
index cfd6a0505b56..000000000000
diff --git a/arch/metag/include/asm/elf.h b/arch/metag/include/asm/elf.h
deleted file mode 100644
index a6c33800ba66..000000000000
diff --git a/arch/metag/include/asm/fixmap.h b/arch/metag/include/asm/fixmap.h
deleted file mode 100644
index af621b041739..000000000000
diff --git a/arch/metag/include/asm/ftrace.h b/arch/metag/include/asm/ftrace.h
deleted file mode 100644
index b1c8c76fb772..000000000000
diff --git a/arch/metag/include/asm/global_lock.h b/arch/metag/include/asm/global_lock.h
deleted file mode 100644
index 4d3da9682233..000000000000
diff --git a/arch/metag/include/asm/highmem.h b/arch/metag/include/asm/highmem.h
deleted file mode 100644
index 8b0dfd684e15..000000000000
diff --git a/arch/metag/include/asm/hugetlb.h b/arch/metag/include/asm/hugetlb.h
deleted file mode 100644
index 1607363d2639..000000000000
diff --git a/arch/metag/include/asm/hwthread.h b/arch/metag/include/asm/hwthread.h
deleted file mode 100644
index 8d2171da5414..000000000000
diff --git a/arch/metag/include/asm/io.h b/arch/metag/include/asm/io.h
deleted file mode 100644
index 71cd2bc54718..000000000000
diff --git a/arch/metag/include/asm/irq.h b/arch/metag/include/asm/irq.h
deleted file mode 100644
index cb02c29935a4..000000000000
diff --git a/arch/metag/include/asm/irqflags.h b/arch/metag/include/asm/irqflags.h
deleted file mode 100644
index e2fe34acb93b..000000000000
diff --git a/arch/metag/include/asm/l2cache.h b/arch/metag/include/asm/l2cache.h
deleted file mode 100644
index f260b158b8fe..000000000000
diff --git a/arch/metag/include/asm/linkage.h b/arch/metag/include/asm/linkage.h
deleted file mode 100644
index 3a9024ecb827..000000000000
diff --git a/arch/metag/include/asm/mach/arch.h b/arch/metag/include/asm/mach/arch.h
deleted file mode 100644
index 433f94624fa2..000000000000
diff --git a/arch/metag/include/asm/metag_isa.h b/arch/metag/include/asm/metag_isa.h
deleted file mode 100644
index c8aa2ae3899f..000000000000
diff --git a/arch/metag/include/asm/metag_mem.h b/arch/metag/include/asm/metag_mem.h
deleted file mode 100644
index 7848bc6d3b61..000000000000
diff --git a/arch/metag/include/asm/metag_regs.h b/arch/metag/include/asm/metag_regs.h
deleted file mode 100644
index 60b750971d8a..000000000000
diff --git a/arch/metag/include/asm/mman.h b/arch/metag/include/asm/mman.h
deleted file mode 100644
index dcb0d20a64fd..000000000000
diff --git a/arch/metag/include/asm/mmu.h b/arch/metag/include/asm/mmu.h
deleted file mode 100644
index cab5a01c3dcb..000000000000
diff --git a/arch/metag/include/asm/mmu_context.h b/arch/metag/include/asm/mmu_context.h
deleted file mode 100644
index 7b4766379622..000000000000
diff --git a/arch/metag/include/asm/mmzone.h b/arch/metag/include/asm/mmzone.h
deleted file mode 100644
index 8627fb532206..000000000000
diff --git a/arch/metag/include/asm/module.h b/arch/metag/include/asm/module.h
deleted file mode 100644
index e957171c320b..000000000000
diff --git a/arch/metag/include/asm/page.h b/arch/metag/include/asm/page.h
deleted file mode 100644
index 9e994d77069d..000000000000
diff --git a/arch/metag/include/asm/perf_event.h b/arch/metag/include/asm/perf_event.h
deleted file mode 100644
index 105bbff0149f..000000000000
diff --git a/arch/metag/include/asm/pgalloc.h b/arch/metag/include/asm/pgalloc.h
deleted file mode 100644
index 0b9d95d78b61..000000000000
diff --git a/arch/metag/include/asm/pgtable-bits.h b/arch/metag/include/asm/pgtable-bits.h
deleted file mode 100644
index 5f6b82282a41..000000000000
diff --git a/arch/metag/include/asm/pgtable.h b/arch/metag/include/asm/pgtable.h
deleted file mode 100644
index a3422f06c03b..000000000000
diff --git a/arch/metag/include/asm/processor.h b/arch/metag/include/asm/processor.h
deleted file mode 100644
index 9a0c502cd4a0..000000000000
diff --git a/arch/metag/include/asm/ptrace.h b/arch/metag/include/asm/ptrace.h
deleted file mode 100644
index 9074f254c9ca..000000000000
diff --git a/arch/metag/include/asm/setup.h b/arch/metag/include/asm/setup.h
deleted file mode 100644
index 504621d79ef5..000000000000
diff --git a/arch/metag/include/asm/smp.h b/arch/metag/include/asm/smp.h
deleted file mode 100644
index 8d3683d83680..000000000000
diff --git a/arch/metag/include/asm/sparsemem.h b/arch/metag/include/asm/sparsemem.h
deleted file mode 100644
index 2942894bace5..000000000000
diff --git a/arch/metag/include/asm/spinlock.h b/arch/metag/include/asm/spinlock.h
deleted file mode 100644
index 4497c232d9c1..000000000000
diff --git a/arch/metag/include/asm/spinlock_lnkget.h b/arch/metag/include/asm/spinlock_lnkget.h
deleted file mode 100644
index dfd780eab350..000000000000
diff --git a/arch/metag/include/asm/spinlock_lock1.h b/arch/metag/include/asm/spinlock_lock1.h
deleted file mode 100644
index c0bd81bbe18c..000000000000
diff --git a/arch/metag/include/asm/spinlock_types.h b/arch/metag/include/asm/spinlock_types.h
deleted file mode 100644
index cd197f1bed59..000000000000
diff --git a/arch/metag/include/asm/stacktrace.h b/arch/metag/include/asm/stacktrace.h
deleted file mode 100644
index f45e3cb2bbb5..000000000000
diff --git a/arch/metag/include/asm/string.h b/arch/metag/include/asm/string.h
deleted file mode 100644
index 86f9614d5fc6..000000000000
diff --git a/arch/metag/include/asm/switch.h b/arch/metag/include/asm/switch.h
deleted file mode 100644
index 1fd6a587c844..000000000000
diff --git a/arch/metag/include/asm/syscall.h b/arch/metag/include/asm/syscall.h
deleted file mode 100644
index 24fc97939f77..000000000000
diff --git a/arch/metag/include/asm/syscalls.h b/arch/metag/include/asm/syscalls.h
deleted file mode 100644
index eac0cf120323..000000000000
diff --git a/arch/metag/include/asm/tbx.h b/arch/metag/include/asm/tbx.h
deleted file mode 100644
index 5cd2a6c86223..000000000000
diff --git a/arch/metag/include/asm/tcm.h b/arch/metag/include/asm/tcm.h
deleted file mode 100644
index a0a4997e4b8a..000000000000
diff --git a/arch/metag/include/asm/thread_info.h b/arch/metag/include/asm/thread_info.h
deleted file mode 100644
index a1a9c7f5ca8c..000000000000
diff --git a/arch/metag/include/asm/tlb.h b/arch/metag/include/asm/tlb.h
deleted file mode 100644
index fbe6ee91e8e7..000000000000
diff --git a/arch/metag/include/asm/tlbflush.h b/arch/metag/include/asm/tlbflush.h
deleted file mode 100644
index f3e5d99a3891..000000000000
diff --git a/arch/metag/include/asm/topology.h b/arch/metag/include/asm/topology.h
deleted file mode 100644
index df0d9e6b7f12..000000000000
diff --git a/arch/metag/include/asm/traps.h b/arch/metag/include/asm/traps.h
deleted file mode 100644
index ac808740bd84..000000000000
diff --git a/arch/metag/include/asm/uaccess.h b/arch/metag/include/asm/uaccess.h
deleted file mode 100644
index a5311eb36e32..000000000000
diff --git a/arch/metag/include/asm/unistd.h b/arch/metag/include/asm/unistd.h
deleted file mode 100644
index 32955a18fb32..000000000000
diff --git a/arch/metag/include/asm/user_gateway.h b/arch/metag/include/asm/user_gateway.h
deleted file mode 100644
index cf2392b95a56..000000000000
diff --git a/arch/metag/include/uapi/asm/Kbuild b/arch/metag/include/uapi/asm/Kbuild
deleted file mode 100644
index f9eaf07d29f8..000000000000
diff --git a/arch/metag/include/uapi/asm/byteorder.h b/arch/metag/include/uapi/asm/byteorder.h
deleted file mode 100644
index e5e03ff7e20d..000000000000
diff --git a/arch/metag/include/uapi/asm/ech.h b/arch/metag/include/uapi/asm/ech.h
deleted file mode 100644
index 1e09f1ea4f7f..000000000000
diff --git a/arch/metag/include/uapi/asm/ptrace.h b/arch/metag/include/uapi/asm/ptrace.h
deleted file mode 100644
index 8ad9daa841c3..000000000000
diff --git a/arch/metag/include/uapi/asm/sigcontext.h b/arch/metag/include/uapi/asm/sigcontext.h
deleted file mode 100644
index ac7e1f28d584..000000000000
diff --git a/arch/metag/include/uapi/asm/siginfo.h b/arch/metag/include/uapi/asm/siginfo.h
deleted file mode 100644
index 9a3f6cde9487..000000000000
diff --git a/arch/metag/include/uapi/asm/swab.h b/arch/metag/include/uapi/asm/swab.h
deleted file mode 100644
index 30d696fcc237..000000000000
diff --git a/arch/metag/include/uapi/asm/unistd.h b/arch/metag/include/uapi/asm/unistd.h
deleted file mode 100644
index 9f72c4cfcfb5..000000000000
diff --git a/arch/metag/kernel/.gitignore b/arch/metag/kernel/.gitignore
deleted file mode 100644
index c5f676c3c224..000000000000
diff --git a/arch/metag/kernel/Makefile b/arch/metag/kernel/Makefile
deleted file mode 100644
index 73441d8c0369..000000000000
diff --git a/arch/metag/kernel/asm-offsets.c b/arch/metag/kernel/asm-offsets.c
deleted file mode 100644
index d9b348b99ff2..000000000000
diff --git a/arch/metag/kernel/cachepart.c b/arch/metag/kernel/cachepart.c
deleted file mode 100644
index 6e0f8a80cc96..000000000000
diff --git a/arch/metag/kernel/clock.c b/arch/metag/kernel/clock.c
deleted file mode 100644
index 6339c9c6d0ab..000000000000
diff --git a/arch/metag/kernel/core_reg.c b/arch/metag/kernel/core_reg.c
deleted file mode 100644
index df2833f2766f..000000000000
diff --git a/arch/metag/kernel/da.c b/arch/metag/kernel/da.c
deleted file mode 100644
index a35dbed6fffa..000000000000
diff --git a/arch/metag/kernel/devtree.c b/arch/metag/kernel/devtree.c
deleted file mode 100644
index 6af749a64438..000000000000
diff --git a/arch/metag/kernel/dma.c b/arch/metag/kernel/dma.c
deleted file mode 100644
index f0ab3a498328..000000000000
diff --git a/arch/metag/kernel/ftrace.c b/arch/metag/kernel/ftrace.c
deleted file mode 100644
index f7b23d300881..000000000000
diff --git a/arch/metag/kernel/ftrace_stub.S b/arch/metag/kernel/ftrace_stub.S
deleted file mode 100644
index 3acc288217c0..000000000000
diff --git a/arch/metag/kernel/head.S b/arch/metag/kernel/head.S
deleted file mode 100644
index 3ed27813413e..000000000000
diff --git a/arch/metag/kernel/irq.c b/arch/metag/kernel/irq.c
deleted file mode 100644
index 704cf17f8370..000000000000
diff --git a/arch/metag/kernel/kick.c b/arch/metag/kernel/kick.c
deleted file mode 100644
index beb377621322..000000000000
diff --git a/arch/metag/kernel/machines.c b/arch/metag/kernel/machines.c
deleted file mode 100644
index e49790181051..000000000000
diff --git a/arch/metag/kernel/metag_ksyms.c b/arch/metag/kernel/metag_ksyms.c
deleted file mode 100644
index e312386efb72..000000000000
diff --git a/arch/metag/kernel/module.c b/arch/metag/kernel/module.c
deleted file mode 100644
index bb8dfba9a763..000000000000
diff --git a/arch/metag/kernel/perf/Makefile b/arch/metag/kernel/perf/Makefile
deleted file mode 100644
index b158cb27208d..000000000000
diff --git a/arch/metag/kernel/perf/perf_event.c b/arch/metag/kernel/perf/perf_event.c
deleted file mode 100644
index 7e793eb0c1fe..000000000000
diff --git a/arch/metag/kernel/perf/perf_event.h b/arch/metag/kernel/perf/perf_event.h
deleted file mode 100644
index fd10a1345b67..000000000000
diff --git a/arch/metag/kernel/perf_callchain.c b/arch/metag/kernel/perf_callchain.c
deleted file mode 100644
index d325ba101de0..000000000000
diff --git a/arch/metag/kernel/process.c b/arch/metag/kernel/process.c
deleted file mode 100644
index 0909834c83a7..000000000000
diff --git a/arch/metag/kernel/ptrace.c b/arch/metag/kernel/ptrace.c
deleted file mode 100644
index e615603a4b0a..000000000000
diff --git a/arch/metag/kernel/setup.c b/arch/metag/kernel/setup.c
deleted file mode 100644
index 1166f1fbfd63..000000000000
diff --git a/arch/metag/kernel/signal.c b/arch/metag/kernel/signal.c
deleted file mode 100644
index e64e8b0a9363..000000000000
diff --git a/arch/metag/kernel/smp.c b/arch/metag/kernel/smp.c
deleted file mode 100644
index 2dbbb7c66043..000000000000
diff --git a/arch/metag/kernel/stacktrace.c b/arch/metag/kernel/stacktrace.c
deleted file mode 100644
index 09d67b7f51ca..000000000000
diff --git a/arch/metag/kernel/sys_metag.c b/arch/metag/kernel/sys_metag.c
deleted file mode 100644
index 27d96499dd38..000000000000
diff --git a/arch/metag/kernel/tbiunexp.S b/arch/metag/kernel/tbiunexp.S
deleted file mode 100644
index 2664808086c7..000000000000
diff --git a/arch/metag/kernel/tcm.c b/arch/metag/kernel/tcm.c
deleted file mode 100644
index 1d7b4e33b114..000000000000
diff --git a/arch/metag/kernel/time.c b/arch/metag/kernel/time.c
deleted file mode 100644
index 1e809e3b43d1..000000000000
diff --git a/arch/metag/kernel/topology.c b/arch/metag/kernel/topology.c
deleted file mode 100644
index 4ba595701f7d..000000000000
diff --git a/arch/metag/kernel/traps.c b/arch/metag/kernel/traps.c
deleted file mode 100644
index 3b62b1b0c0b5..000000000000
diff --git a/arch/metag/kernel/user_gateway.S b/arch/metag/kernel/user_gateway.S
deleted file mode 100644
index 7833fb8f9ddd..000000000000
diff --git a/arch/metag/kernel/vmlinux.lds.S b/arch/metag/kernel/vmlinux.lds.S
deleted file mode 100644
index 1efadae2ea8e..000000000000
diff --git a/arch/metag/lib/Makefile b/arch/metag/lib/Makefile
deleted file mode 100644
index 3982850d692c..000000000000
diff --git a/arch/metag/lib/ashldi3.S b/arch/metag/lib/ashldi3.S
deleted file mode 100644
index 5055df9e5c7b..000000000000
diff --git a/arch/metag/lib/ashrdi3.S b/arch/metag/lib/ashrdi3.S
deleted file mode 100644
index 0c838fd9da85..000000000000
diff --git a/arch/metag/lib/checksum.c b/arch/metag/lib/checksum.c
deleted file mode 100644
index 5d6a98a05e9d..000000000000
diff --git a/arch/metag/lib/clear_page.S b/arch/metag/lib/clear_page.S
deleted file mode 100644
index 87756a5d1367..000000000000
diff --git a/arch/metag/lib/cmpdi2.S b/arch/metag/lib/cmpdi2.S
deleted file mode 100644
index ab70bd94fd81..000000000000
diff --git a/arch/metag/lib/copy_page.S b/arch/metag/lib/copy_page.S
deleted file mode 100644
index abbc75e94374..000000000000
diff --git a/arch/metag/lib/delay.c b/arch/metag/lib/delay.c
deleted file mode 100644
index 6754012a261f..000000000000
diff --git a/arch/metag/lib/div64.S b/arch/metag/lib/div64.S
deleted file mode 100644
index 55eece273a6b..000000000000
diff --git a/arch/metag/lib/divsi3.S b/arch/metag/lib/divsi3.S
deleted file mode 100644
index 9e31abefb160..000000000000
diff --git a/arch/metag/lib/ip_fast_csum.S b/arch/metag/lib/ip_fast_csum.S
deleted file mode 100644
index 441f489d6a81..000000000000
diff --git a/arch/metag/lib/lshrdi3.S b/arch/metag/lib/lshrdi3.S
deleted file mode 100644
index cf7ffc9b377f..000000000000
diff --git a/arch/metag/lib/memcpy.S b/arch/metag/lib/memcpy.S
deleted file mode 100644
index c2e8395f9456..000000000000
diff --git a/arch/metag/lib/memmove.S b/arch/metag/lib/memmove.S
deleted file mode 100644
index 934abda0e680..000000000000
diff --git a/arch/metag/lib/memset.S b/arch/metag/lib/memset.S
deleted file mode 100644
index 6ee246d831c7..000000000000
diff --git a/arch/metag/lib/modsi3.S b/arch/metag/lib/modsi3.S
deleted file mode 100644
index d65a2e5b3154..000000000000
diff --git a/arch/metag/lib/muldi3.S b/arch/metag/lib/muldi3.S
deleted file mode 100644
index 9d106790244d..000000000000
diff --git a/arch/metag/lib/ucmpdi2.S b/arch/metag/lib/ucmpdi2.S
deleted file mode 100644
index 46f5686db8b1..000000000000
diff --git a/arch/metag/lib/usercopy.c b/arch/metag/lib/usercopy.c
deleted file mode 100644
index a48ef522c02d..000000000000
diff --git a/arch/metag/mm/Kconfig b/arch/metag/mm/Kconfig
deleted file mode 100644
index 9d4b2c67dcc1..000000000000
diff --git a/arch/metag/mm/Makefile b/arch/metag/mm/Makefile
deleted file mode 100644
index 0c7c91ba9fb9..000000000000
diff --git a/arch/metag/mm/cache.c b/arch/metag/mm/cache.c
deleted file mode 100644
index a62285284ab8..000000000000
diff --git a/arch/metag/mm/extable.c b/arch/metag/mm/extable.c
deleted file mode 100644
index 9b92d3ad7f9c..000000000000
diff --git a/arch/metag/mm/fault.c b/arch/metag/mm/fault.c
deleted file mode 100644
index de54fe686080..000000000000
diff --git a/arch/metag/mm/highmem.c b/arch/metag/mm/highmem.c
deleted file mode 100644
index 83527fc7c8a7..000000000000
diff --git a/arch/metag/mm/hugetlbpage.c b/arch/metag/mm/hugetlbpage.c
deleted file mode 100644
index 012ee4c80dc7..000000000000
diff --git a/arch/metag/mm/init.c b/arch/metag/mm/init.c
deleted file mode 100644
index 0e2ca9058998..000000000000
diff --git a/arch/metag/mm/ioremap.c b/arch/metag/mm/ioremap.c
deleted file mode 100644
index df2b59cb02eb..000000000000
diff --git a/arch/metag/mm/l2cache.c b/arch/metag/mm/l2cache.c
deleted file mode 100644
index addffc58989c..000000000000
diff --git a/arch/metag/mm/maccess.c b/arch/metag/mm/maccess.c
deleted file mode 100644
index c22755165df9..000000000000
diff --git a/arch/metag/mm/mmu-meta1.c b/arch/metag/mm/mmu-meta1.c
deleted file mode 100644
index 53190b13dc54..000000000000
diff --git a/arch/metag/mm/mmu-meta2.c b/arch/metag/mm/mmu-meta2.c
deleted file mode 100644
index 8b668a69c980..000000000000
diff --git a/arch/metag/mm/numa.c b/arch/metag/mm/numa.c
deleted file mode 100644
index 67b46c295072..000000000000
diff --git a/arch/metag/oprofile/Makefile b/arch/metag/oprofile/Makefile
deleted file mode 100644
index dc92a4a3d618..000000000000
diff --git a/arch/metag/oprofile/backtrace.c b/arch/metag/oprofile/backtrace.c
deleted file mode 100644
index 7cc3f37cb40e..000000000000
diff --git a/arch/metag/oprofile/backtrace.h b/arch/metag/oprofile/backtrace.h
deleted file mode 100644
index 60adb862aa2c..000000000000
diff --git a/arch/metag/oprofile/common.c b/arch/metag/oprofile/common.c
deleted file mode 100644
index ba26152b3c00..000000000000
diff --git a/arch/metag/tbx/Makefile b/arch/metag/tbx/Makefile
deleted file mode 100644
index 98bc5453cf24..000000000000
diff --git a/arch/metag/tbx/tbicore.S b/arch/metag/tbx/tbicore.S
deleted file mode 100644
index a0838ebcb433..000000000000
diff --git a/arch/metag/tbx/tbictx.S b/arch/metag/tbx/tbictx.S
deleted file mode 100644
index 19af983a13ae..000000000000
diff --git a/arch/metag/tbx/tbictxfpu.S b/arch/metag/tbx/tbictxfpu.S
deleted file mode 100644
index e773bea3e7bd..000000000000
diff --git a/arch/metag/tbx/tbidefr.S b/arch/metag/tbx/tbidefr.S
deleted file mode 100644
index 8f0902b22f70..000000000000
diff --git a/arch/metag/tbx/tbidspram.S b/arch/metag/tbx/tbidspram.S
deleted file mode 100644
index 2f27c0372212..000000000000
diff --git a/arch/metag/tbx/tbilogf.S b/arch/metag/tbx/tbilogf.S
deleted file mode 100644
index 4a34d80657db..000000000000
diff --git a/arch/metag/tbx/tbipcx.S b/arch/metag/tbx/tbipcx.S
deleted file mode 100644
index 163c79ac913b..000000000000
diff --git a/arch/metag/tbx/tbiroot.S b/arch/metag/tbx/tbiroot.S
deleted file mode 100644
index 7d84daf1340b..000000000000
diff --git a/arch/metag/tbx/tbisoft.S b/arch/metag/tbx/tbisoft.S
deleted file mode 100644
index b04f50df8d91..000000000000
diff --git a/arch/metag/tbx/tbistring.c b/arch/metag/tbx/tbistring.c
deleted file mode 100644
index f90cd0822065..000000000000
diff --git a/arch/metag/tbx/tbitimer.S b/arch/metag/tbx/tbitimer.S
deleted file mode 100644
index 5dbeddeee7ba..000000000000
-- 
2.13.6
