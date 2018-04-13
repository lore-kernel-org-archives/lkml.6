Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeDMVth (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 17:49:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43223 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeDMVte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 17:49:34 -0400
X-IronPort-AV: E=Sophos;i="5.48,446,1517846400";
   d="scan'208";a="75828832"
From: Atish Patra <atish.patra@wdc.com>
To: palmer@sifive.com, linux-riscv@lists.infradead.org
Cc: albert@sifive.com, tglx@linutronix.de, mjc@sifive.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Fix timer initialization and Add support hotplug.
Date: Fri, 13 Apr 2018 14:49:32 -0700
Message-Id: <1523656174-249811-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch (1/2)fixes issues around timer initialization. This fix is
required for CPU hotplug to work. That's why they are clubbed into one
series. I can separate them if required.


Atish Patra (2):
  RISCV: Register clocksource and events correctly
  RISCV: Support cpu hotplug.

 arch/riscv/Kconfig                | 11 +++++-
 arch/riscv/include/asm/csr.h      |  1 +
 arch/riscv/include/asm/smp.h      |  9 +++--
 arch/riscv/kernel/head.S          | 12 +++++++
 arch/riscv/kernel/process.c       |  7 ++++
 arch/riscv/kernel/setup.c         | 17 ++++++++++
 arch/riscv/kernel/smpboot.c       | 70 +++++++++++++++++++++++++++++++++++++--
 arch/riscv/kernel/time.c          |  9 +----
 arch/riscv/kernel/traps.c         |  6 ++--
 drivers/clocksource/riscv_timer.c | 44 +++++++++++++++---------
 include/linux/cpuhotplug.h        |  1 +
 11 files changed, 154 insertions(+), 33 deletions(-)

-- 
2.7.4
