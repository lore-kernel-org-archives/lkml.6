Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2AAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B8320866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPW8izDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbeL1Sbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:31:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38382 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeL1Sbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 13:31:36 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so19337787lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 10:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ig2fCXrq5JfdxMDwdIofADJdXlMKPIPVy/UV2Rha8A8=;
        b=mPW8izDPqD6Vvicg8sISIX1gLMctq4cUkGDNSxGp0ANOveKOp3sKDptOlBTDIWOmGH
         P/gu9w9O+EigL6WjL6q0OMnzM3DYt9xwrIYYBeB+d5GmxG1Pnf543C9TeWdD3HkEen5m
         VV8cimbUxvsPOYp1la9jUXrOR42gudfR4+dqmkqMi7ppmQUZXyXHK7MHWLsCvx7DzpHu
         cpDuJ7FwpFDMOM344dQgIfHtlyqx2Uw9HCAcghsyjr76fV3+zZQaSLfcUyUQP58abQC8
         fdSzw3tjndUaClxKj0h613vIM4qdNP/w8ZS4hmrPKIy5DICSCsYG6tlvnOL7QVHuyLbi
         pxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ig2fCXrq5JfdxMDwdIofADJdXlMKPIPVy/UV2Rha8A8=;
        b=X+8qzjvhu3HJ0dG+IF6ZI5oyTHFbYo1UjVQ7pywaNfxQBBD+vSyBRNMFoMphBGeWKI
         3Ujnm9af1z2adQisJWdoyN2/GNyLxMyIQj4mH8sZtW9jITM2QvFZyw/tq83fyifiutZx
         la51UJNHe0WXgQQUre7nbx+1K9aHlANb0RlJJIxUxXsuv2h/ZNBVxU45W3gp8msm2J7u
         ejkil5TQF+80z0r3h0z7n/DX9q68JDSpKyKJ5wglePx+AEDoQaZnal+yU/g5ctaAj4SF
         MOtRS6qjXfDg9HRgVnQbhGw+xYTUWxiH2LPDTNhJK55ks2fQHx76JtIHCOmjsSTRkCVM
         6XuQ==
X-Gm-Message-State: AA+aEWZxoT72d0jGiDNlHGkzbyNEC0Azvu5xt3jokrhfIa6a8aoXepfz
        bh666UfM77UsP+82Hwft/peqRQ/f
X-Google-Smtp-Source: AFSGD/WK5ukUgPOnWq9N9G0by0ZpXdEzjIg99Il2ntrS1wieREV96XNwPr+FqrT6zQum/Rs52/l/Tg==
X-Received: by 2002:a2e:4746:: with SMTP id u67-v6mr16305921lja.142.1546021893308;
        Fri, 28 Dec 2018 10:31:33 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net. (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id z6sm7997903lfa.87.2018.12.28.10.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 10:31:32 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 00/25] Xtensa updates for v4.21
Date:   Fri, 28 Dec 2018 10:31:20 -0800
Message-Id: <20181228183120.23058-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following batch of updates for the Xtensa architecture.

The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20181228

for you to fetch changes up to 64711f9a47d4defa90417f5e8db8ed0060bc3275:

  xtensa: implement jump_label support (2018-12-20 14:44:38 -0800)

----------------------------------------------------------------
Xtensa updates for v4.21:

- switch to generated syscall table
- switch ptrace to regsets, use regsets for core dumps
- complete tracehook implementation
- add syscall tracepoints support
- add jumplabels support
- add memtest support
- drop unused/duplicated code from entry.S, ptrace.c, coprocessor.S,
  elf.h and syscall.h
- clean up warnings caused by WSR/RSR macros
- clean up DTC warnings about SPI controller node names in xtfpga.dtsi
- simplify coprocessor.S
- get rid of explicit 'l32r' instruction usage in assembly

----------------------------------------------------------------
Dmitry V. Levin (2):
      Move EM_XTENSA to uapi/linux/elf-em.h
      xtensa: define syscall_get_arch()

Firoz Khan (3):
      xtensa: add __NR_syscalls along with __NR_syscall_count
      xtensa: add system call table generation support
      xtensa: generate uapi header and syscall table header files

Max Filippov (20):
      xtensa: drop fast_syscall_kernel
      xtensa: drop unused field from the struct exc_table
      xtensa: drop custom PTRACE_{PEEK,POKE}{TEXT,DATA}
      xtensa: drop unused coprocessor helper functions
      xtensa: clean up syscall.h
      xtensa: drop unused declarations from elf.h
      xtensa: clean up WSR*/RSR*/get_sr/set_sr
      xtensa: simplify coprocessor.S
      xtensa: don't clear cpenable unconditionally on release
      xtensa: xtfpga.dtsi: fix dtc warnings about SPI
      xtensa: don't use l32r opcode directly
      xtensa: support memtest
      xtensa: use NO_SYSCALL instead of -1
      xtensa: call do_syscall_trace_{enter,leave} selectively
      xtensa: implement task_user_regset_view
      xtensa: implement TIE regset
      xtensa: enable CORE_DUMP_USE_REGSET
      xtensa: implement tracehook functions and enable HAVE_ARCH_TRACEHOOK
      xtensa: implement syscall tracepoints
      xtensa: implement jump_label support

 .../features/core/jump-labels/arch-support.txt     |   2 +-
 arch/xtensa/Kconfig                                |   3 +
 arch/xtensa/Makefile                               |   3 +
 arch/xtensa/boot/boot-elf/bootstrap.S              |  29 +-
 arch/xtensa/boot/dts/xtfpga.dtsi                   |   2 +-
 arch/xtensa/include/asm/Kbuild                     |   1 +
 arch/xtensa/include/asm/coprocessor.h              |  23 -
 arch/xtensa/include/asm/elf.h                      |  33 +-
 arch/xtensa/include/asm/futex.h                    |   8 +-
 arch/xtensa/include/asm/irqflags.h                 |   1 +
 arch/xtensa/include/asm/jump_label.h               |  65 ++
 arch/xtensa/include/asm/processor.h                |  18 +-
 arch/xtensa/include/asm/ptrace.h                   |   7 +
 arch/xtensa/include/asm/syscall.h                  | 109 ++-
 arch/xtensa/include/asm/thread_info.h              |   9 +-
 arch/xtensa/include/asm/timex.h                    |  18 +-
 arch/xtensa/include/asm/traps.h                    |   2 -
 arch/xtensa/include/asm/uaccess.h                  |  10 +-
 arch/xtensa/include/asm/unistd.h                   |   2 +
 arch/xtensa/include/uapi/asm/Kbuild                |   1 +
 arch/xtensa/include/uapi/asm/ptrace.h              |  20 +-
 arch/xtensa/include/uapi/asm/unistd.h              | 781 +--------------------
 arch/xtensa/kernel/Makefile                        |   1 +
 arch/xtensa/kernel/asm-offsets.c                   |   2 -
 arch/xtensa/kernel/coprocessor.S                   | 102 +--
 arch/xtensa/kernel/entry.S                         |  45 +-
 arch/xtensa/kernel/head.S                          |   8 +-
 arch/xtensa/kernel/hw_breakpoint.c                 |  21 +-
 arch/xtensa/kernel/jump_label.c                    |  99 +++
 arch/xtensa/kernel/process.c                       |  55 +-
 arch/xtensa/kernel/ptrace.c                        | 353 ++++++----
 arch/xtensa/kernel/setup.c                         |   8 +-
 arch/xtensa/kernel/signal.c                        |   8 +-
 arch/xtensa/kernel/syscall.c                       |  11 +-
 arch/xtensa/kernel/syscalls/Makefile               |  38 +
 arch/xtensa/kernel/syscalls/syscall.tbl            | 374 ++++++++++
 arch/xtensa/kernel/syscalls/syscallhdr.sh          |  36 +
 arch/xtensa/kernel/syscalls/syscalltbl.sh          |  32 +
 arch/xtensa/kernel/traps.c                         |  10 +-
 arch/xtensa/mm/init.c                              |   3 +
 drivers/irqchip/irq-xtensa-mx.c                    |  10 +-
 drivers/irqchip/irq-xtensa-pic.c                   |   8 +-
 include/uapi/linux/audit.h                         |   1 +
 include/uapi/linux/elf-em.h                        |   1 +
 44 files changed, 1117 insertions(+), 1256 deletions(-)
 create mode 100644 arch/xtensa/include/asm/jump_label.h
 create mode 100644 arch/xtensa/kernel/jump_label.c
 create mode 100644 arch/xtensa/kernel/syscalls/Makefile
 create mode 100644 arch/xtensa/kernel/syscalls/syscall.tbl
 create mode 100644 arch/xtensa/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/xtensa/kernel/syscalls/syscalltbl.sh

Thanks.
-- Max
