Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF1CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01409219CA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="P/iqhuET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01409219CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbeHQXdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 19:33:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41650 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeHQXdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 19:33:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so1290579pgv.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:message-id:cc:from:to;
        bh=oVW+uVn8wt6CKOG6N6xVoTnv5MsHEywuePRlhFkbOdI=;
        b=P/iqhuETmVxmvI1F7UbHBMpTx9+xABr4Ka+gptreR9L0+w+PivRKs1bGKSj+cc/mlf
         9N3W9Ba2nb9sgLQpf9QjyP/oZFqfZvJ7KcjkRYIj4CimqrAkruI9MvRSVl+oR9DO3S6g
         85xTOHrEa3kFoxpCeDF3PHGUkIbUiDt3EJIs0DgFFnqWIVsT5NoqNZAfOBfTfQ0jKMZG
         B+yt8O+IsuoNEcn0eHT3YX2cqX+TTVPrBwfLhFAPAK4mwf1ja04pvIomO/7RLcMynT/a
         SsVUC0N+m+HuTTJ0dlyShdNySZLcagUdosLBK7bhBMZVFeni1poBprS9HLxmXz0cF0qI
         TOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:message-id:cc:from:to;
        bh=oVW+uVn8wt6CKOG6N6xVoTnv5MsHEywuePRlhFkbOdI=;
        b=KkQ8lNd2KCKBn78x4UA1UDxStRu9I99cDRXoPBdLLA7J1mbVG4Vm7AqK3cGCFQ941v
         cj5Vm3iESvsqsOdLx8t5fUj13HuEj7tjBiN3sYaq3qmyrcJM1MmFuf0h2wzBSz3b3uSw
         AJR11FSl8ZJ7NIbBH/Wj3yQKhyvN7E35Oy8iPo9dNvWHWirRCstme4/Ca48iih8BSaLU
         MYZEijtM0VmuUnUOXAvzzCS+hU8gPWgTOu5yMSok+hGcEycgRJYTv3nHlXWVwRh0f5+6
         SXlYNTljQKL0zcZt+5YtkH/ys8tSNHpDSg7aDxt27sZf34SMS0qcY1INkXVYqFh2146Z
         9vxw==
X-Gm-Message-State: AOUpUlHt2V3kaUkXen+yFlpdUpGvps+99voel/7j/DfnYw4SnPw1xsNQ
        MwSt4D9sqV6nXodP9y4950+zlQ==
X-Google-Smtp-Source: AA+uWPxkTvqPPf1fmLotj8m5UQ1Q1UoEJmh5ahHqILVfMSU4WlrWhZh4kTe9TBYblKJHdL85+mNKpA==
X-Received: by 2002:a62:68c3:: with SMTP id d186-v6mr38184991pfc.70.1534537692840;
        Fri, 17 Aug 2018 13:28:12 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id f67-v6sm4472144pfe.75.2018.08.17.13.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 13:28:11 -0700 (PDT)
Date:   Fri, 17 Aug 2018 13:28:11 -0700 (PDT)
X-Google-Original-Date: Fri, 17 Aug 2018 13:25:44 PDT (-0700)
Subject: [GIT PULL] RISC-V Updates for the 4.19 Merge Window
Message-ID: <mhng-4afb9897-29ed-4eb4-88d7-6cfb09a0a65c@palmer-si-x1c4>
CC:      linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I remember having sent this on Wednesday, but for some reason I don't see it in
your tree or my outbox so I might be crazy.  I was planning submitting some
more patches next week anyway, so while I'm OK just rolling these up as well
it'd be slightly easier if we can get these into -rc1 so we can test them.

Sorry!




The following changes since commit 94710cac0ef4ee177a63b5227664b38c95bbf703:

  Linux 4.18 (2018-08-12 13:41:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-4.19-mw0

for you to fetch changes up to 627672cf431b0379c07cc8d146f907cda6797222:

  dt-bindings: interrupt-controller: SiFive Plaform Level Interrupt Controller (2018-08-13 09:39:11 -0700)

----------------------------------------------------------------
RISC-V Updates for the 4.19 Merge Window

This tag contains some major improvements to the RISC-V port, including
the necessary interrupt controller and timer support to actually make it
to userspace.  Support for three devices has been added:

* Support for the ISA-mandated timers on RISC-V systems.
* Support for the ISA-mandated first-level interrupt controller on
  RISC-V systems, which is handled as part of our core arch code because
  it's very small and tightly tied to the ISA.
* Support for SiFive's platform-level interrupt controller, which talks
  to the actual devices.

In addition to these new devices, there are a handful of cleanups all
over the RISC-V tree:

* Build fixes for various configurations
    * A fix to the vDSO build's makefile so it respects CFLAGS.
    * The addition of __lshrti3, a libgcc derived function necessary for
      some 32-bit configurations.
    * !SMP && PERF_EVENTS
* Cleanups to the arch code to remove the remnants of old versions of
  the drivers that were just properly submitted.
    * Some dead code from the timer driver, most of which wasn't ever
      even compiled.
    * Cleanups of some interrupt #defines, which are now local to the
      interrupt handling code.
* Fixes to ptrace(), which while not being sufficient to fully make GDB
  work are at least sufficient to get simple GDB tasks to work.
* Early printk support via RISC-V's architecturally mandated SBI console
  device.
* A fix to our early debug trap handler to ensure it's always aligned.

These patches have all been through a fairly extensive review process,
but as this enables a whole pile of functionality (ie, userspace) I'm
confident we'll need to submit a few more patches.  The only concrete
issues I know about are the sys_riscv_flush_icache patches, but as I
managed to screw those up on Friday I figured it'd be best to let them
bake another week.

This tag boots a Fedora root filesystem on QEMU's master branch for me,
and before this morning's rebase (from 4.18-rc8 to 4.18) it booted on
the HiFive Unleashed.

Thanks to Christoph Hellwig and the other guys at WD for getting the new
drivers in shape!

----------------------------------------------------------------
Alex Guo (1):
      RISC-V: implement __lshrti3.

Atish Patra (1):
      RISC-V: Fix !CONFIG_SMP compilation error

Christoph Hellwig (6):
      RISC-V: remove timer leftovers
      RISC-V: simplify software interrupt / IPI code
      RISC-V: remove INTERRUPT_CAUSE_* defines from asm/irq.h
      RISC-V: add a definition for the SIE SEIE bit
      RISC-V: implement low-level interrupt handling
      irqchip: add a SiFive PLIC driver

Jim Wilson (1):
      RISC-V: Don't increment sepc after breakpoint.

Palmer Dabbelt (5):
      RISC-V: Use KBUILD_CFLAGS instead of KCFLAGS when building the vDSO
      RISC-V: Add early printk support via the SBI console
      clocksource: new RISC-V SBI timer driver
      dt-bindings: interrupt-controller: RISC-V local interrupt controller
      dt-bindings: interrupt-controller: SiFive Plaform Level Interrupt Controller

Zong Li (1):
      RISC-V: Add the directive for alignment of stvec's value

 .../interrupt-controller/riscv,cpu-intc.txt        |  44 ++++
 .../interrupt-controller/sifive,plic-1.0.0.txt     |  58 +++++
 arch/riscv/Makefile                                |   3 +
 arch/riscv/configs/defconfig                       |   1 +
 arch/riscv/include/asm/csr.h                       |   1 +
 arch/riscv/include/asm/irq.h                       |   5 +-
 arch/riscv/include/asm/perf_event.h                |   1 +
 arch/riscv/include/asm/smp.h                       |   6 -
 arch/riscv/kernel/entry.S                          |   4 +-
 arch/riscv/kernel/head.S                           |   2 +
 arch/riscv/kernel/irq.c                            |  55 ++++-
 arch/riscv/kernel/perf_event.c                     |   1 -
 arch/riscv/kernel/setup.c                          |  27 +++
 arch/riscv/kernel/smp.c                            |   6 +-
 arch/riscv/kernel/smpboot.c                        |   1 -
 arch/riscv/kernel/time.c                           |  30 +--
 arch/riscv/kernel/traps.c                          |   1 -
 arch/riscv/kernel/vdso/Makefile                    |   4 +-
 arch/riscv/lib/Makefile                            |   1 +
 arch/riscv/lib/tishift.S                           |  42 ++++
 drivers/clocksource/Kconfig                        |  11 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/riscv_timer.c                  | 105 +++++++++
 drivers/irqchip/Kconfig                            |  12 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-sifive-plic.c                  | 260 +++++++++++++++++++++
 include/linux/cpuhotplug.h                         |   1 +
 27 files changed, 625 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt
 create mode 100644 arch/riscv/lib/tishift.S
 create mode 100644 drivers/clocksource/riscv_timer.c
 create mode 100644 drivers/irqchip/irq-sifive-plic.c
