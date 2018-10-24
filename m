Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C37C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1B42082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1B42082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeJXRVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:21:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45661 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJXRVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:21:24 -0400
Received: from [185.7.230.213] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gFEvB-0004iB-TB; Wed, 24 Oct 2018 10:53:46 +0200
Date:   Wed, 24 Oct 2018 09:53:05 +0100 (BST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: [GIT pull] timekeeping upates for 4.20
Message-ID: <alpine.DEB.2.21.1810240944070.1645@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-for-linus

The timers and timekeeping departement provides:

 - Another large y2038 update with further preparations for providing the
   y2038 safe timespecs closer to the syscalls.

 - An overhaul of the SHCMT clocksource driver

 - SPDX license identifier updates

 - Small cleanups and fixes all over the place

Thanks,

	tglx

------------------>
Arnd Bergmann (14):
      y2038: remove unused time interfaces
      y2038: make do_gettimeofday() and get_seconds() inline
      y2038: globally rename compat_time to old_time32
      y2038: Remove newstat family from default syscall set
      y2038: Remove stat64 family from default syscall set
      asm-generic: Move common compat types to asm-generic/compat.h
      asm-generic: Remove unneeded __ARCH_WANT_SYS_LLSEEK macro
      asm-generic: Remove empty asm/unistd.h
      y2038: Change sys_utimensat() to use __kernel_timespec
      y2038: Compile utimes()/futimesat() conditionally
      y2038: utimes: Rework #ifdef guards for compat syscalls
      y2038: sched: Change sched_rr_get_interval to use __kernel_timespec
      y2038: socket: Change recvmmsg to use __kernel_timespec
      y2038: signal: Change rt_sigtimedwait to use __kernel_timespec

Daniel Lezcano (2):
      clocksource/drivers: Unify the names to timer-* format
      clocksource: Remove obsolete CLOCKSOURCE_OF_DECLARE

Dinh Nguyen (1):
      clocksource/drivers/dw_apb: Add reset control

Guenter Roeck (1):
      RISC-V: Request newstat syscalls

Kuninori Morimoto (4):
      clocksource/drivers/renesas-ostm: Convert to SPDX identifiers
      clocksource/drivers/sh_cmt: Convert to SPDX identifiers
      clocksource/drivers/sh_mtu2: Convert to SPDX identifiers
      clocksource/drivers/sh_tmu: Convert to SPDX identifiers

Peng Hao (2):
      tick/broadcast: Remove redundant check
      tick/sched : Remove redundant cpu_online() check

Rob Herring (1):
      clocksource: Convert to using %pOFn instead of device_node.name

Sergei Shtylyov (5):
      clocksource/drivers/sh_cmt: Fixup for 64-bit machines
      clocksource/drivers/sh_cmt: Fix clocksource width for 32-bit machines
      clocksource/drivers/sh_cmt: Properly line-wrap sh_cmt_of_table[] initializer
      dt-bindings: timer: renesas: cmt: document R-Car gen3 support
      clocksource/drivers/sh_cmt: Add R-Car gen3 support

kbuild test robot (1):
      y2038: __get_old_timespec32() can be static


 .../devicetree/bindings/timer/renesas,cmt.txt      |   7 ++
 MAINTAINERS                                        |  10 +-
 arch/alpha/include/asm/unistd.h                    |   2 +
 arch/arc/include/uapi/asm/unistd.h                 |   1 +
 arch/arm/include/asm/unistd.h                      |   4 +-
 arch/arm64/include/asm/compat.h                    |  26 +----
 arch/arm64/include/asm/stat.h                      |   2 +-
 arch/arm64/include/asm/unistd.h                    |   2 +-
 arch/arm64/include/uapi/asm/unistd.h               |   1 +
 arch/c6x/include/uapi/asm/unistd.h                 |   1 +
 arch/h8300/include/uapi/asm/unistd.h               |   1 +
 arch/hexagon/include/uapi/asm/unistd.h             |   1 +
 arch/ia64/include/asm/unistd.h                     |   3 +
 arch/m68k/include/asm/unistd.h                     |   2 +-
 arch/microblaze/include/asm/unistd.h               |   2 +-
 arch/mips/include/asm/compat.h                     |  28 +-----
 arch/mips/include/asm/unistd.h                     |   3 +-
 arch/mips/kernel/binfmt_elfn32.c                   |  14 +--
 arch/mips/kernel/binfmt_elfo32.c                   |  14 +--
 arch/nds32/include/uapi/asm/unistd.h               |   1 +
 arch/nios2/include/uapi/asm/unistd.h               |   1 +
 arch/openrisc/include/uapi/asm/unistd.h            |   1 +
 arch/parisc/include/asm/compat.h                   |  24 +----
 arch/parisc/include/asm/unistd.h                   |   3 +-
 arch/powerpc/include/asm/compat.h                  |  24 +----
 arch/powerpc/include/asm/unistd.h                  |   3 +-
 arch/powerpc/kernel/asm-offsets.c                  |   8 +-
 arch/powerpc/oprofile/backtrace.c                  |   2 +-
 arch/riscv/include/asm/unistd.h                    |   1 +
 arch/s390/include/asm/compat.h                     |  18 +---
 arch/s390/include/asm/unistd.h                     |   3 +-
 arch/sh/include/asm/unistd.h                       |   2 +-
 arch/sparc/include/asm/compat.h                    |  25 +----
 arch/sparc/include/asm/unistd.h                    |   3 +-
 arch/unicore32/include/uapi/asm/unistd.h           |   1 +
 arch/x86/include/asm/compat.h                      |  19 +---
 arch/x86/include/asm/unistd.h                      |   3 +-
 arch/xtensa/include/asm/unistd.h                   |   2 +-
 drivers/clocksource/Makefile                       |  26 ++---
 drivers/clocksource/asm9260_timer.c                |   2 +-
 drivers/clocksource/dw_apb_timer_of.c              |  20 +++-
 drivers/clocksource/pxa_timer.c                    |   6 +-
 drivers/clocksource/renesas-ostm.c                 |  11 +--
 drivers/clocksource/sh_cmt.c                       | 106 ++++++++++-----------
 drivers/clocksource/sh_mtu2.c                      |  10 +-
 drivers/clocksource/sh_tmu.c                       |  10 +-
 ...{time-armada-370-xp.c => timer-armada-370-xp.c} |   0
 .../{cadence_ttc_timer.c => timer-cadence-ttc.c}   |   2 +-
 .../clocksource/{time-efm32.c => timer-efm32.c}    |   0
 .../{fsl_ftm_timer.c => timer-fsl-ftm.c}           |   0
 drivers/clocksource/timer-integrator-ap.c          |   2 +-
 .../{time-lpc32xx.c => timer-lpc32xx.c}            |   0
 .../clocksource/{time-orion.c => timer-orion.c}    |   8 +-
 drivers/clocksource/{owl-timer.c => timer-owl.c}   |   0
 .../{time-pistachio.c => timer-pistachio.c}        |   0
 drivers/clocksource/{qcom-timer.c => timer-qcom.c} |   0
 drivers/clocksource/timer-sp804.c                  |   2 +-
 .../clocksource/{versatile.c => timer-versatile.c} |   0
 .../clocksource/{vf_pit_timer.c => timer-vf-pit.c} |   0
 .../clocksource/{vt8500_timer.c => timer-vt8500.c} |   0
 .../clocksource/{zevio-timer.c => timer-zevio.c}   |   8 +-
 fs/aio.c                                           |   8 +-
 fs/compat_binfmt_elf.c                             |   2 +-
 fs/read_write.c                                    |   2 +-
 fs/select.c                                        |  20 ++--
 fs/stat.c                                          |   3 +
 fs/timerfd.c                                       |  12 +--
 fs/utimes.c                                        |  73 +++++++-------
 include/asm-generic/compat.h                       |  24 ++++-
 include/asm-generic/unistd.h                       |  13 ---
 include/linux/clocksource.h                        |   3 -
 include/linux/compat.h                             | 101 +++++++++-----------
 include/linux/compat_time.h                        |  32 -------
 include/linux/elfcore-compat.h                     |   8 +-
 include/linux/restart_block.h                      |   4 +-
 include/linux/socket.h                             |   4 +-
 include/linux/syscalls.h                           |  21 ++--
 include/linux/time32.h                             |  78 ++++++++-------
 include/linux/timekeeping.h                        |  12 ---
 include/linux/timekeeping32.h                      |  53 ++---------
 include/uapi/asm-generic/unistd.h                  |   2 +
 ipc/mqueue.c                                       |   8 +-
 ipc/msg.c                                          |   6 +-
 ipc/sem.c                                          |  10 +-
 ipc/shm.c                                          |   6 +-
 ipc/syscall.c                                      |   2 +-
 ipc/util.h                                         |   2 +-
 kernel/compat.c                                    |   8 +-
 kernel/futex_compat.c                              |   2 +-
 kernel/sched/core.c                                |   8 +-
 kernel/signal.c                                    |  19 ++--
 kernel/time/hrtimer.c                              |   8 +-
 kernel/time/posix-stubs.c                          |  18 ++--
 kernel/time/posix-timers.c                         |  30 +++---
 kernel/time/tick-broadcast.c                       |   2 -
 kernel/time/tick-sched.c                           |   2 +-
 kernel/time/time.c                                 |  97 ++++++++-----------
 kernel/time/timekeeping.c                          |  24 -----
 net/compat.c                                       |  10 +-
 net/socket.c                                       |  18 ++--
 100 files changed, 511 insertions(+), 725 deletions(-)
 rename drivers/clocksource/{time-armada-370-xp.c => timer-armada-370-xp.c} (100%)
 rename drivers/clocksource/{cadence_ttc_timer.c => timer-cadence-ttc.c} (99%)
 rename drivers/clocksource/{time-efm32.c => timer-efm32.c} (100%)
 rename drivers/clocksource/{fsl_ftm_timer.c => timer-fsl-ftm.c} (100%)
 rename drivers/clocksource/{time-lpc32xx.c => timer-lpc32xx.c} (100%)
 rename drivers/clocksource/{time-orion.c => timer-orion.c} (95%)
 rename drivers/clocksource/{owl-timer.c => timer-owl.c} (100%)
 rename drivers/clocksource/{time-pistachio.c => timer-pistachio.c} (100%)
 rename drivers/clocksource/{qcom-timer.c => timer-qcom.c} (100%)
 rename drivers/clocksource/{versatile.c => timer-versatile.c} (100%)
 rename drivers/clocksource/{vf_pit_timer.c => timer-vf-pit.c} (100%)
 rename drivers/clocksource/{vt8500_timer.c => timer-vt8500.c} (100%)
 rename drivers/clocksource/{zevio-timer.c => timer-zevio.c} (97%)
 delete mode 100644 include/asm-generic/unistd.h
 delete mode 100644 include/linux/compat_time.h

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index b40add2d9bb4..49948fcc0631 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -34,6 +34,10 @@ Required Properties:
     - "renesas,r8a7793-cmt1" for the 48-bit CMT1 device included in r8a7793.
     - "renesas,r8a7794-cmt0" for the 32-bit CMT0 device included in r8a7794.
     - "renesas,r8a7794-cmt1" for the 48-bit CMT1 device included in r8a7794.
+    - "renesas,r8a77970-cmt0" for the 32-bit CMT0 device included in r8a77970.
+    - "renesas,r8a77970-cmt1" for the 48-bit CMT1 device included in r8a77970.
+    - "renesas,r8a77980-cmt0" for the 32-bit CMT0 device included in r8a77980.
+    - "renesas,r8a77980-cmt1" for the 48-bit CMT1 device included in r8a77980.
 
     - "renesas,rcar-gen2-cmt0" for 32-bit CMT0 devices included in R-Car Gen2
 		and RZ/G1.
@@ -41,6 +45,9 @@ Required Properties:
 		and RZ/G1.
 		These are fallbacks for r8a73a4, R-Car Gen2 and RZ/G1 entries
 		listed above.
+    - "renesas,rcar-gen3-cmt0" for 32-bit CMT0 devices included in R-Car Gen3.
+    - "renesas,rcar-gen3-cmt1" for 48-bit CMT1 devices included in R-Car Gen3.
+		These are fallbacks for R-Car Gen3 entries listed above.
 
   - reg: base address and length of the registers block for the timer module.
   - interrupts: interrupt-specifier for the timer, one per channel.
diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..67e877cccf40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1181,7 +1181,7 @@ N:	owl
 F:	arch/arm/mach-actions/
 F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
-F:	drivers/clocksource/owl-*
+F:	drivers/clocksource/timer-owl*
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
@@ -1604,7 +1604,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/lpc43*
 F:	drivers/clk/nxp/clk-lpc18xx*
-F:	drivers/clocksource/time-lpc32xx.c
+F:	drivers/clocksource/timer-lpc32xx.c
 F:	drivers/i2c/busses/i2c-lpc2k.c
 F:	drivers/memory/pl172.c
 F:	drivers/mtd/spi-nor/nxp-spifi.c
@@ -2220,7 +2220,7 @@ F:	arch/arm/mach-vexpress/
 F:	*/*/vexpress*
 F:	*/*/*/vexpress*
 F:	drivers/clk/versatile/clk-vexpress-osc.c
-F:	drivers/clocksource/versatile.c
+F:	drivers/clocksource/timer-versatile.c
 N:	mps2
 
 ARM/VFP SUPPORT
@@ -2242,7 +2242,7 @@ M:	Tony Prisk <linux@prisktech.co.nz>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-vt8500/
-F:	drivers/clocksource/vt8500_timer.c
+F:	drivers/clocksource/timer-vt8500.c
 F:	drivers/i2c/busses/i2c-wmt.c
 F:	drivers/mmc/host/wmt-sdmmc.c
 F:	drivers/pwm/pwm-vt8500.c
@@ -2307,7 +2307,7 @@ F:	drivers/cpuidle/cpuidle-zynq.c
 F:	drivers/block/xsysace.c
 N:	zynq
 N:	xilinx
-F:	drivers/clocksource/cadence_ttc_timer.c
+F:	drivers/clocksource/timer-cadence-ttc.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
 F:	drivers/edac/synopsys_edac.c
diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index d6e29a1de4cc..9ff37aa1165f 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -6,6 +6,7 @@
 
 #define NR_SYSCALLS			523
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
@@ -13,6 +14,7 @@
 #define __ARCH_WANT_SYS_GETPGRP
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arc/include/uapi/asm/unistd.h b/arch/arc/include/uapi/asm/unistd.h
index 517178b1daef..3b3543fd151c 100644
--- a/arch/arc/include/uapi/asm/unistd.h
+++ b/arch/arc/include/uapi/asm/unistd.h
@@ -17,6 +17,7 @@
 #define _UAPI_ASM_ARC_UNISTD_H
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_EXECVE
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 076090d2dbf5..88ef2ce1f69a 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -16,23 +16,23 @@
 #include <uapi/asm/unistd.h>
 #include <asm/unistd-nr.h>
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_OLD_MMAP
 #define __ARCH_WANT_SYS_OLD_SELECT
+#define __ARCH_WANT_SYS_UTIME
 
 #if !defined(CONFIG_AEABI) || defined(CONFIG_OABI_COMPAT)
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_IPC
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_ALARM
-#define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_OLD_GETRLIMIT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_SOCKETCALL
diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 1a037b94eba1..ee689d8a026d 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -25,6 +25,8 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #ifdef __AARCH64EB__
 #define COMPAT_UTS_MACHINE	"armv8b\0\0"
@@ -32,10 +34,6 @@
 #define COMPAT_UTS_MACHINE	"armv8l\0\0"
 #endif
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
 typedef u16		__compat_uid16_t;
@@ -43,27 +41,13 @@ typedef u16		__compat_gid16_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u32		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef s32		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_key_t;
-typedef s32		compat_timer_t;
-
-typedef s16		compat_short_t;
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u16		compat_ushort_t;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
 
 struct compat_stat {
 #ifdef __AARCH64EB__
@@ -86,11 +70,11 @@ struct compat_stat {
 	compat_off_t	st_size;
 	compat_off_t	st_blksize;
 	compat_off_t	st_blocks;
-	compat_time_t	st_atime;
+	old_time32_t	st_atime;
 	compat_ulong_t	st_atime_nsec;
-	compat_time_t	st_mtime;
+	old_time32_t	st_mtime;
 	compat_ulong_t	st_mtime_nsec;
-	compat_time_t	st_ctime;
+	old_time32_t	st_ctime;
 	compat_ulong_t	st_ctime_nsec;
 	compat_ulong_t	__unused4[2];
 };
diff --git a/arch/arm64/include/asm/stat.h b/arch/arm64/include/asm/stat.h
index eab738019707..397c6ccd04e7 100644
--- a/arch/arm64/include/asm/stat.h
+++ b/arch/arm64/include/asm/stat.h
@@ -20,7 +20,7 @@
 
 #ifdef CONFIG_COMPAT
 
-#include <linux/compat_time.h>
+#include <linux/time.h>
 #include <asm/compat.h>
 
 /*
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index e0d0f5b856e7..b13ca091f833 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -18,11 +18,11 @@
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
+#define __ARCH_WANT_SYS_UTIME32
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 
diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index 5072cbd15c82..dae1584cf017 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -16,5 +16,6 @@
  */
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_NEW_STAT
 
 #include <asm-generic/unistd.h>
diff --git a/arch/c6x/include/uapi/asm/unistd.h b/arch/c6x/include/uapi/asm/unistd.h
index 0d2daf7f9809..6b2fe792de9d 100644
--- a/arch/c6x/include/uapi/asm/unistd.h
+++ b/arch/c6x/include/uapi/asm/unistd.h
@@ -16,6 +16,7 @@
  */
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_CLONE
 
 /* Use the standard ABI for syscalls. */
diff --git a/arch/h8300/include/uapi/asm/unistd.h b/arch/h8300/include/uapi/asm/unistd.h
index 7dd20ef7625a..628195823816 100644
--- a/arch/h8300/include/uapi/asm/unistd.h
+++ b/arch/h8300/include/uapi/asm/unistd.h
@@ -1,5 +1,6 @@
 #define __ARCH_NOMMU
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
 
 #include <asm-generic/unistd.h>
diff --git a/arch/hexagon/include/uapi/asm/unistd.h b/arch/hexagon/include/uapi/asm/unistd.h
index ea181e79162e..c91ca7d02461 100644
--- a/arch/hexagon/include/uapi/asm/unistd.h
+++ b/arch/hexagon/include/uapi/asm/unistd.h
@@ -29,6 +29,7 @@
 
 #define sys_mmap2 sys_mmap_pgoff
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_EXECVE
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index ffb705dc9c13..49e34db2529c 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -28,6 +28,9 @@
 #define __IGNORE_vfork		/* clone() */
 #define __IGNORE_umount2	/* umount() */
 
+#define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SYS_UTIME
+
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
 #include <linux/types.h>
diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index 30d0d3fbd4ef..e680031bda7b 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -7,6 +7,7 @@
 
 #define NR_syscalls		380
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_OLD_STAT
 #define __ARCH_WANT_STAT64
@@ -21,7 +22,6 @@
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLD_GETRLIMIT
 #define __ARCH_WANT_SYS_OLD_MMAP
diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/include/asm/unistd.h
index a62d09420a47..f42c40f5001b 100644
--- a/arch/microblaze/include/asm/unistd.h
+++ b/arch/microblaze/include/asm/unistd.h
@@ -15,6 +15,7 @@
 
 /* #define __ARCH_WANT_OLD_READDIR */
 /* #define __ARCH_WANT_OLD_STAT */
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
@@ -26,7 +27,6 @@
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 /* #define __ARCH_WANT_SYS_OLD_GETRLIMIT */
 #define __ARCH_WANT_SYS_OLDUMOUNT
diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 78675f19440f..c99166eadbde 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -9,43 +9,25 @@
 #include <asm/page.h>
 #include <asm/ptrace.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"mips\0\0\0"
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_suseconds_t;
-
-typedef s32		compat_pid_t;
 typedef s32		__compat_uid_t;
 typedef s32		__compat_gid_t;
 typedef __compat_uid_t	__compat_uid32_t;
 typedef __compat_gid_t	__compat_gid32_t;
 typedef u32		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u32		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef u32		compat_nlink_t;
 typedef s32		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef s32		compat_caddr_t;
 typedef struct {
 	s32	val[2];
 } compat_fsid_t;
-typedef s32		compat_timer_t;
-typedef s32		compat_key_t;
-
-typedef s16		compat_short_t;
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u16		compat_ushort_t;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
 
 struct compat_stat {
 	compat_dev_t	st_dev;
@@ -59,11 +41,11 @@ struct compat_stat {
 	s32		st_pad2[2];
 	compat_off_t	st_size;
 	s32		st_pad3;
-	compat_time_t	st_atime;
+	old_time32_t	st_atime;
 	s32		st_atime_nsec;
-	compat_time_t	st_mtime;
+	old_time32_t	st_mtime;
 	s32		st_mtime_nsec;
-	compat_time_t	st_ctime;
+	old_time32_t	st_ctime;
 	s32		st_ctime_nsec;
 	s32		st_blksize;
 	s32		st_blocks;
diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index 3c09450908aa..c68b8ae3efcb 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -24,16 +24,17 @@
 
 #ifndef __ASSEMBLY__
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_IPC
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_UTIME32
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLD_UNAME
 #define __ARCH_WANT_SYS_OLDUMOUNT
diff --git a/arch/mips/kernel/binfmt_elfn32.c b/arch/mips/kernel/binfmt_elfn32.c
index 89b234844534..7a12763d553a 100644
--- a/arch/mips/kernel/binfmt_elfn32.c
+++ b/arch/mips/kernel/binfmt_elfn32.c
@@ -54,10 +54,10 @@ struct elf_prstatus32
 	pid_t	pr_ppid;
 	pid_t	pr_pgrp;
 	pid_t	pr_sid;
-	struct compat_timeval pr_utime; /* User time */
-	struct compat_timeval pr_stime; /* System time */
-	struct compat_timeval pr_cutime;/* Cumulative user time */
-	struct compat_timeval pr_cstime;/* Cumulative system time */
+	struct old_timeval32 pr_utime; /* User time */
+	struct old_timeval32 pr_stime; /* System time */
+	struct old_timeval32 pr_cutime;/* Cumulative user time */
+	struct old_timeval32 pr_cstime;/* Cumulative system time */
 	elf_gregset_t pr_reg;	/* GP registers */
 	int pr_fpvalid;		/* True if math co-processor being used.  */
 };
@@ -81,9 +81,9 @@ struct elf_prpsinfo32
 #define elf_caddr_t	u32
 #define init_elf_binfmt init_elfn32_binfmt
 
-#define jiffies_to_timeval jiffies_to_compat_timeval
+#define jiffies_to_timeval jiffies_to_old_timeval32
 static __inline__ void
-jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
+jiffies_to_old_timeval32(unsigned long jiffies, struct old_timeval32 *value)
 {
 	/*
 	 * Convert jiffies to nanoseconds and separate with
@@ -101,6 +101,6 @@ jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
 #define TASK_SIZE TASK_SIZE32
 
 #undef ns_to_timeval
-#define ns_to_timeval ns_to_compat_timeval
+#define ns_to_timeval ns_to_old_timeval32
 
 #include "../../../fs/binfmt_elf.c"
diff --git a/arch/mips/kernel/binfmt_elfo32.c b/arch/mips/kernel/binfmt_elfo32.c
index a88c59db3d48..e6db06a1d31a 100644
--- a/arch/mips/kernel/binfmt_elfo32.c
+++ b/arch/mips/kernel/binfmt_elfo32.c
@@ -59,10 +59,10 @@ struct elf_prstatus32
 	pid_t	pr_ppid;
 	pid_t	pr_pgrp;
 	pid_t	pr_sid;
-	struct compat_timeval pr_utime; /* User time */
-	struct compat_timeval pr_stime; /* System time */
-	struct compat_timeval pr_cutime;/* Cumulative user time */
-	struct compat_timeval pr_cstime;/* Cumulative system time */
+	struct old_timeval32 pr_utime; /* User time */
+	struct old_timeval32 pr_stime; /* System time */
+	struct old_timeval32 pr_cutime;/* Cumulative user time */
+	struct old_timeval32 pr_cstime;/* Cumulative system time */
 	elf_gregset_t pr_reg;	/* GP registers */
 	int pr_fpvalid;		/* True if math co-processor being used.  */
 };
@@ -86,9 +86,9 @@ struct elf_prpsinfo32
 #define elf_caddr_t	u32
 #define init_elf_binfmt init_elf32_binfmt
 
-#define jiffies_to_timeval jiffies_to_compat_timeval
+#define jiffies_to_timeval jiffies_to_old_timeval32
 static inline void
-jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
+jiffies_to_old_timeval32(unsigned long jiffies, struct old_timeval32 *value)
 {
 	/*
 	 * Convert jiffies to nanoseconds and separate with
@@ -104,6 +104,6 @@ jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
 #define TASK_SIZE TASK_SIZE32
 
 #undef ns_to_timeval
-#define ns_to_timeval ns_to_compat_timeval
+#define ns_to_timeval ns_to_old_timeval32
 
 #include "../../../fs/binfmt_elf.c"
diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
index 6e95901cabe3..603e826e0449 100644
--- a/arch/nds32/include/uapi/asm/unistd.h
+++ b/arch/nds32/include/uapi/asm/unistd.h
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYNC_FILE_RANGE2
 
 /* Use the standard ABI for syscalls */
diff --git a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
index b6bdae04bc84..d9948d88790b 100644
--- a/arch/nios2/include/uapi/asm/unistd.h
+++ b/arch/nios2/include/uapi/asm/unistd.h
@@ -19,6 +19,7 @@
  #define sys_mmap2 sys_mmap_pgoff
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
 
 /* Use the standard ABI for syscalls */
 #include <asm-generic/unistd.h>
diff --git a/arch/openrisc/include/uapi/asm/unistd.h b/arch/openrisc/include/uapi/asm/unistd.h
index 11c5a58ab333..ec37df18d8ed 100644
--- a/arch/openrisc/include/uapi/asm/unistd.h
+++ b/arch/openrisc/include/uapi/asm/unistd.h
@@ -20,6 +20,7 @@
 #define sys_mmap2 sys_mmap_pgoff
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_CLONE
 
diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index ab8a54771507..e03e3c849f40 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -8,36 +8,22 @@
 #include <linux/sched.h>
 #include <linux/thread_info.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ 		100
 #define COMPAT_UTS_MACHINE	"parisc\0\0"
 
-typedef u32	compat_size_t;
-typedef s32	compat_ssize_t;
-typedef s32	compat_clock_t;
-typedef s32	compat_pid_t;
 typedef u32	__compat_uid_t;
 typedef u32	__compat_gid_t;
 typedef u32	__compat_uid32_t;
 typedef u32	__compat_gid32_t;
 typedef u16	compat_mode_t;
-typedef u32	compat_ino_t;
 typedef u32	compat_dev_t;
-typedef s32	compat_off_t;
-typedef s64	compat_loff_t;
 typedef u16	compat_nlink_t;
 typedef u16	compat_ipc_pid_t;
-typedef s32	compat_daddr_t;
 typedef u32	compat_caddr_t;
-typedef s32	compat_key_t;
-typedef s32	compat_timer_t;
-
-typedef s32	compat_int_t;
-typedef s32	compat_long_t;
 typedef s64	compat_s64;
-typedef u32	compat_uint_t;
-typedef u32	compat_ulong_t;
 typedef u64	compat_u64;
-typedef u32	compat_uptr_t;
 
 struct compat_stat {
 	compat_dev_t		st_dev;	/* dev_t is 32 bits on parisc */
@@ -48,11 +34,11 @@ struct compat_stat {
 	u16			st_reserved2;	/* old st_gid */
 	compat_dev_t		st_rdev;
 	compat_off_t		st_size;
-	compat_time_t		st_atime;
+	old_time32_t		st_atime;
 	u32			st_atime_nsec;
-	compat_time_t		st_mtime;
+	old_time32_t		st_mtime;
 	u32			st_mtime_nsec;
-	compat_time_t		st_ctime;
+	old_time32_t		st_ctime;
 	u32			st_ctime_nsec;
 	s32			st_blksize;
 	s32			st_blocks;
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 3d507d04eb4c..bc37a4953eaa 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -141,6 +141,7 @@ type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
     return K_INLINE_SYSCALL(name, 5, arg1, arg2, arg3, arg4, arg5);	\
 }
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
@@ -151,11 +152,11 @@ type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
 #define __ARCH_WANT_COMPAT_SYS_TIME
 #define __ARCH_WANT_COMPAT_SYS_SCHED_RR_GET_INTERVAL
 #define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_UTIME32
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 85c8af2bb272..74d0db511099 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -8,6 +8,8 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #ifdef __BIG_ENDIAN__
 #define COMPAT_UTS_MACHINE	"ppc\0\0"
@@ -15,34 +17,18 @@
 #define COMPAT_UTS_MACHINE	"ppcle\0\0"
 #endif
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u32		__compat_uid_t;
 typedef u32		__compat_gid_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u32		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u32		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef s16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_key_t;
-typedef s32		compat_timer_t;
-
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
 
 struct compat_stat {
 	compat_dev_t	st_dev;
@@ -55,11 +41,11 @@ struct compat_stat {
 	compat_off_t	st_size;
 	compat_off_t	st_blksize;
 	compat_off_t	st_blocks;
-	compat_time_t	st_atime;
+	old_time32_t	st_atime;
 	u32		st_atime_nsec;
-	compat_time_t	st_mtime;
+	old_time32_t	st_mtime;
 	u32		st_mtime_nsec;
-	compat_time_t	st_ctime;
+	old_time32_t	st_ctime;
 	u32		st_ctime_nsec;
 	u32		__unused4[2];
 };
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index c19379f0a32e..b0de85b477e1 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -22,6 +22,7 @@
 #include <linux/compiler.h>
 #include <linux/linkage.h>
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
@@ -35,7 +36,6 @@
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLD_GETRLIMIT
 #define __ARCH_WANT_SYS_OLD_UNAME
@@ -47,6 +47,7 @@
 #endif
 #ifdef CONFIG_PPC64
 #define __ARCH_WANT_COMPAT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME32
 #define __ARCH_WANT_SYS_NEWFSTATAT
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #endif
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 89cf15566c4e..041a115789a1 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -387,12 +387,12 @@ int main(void)
 	OFFSET(CFG_SYSCALL_MAP64, vdso_data, syscall_map_64);
 	OFFSET(TVAL64_TV_SEC, timeval, tv_sec);
 	OFFSET(TVAL64_TV_USEC, timeval, tv_usec);
-	OFFSET(TVAL32_TV_SEC, compat_timeval, tv_sec);
-	OFFSET(TVAL32_TV_USEC, compat_timeval, tv_usec);
+	OFFSET(TVAL32_TV_SEC, old_timeval32, tv_sec);
+	OFFSET(TVAL32_TV_USEC, old_timeval32, tv_usec);
 	OFFSET(TSPC64_TV_SEC, timespec, tv_sec);
 	OFFSET(TSPC64_TV_NSEC, timespec, tv_nsec);
-	OFFSET(TSPC32_TV_SEC, compat_timespec, tv_sec);
-	OFFSET(TSPC32_TV_NSEC, compat_timespec, tv_nsec);
+	OFFSET(TSPC32_TV_SEC, old_timespec32, tv_sec);
+	OFFSET(TSPC32_TV_NSEC, old_timespec32, tv_nsec);
 #else
 	OFFSET(TVAL32_TV_SEC, timeval, tv_sec);
 	OFFSET(TVAL32_TV_USEC, timeval, tv_usec);
diff --git a/arch/powerpc/oprofile/backtrace.c b/arch/powerpc/oprofile/backtrace.c
index ad054dd0d666..5df6290d1ccc 100644
--- a/arch/powerpc/oprofile/backtrace.c
+++ b/arch/powerpc/oprofile/backtrace.c
@@ -7,7 +7,7 @@
  * 2 of the License, or (at your option) any later version.
 **/
 
-#include <linux/compat_time.h>
+#include <linux/time.h>
 #include <linux/oprofile.h>
 #include <linux/sched.h>
 #include <asm/processor.h>
diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index 0caea01d5cca..eff7aa9aa163 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -16,6 +16,7 @@
  * be included multiple times.  See uapi/asm/syscalls.h for more info.
  */
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_CLONE
 #include <uapi/asm/unistd.h>
 #include <uapi/asm/syscalls.h>
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 97db2fba546a..63b46e30b2c3 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -9,6 +9,8 @@
 #include <linux/sched/task_stack.h>
 #include <linux/thread_info.h>
 
+#include <asm-generic/compat.h>
+
 #define __TYPE_IS_PTR(t) (!__builtin_types_compatible_p( \
 				typeof(0?(__force t)0:0ULL), u64))
 
@@ -51,34 +53,18 @@
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"s390\0\0\0\0"
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef u16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_key_t;
-typedef s32		compat_timer_t;
-
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
 
 typedef struct {
 	u32 mask;
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index fd79c0d35dc4..a1fbf15d53aa 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -15,6 +15,7 @@
 #define __IGNORE_pkey_alloc
 #define __IGNORE_pkey_free
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
@@ -25,7 +26,6 @@
 #define __ARCH_WANT_SYS_IPC
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLD_GETRLIMIT
 #define __ARCH_WANT_SYS_OLD_MMAP
@@ -34,6 +34,7 @@
 #define __ARCH_WANT_SYS_SIGPROCMASK
 # ifdef CONFIG_COMPAT
 #   define __ARCH_WANT_COMPAT_SYS_TIME
+#   define __ARCH_WANT_SYS_UTIME32
 # endif
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/sh/include/asm/unistd.h b/arch/sh/include/asm/unistd.h
index b36200af9ce7..a99234b61051 100644
--- a/arch/sh/include/asm/unistd.h
+++ b/arch/sh/include/asm/unistd.h
@@ -5,6 +5,7 @@
 #  include <asm/unistd_64.h>
 # endif
 
+# define __ARCH_WANT_NEW_STAT
 # define __ARCH_WANT_OLD_READDIR
 # define __ARCH_WANT_OLD_STAT
 # define __ARCH_WANT_STAT64
@@ -19,7 +20,6 @@
 # define __ARCH_WANT_SYS_SOCKETCALL
 # define __ARCH_WANT_SYS_FADVISE64
 # define __ARCH_WANT_SYS_GETPGRP
-# define __ARCH_WANT_SYS_LLSEEK
 # define __ARCH_WANT_SYS_NICE
 # define __ARCH_WANT_SYS_OLD_GETRLIMIT
 # define __ARCH_WANT_SYS_OLD_UNAME
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 4eb51d2dae98..30b1763580b1 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -6,38 +6,23 @@
  */
 #include <linux/types.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"sparc\0\0"
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef s16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_key_t;
-typedef s32		compat_timer_t;
-
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
-
 struct compat_stat {
 	compat_dev_t	st_dev;
 	compat_ino_t	st_ino;
@@ -47,11 +32,11 @@ struct compat_stat {
 	__compat_gid_t	st_gid;
 	compat_dev_t	st_rdev;
 	compat_off_t	st_size;
-	compat_time_t	st_atime;
+	old_time32_t	st_atime;
 	compat_ulong_t	st_atime_nsec;
-	compat_time_t	st_mtime;
+	old_time32_t	st_mtime;
 	compat_ulong_t	st_mtime_nsec;
-	compat_time_t	st_ctime;
+	old_time32_t	st_ctime;
 	compat_ulong_t	st_ctime_nsec;
 	compat_off_t	st_blksize;
 	compat_off_t	st_blocks;
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index b2a6a955113e..00f87dbd0b17 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -21,6 +21,7 @@
 #else
 #define __NR_time		231 /* Linux sparc32                               */
 #endif
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
@@ -33,7 +34,6 @@
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
@@ -42,6 +42,7 @@
 #define __ARCH_WANT_SYS_IPC
 #else
 #define __ARCH_WANT_COMPAT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME32
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #endif
 
diff --git a/arch/unicore32/include/uapi/asm/unistd.h b/arch/unicore32/include/uapi/asm/unistd.h
index 65856eaab163..1e8fe5941b8a 100644
--- a/arch/unicore32/include/uapi/asm/unistd.h
+++ b/arch/unicore32/include/uapi/asm/unistd.h
@@ -15,4 +15,5 @@
 
 /* Use the standard ABI for syscalls. */
 #include <asm-generic/unistd.h>
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index fb97cf7c4137..0ce6f452d334 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -12,38 +12,23 @@
 #include <asm/user32.h>
 #include <asm/unistd.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"i686\0\0"
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef u16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_timer_t;
-typedef s32		compat_key_t;
-
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64 __attribute__((aligned(4))) compat_s64;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
-typedef u32		compat_u32;
 typedef u64 __attribute__((aligned(4))) compat_u64;
-typedef u32		compat_uptr_t;
 
 struct compat_stat {
 	compat_dev_t	st_dev;
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 51c4eee00732..dc4ed8bc2382 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -24,6 +24,7 @@
 #  include <asm/unistd_64.h>
 #  include <asm/unistd_64_x32.h>
 #  define __ARCH_WANT_COMPAT_SYS_TIME
+#  define __ARCH_WANT_SYS_UTIME32
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
@@ -31,13 +32,13 @@
 
 # endif
 
+# define __ARCH_WANT_NEW_STAT
 # define __ARCH_WANT_OLD_READDIR
 # define __ARCH_WANT_OLD_STAT
 # define __ARCH_WANT_SYS_ALARM
 # define __ARCH_WANT_SYS_FADVISE64
 # define __ARCH_WANT_SYS_GETHOSTNAME
 # define __ARCH_WANT_SYS_GETPGRP
-# define __ARCH_WANT_SYS_LLSEEK
 # define __ARCH_WANT_SYS_NICE
 # define __ARCH_WANT_SYS_OLDUMOUNT
 # define __ARCH_WANT_SYS_OLD_GETRLIMIT
diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index ed66db3bc9bb..574e5520968c 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -5,9 +5,9 @@
 #define __ARCH_WANT_SYS_CLONE
 #include <uapi/asm/unistd.h>
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_UTIME
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_GETPGRP
 
 /* 
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index db51b2427e8a..e33b21d3f9d8 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -23,8 +23,8 @@ obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
 obj-$(CONFIG_ROCKCHIP_TIMER)      += rockchip_timer.o
 obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
-obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
-obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
+obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= timer-armada-370-xp.o
+obj-$(CONFIG_ORION_TIMER)	+= timer-orion.o
 obj-$(CONFIG_BCM2835_TIMER)	+= bcm2835_timer.o
 obj-$(CONFIG_CLPS711X_TIMER)	+= clps711x-timer.o
 obj-$(CONFIG_ATLAS7_TIMER)	+= timer-atlas7.o
@@ -36,25 +36,25 @@ obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= meson6_timer.o
 obj-$(CONFIG_TEGRA_TIMER)	+= tegra20_timer.o
-obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
-obj-$(CONFIG_NSPIRE_TIMER)	+= zevio-timer.o
+obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
+obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
 obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
-obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence_ttc_timer.o
-obj-$(CONFIG_CLKSRC_EFM32)	+= time-efm32.o
+obj-$(CONFIG_CADENCE_TTC_TIMER)	+= timer-cadence-ttc.o
+obj-$(CONFIG_CLKSRC_EFM32)	+= timer-efm32.o
 obj-$(CONFIG_CLKSRC_STM32)	+= timer-stm32.o
 obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
-obj-$(CONFIG_CLKSRC_LPC32XX)	+= time-lpc32xx.o
+obj-$(CONFIG_CLKSRC_LPC32XX)	+= timer-lpc32xx.o
 obj-$(CONFIG_CLKSRC_MPS2)	+= mps2-timer.o
 obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+= samsung_pwm_timer.o
-obj-$(CONFIG_FSL_FTM_TIMER)	+= fsl_ftm_timer.o
-obj-$(CONFIG_VF_PIT_TIMER)	+= vf_pit_timer.o
-obj-$(CONFIG_CLKSRC_QCOM)	+= qcom-timer.o
+obj-$(CONFIG_FSL_FTM_TIMER)	+= timer-fsl-ftm.o
+obj-$(CONFIG_VF_PIT_TIMER)	+= timer-vf-pit.o
+obj-$(CONFIG_CLKSRC_QCOM)	+= timer-qcom.o
 obj-$(CONFIG_MTK_TIMER)		+= timer-mediatek.o
-obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
+obj-$(CONFIG_CLKSRC_PISTACHIO)	+= timer-pistachio.o
 obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
 obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
 obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
-obj-$(CONFIG_OWL_TIMER)		+= owl-timer.o
+obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
 obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
 obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
 
@@ -66,7 +66,7 @@ obj-$(CONFIG_ARM_TIMER_SP804)		+= timer-sp804.o
 obj-$(CONFIG_ARCH_HAS_TICK_BROADCAST)	+= dummy_timer.o
 obj-$(CONFIG_KEYSTONE_TIMER)		+= timer-keystone.o
 obj-$(CONFIG_INTEGRATOR_AP_TIMER)	+= timer-integrator-ap.o
-obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
+obj-$(CONFIG_CLKSRC_VERSATILE)		+= timer-versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
 obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= tango_xtal.o
 obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
diff --git a/drivers/clocksource/asm9260_timer.c b/drivers/clocksource/asm9260_timer.c
index 38cd2feb87c4..fbaee04fd1d9 100644
--- a/drivers/clocksource/asm9260_timer.c
+++ b/drivers/clocksource/asm9260_timer.c
@@ -193,7 +193,7 @@ static int __init asm9260_timer_init(struct device_node *np)
 
 	priv.base = of_io_request_and_map(np, 0, np->name);
 	if (IS_ERR(priv.base)) {
-		pr_err("%s: unable to map resource\n", np->name);
+		pr_err("%pOFn: unable to map resource\n", np);
 		return PTR_ERR(priv.base);
 	}
 
diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 69866cd8f4bb..db410acd8964 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -22,6 +22,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/sched_clock.h>
 
 static void __init timer_get_base_and_rate(struct device_node *np,
@@ -29,11 +30,22 @@ static void __init timer_get_base_and_rate(struct device_node *np,
 {
 	struct clk *timer_clk;
 	struct clk *pclk;
+	struct reset_control *rstc;
 
 	*base = of_iomap(np, 0);
 
 	if (!*base)
-		panic("Unable to map regs for %s", np->name);
+		panic("Unable to map regs for %pOFn", np);
+
+	/*
+	 * Reset the timer if the reset control is available, wiping
+	 * out the state the firmware may have left it
+	 */
+	rstc = of_reset_control_get(np, NULL);
+	if (!IS_ERR(rstc)) {
+		reset_control_assert(rstc);
+		reset_control_deassert(rstc);
+	}
 
 	/*
 	 * Not all implementations use a periphal clock, so don't panic
@@ -42,8 +54,8 @@ static void __init timer_get_base_and_rate(struct device_node *np,
 	pclk = of_clk_get_by_name(np, "pclk");
 	if (!IS_ERR(pclk))
 		if (clk_prepare_enable(pclk))
-			pr_warn("pclk for %s is present, but could not be activated\n",
-				np->name);
+			pr_warn("pclk for %pOFn is present, but could not be activated\n",
+				np);
 
 	timer_clk = of_clk_get_by_name(np, "timer");
 	if (IS_ERR(timer_clk))
@@ -57,7 +69,7 @@ static void __init timer_get_base_and_rate(struct device_node *np,
 try_clock_freq:
 	if (of_property_read_u32(np, "clock-freq", rate) &&
 	    of_property_read_u32(np, "clock-frequency", rate))
-		panic("No clock nor clock-frequency property for %s", np->name);
+		panic("No clock nor clock-frequency property for %pOFn", np);
 }
 
 static void __init add_clockevent(struct device_node *event_timer)
diff --git a/drivers/clocksource/pxa_timer.c b/drivers/clocksource/pxa_timer.c
index 08cd6eaf3795..395837938301 100644
--- a/drivers/clocksource/pxa_timer.c
+++ b/drivers/clocksource/pxa_timer.c
@@ -191,13 +191,13 @@ static int __init pxa_timer_dt_init(struct device_node *np)
 	/* timer registers are shared with watchdog timer */
 	timer_base = of_iomap(np, 0);
 	if (!timer_base) {
-		pr_err("%s: unable to map resource\n", np->name);
+		pr_err("%pOFn: unable to map resource\n", np);
 		return -ENXIO;
 	}
 
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
-		pr_crit("%s: unable to get clk\n", np->name);
+		pr_crit("%pOFn: unable to get clk\n", np);
 		return PTR_ERR(clk);
 	}
 
@@ -210,7 +210,7 @@ static int __init pxa_timer_dt_init(struct device_node *np)
 	/* we are only interested in OS-timer0 irq */
 	irq = irq_of_parse_and_map(np, 0);
 	if (irq <= 0) {
-		pr_crit("%s: unable to parse OS-timer0 irq\n", np->name);
+		pr_crit("%pOFn: unable to parse OS-timer0 irq\n", np);
 		return -EINVAL;
 	}
 
diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 6cffd7c6001a..61d5f3b539ce 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Timer Support - OSTM
  *
  * Copyright (C) 2017 Renesas Electronics America, Inc.
  * Copyright (C) 2017 Chris Brandt
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 #include <linux/of_address.h>
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index bbbf37c471a3..55d3e03f2cd4 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SuperH Timer Support - CMT
  *
  *  Copyright (C) 2008 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/clk.h>
@@ -78,18 +70,17 @@ struct sh_cmt_info {
 	unsigned int channels_mask;
 
 	unsigned long width; /* 16 or 32 bit version of hardware block */
-	unsigned long overflow_bit;
-	unsigned long clear_bits;
+	u32 overflow_bit;
+	u32 clear_bits;
 
 	/* callbacks for CMSTR and CMCSR access */
-	unsigned long (*read_control)(void __iomem *base, unsigned long offs);
+	u32 (*read_control)(void __iomem *base, unsigned long offs);
 	void (*write_control)(void __iomem *base, unsigned long offs,
-			      unsigned long value);
+			      u32 value);
 
 	/* callbacks for CMCNT and CMCOR access */
-	unsigned long (*read_count)(void __iomem *base, unsigned long offs);
-	void (*write_count)(void __iomem *base, unsigned long offs,
-			    unsigned long value);
+	u32 (*read_count)(void __iomem *base, unsigned long offs);
+	void (*write_count)(void __iomem *base, unsigned long offs, u32 value);
 };
 
 struct sh_cmt_channel {
@@ -103,13 +94,13 @@ struct sh_cmt_channel {
 
 	unsigned int timer_bit;
 	unsigned long flags;
-	unsigned long match_value;
-	unsigned long next_match_value;
-	unsigned long max_match_value;
+	u32 match_value;
+	u32 next_match_value;
+	u32 max_match_value;
 	raw_spinlock_t lock;
 	struct clock_event_device ced;
 	struct clocksource cs;
-	unsigned long total_cycles;
+	u64 total_cycles;
 	bool cs_enabled;
 };
 
@@ -160,24 +151,22 @@ struct sh_cmt_device {
 #define SH_CMT32_CMCSR_CKS_RCLK1	(7 << 0)
 #define SH_CMT32_CMCSR_CKS_MASK		(7 << 0)
 
-static unsigned long sh_cmt_read16(void __iomem *base, unsigned long offs)
+static u32 sh_cmt_read16(void __iomem *base, unsigned long offs)
 {
 	return ioread16(base + (offs << 1));
 }
 
-static unsigned long sh_cmt_read32(void __iomem *base, unsigned long offs)
+static u32 sh_cmt_read32(void __iomem *base, unsigned long offs)
 {
 	return ioread32(base + (offs << 2));
 }
 
-static void sh_cmt_write16(void __iomem *base, unsigned long offs,
-			   unsigned long value)
+static void sh_cmt_write16(void __iomem *base, unsigned long offs, u32 value)
 {
 	iowrite16(value, base + (offs << 1));
 }
 
-static void sh_cmt_write32(void __iomem *base, unsigned long offs,
-			   unsigned long value)
+static void sh_cmt_write32(void __iomem *base, unsigned long offs, u32 value)
 {
 	iowrite32(value, base + (offs << 2));
 }
@@ -242,7 +231,7 @@ static const struct sh_cmt_info sh_cmt_info[] = {
 #define CMCNT 1 /* channel register */
 #define CMCOR 2 /* channel register */
 
-static inline unsigned long sh_cmt_read_cmstr(struct sh_cmt_channel *ch)
+static inline u32 sh_cmt_read_cmstr(struct sh_cmt_channel *ch)
 {
 	if (ch->iostart)
 		return ch->cmt->info->read_control(ch->iostart, 0);
@@ -250,8 +239,7 @@ static inline unsigned long sh_cmt_read_cmstr(struct sh_cmt_channel *ch)
 		return ch->cmt->info->read_control(ch->cmt->mapbase, 0);
 }
 
-static inline void sh_cmt_write_cmstr(struct sh_cmt_channel *ch,
-				      unsigned long value)
+static inline void sh_cmt_write_cmstr(struct sh_cmt_channel *ch, u32 value)
 {
 	if (ch->iostart)
 		ch->cmt->info->write_control(ch->iostart, 0, value);
@@ -259,39 +247,35 @@ static inline void sh_cmt_write_cmstr(struct sh_cmt_channel *ch,
 		ch->cmt->info->write_control(ch->cmt->mapbase, 0, value);
 }
 
-static inline unsigned long sh_cmt_read_cmcsr(struct sh_cmt_channel *ch)
+static inline u32 sh_cmt_read_cmcsr(struct sh_cmt_channel *ch)
 {
 	return ch->cmt->info->read_control(ch->ioctrl, CMCSR);
 }
 
-static inline void sh_cmt_write_cmcsr(struct sh_cmt_channel *ch,
-				      unsigned long value)
+static inline void sh_cmt_write_cmcsr(struct sh_cmt_channel *ch, u32 value)
 {
 	ch->cmt->info->write_control(ch->ioctrl, CMCSR, value);
 }
 
-static inline unsigned long sh_cmt_read_cmcnt(struct sh_cmt_channel *ch)
+static inline u32 sh_cmt_read_cmcnt(struct sh_cmt_channel *ch)
 {
 	return ch->cmt->info->read_count(ch->ioctrl, CMCNT);
 }
 
-static inline void sh_cmt_write_cmcnt(struct sh_cmt_channel *ch,
-				      unsigned long value)
+static inline void sh_cmt_write_cmcnt(struct sh_cmt_channel *ch, u32 value)
 {
 	ch->cmt->info->write_count(ch->ioctrl, CMCNT, value);
 }
 
-static inline void sh_cmt_write_cmcor(struct sh_cmt_channel *ch,
-				      unsigned long value)
+static inline void sh_cmt_write_cmcor(struct sh_cmt_channel *ch, u32 value)
 {
 	ch->cmt->info->write_count(ch->ioctrl, CMCOR, value);
 }
 
-static unsigned long sh_cmt_get_counter(struct sh_cmt_channel *ch,
-					int *has_wrapped)
+static u32 sh_cmt_get_counter(struct sh_cmt_channel *ch, u32 *has_wrapped)
 {
-	unsigned long v1, v2, v3;
-	int o1, o2;
+	u32 v1, v2, v3;
+	u32 o1, o2;
 
 	o1 = sh_cmt_read_cmcsr(ch) & ch->cmt->info->overflow_bit;
 
@@ -311,7 +295,8 @@ static unsigned long sh_cmt_get_counter(struct sh_cmt_channel *ch,
 
 static void sh_cmt_start_stop_ch(struct sh_cmt_channel *ch, int start)
 {
-	unsigned long flags, value;
+	unsigned long flags;
+	u32 value;
 
 	/* start stop register shared by multiple timer channels */
 	raw_spin_lock_irqsave(&ch->cmt->lock, flags);
@@ -418,11 +403,11 @@ static void sh_cmt_disable(struct sh_cmt_channel *ch)
 static void sh_cmt_clock_event_program_verify(struct sh_cmt_channel *ch,
 					      int absolute)
 {
-	unsigned long new_match;
-	unsigned long value = ch->next_match_value;
-	unsigned long delay = 0;
-	unsigned long now = 0;
-	int has_wrapped;
+	u32 value = ch->next_match_value;
+	u32 new_match;
+	u32 delay = 0;
+	u32 now = 0;
+	u32 has_wrapped;
 
 	now = sh_cmt_get_counter(ch, &has_wrapped);
 	ch->flags |= FLAG_REPROGRAM; /* force reprogram */
@@ -619,9 +604,10 @@ static struct sh_cmt_channel *cs_to_sh_cmt(struct clocksource *cs)
 static u64 sh_cmt_clocksource_read(struct clocksource *cs)
 {
 	struct sh_cmt_channel *ch = cs_to_sh_cmt(cs);
-	unsigned long flags, raw;
-	unsigned long value;
-	int has_wrapped;
+	unsigned long flags;
+	u32 has_wrapped;
+	u64 value;
+	u32 raw;
 
 	raw_spin_lock_irqsave(&ch->lock, flags);
 	value = ch->total_cycles;
@@ -694,7 +680,7 @@ static int sh_cmt_register_clocksource(struct sh_cmt_channel *ch,
 	cs->disable = sh_cmt_clocksource_disable;
 	cs->suspend = sh_cmt_clocksource_suspend;
 	cs->resume = sh_cmt_clocksource_resume;
-	cs->mask = CLOCKSOURCE_MASK(sizeof(unsigned long) * 8);
+	cs->mask = CLOCKSOURCE_MASK(sizeof(u64) * 8);
 	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
 	dev_info(&ch->cmt->pdev->dev, "ch%u: used as clock source\n",
@@ -941,8 +927,22 @@ static const struct of_device_id sh_cmt_of_table[] __maybe_unused = {
 		.compatible = "renesas,cmt-48-gen2",
 		.data = &sh_cmt_info[SH_CMT0_RCAR_GEN2]
 	},
-	{ .compatible = "renesas,rcar-gen2-cmt0", .data = &sh_cmt_info[SH_CMT0_RCAR_GEN2] },
-	{ .compatible = "renesas,rcar-gen2-cmt1", .data = &sh_cmt_info[SH_CMT1_RCAR_GEN2] },
+	{
+		.compatible = "renesas,rcar-gen2-cmt0",
+		.data = &sh_cmt_info[SH_CMT0_RCAR_GEN2]
+	},
+	{
+		.compatible = "renesas,rcar-gen2-cmt1",
+		.data = &sh_cmt_info[SH_CMT1_RCAR_GEN2]
+	},
+	{
+		.compatible = "renesas,rcar-gen3-cmt0",
+		.data = &sh_cmt_info[SH_CMT0_RCAR_GEN2]
+	},
+	{
+		.compatible = "renesas,rcar-gen3-cmt1",
+		.data = &sh_cmt_info[SH_CMT1_RCAR_GEN2]
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sh_cmt_of_table);
diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 6812e099b6a3..354b27d14a19 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SuperH Timer Support - MTU2
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index c74a6c543ca2..49f1c805fc95 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SuperH Timer Support - TMU
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/timer-armada-370-xp.c
similarity index 100%
rename from drivers/clocksource/time-armada-370-xp.c
rename to drivers/clocksource/timer-armada-370-xp.c
diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/timer-cadence-ttc.c
similarity index 99%
rename from drivers/clocksource/cadence_ttc_timer.c
rename to drivers/clocksource/timer-cadence-ttc.c
index 29d51755e18b..b33402980b6f 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -535,7 +535,7 @@ static int __init ttc_timer_init(struct device_node *timer)
 	if (ret)
 		return ret;
 
-	pr_info("%s #0 at %p, irq=%d\n", timer->name, timer_baseaddr, irq);
+	pr_info("%pOFn #0 at %p, irq=%d\n", timer, timer_baseaddr, irq);
 
 	return 0;
 }
diff --git a/drivers/clocksource/time-efm32.c b/drivers/clocksource/timer-efm32.c
similarity index 100%
rename from drivers/clocksource/time-efm32.c
rename to drivers/clocksource/timer-efm32.c
diff --git a/drivers/clocksource/fsl_ftm_timer.c b/drivers/clocksource/timer-fsl-ftm.c
similarity index 100%
rename from drivers/clocksource/fsl_ftm_timer.c
rename to drivers/clocksource/timer-fsl-ftm.c
diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index 62d24690ba02..76e526f58620 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -190,7 +190,7 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
-		pr_err("No clock for %s\n", node->name);
+		pr_err("No clock for %pOFn\n", node);
 		return PTR_ERR(clk);
 	}
 	clk_prepare_enable(clk);
diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/timer-lpc32xx.c
similarity index 100%
rename from drivers/clocksource/time-lpc32xx.c
rename to drivers/clocksource/timer-lpc32xx.c
diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/timer-orion.c
similarity index 95%
rename from drivers/clocksource/time-orion.c
rename to drivers/clocksource/timer-orion.c
index 12202067fe4b..7d487107e3cd 100644
--- a/drivers/clocksource/time-orion.c
+++ b/drivers/clocksource/timer-orion.c
@@ -129,13 +129,13 @@ static int __init orion_timer_init(struct device_node *np)
 	/* timer registers are shared with watchdog timer */
 	timer_base = of_iomap(np, 0);
 	if (!timer_base) {
-		pr_err("%s: unable to map resource\n", np->name);
+		pr_err("%pOFn: unable to map resource\n", np);
 		return -ENXIO;
 	}
 
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
-		pr_err("%s: unable to get clk\n", np->name);
+		pr_err("%pOFn: unable to get clk\n", np);
 		return PTR_ERR(clk);
 	}
 
@@ -148,7 +148,7 @@ static int __init orion_timer_init(struct device_node *np)
 	/* we are only interested in timer1 irq */
 	irq = irq_of_parse_and_map(np, 1);
 	if (irq <= 0) {
-		pr_err("%s: unable to parse timer1 irq\n", np->name);
+		pr_err("%pOFn: unable to parse timer1 irq\n", np);
 		return -EINVAL;
 	}
 
@@ -174,7 +174,7 @@ static int __init orion_timer_init(struct device_node *np)
 	/* setup timer1 as clockevent timer */
 	ret = setup_irq(irq, &orion_clkevt_irq);
 	if (ret) {
-		pr_err("%s: unable to setup irq\n", np->name);
+		pr_err("%pOFn: unable to setup irq\n", np);
 		return ret;
 	}
 
diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/timer-owl.c
similarity index 100%
rename from drivers/clocksource/owl-timer.c
rename to drivers/clocksource/timer-owl.c
diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/timer-pistachio.c
similarity index 100%
rename from drivers/clocksource/time-pistachio.c
rename to drivers/clocksource/timer-pistachio.c
diff --git a/drivers/clocksource/qcom-timer.c b/drivers/clocksource/timer-qcom.c
similarity index 100%
rename from drivers/clocksource/qcom-timer.c
rename to drivers/clocksource/timer-qcom.c
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index e01222ea888f..052b230ca312 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -249,7 +249,7 @@ static int __init sp804_of_init(struct device_node *np)
 	if (of_clk_get_parent_count(np) == 3) {
 		clk2 = of_clk_get(np, 1);
 		if (IS_ERR(clk2)) {
-			pr_err("sp804: %s clock not found: %d\n", np->name,
+			pr_err("sp804: %pOFn clock not found: %d\n", np,
 				(int)PTR_ERR(clk2));
 			clk2 = NULL;
 		}
diff --git a/drivers/clocksource/versatile.c b/drivers/clocksource/timer-versatile.c
similarity index 100%
rename from drivers/clocksource/versatile.c
rename to drivers/clocksource/timer-versatile.c
diff --git a/drivers/clocksource/vf_pit_timer.c b/drivers/clocksource/timer-vf-pit.c
similarity index 100%
rename from drivers/clocksource/vf_pit_timer.c
rename to drivers/clocksource/timer-vf-pit.c
diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/timer-vt8500.c
similarity index 100%
rename from drivers/clocksource/vt8500_timer.c
rename to drivers/clocksource/timer-vt8500.c
diff --git a/drivers/clocksource/zevio-timer.c b/drivers/clocksource/timer-zevio.c
similarity index 97%
rename from drivers/clocksource/zevio-timer.c
rename to drivers/clocksource/timer-zevio.c
index f74689334f7c..6127e8062a71 100644
--- a/drivers/clocksource/zevio-timer.c
+++ b/drivers/clocksource/timer-zevio.c
@@ -148,12 +148,12 @@ static int __init zevio_timer_add(struct device_node *node)
 
 	of_address_to_resource(node, 0, &res);
 	scnprintf(timer->clocksource_name, sizeof(timer->clocksource_name),
-			"%llx.%s_clocksource",
-			(unsigned long long)res.start, node->name);
+			"%llx.%pOFn_clocksource",
+			(unsigned long long)res.start, node);
 
 	scnprintf(timer->clockevent_name, sizeof(timer->clockevent_name),
-			"%llx.%s_clockevent",
-			(unsigned long long)res.start, node->name);
+			"%llx.%pOFn_clockevent",
+			(unsigned long long)res.start, node);
 
 	if (timer->interrupt_regs && irqnr) {
 		timer->clkevt.name		= timer->clockevent_name;
diff --git a/fs/aio.c b/fs/aio.c
index b9350f3360c6..301e6314183b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2135,12 +2135,12 @@ COMPAT_SYSCALL_DEFINE5(io_getevents, compat_aio_context_t, ctx_id,
 		       compat_long_t, min_nr,
 		       compat_long_t, nr,
 		       struct io_event __user *, events,
-		       struct compat_timespec __user *, timeout)
+		       struct old_timespec32 __user *, timeout)
 {
 	struct timespec64 t;
 	int ret;
 
-	if (timeout && compat_get_timespec64(&t, timeout))
+	if (timeout && get_old_timespec32(&t, timeout))
 		return -EFAULT;
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
@@ -2160,7 +2160,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 		compat_long_t, min_nr,
 		compat_long_t, nr,
 		struct io_event __user *, events,
-		struct compat_timespec __user *, timeout,
+		struct old_timespec32 __user *, timeout,
 		const struct __compat_aio_sigset __user *, usig)
 {
 	struct __compat_aio_sigset ksig = { NULL, };
@@ -2168,7 +2168,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 	struct timespec64 t;
 	int ret;
 
-	if (timeout && compat_get_timespec64(&t, timeout))
+	if (timeout && get_old_timespec32(&t, timeout))
 		return -EFAULT;
 
 	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 504b3c3539dc..15f6e96b3bd9 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -52,7 +52,7 @@
 #define elf_prpsinfo	compat_elf_prpsinfo
 
 #undef ns_to_timeval
-#define ns_to_timeval ns_to_compat_timeval
+#define ns_to_timeval ns_to_old_timeval32
 
 /*
  * To use this file, asm/elf.h must define compat_elf_check_arch.
diff --git a/fs/read_write.c b/fs/read_write.c
index 39b4a21dd933..e892e409386b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -331,7 +331,7 @@ COMPAT_SYSCALL_DEFINE3(lseek, unsigned int, fd, compat_off_t, offset, unsigned i
 }
 #endif
 
-#ifdef __ARCH_WANT_SYS_LLSEEK
+#if !defined(CONFIG_64BIT) || defined(CONFIG_COMPAT)
 SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 		unsigned long, offset_low, loff_t __user *, result,
 		unsigned int, whence)
diff --git a/fs/select.c b/fs/select.c
index 4a6b6e4b21cb..22b3bf89f051 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1120,7 +1120,7 @@ int compat_poll_select_copy_remaining(struct timespec64 *end_time, void __user *
 		ts.tv_sec = ts.tv_nsec = 0;
 
 	if (timeval) {
-		struct compat_timeval rtv;
+		struct old_timeval32 rtv;
 
 		rtv.tv_sec = ts.tv_sec;
 		rtv.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
@@ -1128,7 +1128,7 @@ int compat_poll_select_copy_remaining(struct timespec64 *end_time, void __user *
 		if (!copy_to_user(p, &rtv, sizeof(rtv)))
 			return ret;
 	} else {
-		if (!compat_put_timespec64(&ts, p))
+		if (!put_old_timespec32(&ts, p))
 			return ret;
 	}
 	/*
@@ -1257,10 +1257,10 @@ static int compat_core_sys_select(int n, compat_ulong_t __user *inp,
 
 static int do_compat_select(int n, compat_ulong_t __user *inp,
 	compat_ulong_t __user *outp, compat_ulong_t __user *exp,
-	struct compat_timeval __user *tvp)
+	struct old_timeval32 __user *tvp)
 {
 	struct timespec64 end_time, *to = NULL;
-	struct compat_timeval tv;
+	struct old_timeval32 tv;
 	int ret;
 
 	if (tvp) {
@@ -1282,7 +1282,7 @@ static int do_compat_select(int n, compat_ulong_t __user *inp,
 
 COMPAT_SYSCALL_DEFINE5(select, int, n, compat_ulong_t __user *, inp,
 	compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
-	struct compat_timeval __user *, tvp)
+	struct old_timeval32 __user *, tvp)
 {
 	return do_compat_select(n, inp, outp, exp, tvp);
 }
@@ -1307,7 +1307,7 @@ COMPAT_SYSCALL_DEFINE1(old_select, struct compat_sel_arg_struct __user *, arg)
 
 static long do_compat_pselect(int n, compat_ulong_t __user *inp,
 	compat_ulong_t __user *outp, compat_ulong_t __user *exp,
-	struct compat_timespec __user *tsp, compat_sigset_t __user *sigmask,
+	struct old_timespec32 __user *tsp, compat_sigset_t __user *sigmask,
 	compat_size_t sigsetsize)
 {
 	sigset_t ksigmask, sigsaved;
@@ -1315,7 +1315,7 @@ static long do_compat_pselect(int n, compat_ulong_t __user *inp,
 	int ret;
 
 	if (tsp) {
-		if (compat_get_timespec64(&ts, tsp))
+		if (get_old_timespec32(&ts, tsp))
 			return -EFAULT;
 
 		to = &end_time;
@@ -1355,7 +1355,7 @@ static long do_compat_pselect(int n, compat_ulong_t __user *inp,
 
 COMPAT_SYSCALL_DEFINE6(pselect6, int, n, compat_ulong_t __user *, inp,
 	compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
-	struct compat_timespec __user *, tsp, void __user *, sig)
+	struct old_timespec32 __user *, tsp, void __user *, sig)
 {
 	compat_size_t sigsetsize = 0;
 	compat_uptr_t up = 0;
@@ -1373,7 +1373,7 @@ COMPAT_SYSCALL_DEFINE6(pselect6, int, n, compat_ulong_t __user *, inp,
 }
 
 COMPAT_SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds,
-	unsigned int,  nfds, struct compat_timespec __user *, tsp,
+	unsigned int,  nfds, struct old_timespec32 __user *, tsp,
 	const compat_sigset_t __user *, sigmask, compat_size_t, sigsetsize)
 {
 	sigset_t ksigmask, sigsaved;
@@ -1381,7 +1381,7 @@ COMPAT_SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds,
 	int ret;
 
 	if (tsp) {
-		if (compat_get_timespec64(&ts, tsp))
+		if (get_old_timespec32(&ts, tsp))
 			return -EFAULT;
 
 		to = &end_time;
diff --git a/fs/stat.c b/fs/stat.c
index f8e6fb2c3657..adbfcd86c81b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -280,6 +280,8 @@ SYSCALL_DEFINE2(fstat, unsigned int, fd, struct __old_kernel_stat __user *, stat
 
 #endif /* __ARCH_WANT_OLD_STAT */
 
+#ifdef __ARCH_WANT_NEW_STAT
+
 #if BITS_PER_LONG == 32
 #  define choose_32_64(a,b) a
 #else
@@ -378,6 +380,7 @@ SYSCALL_DEFINE2(newfstat, unsigned int, fd, struct stat __user *, statbuf)
 
 	return error;
 }
+#endif
 
 static int do_readlinkat(int dfd, const char __user *pathname,
 			 char __user *buf, int bufsiz)
diff --git a/fs/timerfd.c b/fs/timerfd.c
index d69ad801eb80..803ca070d42e 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -561,29 +561,29 @@ SYSCALL_DEFINE2(timerfd_gettime, int, ufd, struct __kernel_itimerspec __user *,
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE4(timerfd_settime, int, ufd, int, flags,
-		const struct compat_itimerspec __user *, utmr,
-		struct compat_itimerspec __user *, otmr)
+		const struct old_itimerspec32 __user *, utmr,
+		struct old_itimerspec32 __user *, otmr)
 {
 	struct itimerspec64 new, old;
 	int ret;
 
-	if (get_compat_itimerspec64(&new, utmr))
+	if (get_old_itimerspec32(&new, utmr))
 		return -EFAULT;
 	ret = do_timerfd_settime(ufd, flags, &new, &old);
 	if (ret)
 		return ret;
-	if (otmr && put_compat_itimerspec64(&old, otmr))
+	if (otmr && put_old_itimerspec32(&old, otmr))
 		return -EFAULT;
 	return ret;
 }
 
 COMPAT_SYSCALL_DEFINE2(timerfd_gettime, int, ufd,
-		struct compat_itimerspec __user *, otmr)
+		struct old_itimerspec32 __user *, otmr)
 {
 	struct itimerspec64 kotmr;
 	int ret = do_timerfd_gettime(ufd, &kotmr);
 	if (ret)
 		return ret;
-	return put_compat_itimerspec64(&kotmr, otmr) ? -EFAULT : 0;
+	return put_old_itimerspec32(&kotmr, otmr) ? -EFAULT : 0;
 }
 #endif
diff --git a/fs/utimes.c b/fs/utimes.c
index 69d4b6ba1bfb..bdcf2daf39c1 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -8,35 +8,6 @@
 #include <linux/compat.h>
 #include <asm/unistd.h>
 
-#ifdef __ARCH_WANT_SYS_UTIME
-
-/*
- * sys_utime() can be implemented in user-level using sys_utimes().
- * Is this for backwards compatibility?  If so, why not move it
- * into the appropriate arch directory (for those architectures that
- * need it).
- */
-
-/* If times==NULL, set access and modification to current time,
- * must be owner or have write permission.
- * Else, update from *times, must be owner or super user.
- */
-SYSCALL_DEFINE2(utime, char __user *, filename, struct utimbuf __user *, times)
-{
-	struct timespec64 tv[2];
-
-	if (times) {
-		if (get_user(tv[0].tv_sec, &times->actime) ||
-		    get_user(tv[1].tv_sec, &times->modtime))
-			return -EFAULT;
-		tv[0].tv_nsec = 0;
-		tv[1].tv_nsec = 0;
-	}
-	return do_utimes(AT_FDCWD, filename, times ? tv : NULL, 0);
-}
-
-#endif
-
 static bool nsec_valid(long nsec)
 {
 	if (nsec == UTIME_OMIT || nsec == UTIME_NOW)
@@ -166,7 +137,7 @@ long do_utimes(int dfd, const char __user *filename, struct timespec64 *times,
 }
 
 SYSCALL_DEFINE4(utimensat, int, dfd, const char __user *, filename,
-		struct timespec __user *, utimes, int, flags)
+		struct __kernel_timespec __user *, utimes, int, flags)
 {
 	struct timespec64 tstimes[2];
 
@@ -184,6 +155,13 @@ SYSCALL_DEFINE4(utimensat, int, dfd, const char __user *, filename,
 	return do_utimes(dfd, filename, utimes ? tstimes : NULL, flags);
 }
 
+#ifdef __ARCH_WANT_SYS_UTIME
+/*
+ * futimesat(), utimes() and utime() are older versions of utimensat()
+ * that are provided for compatibility with traditional C libraries.
+ * On modern architectures, we always use libc wrappers around
+ * utimensat() instead.
+ */
 static long do_futimesat(int dfd, const char __user *filename,
 			 struct timeval __user *utimes)
 {
@@ -225,13 +203,29 @@ SYSCALL_DEFINE2(utimes, char __user *, filename,
 	return do_futimesat(AT_FDCWD, filename, utimes);
 }
 
-#ifdef CONFIG_COMPAT
+SYSCALL_DEFINE2(utime, char __user *, filename, struct utimbuf __user *, times)
+{
+	struct timespec64 tv[2];
+
+	if (times) {
+		if (get_user(tv[0].tv_sec, &times->actime) ||
+		    get_user(tv[1].tv_sec, &times->modtime))
+			return -EFAULT;
+		tv[0].tv_nsec = 0;
+		tv[1].tv_nsec = 0;
+	}
+	return do_utimes(AT_FDCWD, filename, times ? tv : NULL, 0);
+}
+#endif
+
+#ifdef CONFIG_COMPAT_32BIT_TIME
 /*
  * Not all architectures have sys_utime, so implement this in terms
  * of sys_utimes.
  */
+#ifdef __ARCH_WANT_SYS_UTIME32
 COMPAT_SYSCALL_DEFINE2(utime, const char __user *, filename,
-		       struct compat_utimbuf __user *, t)
+		       struct old_utimbuf32 __user *, t)
 {
 	struct timespec64 tv[2];
 
@@ -244,14 +238,15 @@ COMPAT_SYSCALL_DEFINE2(utime, const char __user *, filename,
 	}
 	return do_utimes(AT_FDCWD, filename, t ? tv : NULL, 0);
 }
+#endif
 
-COMPAT_SYSCALL_DEFINE4(utimensat, unsigned int, dfd, const char __user *, filename, struct compat_timespec __user *, t, int, flags)
+COMPAT_SYSCALL_DEFINE4(utimensat, unsigned int, dfd, const char __user *, filename, struct old_timespec32 __user *, t, int, flags)
 {
 	struct timespec64 tv[2];
 
 	if  (t) {
-		if (compat_get_timespec64(&tv[0], &t[0]) ||
-		    compat_get_timespec64(&tv[1], &t[1]))
+		if (get_old_timespec32(&tv[0], &t[0]) ||
+		    get_old_timespec32(&tv[1], &t[1]))
 			return -EFAULT;
 
 		if (tv[0].tv_nsec == UTIME_OMIT && tv[1].tv_nsec == UTIME_OMIT)
@@ -260,8 +255,9 @@ COMPAT_SYSCALL_DEFINE4(utimensat, unsigned int, dfd, const char __user *, filena
 	return do_utimes(dfd, filename, t ? tv : NULL, flags);
 }
 
+#ifdef __ARCH_WANT_SYS_UTIME32
 static long do_compat_futimesat(unsigned int dfd, const char __user *filename,
-				struct compat_timeval __user *t)
+				struct old_timeval32 __user *t)
 {
 	struct timespec64 tv[2];
 
@@ -282,13 +278,14 @@ static long do_compat_futimesat(unsigned int dfd, const char __user *filename,
 
 COMPAT_SYSCALL_DEFINE3(futimesat, unsigned int, dfd,
 		       const char __user *, filename,
-		       struct compat_timeval __user *, t)
+		       struct old_timeval32 __user *, t)
 {
 	return do_compat_futimesat(dfd, filename, t);
 }
 
-COMPAT_SYSCALL_DEFINE2(utimes, const char __user *, filename, struct compat_timeval __user *, t)
+COMPAT_SYSCALL_DEFINE2(utimes, const char __user *, filename, struct old_timeval32 __user *, t)
 {
 	return do_compat_futimesat(AT_FDCWD, filename, t);
 }
 #endif
+#endif
diff --git a/include/asm-generic/compat.h b/include/asm-generic/compat.h
index 28819451b6d1..a86f65bffab8 100644
--- a/include/asm-generic/compat.h
+++ b/include/asm-generic/compat.h
@@ -1,3 +1,25 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_COMPAT_H
+#define __ASM_GENERIC_COMPAT_H
 
-/* This is an empty stub for 32-bit-only architectures */
+/* These types are common across all compat ABIs */
+typedef u32 compat_size_t;
+typedef s32 compat_ssize_t;
+typedef s32 compat_clock_t;
+typedef s32 compat_pid_t;
+typedef u32 compat_ino_t;
+typedef s32 compat_off_t;
+typedef s64 compat_loff_t;
+typedef s32 compat_daddr_t;
+typedef s32 compat_timer_t;
+typedef s32 compat_key_t;
+typedef s16 compat_short_t;
+typedef s32 compat_int_t;
+typedef s32 compat_long_t;
+typedef u16 compat_ushort_t;
+typedef u32 compat_uint_t;
+typedef u32 compat_ulong_t;
+typedef u32 compat_uptr_t;
+typedef u32 compat_aio_context_t;
+
+#endif
diff --git a/include/asm-generic/unistd.h b/include/asm-generic/unistd.h
deleted file mode 100644
index cdf904265caf..000000000000
--- a/include/asm-generic/unistd.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <uapi/asm-generic/unistd.h>
-#include <linux/export.h>
-
-/*
- * These are required system calls, we should
- * invert the logic eventually and let them
- * be selected by default.
- */
-#if __BITS_PER_LONG == 32
-#define __ARCH_WANT_STAT64
-#define __ARCH_WANT_SYS_LLSEEK
-#endif
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 308918928767..4c58c1e64080 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -257,9 +257,6 @@ extern int clocksource_i8253_init(void);
 #define TIMER_OF_DECLARE(name, compat, fn) \
 	OF_DECLARE_1_RET(timer, name, compat, fn)
 
-#define CLOCKSOURCE_OF_DECLARE(name, compat, fn) \
-	TIMER_OF_DECLARE(name, compat, fn)
-
 #ifdef CONFIG_TIMER_PROBE
 extern void timer_probe(void);
 #else
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 1a3c4f37e908..6fb5abdb87be 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -7,7 +7,7 @@
  */
 
 #include <linux/types.h>
-#include <linux/compat_time.h>
+#include <linux/time.h>
 
 #include <linux/stat.h>
 #include <linux/param.h>	/* for HZ */
@@ -110,19 +110,12 @@ typedef struct compat_sigaltstack {
 typedef __compat_uid32_t	compat_uid_t;
 typedef __compat_gid32_t	compat_gid_t;
 
-typedef	compat_ulong_t		compat_aio_context_t;
-
 struct compat_sel_arg_struct;
 struct rusage;
 
-struct compat_utimbuf {
-	compat_time_t		actime;
-	compat_time_t		modtime;
-};
-
 struct compat_itimerval {
-	struct compat_timeval	it_interval;
-	struct compat_timeval	it_value;
+	struct old_timeval32	it_interval;
+	struct old_timeval32	it_value;
 };
 
 struct itimerval;
@@ -146,7 +139,7 @@ struct compat_timex {
 	compat_long_t constant;
 	compat_long_t precision;
 	compat_long_t tolerance;
-	struct compat_timeval time;
+	struct old_timeval32 time;
 	compat_long_t tick;
 	compat_long_t ppsfreq;
 	compat_long_t jitter;
@@ -307,8 +300,8 @@ struct compat_rlimit {
 };
 
 struct compat_rusage {
-	struct compat_timeval ru_utime;
-	struct compat_timeval ru_stime;
+	struct old_timeval32 ru_utime;
+	struct old_timeval32 ru_stime;
 	compat_long_t	ru_maxrss;
 	compat_long_t	ru_ixrss;
 	compat_long_t	ru_idrss;
@@ -457,8 +450,8 @@ int copy_siginfo_to_user32(struct compat_siginfo __user *to, const siginfo_t *fr
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event);
 
-static inline int compat_timeval_compare(struct compat_timeval *lhs,
-					struct compat_timeval *rhs)
+static inline int old_timeval32_compare(struct old_timeval32 *lhs,
+					struct old_timeval32 *rhs)
 {
 	if (lhs->tv_sec < rhs->tv_sec)
 		return -1;
@@ -467,8 +460,8 @@ static inline int compat_timeval_compare(struct compat_timeval *lhs,
 	return lhs->tv_usec - rhs->tv_usec;
 }
 
-static inline int compat_timespec_compare(struct compat_timespec *lhs,
-					struct compat_timespec *rhs)
+static inline int old_timespec32_compare(struct old_timespec32 *lhs,
+					struct old_timespec32 *rhs)
 {
 	if (lhs->tv_sec < rhs->tv_sec)
 		return -1;
@@ -552,12 +545,12 @@ asmlinkage long compat_sys_io_getevents(compat_aio_context_t ctx_id,
 					compat_long_t min_nr,
 					compat_long_t nr,
 					struct io_event __user *events,
-					struct compat_timespec __user *timeout);
+					struct old_timespec32 __user *timeout);
 asmlinkage long compat_sys_io_pgetevents(compat_aio_context_t ctx_id,
 					compat_long_t min_nr,
 					compat_long_t nr,
 					struct io_event __user *events,
-					struct compat_timespec __user *timeout,
+					struct old_timespec32 __user *timeout,
 					const struct __compat_aio_sigset __user *usig);
 
 /* fs/cookies.c */
@@ -642,11 +635,11 @@ asmlinkage long compat_sys_sendfile64(int out_fd, int in_fd,
 asmlinkage long compat_sys_pselect6(int n, compat_ulong_t __user *inp,
 				    compat_ulong_t __user *outp,
 				    compat_ulong_t __user *exp,
-				    struct compat_timespec __user *tsp,
+				    struct old_timespec32 __user *tsp,
 				    void __user *sig);
 asmlinkage long compat_sys_ppoll(struct pollfd __user *ufds,
 				 unsigned int nfds,
-				 struct compat_timespec __user *tsp,
+				 struct old_timespec32 __user *tsp,
 				 const compat_sigset_t __user *sigmask,
 				 compat_size_t sigsetsize);
 
@@ -671,15 +664,15 @@ asmlinkage long compat_sys_newfstat(unsigned int fd,
 
 /* fs/timerfd.c */
 asmlinkage long compat_sys_timerfd_gettime(int ufd,
-				   struct compat_itimerspec __user *otmr);
+				   struct old_itimerspec32 __user *otmr);
 asmlinkage long compat_sys_timerfd_settime(int ufd, int flags,
-				   const struct compat_itimerspec __user *utmr,
-				   struct compat_itimerspec __user *otmr);
+				   const struct old_itimerspec32 __user *utmr,
+				   struct old_itimerspec32 __user *otmr);
 
 /* fs/utimes.c */
 asmlinkage long compat_sys_utimensat(unsigned int dfd,
 				     const char __user *filename,
-				     struct compat_timespec __user *t,
+				     struct old_timespec32 __user *t,
 				     int flags);
 
 /* kernel/exit.c */
@@ -691,7 +684,7 @@ asmlinkage long compat_sys_waitid(int, compat_pid_t,
 
 /* kernel/futex.c */
 asmlinkage long compat_sys_futex(u32 __user *uaddr, int op, u32 val,
-		struct compat_timespec __user *utime, u32 __user *uaddr2,
+		struct old_timespec32 __user *utime, u32 __user *uaddr2,
 		u32 val3);
 asmlinkage long
 compat_sys_set_robust_list(struct compat_robust_list_head __user *head,
@@ -701,8 +694,8 @@ compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
 			   compat_size_t __user *len_ptr);
 
 /* kernel/hrtimer.c */
-asmlinkage long compat_sys_nanosleep(struct compat_timespec __user *rqtp,
-				     struct compat_timespec __user *rmtp);
+asmlinkage long compat_sys_nanosleep(struct old_timespec32 __user *rqtp,
+				     struct old_timespec32 __user *rmtp);
 
 /* kernel/itimer.c */
 asmlinkage long compat_sys_getitimer(int which,
@@ -722,19 +715,19 @@ asmlinkage long compat_sys_timer_create(clockid_t which_clock,
 			struct compat_sigevent __user *timer_event_spec,
 			timer_t __user *created_timer_id);
 asmlinkage long compat_sys_timer_gettime(timer_t timer_id,
-				 struct compat_itimerspec __user *setting);
+				 struct old_itimerspec32 __user *setting);
 asmlinkage long compat_sys_timer_settime(timer_t timer_id, int flags,
-					 struct compat_itimerspec __user *new,
-					 struct compat_itimerspec __user *old);
+					 struct old_itimerspec32 __user *new,
+					 struct old_itimerspec32 __user *old);
 asmlinkage long compat_sys_clock_settime(clockid_t which_clock,
-					 struct compat_timespec __user *tp);
+					 struct old_timespec32 __user *tp);
 asmlinkage long compat_sys_clock_gettime(clockid_t which_clock,
-					 struct compat_timespec __user *tp);
+					 struct old_timespec32 __user *tp);
 asmlinkage long compat_sys_clock_getres(clockid_t which_clock,
-					struct compat_timespec __user *tp);
+					struct old_timespec32 __user *tp);
 asmlinkage long compat_sys_clock_nanosleep(clockid_t which_clock, int flags,
-					   struct compat_timespec __user *rqtp,
-					   struct compat_timespec __user *rmtp);
+					   struct old_timespec32 __user *rqtp,
+					   struct old_timespec32 __user *rmtp);
 
 /* kernel/ptrace.c */
 asmlinkage long compat_sys_ptrace(compat_long_t request, compat_long_t pid,
@@ -748,7 +741,7 @@ asmlinkage long compat_sys_sched_getaffinity(compat_pid_t pid,
 				     unsigned int len,
 				     compat_ulong_t __user *user_mask_ptr);
 asmlinkage long compat_sys_sched_rr_get_interval(compat_pid_t pid,
-						 struct compat_timespec __user *interval);
+						 struct old_timespec32 __user *interval);
 
 /* kernel/signal.c */
 asmlinkage long compat_sys_sigaltstack(const compat_stack_t __user *uss_ptr,
@@ -768,7 +761,7 @@ asmlinkage long compat_sys_rt_sigpending(compat_sigset_t __user *uset,
 					 compat_size_t sigsetsize);
 asmlinkage long compat_sys_rt_sigtimedwait(compat_sigset_t __user *uthese,
 		struct compat_siginfo __user *uinfo,
-		struct compat_timespec __user *uts, compat_size_t sigsetsize);
+		struct old_timespec32 __user *uts, compat_size_t sigsetsize);
 asmlinkage long compat_sys_rt_sigqueueinfo(compat_pid_t pid, int sig,
 				struct compat_siginfo __user *uinfo);
 /* No generic prototype for rt_sigreturn */
@@ -782,9 +775,9 @@ asmlinkage long compat_sys_setrlimit(unsigned int resource,
 asmlinkage long compat_sys_getrusage(int who, struct compat_rusage __user *ru);
 
 /* kernel/time.c */
-asmlinkage long compat_sys_gettimeofday(struct compat_timeval __user *tv,
+asmlinkage long compat_sys_gettimeofday(struct old_timeval32 __user *tv,
 		struct timezone __user *tz);
-asmlinkage long compat_sys_settimeofday(struct compat_timeval __user *tv,
+asmlinkage long compat_sys_settimeofday(struct old_timeval32 __user *tv,
 		struct timezone __user *tz);
 asmlinkage long compat_sys_adjtimex(struct compat_timex __user *utp);
 
@@ -798,11 +791,11 @@ asmlinkage long compat_sys_mq_open(const char __user *u_name,
 asmlinkage long compat_sys_mq_timedsend(mqd_t mqdes,
 			const char __user *u_msg_ptr,
 			compat_size_t msg_len, unsigned int msg_prio,
-			const struct compat_timespec __user *u_abs_timeout);
+			const struct old_timespec32 __user *u_abs_timeout);
 asmlinkage ssize_t compat_sys_mq_timedreceive(mqd_t mqdes,
 			char __user *u_msg_ptr,
 			compat_size_t msg_len, unsigned int __user *u_msg_prio,
-			const struct compat_timespec __user *u_abs_timeout);
+			const struct old_timespec32 __user *u_abs_timeout);
 asmlinkage long compat_sys_mq_notify(mqd_t mqdes,
 			const struct compat_sigevent __user *u_notification);
 asmlinkage long compat_sys_mq_getsetattr(mqd_t mqdes,
@@ -819,7 +812,7 @@ asmlinkage long compat_sys_msgsnd(int msqid, compat_uptr_t msgp,
 /* ipc/sem.c */
 asmlinkage long compat_sys_semctl(int semid, int semnum, int cmd, int arg);
 asmlinkage long compat_sys_semtimedop(int semid, struct sembuf __user *tsems,
-		unsigned nsems, const struct compat_timespec __user *timeout);
+		unsigned nsems, const struct old_timespec32 __user *timeout);
 
 /* ipc/shm.c */
 asmlinkage long compat_sys_shmctl(int first, int second, void __user *uptr);
@@ -876,7 +869,7 @@ asmlinkage long compat_sys_rt_tgsigqueueinfo(compat_pid_t tgid,
 					struct compat_siginfo __user *uinfo);
 asmlinkage long compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
 				    unsigned vlen, unsigned int flags,
-				    struct compat_timespec __user *timeout);
+				    struct old_timespec32 __user *timeout);
 asmlinkage long compat_sys_wait4(compat_pid_t pid,
 				 compat_uint_t __user *stat_addr, int options,
 				 struct compat_rusage __user *ru);
@@ -928,7 +921,7 @@ asmlinkage long compat_sys_pwritev64v2(unsigned long fd,
 asmlinkage long compat_sys_open(const char __user *filename, int flags,
 				umode_t mode);
 asmlinkage long compat_sys_utimes(const char __user *filename,
-				  struct compat_timeval __user *t);
+				  struct old_timeval32 __user *t);
 
 /* __ARCH_WANT_SYSCALL_NO_FLAGS */
 asmlinkage long compat_sys_signalfd(int ufd,
@@ -942,15 +935,15 @@ asmlinkage long compat_sys_newlstat(const char __user *filename,
 				    struct compat_stat __user *statbuf);
 
 /* __ARCH_WANT_SYSCALL_DEPRECATED */
-asmlinkage long compat_sys_time(compat_time_t __user *tloc);
+asmlinkage long compat_sys_time(old_time32_t __user *tloc);
 asmlinkage long compat_sys_utime(const char __user *filename,
-				 struct compat_utimbuf __user *t);
+				 struct old_utimbuf32 __user *t);
 asmlinkage long compat_sys_futimesat(unsigned int dfd,
 				     const char __user *filename,
-				     struct compat_timeval __user *t);
+				     struct old_timeval32 __user *t);
 asmlinkage long compat_sys_select(int n, compat_ulong_t __user *inp,
 		compat_ulong_t __user *outp, compat_ulong_t __user *exp,
-		struct compat_timeval __user *tvp);
+		struct old_timeval32 __user *tvp);
 asmlinkage long compat_sys_ustat(unsigned dev, struct compat_ustat __user *u32);
 asmlinkage long compat_sys_recv(int fd, void __user *buf, compat_size_t len,
 				unsigned flags);
@@ -983,7 +976,7 @@ asmlinkage long compat_sys_sigaction(int sig,
 #endif
 
 /* obsolete: kernel/time/time.c */
-asmlinkage long compat_sys_stime(compat_time_t __user *tptr);
+asmlinkage long compat_sys_stime(old_time32_t __user *tptr);
 
 /* obsolete: net/socket.c */
 asmlinkage long compat_sys_socketcall(int call, u32 __user *args);
@@ -1002,15 +995,15 @@ static inline bool in_compat_syscall(void) { return is_compat_task(); }
 #endif
 
 /**
- * ns_to_compat_timeval - Compat version of ns_to_timeval
+ * ns_to_old_timeval32 - Compat version of ns_to_timeval
  * @nsec:	the nanoseconds value to be converted
  *
- * Returns the compat_timeval representation of the nsec parameter.
+ * Returns the old_timeval32 representation of the nsec parameter.
  */
-static inline struct compat_timeval ns_to_compat_timeval(s64 nsec)
+static inline struct old_timeval32 ns_to_old_timeval32(s64 nsec)
 {
 	struct timeval tv;
-	struct compat_timeval ctv;
+	struct old_timeval32 ctv;
 
 	tv = ns_to_timeval(nsec);
 	ctv.tv_sec = tv.tv_sec;
diff --git a/include/linux/compat_time.h b/include/linux/compat_time.h
deleted file mode 100644
index e70bfd1d2c3f..000000000000
--- a/include/linux/compat_time.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_COMPAT_TIME_H
-#define _LINUX_COMPAT_TIME_H
-
-#include <linux/types.h>
-#include <linux/time64.h>
-
-typedef s32		compat_time_t;
-
-struct compat_timespec {
-	compat_time_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct compat_timeval {
-	compat_time_t	tv_sec;
-	s32		tv_usec;
-};
-
-struct compat_itimerspec {
-	struct compat_timespec it_interval;
-	struct compat_timespec it_value;
-};
-
-extern int compat_get_timespec64(struct timespec64 *, const void __user *);
-extern int compat_put_timespec64(const struct timespec64 *, void __user *);
-extern int get_compat_itimerspec64(struct itimerspec64 *its,
-			const struct compat_itimerspec __user *uits);
-extern int put_compat_itimerspec64(const struct itimerspec64 *its,
-			struct compat_itimerspec __user *uits);
-
-#endif /* _LINUX_COMPAT_TIME_H */
diff --git a/include/linux/elfcore-compat.h b/include/linux/elfcore-compat.h
index b5f2efdd05e0..7a37f4ce9fd2 100644
--- a/include/linux/elfcore-compat.h
+++ b/include/linux/elfcore-compat.h
@@ -27,10 +27,10 @@ struct compat_elf_prstatus
 	compat_pid_t			pr_ppid;
 	compat_pid_t			pr_pgrp;
 	compat_pid_t			pr_sid;
-	struct compat_timeval		pr_utime;
-	struct compat_timeval		pr_stime;
-	struct compat_timeval		pr_cutime;
-	struct compat_timeval		pr_cstime;
+	struct old_timeval32		pr_utime;
+	struct old_timeval32		pr_stime;
+	struct old_timeval32		pr_cutime;
+	struct old_timeval32		pr_cstime;
 	compat_elf_gregset_t		pr_reg;
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 	compat_ulong_t			pr_exec_fdpic_loadmap;
diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index 5d83d0c1d06c..bba2920e9c05 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -10,7 +10,7 @@
 #include <linux/time64.h>
 
 struct timespec;
-struct compat_timespec;
+struct old_timespec32;
 struct pollfd;
 
 enum timespec_type {
@@ -40,7 +40,7 @@ struct restart_block {
 			enum timespec_type type;
 			union {
 				struct __kernel_timespec __user *rmtp;
-				struct compat_timespec __user *compat_rmtp;
+				struct old_timespec32 __user *compat_rmtp;
 			};
 			u64 expires;
 		} nanosleep;
diff --git a/include/linux/socket.h b/include/linux/socket.h
index 7ed4713d5337..8b571e9b9f76 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -348,7 +348,7 @@ struct ucred {
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
 
-struct timespec;
+struct timespec64;
 
 /* The __sys_...msg variants allow MSG_CMSG_COMPAT iff
  * forbid_cmsg_compat==false
@@ -358,7 +358,7 @@ extern long __sys_recvmsg(int fd, struct user_msghdr __user *msg,
 extern long __sys_sendmsg(int fd, struct user_msghdr __user *msg,
 			  unsigned int flags, bool forbid_cmsg_compat);
 extern int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
-			  unsigned int flags, struct timespec *timeout);
+			  unsigned int flags, struct timespec64 *timeout);
 extern int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg,
 			  unsigned int vlen, unsigned int flags,
 			  bool forbid_cmsg_compat);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2ff814c92f7f..2ac3d13a915b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -60,7 +60,7 @@ struct tms;
 struct utimbuf;
 struct mq_attr;
 struct compat_stat;
-struct compat_timeval;
+struct old_timeval32;
 struct robust_list_head;
 struct getcpu_cache;
 struct old_linux_dirent;
@@ -513,7 +513,8 @@ asmlinkage long sys_timerfd_gettime(int ufd, struct __kernel_itimerspec __user *
 
 /* fs/utimes.c */
 asmlinkage long sys_utimensat(int dfd, const char __user *filename,
-				struct timespec __user *utimes, int flags);
+				struct __kernel_timespec __user *utimes,
+				int flags);
 
 /* kernel/acct.c */
 asmlinkage long sys_acct(const char __user *name);
@@ -613,7 +614,7 @@ asmlinkage long sys_sched_yield(void);
 asmlinkage long sys_sched_get_priority_max(int policy);
 asmlinkage long sys_sched_get_priority_min(int policy);
 asmlinkage long sys_sched_rr_get_interval(pid_t pid,
-					struct timespec __user *interval);
+				struct __kernel_timespec __user *interval);
 
 /* kernel/signal.c */
 asmlinkage long sys_restart_syscall(void);
@@ -634,7 +635,7 @@ asmlinkage long sys_rt_sigprocmask(int how, sigset_t __user *set,
 asmlinkage long sys_rt_sigpending(sigset_t __user *set, size_t sigsetsize);
 asmlinkage long sys_rt_sigtimedwait(const sigset_t __user *uthese,
 				siginfo_t __user *uinfo,
-				const struct timespec __user *uts,
+				const struct __kernel_timespec __user *uts,
 				size_t sigsetsize);
 asmlinkage long sys_rt_sigqueueinfo(pid_t pid, int sig, siginfo_t __user *uinfo);
 
@@ -829,7 +830,7 @@ asmlinkage long sys_perf_event_open(
 asmlinkage long sys_accept4(int, struct sockaddr __user *, int __user *, int);
 asmlinkage long sys_recvmmsg(int fd, struct mmsghdr __user *msg,
 			     unsigned int vlen, unsigned flags,
-			     struct timespec __user *timeout);
+			     struct __kernel_timespec __user *timeout);
 
 asmlinkage long sys_wait4(pid_t pid, int __user *stat_addr,
 				int options, struct rusage __user *ru);
@@ -954,8 +955,6 @@ asmlinkage long sys_access(const char __user *filename, int mode);
 asmlinkage long sys_rename(const char __user *oldname,
 				const char __user *newname);
 asmlinkage long sys_symlink(const char __user *old, const char __user *new);
-asmlinkage long sys_utimes(char __user *filename,
-				struct timeval __user *utimes);
 #if defined(__ARCH_WANT_STAT64) || defined(__ARCH_WANT_COMPAT_STAT64)
 asmlinkage long sys_stat64(const char __user *filename,
 				struct stat64 __user *statbuf);
@@ -985,14 +984,18 @@ asmlinkage long sys_alarm(unsigned int seconds);
 asmlinkage long sys_getpgrp(void);
 asmlinkage long sys_pause(void);
 asmlinkage long sys_time(time_t __user *tloc);
+#ifdef __ARCH_WANT_SYS_UTIME
 asmlinkage long sys_utime(char __user *filename,
 				struct utimbuf __user *times);
+asmlinkage long sys_utimes(char __user *filename,
+				struct timeval __user *utimes);
+asmlinkage long sys_futimesat(int dfd, const char __user *filename,
+			      struct timeval __user *utimes);
+#endif
 asmlinkage long sys_creat(const char __user *pathname, umode_t mode);
 asmlinkage long sys_getdents(unsigned int fd,
 				struct linux_dirent __user *dirent,
 				unsigned int count);
-asmlinkage long sys_futimesat(int dfd, const char __user *filename,
-			      struct timeval __user *utimes);
 asmlinkage long sys_select(int n, fd_set __user *inp, fd_set __user *outp,
 			fd_set __user *exp, struct timeval __user *tvp);
 asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
diff --git a/include/linux/time32.h b/include/linux/time32.h
index d1ae43c13e25..61904a6c098f 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -13,6 +13,36 @@
 
 #define TIME_T_MAX	(time_t)((1UL << ((sizeof(time_t) << 3) - 1)) - 1)
 
+typedef s32		old_time32_t;
+
+struct old_timespec32 {
+	old_time32_t	tv_sec;
+	s32		tv_nsec;
+};
+
+struct old_timeval32 {
+	old_time32_t	tv_sec;
+	s32		tv_usec;
+};
+
+struct old_itimerspec32 {
+	struct old_timespec32 it_interval;
+	struct old_timespec32 it_value;
+};
+
+struct old_utimbuf32 {
+	old_time32_t	actime;
+	old_time32_t	modtime;
+};
+
+extern int get_old_timespec32(struct timespec64 *, const void __user *);
+extern int put_old_timespec32(const struct timespec64 *, void __user *);
+extern int get_old_itimerspec32(struct itimerspec64 *its,
+			const struct old_itimerspec32 __user *uits);
+extern int put_old_itimerspec32(const struct itimerspec64 *its,
+			struct old_itimerspec32 __user *uits);
+
+
 #if __BITS_PER_LONG == 64
 
 /* timespec64 is defined as timespec here */
@@ -105,16 +135,6 @@ static inline bool timespec_valid(const struct timespec *ts)
 	return true;
 }
 
-static inline bool timespec_valid_strict(const struct timespec *ts)
-{
-	if (!timespec_valid(ts))
-		return false;
-	/* Disallow values that could overflow ktime_t */
-	if ((unsigned long long)ts->tv_sec >= KTIME_SEC_MAX)
-		return false;
-	return true;
-}
-
 /**
  * timespec_to_ns - Convert timespec to nanoseconds
  * @ts:		pointer to the timespec variable to be converted
@@ -149,19 +169,6 @@ static __always_inline void timespec_add_ns(struct timespec *a, u64 ns)
 	a->tv_nsec = ns;
 }
 
-/**
- * time_to_tm - converts the calendar time to local broken-down time
- *
- * @totalsecs	the number of seconds elapsed since 00:00:00 on January 1, 1970,
- *		Coordinated Universal Time (UTC).
- * @offset	offset seconds adding to totalsecs.
- * @result	pointer to struct tm variable to receive broken-down time
- */
-static inline void time_to_tm(time_t totalsecs, int offset, struct tm *result)
-{
-	time64_to_tm(totalsecs, offset, result);
-}
-
 static inline unsigned long mktime(const unsigned int year,
 			const unsigned int mon, const unsigned int day,
 			const unsigned int hour, const unsigned int min,
@@ -183,8 +190,6 @@ static inline bool timeval_valid(const struct timeval *tv)
 	return true;
 }
 
-extern struct timespec timespec_trunc(struct timespec t, unsigned int gran);
-
 /**
  * timeval_to_ns - Convert timeval to nanoseconds
  * @ts:		pointer to the timeval variable to be converted
@@ -208,18 +213,17 @@ extern struct timeval ns_to_timeval(const s64 nsec);
 extern struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec);
 
 /*
- * New aliases for compat time functions. These will be used to replace
- * the compat code so it can be shared between 32-bit and 64-bit builds
- * both of which provide compatibility with old 32-bit tasks.
+ * Old names for the 32-bit time_t interfaces, these will be removed
+ * when everything uses the new names.
  */
-#define old_time32_t		compat_time_t
-#define old_timeval32		compat_timeval
-#define old_timespec32		compat_timespec
-#define old_itimerspec32	compat_itimerspec
-#define ns_to_old_timeval32	ns_to_compat_timeval
-#define get_old_itimerspec32	get_compat_itimerspec64
-#define put_old_itimerspec32	put_compat_itimerspec64
-#define get_old_timespec32	compat_get_timespec64
-#define put_old_timespec32	compat_put_timespec64
+#define compat_time_t		old_time32_t
+#define compat_timeval		old_timeval32
+#define compat_timespec		old_timespec32
+#define compat_itimerspec	old_itimerspec32
+#define ns_to_compat_timeval	ns_to_old_timeval32
+#define get_compat_itimerspec64	get_old_itimerspec32
+#define put_compat_itimerspec64	put_old_itimerspec32
+#define compat_get_timespec64	get_old_timespec32
+#define compat_put_timespec64	put_old_timespec32
 
 #endif
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 5d738804e3d6..3faba06411aa 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -266,9 +266,6 @@ extern int update_persistent_clock64(struct timespec64 now);
  * deprecated aliases, don't use in new code
  */
 #define getnstimeofday64(ts)		ktime_get_real_ts64(ts)
-#define get_monotonic_boottime64(ts)	ktime_get_boottime_ts64(ts)
-#define getrawmonotonic64(ts)		ktime_get_raw_ts64(ts)
-#define timekeeping_clocktai64(ts)	ktime_get_clocktai_ts64(ts)
 
 static inline struct timespec64 current_kernel_time64(void)
 {
@@ -279,13 +276,4 @@ static inline struct timespec64 current_kernel_time64(void)
 	return ts;
 }
 
-static inline struct timespec64 get_monotonic_coarse64(void)
-{
-	struct timespec64 ts;
-
-	ktime_get_coarse_ts64(&ts);
-
-	return ts;
-}
-
 #endif
diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index 8762c2f45f8b..a502616f7e1c 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -6,27 +6,18 @@
  * over time so we can remove the file here.
  */
 
-extern void do_gettimeofday(struct timeval *tv);
-unsigned long get_seconds(void);
-
-static inline struct timespec current_kernel_time(void)
+static inline void do_gettimeofday(struct timeval *tv)
 {
-	struct timespec64 ts64;
+	struct timespec64 now;
 
-	ktime_get_coarse_real_ts64(&ts64);
-
-	return timespec64_to_timespec(ts64);
+	ktime_get_real_ts64(&now);
+	tv->tv_sec = now.tv_sec;
+	tv->tv_usec = now.tv_nsec/1000;
 }
 
-/**
- * Deprecated. Use do_settimeofday64().
- */
-static inline int do_settimeofday(const struct timespec *ts)
+static inline unsigned long get_seconds(void)
 {
-	struct timespec64 ts64;
-
-	ts64 = timespec_to_timespec64(*ts);
-	return do_settimeofday64(&ts64);
+	return ktime_get_real_seconds();
 }
 
 static inline void getnstimeofday(struct timespec *ts)
@@ -45,14 +36,6 @@ static inline void ktime_get_ts(struct timespec *ts)
 	*ts = timespec64_to_timespec(ts64);
 }
 
-static inline void ktime_get_real_ts(struct timespec *ts)
-{
-	struct timespec64 ts64;
-
-	ktime_get_real_ts64(&ts64);
-	*ts = timespec64_to_timespec(ts64);
-}
-
 static inline void getrawmonotonic(struct timespec *ts)
 {
 	struct timespec64 ts64;
@@ -61,15 +44,6 @@ static inline void getrawmonotonic(struct timespec *ts)
 	*ts = timespec64_to_timespec(ts64);
 }
 
-static inline struct timespec get_monotonic_coarse(void)
-{
-	struct timespec64 ts64;
-
-	ktime_get_coarse_ts64(&ts64);
-
-	return timespec64_to_timespec(ts64);
-}
-
 static inline void getboottime(struct timespec *ts)
 {
 	struct timespec64 ts64;
@@ -78,19 +52,6 @@ static inline void getboottime(struct timespec *ts)
 	*ts = timespec64_to_timespec(ts64);
 }
 
-/*
- * Timespec interfaces utilizing the ktime based ones
- */
-static inline void get_monotonic_boottime(struct timespec *ts)
-{
-	*ts = ktime_to_timespec(ktime_get_boottime());
-}
-
-static inline void timekeeping_clocktai(struct timespec *ts)
-{
-	*ts = ktime_to_timespec(ktime_get_clocktai());
-}
-
 /*
  * Persistent clock related interfaces
  */
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index df4bedb9b01c..538546edbfbd 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -242,10 +242,12 @@ __SYSCALL(__NR_tee, sys_tee)
 /* fs/stat.c */
 #define __NR_readlinkat 78
 __SYSCALL(__NR_readlinkat, sys_readlinkat)
+#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
 #define __NR3264_fstatat 79
 __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
 #define __NR3264_fstat 80
 __SC_3264(__NR3264_fstat, sys_fstat64, sys_newfstat)
+#endif
 
 /* fs/sync.c */
 #define __NR_sync 81
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index c0d58f390c3b..db7833370351 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1461,10 +1461,10 @@ COMPAT_SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
 #endif
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
-static int compat_prepare_timeout(const struct compat_timespec __user *p,
+static int compat_prepare_timeout(const struct old_timespec32 __user *p,
 				   struct timespec64 *ts)
 {
-	if (compat_get_timespec64(ts, p))
+	if (get_old_timespec32(ts, p))
 		return -EFAULT;
 	if (!timespec64_valid(ts))
 		return -EINVAL;
@@ -1474,7 +1474,7 @@ static int compat_prepare_timeout(const struct compat_timespec __user *p,
 COMPAT_SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes,
 		       const char __user *, u_msg_ptr,
 		       compat_size_t, msg_len, unsigned int, msg_prio,
-		       const struct compat_timespec __user *, u_abs_timeout)
+		       const struct old_timespec32 __user *, u_abs_timeout)
 {
 	struct timespec64 ts, *p = NULL;
 	if (u_abs_timeout) {
@@ -1489,7 +1489,7 @@ COMPAT_SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes,
 COMPAT_SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes,
 		       char __user *, u_msg_ptr,
 		       compat_size_t, msg_len, unsigned int __user *, u_msg_prio,
-		       const struct compat_timespec __user *, u_abs_timeout)
+		       const struct old_timespec32 __user *, u_abs_timeout)
 {
 	struct timespec64 ts, *p = NULL;
 	if (u_abs_timeout) {
diff --git a/ipc/msg.c b/ipc/msg.c
index 883642cf2b27..0833c6405915 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -622,9 +622,9 @@ struct compat_msqid_ds {
 	struct compat_ipc_perm msg_perm;
 	compat_uptr_t msg_first;
 	compat_uptr_t msg_last;
-	compat_time_t msg_stime;
-	compat_time_t msg_rtime;
-	compat_time_t msg_ctime;
+	old_time32_t msg_stime;
+	old_time32_t msg_rtime;
+	old_time32_t msg_ctime;
 	compat_ulong_t msg_lcbytes;
 	compat_ulong_t msg_lqbytes;
 	unsigned short msg_cbytes;
diff --git a/ipc/sem.c b/ipc/sem.c
index 26f8e37fcdcb..745dc6187e84 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1698,8 +1698,8 @@ SYSCALL_DEFINE4(semctl, int, semid, int, semnum, int, cmd, unsigned long, arg)
 
 struct compat_semid_ds {
 	struct compat_ipc_perm sem_perm;
-	compat_time_t sem_otime;
-	compat_time_t sem_ctime;
+	old_time32_t sem_otime;
+	old_time32_t sem_ctime;
 	compat_uptr_t sem_base;
 	compat_uptr_t sem_pending;
 	compat_uptr_t sem_pending_last;
@@ -2214,11 +2214,11 @@ SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsops,
 #ifdef CONFIG_COMPAT_32BIT_TIME
 long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
-			    const struct compat_timespec __user *timeout)
+			    const struct old_timespec32 __user *timeout)
 {
 	if (timeout) {
 		struct timespec64 ts;
-		if (compat_get_timespec64(&ts, timeout))
+		if (get_old_timespec32(&ts, timeout))
 			return -EFAULT;
 		return do_semtimedop(semid, tsems, nsops, &ts);
 	}
@@ -2227,7 +2227,7 @@ long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 
 COMPAT_SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsems,
 		       unsigned int, nsops,
-		       const struct compat_timespec __user *, timeout)
+		       const struct old_timespec32 __user *, timeout)
 {
 	return compat_ksys_semtimedop(semid, tsems, nsops, timeout);
 }
diff --git a/ipc/shm.c b/ipc/shm.c
index b0eb3757ab89..2657692199eb 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1201,9 +1201,9 @@ SYSCALL_DEFINE3(shmctl, int, shmid, int, cmd, struct shmid_ds __user *, buf)
 struct compat_shmid_ds {
 	struct compat_ipc_perm shm_perm;
 	int shm_segsz;
-	compat_time_t shm_atime;
-	compat_time_t shm_dtime;
-	compat_time_t shm_ctime;
+	old_time32_t shm_atime;
+	old_time32_t shm_dtime;
+	old_time32_t shm_ctime;
 	compat_ipc_pid_t shm_cpid;
 	compat_ipc_pid_t shm_lpid;
 	unsigned short shm_nattch;
diff --git a/ipc/syscall.c b/ipc/syscall.c
index 65d405f1ba0c..1ac06e3983c0 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -35,7 +35,7 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 			        (const struct __kernel_timespec __user *)fifth);
 		else if (IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
 			return compat_ksys_semtimedop(first, ptr, second,
-			        (const struct compat_timespec __user *)fifth);
+			        (const struct old_timespec32 __user *)fifth);
 		else
 			return -ENOSYS;
 
diff --git a/ipc/util.h b/ipc/util.h
index 0a159f69b3bb..1ee81bce25e9 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -266,7 +266,7 @@ long ksys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 /* for CONFIG_ARCH_WANT_OLD_COMPAT_IPC */
 long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
-			    const struct compat_timespec __user *timeout);
+			    const struct old_timespec32 __user *timeout);
 #ifdef CONFIG_COMPAT
 long compat_ksys_semctl(int semid, int semnum, int cmd, int arg);
 long compat_ksys_msgctl(int msqid, int cmd, void __user *uptr);
diff --git a/kernel/compat.c b/kernel/compat.c
index 8e40efc2928a..089d00d0da9c 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -93,28 +93,28 @@ int compat_put_timex(struct compat_timex __user *utp, const struct timex *txc)
 	return 0;
 }
 
-static int __compat_get_timeval(struct timeval *tv, const struct compat_timeval __user *ctv)
+static int __compat_get_timeval(struct timeval *tv, const struct old_timeval32 __user *ctv)
 {
 	return (!access_ok(VERIFY_READ, ctv, sizeof(*ctv)) ||
 			__get_user(tv->tv_sec, &ctv->tv_sec) ||
 			__get_user(tv->tv_usec, &ctv->tv_usec)) ? -EFAULT : 0;
 }
 
-static int __compat_put_timeval(const struct timeval *tv, struct compat_timeval __user *ctv)
+static int __compat_put_timeval(const struct timeval *tv, struct old_timeval32 __user *ctv)
 {
 	return (!access_ok(VERIFY_WRITE, ctv, sizeof(*ctv)) ||
 			__put_user(tv->tv_sec, &ctv->tv_sec) ||
 			__put_user(tv->tv_usec, &ctv->tv_usec)) ? -EFAULT : 0;
 }
 
-static int __compat_get_timespec(struct timespec *ts, const struct compat_timespec __user *cts)
+static int __compat_get_timespec(struct timespec *ts, const struct old_timespec32 __user *cts)
 {
 	return (!access_ok(VERIFY_READ, cts, sizeof(*cts)) ||
 			__get_user(ts->tv_sec, &cts->tv_sec) ||
 			__get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
 }
 
-static int __compat_put_timespec(const struct timespec *ts, struct compat_timespec __user *cts)
+static int __compat_put_timespec(const struct timespec *ts, struct old_timespec32 __user *cts)
 {
 	return (!access_ok(VERIFY_WRITE, cts, sizeof(*cts)) ||
 			__put_user(ts->tv_sec, &cts->tv_sec) ||
diff --git a/kernel/futex_compat.c b/kernel/futex_compat.c
index 83f830acbb5f..410a77a8f6e2 100644
--- a/kernel/futex_compat.c
+++ b/kernel/futex_compat.c
@@ -173,7 +173,7 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 }
 
 COMPAT_SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
-		struct compat_timespec __user *, utime, u32 __user *, uaddr2,
+		struct old_timespec32 __user *, utime, u32 __user *, uaddr2,
 		u32, val3)
 {
 	struct timespec ts;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc9897f62..39af2bec2b39 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5243,7 +5243,7 @@ static int sched_rr_get_interval(pid_t pid, struct timespec64 *t)
  * an error code.
  */
 SYSCALL_DEFINE2(sched_rr_get_interval, pid_t, pid,
-		struct timespec __user *, interval)
+		struct __kernel_timespec __user *, interval)
 {
 	struct timespec64 t;
 	int retval = sched_rr_get_interval(pid, &t);
@@ -5254,16 +5254,16 @@ SYSCALL_DEFINE2(sched_rr_get_interval, pid_t, pid,
 	return retval;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE2(sched_rr_get_interval,
 		       compat_pid_t, pid,
-		       struct compat_timespec __user *, interval)
+		       struct old_timespec32 __user *, interval)
 {
 	struct timespec64 t;
 	int retval = sched_rr_get_interval(pid, &t);
 
 	if (retval == 0)
-		retval = compat_put_timespec64(&t, interval);
+		retval = put_old_timespec32(&t, interval);
 	return retval;
 }
 #endif
diff --git a/kernel/signal.c b/kernel/signal.c
index 5843c541fda9..0831d56a731a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3082,7 +3082,7 @@ int copy_siginfo_from_user32(struct siginfo *to,
  *  @ts: upper bound on process time suspension
  */
 static int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
-		    const struct timespec *ts)
+		    const struct timespec64 *ts)
 {
 	ktime_t *to = NULL, timeout = KTIME_MAX;
 	struct task_struct *tsk = current;
@@ -3090,9 +3090,9 @@ static int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
 	int sig, ret = 0;
 
 	if (ts) {
-		if (!timespec_valid(ts))
+		if (!timespec64_valid(ts))
 			return -EINVAL;
-		timeout = timespec_to_ktime(*ts);
+		timeout = timespec64_to_ktime(*ts);
 		to = &timeout;
 	}
 
@@ -3140,11 +3140,12 @@ static int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
  *  @sigsetsize: size of sigset_t type
  */
 SYSCALL_DEFINE4(rt_sigtimedwait, const sigset_t __user *, uthese,
-		siginfo_t __user *, uinfo, const struct timespec __user *, uts,
+		siginfo_t __user *, uinfo,
+		const struct __kernel_timespec __user *, uts,
 		size_t, sigsetsize)
 {
 	sigset_t these;
-	struct timespec ts;
+	struct timespec64 ts;
 	siginfo_t info;
 	int ret;
 
@@ -3156,7 +3157,7 @@ SYSCALL_DEFINE4(rt_sigtimedwait, const sigset_t __user *, uthese,
 		return -EFAULT;
 
 	if (uts) {
-		if (copy_from_user(&ts, uts, sizeof(ts)))
+		if (get_timespec64(&ts, uts))
 			return -EFAULT;
 	}
 
@@ -3173,10 +3174,10 @@ SYSCALL_DEFINE4(rt_sigtimedwait, const sigset_t __user *, uthese,
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
 		struct compat_siginfo __user *, uinfo,
-		struct compat_timespec __user *, uts, compat_size_t, sigsetsize)
+		struct old_timespec32 __user *, uts, compat_size_t, sigsetsize)
 {
 	sigset_t s;
-	struct timespec t;
+	struct timespec64 t;
 	siginfo_t info;
 	long ret;
 
@@ -3187,7 +3188,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
 		return -EFAULT;
 
 	if (uts) {
-		if (compat_get_timespec(&t, uts))
+		if (get_old_timespec32(&t, uts))
 			return -EFAULT;
 	}
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e1a549c9e399..9cdd74bd2d27 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1660,7 +1660,7 @@ int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 	switch(restart->nanosleep.type) {
 #ifdef CONFIG_COMPAT_32BIT_TIME
 	case TT_COMPAT:
-		if (compat_put_timespec64(ts, restart->nanosleep.compat_rmtp))
+		if (put_old_timespec32(ts, restart->nanosleep.compat_rmtp))
 			return -EFAULT;
 		break;
 #endif
@@ -1780,12 +1780,12 @@ SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __user *, rqtp,
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
 
-COMPAT_SYSCALL_DEFINE2(nanosleep, struct compat_timespec __user *, rqtp,
-		       struct compat_timespec __user *, rmtp)
+COMPAT_SYSCALL_DEFINE2(nanosleep, struct old_timespec32 __user *, rqtp,
+		       struct old_timespec32 __user *, rmtp)
 {
 	struct timespec64 tu;
 
-	if (compat_get_timespec64(&tu, rqtp))
+	if (get_old_timespec32(&tu, rqtp))
 		return -EFAULT;
 
 	if (!timespec64_valid(&tu))
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 2c6847d5d69b..989ccf028bde 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -162,20 +162,20 @@ COMPAT_SYS_NI(setitimer);
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
-		       struct compat_timespec __user *, tp)
+		       struct old_timespec32 __user *, tp)
 {
 	struct timespec64 new_tp;
 
 	if (which_clock != CLOCK_REALTIME)
 		return -EINVAL;
-	if (compat_get_timespec64(&new_tp, tp))
+	if (get_old_timespec32(&new_tp, tp))
 		return -EFAULT;
 
 	return do_sys_settimeofday64(&new_tp, NULL);
 }
 
 COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
-		       struct compat_timespec __user *, tp)
+		       struct old_timespec32 __user *, tp)
 {
 	int ret;
 	struct timespec64 kernel_tp;
@@ -184,13 +184,13 @@ COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
 	if (ret)
 		return ret;
 
-	if (compat_put_timespec64(&kernel_tp, tp))
+	if (put_old_timespec32(&kernel_tp, tp))
 		return -EFAULT;
 	return 0;
 }
 
 COMPAT_SYSCALL_DEFINE2(clock_getres, clockid_t, which_clock,
-		       struct compat_timespec __user *, tp)
+		       struct old_timespec32 __user *, tp)
 {
 	struct timespec64 rtn_tp = {
 		.tv_sec = 0,
@@ -201,7 +201,7 @@ COMPAT_SYSCALL_DEFINE2(clock_getres, clockid_t, which_clock,
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (compat_put_timespec64(&rtn_tp, tp))
+		if (put_old_timespec32(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:
@@ -210,8 +210,8 @@ COMPAT_SYSCALL_DEFINE2(clock_getres, clockid_t, which_clock,
 }
 
 COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
-		       struct compat_timespec __user *, rqtp,
-		       struct compat_timespec __user *, rmtp)
+		       struct old_timespec32 __user *, rqtp,
+		       struct old_timespec32 __user *, rmtp)
 {
 	struct timespec64 t;
 
@@ -224,7 +224,7 @@ COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
 		return -EINVAL;
 	}
 
-	if (compat_get_timespec64(&t, rqtp))
+	if (get_old_timespec32(&t, rqtp))
 		return -EFAULT;
 	if (!timespec64_valid(&t))
 		return -EINVAL;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 4b9127e95430..3e71921668ba 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -755,13 +755,13 @@ SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
 #ifdef CONFIG_COMPAT_32BIT_TIME
 
 COMPAT_SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
-		       struct compat_itimerspec __user *, setting)
+		       struct old_itimerspec32 __user *, setting)
 {
 	struct itimerspec64 cur_setting;
 
 	int ret = do_timer_gettime(timer_id, &cur_setting);
 	if (!ret) {
-		if (put_compat_itimerspec64(&cur_setting, setting))
+		if (put_old_itimerspec32(&cur_setting, setting))
 			ret = -EFAULT;
 	}
 	return ret;
@@ -928,8 +928,8 @@ SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
-		       struct compat_itimerspec __user *, new,
-		       struct compat_itimerspec __user *, old)
+		       struct old_itimerspec32 __user *, new,
+		       struct old_itimerspec32 __user *, old)
 {
 	struct itimerspec64 new_spec, old_spec;
 	struct itimerspec64 *rtn = old ? &old_spec : NULL;
@@ -937,12 +937,12 @@ COMPAT_SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
 
 	if (!new)
 		return -EINVAL;
-	if (get_compat_itimerspec64(&new_spec, new))
+	if (get_old_itimerspec32(&new_spec, new))
 		return -EFAULT;
 
 	error = do_timer_settime(timer_id, flags, &new_spec, rtn);
 	if (!error && old) {
-		if (put_compat_itimerspec64(&old_spec, old))
+		if (put_old_itimerspec32(&old_spec, old))
 			error = -EFAULT;
 	}
 	return error;
@@ -1115,7 +1115,7 @@ SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock,
 #ifdef CONFIG_COMPAT_32BIT_TIME
 
 COMPAT_SYSCALL_DEFINE2(clock_settime, clockid_t, which_clock,
-		       struct compat_timespec __user *, tp)
+		       struct old_timespec32 __user *, tp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 ts;
@@ -1123,14 +1123,14 @@ COMPAT_SYSCALL_DEFINE2(clock_settime, clockid_t, which_clock,
 	if (!kc || !kc->clock_set)
 		return -EINVAL;
 
-	if (compat_get_timespec64(&ts, tp))
+	if (get_old_timespec32(&ts, tp))
 		return -EFAULT;
 
 	return kc->clock_set(which_clock, &ts);
 }
 
 COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
-		       struct compat_timespec __user *, tp)
+		       struct old_timespec32 __user *, tp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 ts;
@@ -1141,7 +1141,7 @@ COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
 
 	err = kc->clock_get(which_clock, &ts);
 
-	if (!err && compat_put_timespec64(&ts, tp))
+	if (!err && put_old_timespec32(&ts, tp))
 		err = -EFAULT;
 
 	return err;
@@ -1180,7 +1180,7 @@ COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
 #ifdef CONFIG_COMPAT_32BIT_TIME
 
 COMPAT_SYSCALL_DEFINE2(clock_getres, clockid_t, which_clock,
-		       struct compat_timespec __user *, tp)
+		       struct old_timespec32 __user *, tp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 ts;
@@ -1190,7 +1190,7 @@ COMPAT_SYSCALL_DEFINE2(clock_getres, clockid_t, which_clock,
 		return -EINVAL;
 
 	err = kc->clock_getres(which_clock, &ts);
-	if (!err && tp && compat_put_timespec64(&ts, tp))
+	if (!err && tp && put_old_timespec32(&ts, tp))
 		return -EFAULT;
 
 	return err;
@@ -1237,8 +1237,8 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 #ifdef CONFIG_COMPAT_32BIT_TIME
 
 COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
-		       struct compat_timespec __user *, rqtp,
-		       struct compat_timespec __user *, rmtp)
+		       struct old_timespec32 __user *, rqtp,
+		       struct old_timespec32 __user *, rmtp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 t;
@@ -1248,7 +1248,7 @@ COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
 	if (!kc->nsleep)
 		return -EOPNOTSUPP;
 
-	if (compat_get_timespec64(&t, rqtp))
+	if (get_old_timespec32(&t, rqtp))
 		return -EFAULT;
 
 	if (!timespec64_valid(&t))
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index aa2094d5dd27..be0aac2b4300 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -400,8 +400,6 @@ void tick_broadcast_control(enum tick_broadcast_mode mode)
 		if (tick_broadcast_forced)
 			break;
 		cpumask_clear_cpu(cpu, tick_broadcast_on);
-		if (!tick_device_is_functional(dev))
-			break;
 		if (cpumask_test_and_clear_cpu(cpu, tick_broadcast_mask)) {
 			if (tick_broadcast_device.mode ==
 			    TICKDEV_MODE_PERIODIC)
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 5b33e2f5c0ed..69e673b88474 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -885,7 +885,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	if (need_resched())
 		return false;
 
-	if (unlikely(local_softirq_pending() && cpu_online(cpu))) {
+	if (unlikely(local_softirq_pending())) {
 		static int ratelimit;
 
 		if (ratelimit < 10 &&
diff --git a/kernel/time/time.c b/kernel/time/time.c
index ccdb351277ee..e3a7f7fd3abc 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -104,12 +104,12 @@ SYSCALL_DEFINE1(stime, time_t __user *, tptr)
 #ifdef CONFIG_COMPAT
 #ifdef __ARCH_WANT_COMPAT_SYS_TIME
 
-/* compat_time_t is a 32 bit "long" and needs to get converted. */
-COMPAT_SYSCALL_DEFINE1(time, compat_time_t __user *, tloc)
+/* old_time32_t is a 32 bit "long" and needs to get converted. */
+COMPAT_SYSCALL_DEFINE1(time, old_time32_t __user *, tloc)
 {
-	compat_time_t i;
+	old_time32_t i;
 
-	i = (compat_time_t)ktime_get_real_seconds();
+	i = (old_time32_t)ktime_get_real_seconds();
 
 	if (tloc) {
 		if (put_user(i,tloc))
@@ -119,7 +119,7 @@ COMPAT_SYSCALL_DEFINE1(time, compat_time_t __user *, tloc)
 	return i;
 }
 
-COMPAT_SYSCALL_DEFINE1(stime, compat_time_t __user *, tptr)
+COMPAT_SYSCALL_DEFINE1(stime, old_time32_t __user *, tptr)
 {
 	struct timespec64 tv;
 	int err;
@@ -144,9 +144,11 @@ SYSCALL_DEFINE2(gettimeofday, struct timeval __user *, tv,
 		struct timezone __user *, tz)
 {
 	if (likely(tv != NULL)) {
-		struct timeval ktv;
-		do_gettimeofday(&ktv);
-		if (copy_to_user(tv, &ktv, sizeof(ktv)))
+		struct timespec64 ts;
+
+		ktime_get_real_ts64(&ts);
+		if (put_user(ts.tv_sec, &tv->tv_sec) ||
+		    put_user(ts.tv_nsec / 1000, &tv->tv_usec))
 			return -EFAULT;
 	}
 	if (unlikely(tz != NULL)) {
@@ -223,14 +225,15 @@ SYSCALL_DEFINE2(settimeofday, struct timeval __user *, tv,
 }
 
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE2(gettimeofday, struct compat_timeval __user *, tv,
+COMPAT_SYSCALL_DEFINE2(gettimeofday, struct old_timeval32 __user *, tv,
 		       struct timezone __user *, tz)
 {
 	if (tv) {
-		struct timeval ktv;
+		struct timespec64 ts;
 
-		do_gettimeofday(&ktv);
-		if (compat_put_timeval(&ktv, tv))
+		ktime_get_real_ts64(&ts);
+		if (put_user(ts.tv_sec, &tv->tv_sec) ||
+		    put_user(ts.tv_nsec / 1000, &tv->tv_usec))
 			return -EFAULT;
 	}
 	if (tz) {
@@ -241,7 +244,7 @@ COMPAT_SYSCALL_DEFINE2(gettimeofday, struct compat_timeval __user *, tv,
 	return 0;
 }
 
-COMPAT_SYSCALL_DEFINE2(settimeofday, struct compat_timeval __user *, tv,
+COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 		       struct timezone __user *, tz)
 {
 	struct timespec64 new_ts;
@@ -342,30 +345,6 @@ unsigned int jiffies_to_usecs(const unsigned long j)
 }
 EXPORT_SYMBOL(jiffies_to_usecs);
 
-/**
- * timespec_trunc - Truncate timespec to a granularity
- * @t: Timespec
- * @gran: Granularity in ns.
- *
- * Truncate a timespec to a granularity. Always rounds down. gran must
- * not be 0 nor greater than a second (NSEC_PER_SEC, or 10^9 ns).
- */
-struct timespec timespec_trunc(struct timespec t, unsigned gran)
-{
-	/* Avoid division in the common cases 1 ns and 1 s. */
-	if (gran == 1) {
-		/* nothing */
-	} else if (gran == NSEC_PER_SEC) {
-		t.tv_nsec = 0;
-	} else if (gran > 1 && gran < NSEC_PER_SEC) {
-		t.tv_nsec -= t.tv_nsec % gran;
-	} else {
-		WARN(1, "illegal file time granularity: %u", gran);
-	}
-	return t;
-}
-EXPORT_SYMBOL(timespec_trunc);
-
 /*
  * mktime64 - Converts date to seconds.
  * Converts Gregorian date to seconds since 1970-01-01 00:00:00.
@@ -884,10 +863,10 @@ int put_timespec64(const struct timespec64 *ts,
 }
 EXPORT_SYMBOL_GPL(put_timespec64);
 
-int __compat_get_timespec64(struct timespec64 *ts64,
-				   const struct compat_timespec __user *cts)
+static int __get_old_timespec32(struct timespec64 *ts64,
+				   const struct old_timespec32 __user *cts)
 {
-	struct compat_timespec ts;
+	struct old_timespec32 ts;
 	int ret;
 
 	ret = copy_from_user(&ts, cts, sizeof(ts));
@@ -900,33 +879,33 @@ int __compat_get_timespec64(struct timespec64 *ts64,
 	return 0;
 }
 
-int __compat_put_timespec64(const struct timespec64 *ts64,
-				   struct compat_timespec __user *cts)
+static int __put_old_timespec32(const struct timespec64 *ts64,
+				   struct old_timespec32 __user *cts)
 {
-	struct compat_timespec ts = {
+	struct old_timespec32 ts = {
 		.tv_sec = ts64->tv_sec,
 		.tv_nsec = ts64->tv_nsec
 	};
 	return copy_to_user(cts, &ts, sizeof(ts)) ? -EFAULT : 0;
 }
 
-int compat_get_timespec64(struct timespec64 *ts, const void __user *uts)
+int get_old_timespec32(struct timespec64 *ts, const void __user *uts)
 {
 	if (COMPAT_USE_64BIT_TIME)
 		return copy_from_user(ts, uts, sizeof(*ts)) ? -EFAULT : 0;
 	else
-		return __compat_get_timespec64(ts, uts);
+		return __get_old_timespec32(ts, uts);
 }
-EXPORT_SYMBOL_GPL(compat_get_timespec64);
+EXPORT_SYMBOL_GPL(get_old_timespec32);
 
-int compat_put_timespec64(const struct timespec64 *ts, void __user *uts)
+int put_old_timespec32(const struct timespec64 *ts, void __user *uts)
 {
 	if (COMPAT_USE_64BIT_TIME)
 		return copy_to_user(uts, ts, sizeof(*ts)) ? -EFAULT : 0;
 	else
-		return __compat_put_timespec64(ts, uts);
+		return __put_old_timespec32(ts, uts);
 }
-EXPORT_SYMBOL_GPL(compat_put_timespec64);
+EXPORT_SYMBOL_GPL(put_old_timespec32);
 
 int get_itimerspec64(struct itimerspec64 *it,
 			const struct __kernel_itimerspec __user *uit)
@@ -958,23 +937,23 @@ int put_itimerspec64(const struct itimerspec64 *it,
 }
 EXPORT_SYMBOL_GPL(put_itimerspec64);
 
-int get_compat_itimerspec64(struct itimerspec64 *its,
-			const struct compat_itimerspec __user *uits)
+int get_old_itimerspec32(struct itimerspec64 *its,
+			const struct old_itimerspec32 __user *uits)
 {
 
-	if (__compat_get_timespec64(&its->it_interval, &uits->it_interval) ||
-	    __compat_get_timespec64(&its->it_value, &uits->it_value))
+	if (__get_old_timespec32(&its->it_interval, &uits->it_interval) ||
+	    __get_old_timespec32(&its->it_value, &uits->it_value))
 		return -EFAULT;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(get_compat_itimerspec64);
+EXPORT_SYMBOL_GPL(get_old_itimerspec32);
 
-int put_compat_itimerspec64(const struct itimerspec64 *its,
-			struct compat_itimerspec __user *uits)
+int put_old_itimerspec32(const struct itimerspec64 *its,
+			struct old_itimerspec32 __user *uits)
 {
-	if (__compat_put_timespec64(&its->it_interval, &uits->it_interval) ||
-	    __compat_put_timespec64(&its->it_value, &uits->it_value))
+	if (__put_old_timespec32(&its->it_interval, &uits->it_interval) ||
+	    __put_old_timespec32(&its->it_value, &uits->it_value))
 		return -EFAULT;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(put_compat_itimerspec64);
+EXPORT_SYMBOL_GPL(put_old_itimerspec32);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f3b22f456fac..2d110c948805 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1211,22 +1211,6 @@ int get_device_system_crosststamp(int (*get_time_fn)
 }
 EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
 
-/**
- * do_gettimeofday - Returns the time of day in a timeval
- * @tv:		pointer to the timeval to be set
- *
- * NOTE: Users should be converted to using getnstimeofday()
- */
-void do_gettimeofday(struct timeval *tv)
-{
-	struct timespec64 now;
-
-	getnstimeofday64(&now);
-	tv->tv_sec = now.tv_sec;
-	tv->tv_usec = now.tv_nsec/1000;
-}
-EXPORT_SYMBOL(do_gettimeofday);
-
 /**
  * do_settimeofday64 - Sets the time of day.
  * @ts:     pointer to the timespec64 variable containing the new time
@@ -2174,14 +2158,6 @@ void getboottime64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL_GPL(getboottime64);
 
-unsigned long get_seconds(void)
-{
-	struct timekeeper *tk = &tk_core.timekeeper;
-
-	return tk->xtime_sec;
-}
-EXPORT_SYMBOL(get_seconds);
-
 void ktime_get_coarse_real_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
diff --git a/net/compat.c b/net/compat.c
index 3b2105f6549d..47a614b370cd 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -812,21 +812,21 @@ COMPAT_SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, buf, compat_size_t, len
 
 static int __compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
 				 unsigned int vlen, unsigned int flags,
-				 struct compat_timespec __user *timeout)
+				 struct old_timespec32 __user *timeout)
 {
 	int datagrams;
-	struct timespec ktspec;
+	struct timespec64 ktspec;
 
 	if (timeout == NULL)
 		return __sys_recvmmsg(fd, (struct mmsghdr __user *)mmsg, vlen,
 				      flags | MSG_CMSG_COMPAT, NULL);
 
-	if (compat_get_timespec(&ktspec, timeout))
+	if (compat_get_timespec64(&ktspec, timeout))
 		return -EFAULT;
 
 	datagrams = __sys_recvmmsg(fd, (struct mmsghdr __user *)mmsg, vlen,
 				   flags | MSG_CMSG_COMPAT, &ktspec);
-	if (datagrams > 0 && compat_put_timespec(&ktspec, timeout))
+	if (datagrams > 0 && compat_put_timespec64(&ktspec, timeout))
 		datagrams = -EFAULT;
 
 	return datagrams;
@@ -834,7 +834,7 @@ static int __compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
 
 COMPAT_SYSCALL_DEFINE5(recvmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
 		       unsigned int, vlen, unsigned int, flags,
-		       struct compat_timespec __user *, timeout)
+		       struct old_timespec32 __user *, timeout)
 {
 	return __compat_sys_recvmmsg(fd, mmsg, vlen, flags, timeout);
 }
diff --git a/net/socket.c b/net/socket.c
index e6945e318f02..b9d71b503720 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2340,7 +2340,7 @@ SYSCALL_DEFINE3(recvmsg, int, fd, struct user_msghdr __user *, msg,
  */
 
 int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
-		   unsigned int flags, struct timespec *timeout)
+		   unsigned int flags, struct timespec64 *timeout)
 {
 	int fput_needed, err, datagrams;
 	struct socket *sock;
@@ -2405,8 +2405,7 @@ int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 
 		if (timeout) {
 			ktime_get_ts64(&timeout64);
-			*timeout = timespec64_to_timespec(
-					timespec64_sub(end_time, timeout64));
+			*timeout = timespec64_sub(end_time, timeout64);
 			if (timeout->tv_sec < 0) {
 				timeout->tv_sec = timeout->tv_nsec = 0;
 				break;
@@ -2452,10 +2451,10 @@ int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 
 static int do_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 			   unsigned int vlen, unsigned int flags,
-			   struct timespec __user *timeout)
+			   struct __kernel_timespec __user *timeout)
 {
 	int datagrams;
-	struct timespec timeout_sys;
+	struct timespec64 timeout_sys;
 
 	if (flags & MSG_CMSG_COMPAT)
 		return -EINVAL;
@@ -2463,13 +2462,12 @@ static int do_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 	if (!timeout)
 		return __sys_recvmmsg(fd, mmsg, vlen, flags, NULL);
 
-	if (copy_from_user(&timeout_sys, timeout, sizeof(timeout_sys)))
+	if (get_timespec64(&timeout_sys, timeout))
 		return -EFAULT;
 
 	datagrams = __sys_recvmmsg(fd, mmsg, vlen, flags, &timeout_sys);
 
-	if (datagrams > 0 &&
-	    copy_to_user(timeout, &timeout_sys, sizeof(timeout_sys)))
+	if (datagrams > 0 && put_timespec64(&timeout_sys, timeout))
 		datagrams = -EFAULT;
 
 	return datagrams;
@@ -2477,7 +2475,7 @@ static int do_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 
 SYSCALL_DEFINE5(recvmmsg, int, fd, struct mmsghdr __user *, mmsg,
 		unsigned int, vlen, unsigned int, flags,
-		struct timespec __user *, timeout)
+		struct __kernel_timespec __user *, timeout)
 {
 	return do_sys_recvmmsg(fd, mmsg, vlen, flags, timeout);
 }
@@ -2601,7 +2599,7 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 		break;
 	case SYS_RECVMMSG:
 		err = do_sys_recvmmsg(a0, (struct mmsghdr __user *)a1, a[2],
-				      a[3], (struct timespec __user *)a[4]);
+				      a[3], (struct __kernel_timespec __user *)a[4]);
 		break;
 	case SYS_ACCEPT4:
 		err = __sys_accept4(a0, (struct sockaddr __user *)a1,
