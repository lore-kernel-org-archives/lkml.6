Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367D9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E542720652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="sIBROMDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E542720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeIFRMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:12:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34592 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeIFRMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:12:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so5241028pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=B31DAqDl+rn73Uto0nltOX6IpjJWn36fMyeffgg84RY=;
        b=sIBROMDAisQzoMKTe1F+e8KU3/HfIGdZaVRqiH2luZ4NyY+/L+AV/wAOrNnUONFup4
         8xYXRVaFDovjZQhQY9MOXG6lrnaLyqYjgV749zUeZliSyxrTFCwgBEEOJ0wHwn4O36K1
         v0/XCxWp+Eg2J3IvUhPQKunFksVG3b9k3fr/ho/D+G4NJyxCT1z93Cbi4JG8DwNjmK09
         9lO22FAtHKn6wFS+vkmbrDzIYx+uPXcx9wb8gTjMIrMzDQWYhQr41zftV0anNVdzmDjq
         wox8Y4ObanTg5/tTTtfhT+Ha5cZ8OlbLtBpgSsg55zfDj57vrQgUfH7cBM9lNv38LN7g
         lfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B31DAqDl+rn73Uto0nltOX6IpjJWn36fMyeffgg84RY=;
        b=o+vKk8y9SXlqu5hg00JJ+scVz8UlSGomGBbuqKTcSmWEnFTUFvMYgW2Fmxar7YC+TW
         GFc5JT3XLcQsNnVTJlVFJN9D0/XffpUBgAY84AXv67jn2ZSqefO9DaRicj0Kk5qiY6wJ
         23Tv2KBQ5yo8TyLs4pDzbNqwbfr8e53PYC5b0riI+sHdowSvdTPmZdgdrjwmKHdkxKZT
         nI836ucZQMyA2OOxEq1D0pJGzfaz5gsvWQoGXJWpjkC//44fTK5Apd8aLEwtktckl8Sr
         GzfytQ8zDtY4abpOHhffwK4TdVhR42FpR5k59/u+E17dsArbPwXvSIudzigaBJCy+Ye4
         +Psg==
X-Gm-Message-State: APzg51CazYPM7nzdvKTeE4JcKuHpGI3QaSW10S5MzCqjLKL38GTP6qHa
        Tkx19B2Xxx2nBd6W2FCAVTEYYA==
X-Google-Smtp-Source: ANB0VdYldtHRl0/6LcWdPdrEZnZ84s+VqT960p0rJxoFN0lVoMrVdJdKeNbKTsKSsw0eg+9Mf5AM9w==
X-Received: by 2002:a63:6949:: with SMTP id e70-v6mr2478319pgc.119.1536237427537;
        Thu, 06 Sep 2018 05:37:07 -0700 (PDT)
Received: from anup-ubuntu64.wlan.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id 193-v6sm11446165pgh.47.2018.09.06.05.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 05:37:06 -0700 (PDT)
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
Subject: [PATCH v2 0/5] New RISC-V Local Interrupt Controller Driver
Date:   Thu,  6 Sep 2018 18:06:46 +0530
Message-Id: <20180906123651.28500-1-anup@brainfault.org>
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
  5:       1256       1269       1276       1262  RISC-V INTC   5  riscv_timer
  8:          6         15          7         16  SiFive PLIC   8  virtio0
 10:         22         12         12         21  SiFive PLIC  10  ttyS0

The patchset is based up Linux-4.19-rc2 and can be found at
riscv_intc_v2 branch of:
https://github.com/avpatel/linux.git

Changes since v1:
 - Removed changes related to puggable IPI triggering
 - Separate patch for self-contained IPI handling routine
 - Removed patch for GENERIC_IRQ kconfig options
 - Added patch to remove do_IRQ() function
 - Rebased upon Atish's SMP patches

Anup Patel (5):
  RISC-V: self-contained IPI handling routine
  RISC-V: No need to pass scause as arg to do_IRQ()
  irqchip: RISC-V Local Interrupt Controller Driver
  clocksource: riscv_timer: Make timer interrupt as a per-CPU interrupt
  RISC-V: Remove do_IRQ() function

 arch/riscv/Kconfig                |   1 +
 arch/riscv/include/asm/irq.h      |  17 +++-
 arch/riscv/include/asm/smp.h      |   3 +
 arch/riscv/kernel/entry.S         |   5 +-
 arch/riscv/kernel/irq.c           |  47 +---------
 arch/riscv/kernel/smp.c           |  11 ++-
 drivers/clocksource/riscv_timer.c |  78 ++++++++++++----
 drivers/irqchip/Kconfig           |  15 ++-
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-riscv-intc.c  | 148 ++++++++++++++++++++++++++++++
 drivers/irqchip/irq-sifive-plic.c |  20 +++-
 include/linux/cpuhotplug.h        |   1 +
 12 files changed, 273 insertions(+), 74 deletions(-)
 create mode 100644 drivers/irqchip/irq-riscv-intc.c

-- 
2.17.1

