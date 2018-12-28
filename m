Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A10C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379812146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vClJJZZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbeL1IYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:24:41 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41059 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeL1IYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:24:40 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so10182885edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 00:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=m7NlLWuMK0JbCMv9Gq8qDhbyU4X4Xpw1uGXnInFsRug=;
        b=vClJJZZv0jbAox6bqOIiv/NUHQebr/W+bYshtx31pavoqynfLH25YH2plxjdUWrnLP
         NQ7sXZ8QJfV2ghliXI5prASYVCHOkhg+qepBmk3gkkxqmPuaYUMVyCSwU4ePPl89dnwt
         sta5yCALdxSN0cNjrsqHd9N4Q8GFrKybm/0qMpHC0yrLTHbpWMgN7CPagIU/LOqxg+jI
         e9YvHAISLUAuPDLZ6KOY6RKu8uuLcayDSh3kGwI1N2gJPLYr2H4z5NlC/RFcHibHwm2G
         ZBozvsaLpc9wPqKbwwvpIUv+33rK3FH2CPeAkq1YP1hShXOs1sdPI4bBQbwTLWUMdLpa
         Xz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=m7NlLWuMK0JbCMv9Gq8qDhbyU4X4Xpw1uGXnInFsRug=;
        b=bW/c368mc/Y954B4vxDl8x3LOFLZr96+OkWwxu2wprnFf76vKdX2bGPaFtFFf2xSA6
         PbavjoZPND/tGpUAM3MNic4ASAErF4xBv7hXiA08MWVrq1BcbyVT+84Ac/upLcTg0199
         YPQ52PkTgtUuKmnxPhaWiBMb1Gwfg+3fTz8EiWVV5fkO0PPV/ApBnmyQ0J2uGfH1MRcc
         FjdA7ZVqlgrkjO06F6rSFdAYk3ezpwew4MywycysBZsrJkwSP/sAWbqyC3LBkGh6Y+js
         nosQbaV/TnU6lh3KyM0lm/hKy9nI8x26Zqobrz3T600JnQ4uRbISzHTcSq+0D/1/Disl
         JgGA==
X-Gm-Message-State: AA+aEWb9itbDIbHPjMmX7pZYaHwPneJKSzbSfAVx8mclRT2NlUl7ejTs
        dam23lhP4mDMIvrZvJRyQ0Jyf2ikbVShK/J/Pk0=
X-Google-Smtp-Source: AFSGD/WnQxdCi/IHUH+3aNihjcbaU9jT0PDwpcf8s1pONo8cgWDK+lOC7f4KCBI1/YTw4ebb45NFDlUN5NyX8xM2R18=
X-Received: by 2002:aa7:d597:: with SMTP id r23mr21803820edq.51.1545985478213;
 Fri, 28 Dec 2018 00:24:38 -0800 (PST)
MIME-Version: 1.0
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 28 Dec 2018 16:24:01 +0800
Message-ID: <CAEbi=3c7dr2pjQf_1FMZXMfYx5qvnf6_+WsfEVByKHwrh-bBPA@mail.gmail.com>
Subject: [GIT PULL] nds32 new features and bug fix for 4.21
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime <greentime@andestech.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git
tags/nds32-for-linus-4.21

for you to fetch changes up to e2f3f8b4a497d26bdcd55a53246ec2e613ae0fd4:

  nds32: support hardware prefetcher (2018-11-22 18:13:51 +0800)

----------------------------------------------------------------
nds32 patches for 4.21

Here is the nds32 patch set based on 4.20-rc1.
Contained in here are
1. Perf support
2. Power management support
3. FPU support
4. Hardware prefetcher support
5. Build error fixed
6. Performance enhancement

These are the LTP20170427 testing results.
Total Tests: 1902
Total Skipped Tests: 603
Total Failures: 410
Kernel Version: 4.20.0-rc1-00016-ge0db606bc023
Machine Architecture: nds32
Hostname: greentime-d15-ae3xx

----------------------------------------------------------------
Nick Hu (1):
      nds32: Power management for nds32

Nickhu (5):
      nds32: Fix gcc 8.0 compiler option incompatible.
      nds32: Fix bug in bitfield.h
      nds32: Perf porting
      nds32: Add perf call-graph support.
      nds32: Add document for NDS32 PMU.

Nylon Chen (2):
      nds32: Fix the items of hwcap_str ordering issue.
      nds32: support hardware prefetcher

Vincent Chen (5):
      nds32: nds32 FPU port
      nds32: Support FP emulation
      nds32: support denormalized result through FP emulator
      math-emu/op-2.h: Use statement expressions to prevent negative
constant shift
      math-emu/soft-fp.h: (_FP_ROUND_ZERO) cast 0 to void to fix warning

YueHaibing (1):
      nds32: Remove duplicated include from pm.c

Zong Li (2):
      nds32: Remove the redundant assignment
      nds32: Fill all TLB entries with kernel image mapping

 Documentation/devicetree/bindings/perf/nds32v3-pmu.txt |   17 ++
 arch/nds32/Kconfig                                     |   12 +
 arch/nds32/Kconfig.cpu                                 |   41 ++++
 arch/nds32/Makefile                                    |    5 +
 arch/nds32/boot/dts/ae3xx.dts                          |    5 +
 arch/nds32/include/asm/Kbuild                          |    1 +
 arch/nds32/include/asm/bitfield.h                      |   25 ++-
 arch/nds32/include/asm/elf.h                           |   11 +
 arch/nds32/include/asm/fpu.h                           |  126 +++++++++++
 arch/nds32/include/asm/fpuemu.h                        |   32 +++
 arch/nds32/include/asm/nds32_fpu_inst.h                |  109 +++++++++
 arch/nds32/include/asm/perf_event.h                    |   16 ++
 arch/nds32/include/asm/pmu.h                           |  386
++++++++++++++++++++++++++++++++
 arch/nds32/include/asm/processor.h                     |    7 +
 arch/nds32/include/asm/sfp-machine.h                   |  158 +++++++++++++
 arch/nds32/include/asm/stacktrace.h                    |   39 ++++
 arch/nds32/include/asm/suspend.h                       |   11 +
 arch/nds32/include/asm/syscalls.h                      |    1 +
 arch/nds32/include/uapi/asm/auxvec.h                   |    7 +
 arch/nds32/include/uapi/asm/sigcontext.h               |   14 ++
 arch/nds32/include/uapi/asm/udftrap.h                  |   13 ++
 arch/nds32/include/uapi/asm/unistd.h                   |    2 +
 arch/nds32/kernel/Makefile                             |    7 +-
 arch/nds32/kernel/ex-entry.S                           |   24 +-
 arch/nds32/kernel/ex-exit.S                            |   13 +-
 arch/nds32/kernel/ex-scall.S                           |    8 +-
 arch/nds32/kernel/fpu.c                                |  269
+++++++++++++++++++++++
 arch/nds32/kernel/head.S                               |   13 +-
 arch/nds32/kernel/perf_event_cpu.c                     | 1522
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/pm.c                                 |   78 +++++++
 arch/nds32/kernel/process.c                            |   64 +++++-
 arch/nds32/kernel/setup.c                              |   22 +-
 arch/nds32/kernel/signal.c                             |   62 +++++-
 arch/nds32/kernel/sleep.S                              |  131 +++++++++++
 arch/nds32/kernel/sys_nds32.c                          |   32 +++
 arch/nds32/kernel/traps.c                              |   16 ++
 arch/nds32/math-emu/Makefile                           |    7 +
 arch/nds32/math-emu/faddd.c                            |   24 ++
 arch/nds32/math-emu/fadds.c                            |   24 ++
 arch/nds32/math-emu/fcmpd.c                            |   24 ++
 arch/nds32/math-emu/fcmps.c                            |   24 ++
 arch/nds32/math-emu/fd2s.c                             |   22 ++
 arch/nds32/math-emu/fdivd.c                            |   27 +++
 arch/nds32/math-emu/fdivs.c                            |   26 +++
 arch/nds32/math-emu/fmuld.c                            |   23 ++
 arch/nds32/math-emu/fmuls.c                            |   23 ++
 arch/nds32/math-emu/fnegd.c                            |   21 ++
 arch/nds32/math-emu/fnegs.c                            |   21 ++
 arch/nds32/math-emu/fpuemu.c                           |  357
++++++++++++++++++++++++++++++
 arch/nds32/math-emu/fs2d.c                             |   23 ++
 arch/nds32/math-emu/fsqrtd.c                           |   21 ++
 arch/nds32/math-emu/fsqrts.c                           |   21 ++
 arch/nds32/math-emu/fsubd.c                            |   27 +++
 arch/nds32/math-emu/fsubs.c                            |   27 +++
 arch/nds32/mm/Makefile                                 |    6 +-
 arch/nds32/mm/fault.c                                  |   13 +-
 drivers/irqchip/irq-ativic32.c                         |   31 +++
 include/math-emu/op-2.h                                |   99 ++++-----
 include/math-emu/soft-fp.h                             |    2 +-
 tools/include/asm/barrier.h                            |    2 +
 tools/perf/arch/nds32/Build                            |    1 +
 tools/perf/arch/nds32/util/Build                       |    1 +
 tools/perf/arch/nds32/util/header.c                    |   29 +++
 tools/perf/pmu-events/arch/nds32/mapfile.csv           |   15 ++
 tools/perf/pmu-events/arch/nds32/n13/atcpmu.json       |  290
++++++++++++++++++++++++
 65 files changed, 4441 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/nds32v3-pmu.txt
 create mode 100644 arch/nds32/include/asm/fpu.h
 create mode 100644 arch/nds32/include/asm/fpuemu.h
 create mode 100644 arch/nds32/include/asm/nds32_fpu_inst.h
 create mode 100644 arch/nds32/include/asm/perf_event.h
 create mode 100644 arch/nds32/include/asm/pmu.h
 create mode 100644 arch/nds32/include/asm/sfp-machine.h
 create mode 100644 arch/nds32/include/asm/stacktrace.h
 create mode 100644 arch/nds32/include/asm/suspend.h
 create mode 100644 arch/nds32/include/uapi/asm/udftrap.h
 create mode 100644 arch/nds32/kernel/fpu.c
 create mode 100644 arch/nds32/kernel/perf_event_cpu.c
 create mode 100644 arch/nds32/kernel/pm.c
 create mode 100644 arch/nds32/kernel/sleep.S
 create mode 100644 arch/nds32/math-emu/Makefile
 create mode 100644 arch/nds32/math-emu/faddd.c
 create mode 100644 arch/nds32/math-emu/fadds.c
 create mode 100644 arch/nds32/math-emu/fcmpd.c
 create mode 100644 arch/nds32/math-emu/fcmps.c
 create mode 100644 arch/nds32/math-emu/fd2s.c
 create mode 100644 arch/nds32/math-emu/fdivd.c
 create mode 100644 arch/nds32/math-emu/fdivs.c
 create mode 100644 arch/nds32/math-emu/fmuld.c
 create mode 100644 arch/nds32/math-emu/fmuls.c
 create mode 100644 arch/nds32/math-emu/fnegd.c
 create mode 100644 arch/nds32/math-emu/fnegs.c
 create mode 100644 arch/nds32/math-emu/fpuemu.c
 create mode 100644 arch/nds32/math-emu/fs2d.c
 create mode 100644 arch/nds32/math-emu/fsqrtd.c
 create mode 100644 arch/nds32/math-emu/fsqrts.c
 create mode 100644 arch/nds32/math-emu/fsubd.c
 create mode 100644 arch/nds32/math-emu/fsubs.c
 create mode 100644 tools/perf/arch/nds32/Build
 create mode 100644 tools/perf/arch/nds32/util/Build
 create mode 100644 tools/perf/arch/nds32/util/header.c
 create mode 100644 tools/perf/pmu-events/arch/nds32/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/nds32/n13/atcpmu.json
