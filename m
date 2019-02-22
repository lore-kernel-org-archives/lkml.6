Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87E2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02952075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfBVQFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:05:31 -0500
Received: from foss.arm.com ([217.140.101.70]:35598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfBVQFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:05:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 560BB80D;
        Fri, 22 Feb 2019 08:05:30 -0800 (PST)
Received: from big-swifty.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C37373F575;
        Fri, 22 Feb 2019 08:05:25 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Li Wei <liwei391@huawei.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for Linux 5.1
Date:   Fri, 22 Feb 2019 16:05:15 +0000
Message-Id: <20190222160515.4704-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's the set of irqchip and related changes that I've queued for 5.1.
The most interesting change is Julien's pseudo-NMI series, which will be
used on arm64. The rest is the usual set of new interrupt controllers
(Loongson LS1X), feature updates (irqsteer, PLIC, GICv3), and bug fixes
(i8259, PLIC, GICv3).

Please note that the NMI series is also in the arm64 tree, since there is a
dependency between the core code the and architecture-specific backend.

Please pull,

	M.

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.1

for you to fetch changes up to 28528fca4908142bd1a3247956cba56c9c667d71:

  irqchip/imx-irqsteer: Add multi output interrupts support (2019-02-22 09:23:46 +0000)

----------------------------------------------------------------
irqchip updates for Linux 5.1

- Core pseudo-NMI handling code
- Allow the default irq domain to be retrieved
- A new interrupt controller for the Loongson LS1X platform
- Affinity support for the SiFive PLIC
- Better support for the iMX irqsteer driver
- NUMA aware memory allocations for GICv3
- A handful of other fixes (i8259, GICv3, PLIC)

----------------------------------------------------------------
Aaro Koskinen (1):
      irqchip/i8259: Fix shutdown order by moving syscore_ops registration

Aisheng Dong (4):
      dt-binding: irq: imx-irqsteer: Use irq number instead of group number
      dt-bindings: irq: imx-irqsteer: Add multi output interrupts support
      irqchip/imx-irqsteer: Change to use reg_num instead of irq_group
      irqchip/imx-irqsteer: Add multi output interrupts support

Anup Patel (4):
      irqchip/sifive-plic: Pre-compute context hart base and enable base
      irqchip/sifive-plic: Add warning in plic_init() if handler already present
      irqchip/sifive-plic: Differentiate between PLIC handler and context
      irqchip/sifive-plic: Implement irq_set_affinity() for SMP host

Atish Patra (1):
      irqchip/irq-sifive-plic: Check and continue in case of an invalid cpuid.

Doug Berger (1):
      irqchip/brcmstb-l2: Use _irqsave locking variants in non-interrupt code

Jiaxun Yang (2):
      irqchip: Add driver for Loongson-1 interrupt controller
      dt-bindings: interrupt-controller: loongson ls1x intc

Julien Thierry (5):
      genirq: Provide basic NMI management for interrupt lines
      genirq: Provide NMI management for percpu_devid interrupts
      genirq: Provide NMI handlers
      irqdesc: Add domain handler for NMIs
      genirq: Fix wrong name in request_percpu_nmi() description

Marc Zyngier (1):
      irqdomain: Allow the default irq domain to be retrieved

Shanker Donthineni (1):
      irqchip/gicv3-its: Use NUMA aware memory allocation for ITS tables

Zenghui Yu (1):
      irqchip/gic-v3-its: Avoid parsing _indirect_ twice for Device table

 .../bindings/interrupt-controller/fsl,irqsteer.txt |  11 +-
 .../interrupt-controller/loongson,ls1x-intc.txt    |  24 ++
 drivers/irqchip/Kconfig                            |   9 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-brcmstb-l2.c                   |  10 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  28 +-
 drivers/irqchip/irq-i8259.c                        |   9 +-
 drivers/irqchip/irq-imx-irqsteer.c                 | 115 ++++--
 drivers/irqchip/irq-ls1x.c                         | 192 ++++++++++
 drivers/irqchip/irq-sifive-plic.c                  | 116 ++++--
 include/linux/interrupt.h                          |  18 +
 include/linux/irq.h                                |  10 +
 include/linux/irqdesc.h                            |   5 +
 include/linux/irqdomain.h                          |   1 +
 kernel/irq/chip.c                                  |  54 +++
 kernel/irq/debugfs.c                               |   6 +-
 kernel/irq/internals.h                             |   2 +
 kernel/irq/irqdesc.c                               |  35 ++
 kernel/irq/irqdomain.c                             |  14 +
 kernel/irq/manage.c                                | 405 ++++++++++++++++++++-
 20 files changed, 964 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
 create mode 100644 drivers/irqchip/irq-ls1x.c
