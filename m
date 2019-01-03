Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37FBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7268F217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546507570;
	bh=wxXDTShdm4qwEQIkjtLHocHu0dVntFaDLK6WjOavtDE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BewsbDj8mtyLsJAprb0LhJ9Smq+zOFu9i97AsMlUDrbUg0w+37oaehJzOwh70WtYu
	 ieQxKm6L3lsl+p2BTA6EAkiruOT84li2NeRiBJBsFJXkNQOO6l2EPEoQs60Zio+r1j
	 iGhTiqB0aki/iciCfXT16kLp+h7EOUYejyR2Ewc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfACJ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:26:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfACJ0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:26:09 -0500
Received: from localhost.localdomain (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DB892073D;
        Thu,  3 Jan 2019 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546507568;
        bh=wxXDTShdm4qwEQIkjtLHocHu0dVntFaDLK6WjOavtDE=;
        h=From:To:Cc:Subject:Date:From;
        b=wfbbD/l/+1De+B4ncVnNXJNxmTYTd4ipj5w2H16TPCsdsZLWFKNxg/FWxFCMNszBa
         C6aVTEkykDU/Du+VIVn0MT2mYT9z3IduHL/xmjuqM/qlw7SM9k6dHkjXbhxbGAv7Qj
         3o2y1kxpmsbkUqT34w1h8ZVzdu/l/RXslzHh2dpM=
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, ren_guo@c-sky.com
Subject: [GIT PULL] csky patches for the 4.21 merge window
Date:   Thu,  3 Jan 2019 17:26:00 +0800
Message-Id: <1546507560-2486-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the git repository at:

  git@github.com:c-sky/csky-linux.git tags/csky-for-linus-4.21

for you to fetch changes up to f50fd2d8524c15b08da9e7e9d84752f0f1be7172:

  csky: Add perf support for C-SKY (2019-01-02 22:17:11 +0800)

----------------------------------------------------------------
arch/csky patches for 4.21-rc1

Here is the arch/csky patch set for the 4.21-rc1 merge window.
Contianed in here is some features (cpu_hotplug, basic ftrace,
basic perf ...) and some bugfixes.

Features:
 - Add CPU-hotplug support for SMP
 - Add ftrace with function trace and function graph trace
 - Add Perf support
 - Add EM_CSKY_OLD 39
 - optimize kernel panic print.
 - remove syscall_exit_work

Bugfixes:
 - fixup abiv2 mmap(... O_SYNC) failed.
 - fixup gdb coredump error.
 - fixup remove vdsp implement for kernel.
 - fixup qemu fail to bootup sometimes.
 - fixup ftrace call-graph panic
 - fixup leak device tree node reference
 - fixup remove meaningless header-y
 - fixup save hi,lo,dspcr regs in switch_stack.
 - fixup unused members in processor.h

----------------------------------------------------------------
Dmitry V. Levin (2):
      elf-em.h: add EM_CSKY
      csky: define syscall_get_arch()

Guo Ren (15):
      csky: fixup abiv2 mmap(... O_SYNC) failed.
      csky: bugfix gdb coredump error.
      csky: fixup remove vdsp implement for kernel.
      csky: remove syscall_exit_work
      csky: fixup save hi,lo,dspcr regs in switch_stack.
      clocksource/drivers/c-sky: fixup qemu fail to bootup sometimes.
      csky: CPU-hotplug supported for SMP
      csky: stacktrace supported.
      csky: optimize kernel panic print.
      csky: remove unused members in processor.h
      csky: basic ftrace supported
      csky: ftrace call graph supported.
      clocksource/drivers/c-sky: fixup ftrace call-graph panic
      csky: Add EM_CSKY_OLD 39
      csky: Add perf support for C-SKY

Masahiro Yamada (1):
      csky: remove meaningless header-y

Yangtao Li (1):
      csky: Don't leak device tree node reference

 arch/csky/Kconfig                        |   30 +-
 arch/csky/Makefile                       |    4 +
 arch/csky/abiv1/inc/abi/pgtable-bits.h   |    1 +
 arch/csky/abiv1/inc/abi/switch_context.h |   17 +
 arch/csky/abiv2/Makefile                 |    1 +
 arch/csky/abiv2/inc/abi/entry.h          |   28 +-
 arch/csky/abiv2/inc/abi/pgtable-bits.h   |    2 +-
 arch/csky/abiv2/inc/abi/switch_context.h |   32 +
 arch/csky/abiv2/mcount.S                 |  124 ++++
 arch/csky/abiv2/memcpy.S                 |    8 +-
 arch/csky/include/asm/elf.h              |   13 +-
 arch/csky/include/asm/ftrace.h           |   13 +
 arch/csky/include/asm/perf_event.h       |    7 +
 arch/csky/include/asm/processor.h        |   15 +-
 arch/csky/include/asm/smp.h              |    4 +
 arch/csky/include/asm/syscall.h          |    7 +
 arch/csky/include/asm/thread_info.h      |    4 +
 arch/csky/include/uapi/asm/Kbuild        |    2 -
 arch/csky/include/uapi/asm/ptrace.h      |   39 +-
 arch/csky/kernel/Makefile                |    7 +
 arch/csky/kernel/asm-offsets.c           |    3 -
 arch/csky/kernel/dumpstack.c             |   59 +-
 arch/csky/kernel/entry.S                 |   50 +-
 arch/csky/kernel/ftrace.c                |   50 ++
 arch/csky/kernel/perf_event.c            | 1031 ++++++++++++++++++++++++++++++
 arch/csky/kernel/process.c               |   29 +-
 arch/csky/kernel/ptrace.c                |   42 +-
 arch/csky/kernel/signal.c                |    2 -
 arch/csky/kernel/smp.c                   |   73 ++-
 arch/csky/kernel/stacktrace.c            |   57 ++
 arch/csky/kernel/traps.c                 |    6 -
 arch/csky/mm/fault.c                     |    7 +-
 arch/csky/mm/ioremap.c                   |    2 +-
 drivers/clocksource/timer-mp-csky.c      |    6 +-
 include/uapi/linux/audit.h               |    1 +
 include/uapi/linux/elf-em.h              |    1 +
 36 files changed, 1555 insertions(+), 222 deletions(-)
 create mode 100644 arch/csky/abiv1/inc/abi/switch_context.h
 create mode 100644 arch/csky/abiv2/inc/abi/switch_context.h
 create mode 100644 arch/csky/abiv2/mcount.S
 create mode 100644 arch/csky/include/asm/ftrace.h
 create mode 100644 arch/csky/include/asm/perf_event.h
 create mode 100644 arch/csky/kernel/ftrace.c
 create mode 100644 arch/csky/kernel/perf_event.c
 create mode 100644 arch/csky/kernel/stacktrace.c
