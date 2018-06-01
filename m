Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbeFAPq5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:46:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54642 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751777AbeFAPqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:46:53 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
        Ludovic Barre <ludovic.barre@st.com>,
        Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>,
        Rob Herring <robh@kernel.org>, Yixun Lan <yixun.lan@amlogic.com>
Subject: [GIT PULL] irqchip updates for 4.18
Date: Fri,  1 Jun 2018 16:46:32 +0100
Message-Id: <20180601154632.24581-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

This is the (quite small, for once) set of irqchip updates for
4.18. On the menu, bunch of cleanups and new feature for the stm32
irqchip, and sSupport for the Meson-AXG GPIO irqchip.

Please pull,

	M.

The following changes since commit 48bda43eabb8d086204f543cf8bbad696b8c6391:

  softirq/s390: Move default mutators of overwritten softirq mask to s390 (2018-05-14 11:25:28 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-4.18

for you to fetch changes up to 6a88c221acbaaa0460d190f99093ab8114f23c09:

  ARM: dts: stm32: Add exti support to stm32mp157 pinctrl (2018-05-24 12:38:23 +0100)

----------------------------------------------------------------
irqchip updates for 4.18

- Support for Meson-AXG GPIO irqchip
- Large stm32 irqchip rework (suspend/resume, hierarchical domains)

----------------------------------------------------------------
Ludovic Barre (10):
      irqchip/stm32: Checkpatch fix
      irqchip/stm32: Add falling pending register support
      irqchip/stm32: Add suspend support
      irqchip/stm32: Add host and driver data structures
      irqchip/stm32: Prepare common functions
      irqchip/stm32: Add stm32mp1 support with hierarchy domain
      irqchip/stm32: Add suspend/resume support for hierarchy domain
      pinctrl/stm32: Add irq_eoi for stm32gpio irqchip
      ARM: dts: stm32: Add exti support for stm32mp157c
      ARM: dts: stm32: Add exti support to stm32mp157 pinctrl

Radoslaw Pietrzyk (1):
      irqchip/stm32: Optimizes and cleans up stm32-exti irq_domain

Yixun Lan (3):
      dt-bindings: interrupt-controller: Fix the double quotes
      dt-bindings: interrupt-controller: New binding for Meson-AXG SoC
      irqchip/meson-gpio: Add support for Meson-AXG SoCs

 .../amlogic,meson-gpio-intc.txt                    |  11 +-
 .../interrupt-controller/st,stm32-exti.txt         |   3 +
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          |   4 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   7 +
 drivers/irqchip/irq-meson-gpio.c                   |   5 +
 drivers/irqchip/irq-stm32-exti.c                   | 683 ++++++++++++++++++---
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  13 +-
 7 files changed, 623 insertions(+), 103 deletions(-)
