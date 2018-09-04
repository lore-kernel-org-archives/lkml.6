Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37BAC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B2E20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="pI9HTMia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B2E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeIDRKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:10:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39504 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeIDRKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:10:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so1648802pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=aK+44AgjQhlds2pRx9QFF0dWADxxjR/z/P/X2H02ebI=;
        b=pI9HTMia5Yiiiio7L9rAsjoQ2mfrpCaRy9lMYZDBeiR1t9dnXUCO86VE2PKVxhlkiy
         Uacmyv2k9omyb096ctfpS/HejpTlKoQkkFC03ITiWrGFxiJX5x1MHqaJ0vFWzmUNNrEn
         KSKa6o2U1l72yiwALeRq/ah5BuaSu4WuoHFlNETmbsa0WvRFQalIyUYI4sIfdegmN9tL
         dk/R5cT2uPaa7mTZnZovQP4mwGCZ1/1/NiIP6+ez7PPL9+KQShsUuEeq4H9XyvgFx1Li
         fltGKzFzGFDtfehQPoYBxIHuDJhwLlFiNKZtxSf8+/enRE9k2ZPMnutXULEXwufchSiw
         hbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aK+44AgjQhlds2pRx9QFF0dWADxxjR/z/P/X2H02ebI=;
        b=F8nXdwKdYTxlHRrP2YyTx0EBzIv8JWrD6xzn386t4EC6t2+XPApndwm6pJxN8B2ntS
         rql1gopv11MRJfBeO2Fa8hyIx1ZfcnM49MsOGjwkd6PRzSLo8H4dhUy87RDkHFALwL1F
         hoiAsbtCOYTxPtpfbyexfH0I9Rlv5gV4k6W4nlldTLTXnrFufYben489n3l8cFsCr7YZ
         u8AWFObdC4EnNPTMsVYxAA6dUF+UmI67l3/Ve1RByBe+niS2D0ixiPOL9g1wauorbqft
         Pon5RcQAL5FBc0LJhf0FiIlQ1ctQa+wezrc2Ef5k+Ce8tllPA6daA2nblpcD6wADRzaU
         aDfg==
X-Gm-Message-State: APzg51B89G1aFMQDwdO1k+0DLGS30Ui4OPYDl/XpSBzbYpPyLb72yGxS
        wexs3QTM9RFA5XnrgYwKNemOSg==
X-Google-Smtp-Source: ANB0VdYnMDer5ZiZy2JRUg0EnwfgGMn4SxkIfmTa2OiVXVboPbzZWS2Z+4D1LPXoO4PP4nKIUjwi2Q==
X-Received: by 2002:a63:7a45:: with SMTP id j5-v6mr29806268pgn.363.1536065140601;
        Tue, 04 Sep 2018 05:45:40 -0700 (PDT)
Received: from anup-ubuntu64.wlan.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id p11-v6sm31621773pfj.72.2018.09.04.05.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 05:45:39 -0700 (PDT)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [RFC PATCH 0/5] New RISC-V Local Interrupt Controller Driver
Date:   Tue,  4 Sep 2018 18:15:09 +0530
Message-Id: <20180904124514.6290-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset provides a new RISC-V Local Interrupt Controller Driver
for managing per-CPU local interrupts. The overall approach is inspired
from the way per-CPU local interrupts are handled by Linux ARM64 and
ARM GICv3 driver.

Few advantages of having this new driver are as follows:
1. It registers all local interrupts as per-CPU interrupts
2. We can develop drivers for devices with per-CPU local interrupts
without changing arch code or this driver
3. It allows local interrupt controller DT node under each CPU DT node
as well as single system-wide DT node for local interrupt controller.

With this patchset, output of "cat /proc/interrupts" looks as follows:
           CPU0       CPU1       CPU2       CPU3       
  5:        995       1012        997       1015  RISC-V INTC   5 Edge      riscv_timer
  8:         23          6         10          7  SiFive PLIC   8 Edge      virtio0
 10:          9         10          5          4  SiFive PLIC  10 Edge      ttyS0

The patchset is based up Linux-4.19-rc2 and can be found at
riscv_intc_v1 branch of:
https://github.com/avpatel/linux.git

Anup Patel (5):
  RISC-V: Make IPI triggering flexible
  RISC-V: No need to pass scause as arg to do_IRQ()
  RISC-V: Select useful GENERIC_IRQ kconfig options
  irqchip: RISC-V Local Interrupt Controller Driver
  clocksource: riscv_timer: Make timer interrupt as a per-CPU interrupt

 arch/riscv/Kconfig                |   4 +
 arch/riscv/include/asm/irq.h      |  16 ++-
 arch/riscv/include/asm/smp.h      |  10 ++
 arch/riscv/kernel/entry.S         |   1 -
 arch/riscv/kernel/irq.c           |  45 +--------
 arch/riscv/kernel/smp.c           |  23 ++++-
 drivers/clocksource/riscv_timer.c |  76 ++++++++++++---
 drivers/irqchip/Kconfig           |  15 ++-
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-riscv-intc.c  | 156 ++++++++++++++++++++++++++++++
 drivers/irqchip/irq-sifive-plic.c |  21 +++-
 include/linux/cpuhotplug.h        |   1 +
 12 files changed, 301 insertions(+), 68 deletions(-)
 create mode 100644 drivers/irqchip/irq-riscv-intc.c

-- 
2.17.1

