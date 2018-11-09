Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F99C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F2A20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTMWb9+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F2A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeKITky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:40:54 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36645 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeKITkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:40:53 -0500
Received: by mail-ua1-f65.google.com with SMTP id j3so423446uap.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/iYTfJ+xvmHKAYJ8KX+pFriE/QZ4u5ENiz80IeXRRSM=;
        b=VTMWb9+hAOK8Kedqgu9WP8+B71GvragfwCYfeNQcA8FEXAoWTeV6ZrldSeTasHtq2S
         vtY/vayIp6ihNT1wyZ/zkfYdVL7EQdEgg0B596g3U9FyqRmKA6p+rymwRh523eybsszm
         eEm4TMN35UUtZqUdkUW7VI1OF70QTFM2B2rHWMIeQAVP6JyNsXt6kNoF12N6p452N1nZ
         +IGLCyOdYALNJrPGg+H0UqyQpNyUu1xNR0qdRAO9cYFFFfWpMXH97ZBNRwYXiLY0jEKI
         3jGpUEjUTMSo85XU/U0+T8UHHtKAAFX0W8EeBMf5sTVP1Nn6VY9CoXR8kQhr9GF+582K
         Y8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iYTfJ+xvmHKAYJ8KX+pFriE/QZ4u5ENiz80IeXRRSM=;
        b=gwlagdeeIdSIHMHVbxKHdl/A5RojeQBNsjqi3rBQvTxsgXfb9gR3uBJc7mw1CxNa/P
         4LsFX7BTge5Z7AA45tXG83N6/UGifios29SHTP/PxKPL2JsHFmquglAh3Q2X0eF75uev
         Q+r9gBCpp+riQDyvUwOvc9ERIRWPPRAclrDTJROsJmK2jAM31s7nhDwgtGrE3+YTmm+Q
         43MjmV34LfLE2tGs3ZZbybTcebesM6SL4nr0SNoipXMWf8fPWSOG3XlBCqeh7yQz0Dok
         cPXsk1pEwX51KBwjF42XuY4333JMXq2v1HIPhcXnV7vWR+NfMmyix4TNvYJtlwpP8xK/
         uquQ==
X-Gm-Message-State: AGRZ1gL4KRid1W+DNFa6cD79trs5wRVZbfY0nmUww84yhPvtA2YOeZ/N
        7zyzl69oC2LbV6z0P8GRFkt1/5yI3vc+x8KAt+ZFYw==
X-Google-Smtp-Source: AJdET5catTyCGLeHhjoVpN1+3dFseCOb+TuUfRbtzf13IfKQqHply+/H+Q4Yv1MfKnPYDzmXyPnkplV4oHpr+pTuGfc=
X-Received: by 2002:a9f:2622:: with SMTP id 31mr3834138uag.90.1541757661685;
 Fri, 09 Nov 2018 02:01:01 -0800 (PST)
MIME-Version: 1.0
References: <CAEbi=3dou8JWKYq9FpRBtPKRRu4ahhsh=+kHKcF8vg5hyO2ZGQ@mail.gmail.com>
In-Reply-To: <CAEbi=3dou8JWKYq9FpRBtPKRRu4ahhsh=+kHKcF8vg5hyO2ZGQ@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 9 Nov 2018 18:00:25 +0800
Message-ID: <CAEbi=3dCGmCzM7td_-hdsgfpHOVeB_Bc_tFtvWnn1AJqzMbiUw@mail.gmail.com>
Subject: [GIT PULL] nds32 new features and bug fix for 4.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime <greentime@andestech.com>
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
tags/nds32-for-linus-4.20

for you to fetch changes up to 3fb688b03d0c14e661ef20b11aa129048ccde0bf:

  nds32: support hardware prefetcher (2018-11-08 20:42:49 +0800)

----------------------------------------------------------------
nds32 patches for 4.20

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
 arch/nds32/Makefile                                    |   11 +
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
 arch/nds32/kernel/Makefile                             |   13 +-
 arch/nds32/kernel/ex-entry.S                           |   24 +-
 arch/nds32/kernel/ex-exit.S                            |   13 +-
 arch/nds32/kernel/ex-scall.S                           |    8 +-
 arch/nds32/kernel/fpu.c                                |  269
++++++++++++++++++++++
 arch/nds32/kernel/head.S                               |   13 +-
 arch/nds32/kernel/perf_event_cpu.c                     | 1522
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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
 65 files changed, 4453 insertions(+), 89 deletions(-)
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
