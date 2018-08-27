Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173DDC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77D8208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77D8208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeH0Xdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:33:45 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54609 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeH0Xdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:33:44 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0McnTN-1gCBQ61ygj-00I0a2; Mon, 27 Aug 2018 21:45:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     tglx@linutronix.de
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, deepa.kernel@gmail.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 00/14] y2038 syscall changes for 4.20
Date:   Mon, 27 Aug 2018 21:45:17 +0200
Message-Id: <20180827194531.3796559-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:gUFtbYPF7j9berm3qb/nTTQr0X3ghf3m74wWz79yuKoMDz0FDdr
 rkjgK/hoq3d4Fg4v19U6T0KJCAl9NU96umau+5WBRERDluCbOnutnirCHJXaD1s/SZO0RL4
 PUECIdiuHtItySx5vIlDDPKAlZ7ht9zcaOMY6oHDOrbKm5rRoOdOnHNjGIs3WLj5lWJsLXC
 3dRLraA6yIax7Eh7BzOUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CSccXaqFyWU=:HV87woeuvR0MJtvu+bJ1+s
 Ic1DE43kZng3plV7v9JGujFeu0NKFhwfmICDZInpp4nha0AY0+fP+9+7IcTPTy/bxfKBL/6py
 K2F/d2aVptXLJzlqj5xB7PJ74kOTGXJQc552lckne0Eq4oCEe9gr+xrPsWOEpSlCrFsFChuVG
 xo6G02aiMSNuHfN6TT67QV2IvoUngPu/jjuf0LIRDl/5AoKtMykJcIlqvewKtGdH/CCOuV7M6
 HmQ0MCW46B0umw0zfr2eKdSGiwjf73ZBQv1pICJBlTov84PXLbCdybLPxK+DsplJpnuHKZMQW
 TBZ6KU4ZeqIzEjJ7Utr+EtWVk1NjeaI0VpOmZjYi8jfKfTmjjYa37Vz3afLpDNx3pC2c2SGfP
 JAYvVn7vArsVZGK/TntZY43LhulO++3lBS7wXozgbrfaIDjJtcdsYZNr/viqPAb9K/rJ7HrdW
 sSDF91DG2td6aErMNLI+lq5t2H4aTtniqpcSXVN7I46hB+SnSOSnfGJwBVG1l/CvczmdZGzUX
 +Ki2zRx9bWVHoszR+lSPzpnfmRjw+H3FHYMeLoth44L2YaRrFHPTdBpAxPyzgFqPo49x2aUOh
 x4AP0pgFYoxlslx/5kj1jcCyJVej3ug/jMGZeClx2WErGy7GKf2Kud0l0ZSIqWI+h90Hj5i4R
 KJHlGYDnx3o2932TOZNObWhUJXcfSB5L8T8f/i3lNYMECfhViWMW86GQTB+SIVea6usU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

I've rebased the syscall changes on top of 4.19-rc1, and the old_time32
rename. This is the first set of those patches, the ones that I hope
are all uncontroversial and obvious now. I'm still in the process of
reorganizing and testing the next set batch top, and plan to send them
after you've merged these.

The first three patches are new here, the other ones have been posted
before a few times.

      Arnd

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

 arch/alpha/include/asm/unistd.h          |   2 +
 arch/arc/include/uapi/asm/unistd.h       |   1 +
 arch/arm/include/asm/unistd.h            |   4 +-
 arch/arm64/include/asm/compat.h          |  26 ++----
 arch/arm64/include/asm/stat.h            |   2 +-
 arch/arm64/include/asm/unistd.h          |   2 +-
 arch/arm64/include/uapi/asm/unistd.h     |   1 +
 arch/c6x/include/uapi/asm/unistd.h       |   1 +
 arch/h8300/include/uapi/asm/unistd.h     |   1 +
 arch/hexagon/include/uapi/asm/unistd.h   |   1 +
 arch/ia64/include/asm/unistd.h           |   3 +
 arch/m68k/include/asm/unistd.h           |   2 +-
 arch/microblaze/include/asm/unistd.h     |   2 +-
 arch/mips/include/asm/compat.h           |  28 ++-----
 arch/mips/include/asm/unistd.h           |   3 +-
 arch/mips/kernel/binfmt_elfn32.c         |  14 ++--
 arch/mips/kernel/binfmt_elfo32.c         |  14 ++--
 arch/nds32/include/uapi/asm/unistd.h     |   1 +
 arch/nios2/include/uapi/asm/unistd.h     |   1 +
 arch/openrisc/include/uapi/asm/unistd.h  |   1 +
 arch/parisc/include/asm/compat.h         |  24 ++----
 arch/parisc/include/asm/unistd.h         |   3 +-
 arch/powerpc/include/asm/compat.h        |  24 ++----
 arch/powerpc/include/asm/unistd.h        |   3 +-
 arch/powerpc/kernel/asm-offsets.c        |   8 +-
 arch/powerpc/oprofile/backtrace.c        |   2 +-
 arch/s390/include/asm/compat.h           |  18 +---
 arch/s390/include/asm/unistd.h           |   3 +-
 arch/sh/include/asm/unistd.h             |   2 +-
 arch/sparc/include/asm/compat.h          |  25 ++----
 arch/sparc/include/asm/unistd.h          |   3 +-
 arch/unicore32/include/uapi/asm/unistd.h |   1 +
 arch/x86/include/asm/compat.h            |  19 +----
 arch/x86/include/asm/unistd.h            |   3 +-
 arch/xtensa/include/asm/unistd.h         |   2 +-
 fs/aio.c                                 |   8 +-
 fs/compat_binfmt_elf.c                   |   2 +-
 fs/read_write.c                          |   2 +-
 fs/select.c                              |  20 ++---
 fs/stat.c                                |   3 +
 fs/timerfd.c                             |  12 +--
 fs/utimes.c                              |  73 ++++++++--------
 include/asm-generic/compat.h             |  24 +++++-
 include/asm-generic/unistd.h             |  13 ---
 include/linux/compat.h                   | 101 +++++++++++------------
 include/linux/compat_time.h              |  32 -------
 include/linux/elfcore-compat.h           |   8 +-
 include/linux/restart_block.h            |   4 +-
 include/linux/socket.h                   |   4 +-
 include/linux/syscalls.h                 |  21 +++--
 include/linux/time32.h                   |  78 ++++++++---------
 include/linux/timekeeping.h              |  12 ---
 include/linux/timekeeping32.h            |  53 ++----------
 include/uapi/asm-generic/unistd.h        |   2 +
 ipc/mqueue.c                             |   8 +-
 ipc/msg.c                                |   6 +-
 ipc/sem.c                                |  10 +--
 ipc/shm.c                                |   6 +-
 ipc/syscall.c                            |   2 +-
 ipc/util.h                               |   2 +-
 kernel/compat.c                          |   8 +-
 kernel/futex_compat.c                    |   2 +-
 kernel/sched/core.c                      |   8 +-
 kernel/signal.c                          |  19 +++--
 kernel/time/hrtimer.c                    |   8 +-
 kernel/time/posix-stubs.c                |  18 ++--
 kernel/time/posix-timers.c               |  30 +++----
 kernel/time/time.c                       |  97 +++++++++-------------
 kernel/time/timekeeping.c                |  24 ------
 net/compat.c                             |  10 +--
 net/socket.c                             |  18 ++--
 71 files changed, 397 insertions(+), 601 deletions(-)
 delete mode 100644 include/asm-generic/unistd.h
 delete mode 100644 include/linux/compat_time.h

-- 
2.18.0

