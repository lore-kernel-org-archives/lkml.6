Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034452AbeBPOhP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:37:15 -0500
Received: from foss.arm.com ([217.140.101.70]:40444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750942AbeBPOhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:37:14 -0500
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>, Mark Salter <msalter@redhat.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>, Will Deacon <will.deacon@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 4.16-rc2
Date: Fri, 16 Feb 2018 14:37:01 +0000
Message-Id: <20180216143701.20003-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's the few updates I've collected for the irq department. Nothing
major (always a good thing), the biggest update being GICv2m now being
able to use Multi-MSI, and resulting in a negative diffstat...

Please pull.

	M.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-4.16-2

for you to fetch changes up to 0b24a0bbe2147815d982d9335c41bb10c04f40bc:

  irqdomain: Re-use DEFINE_SHOW_ATTRIBUTE() macro (2018-02-16 14:22:34 +0000)

----------------------------------------------------------------
irqchip updates for 4.16-rc2

- a MIPS GIC fix for spurious, masked interrupts
- a fix for a subtle IPI bug in GICv3
- do no probe GICv3 ITSs that are marked as disabled
- multi-MSI support for GICv2m
- various cleanups

----------------------------------------------------------------
Andy Shevchenko (1):
      irqdomain: Re-use DEFINE_SHOW_ATTRIBUTE() macro

Jaedon Shin (1):
      irqchip/bcm: Remove hashed address printing

Marc Zyngier (1):
      irqchip/gic-v2m: Add PCI Multi-MSI support

Mark Salter (1):
      irqchip/gic-v3: Change pr_debug message to pr_devel

Matt Redfearn (1):
      irqchip/mips-gic: Avoid spuriously handling masked interrupts

Shanker Donthineni (1):
      irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()

Stephen Boyd (1):
      irqchip/gic-v3: Ignore disabled ITS nodes

 drivers/irqchip/irq-bcm7038-l1.c                   |  3 --
 drivers/irqchip/irq-bcm7120-l2.c                   |  3 --
 drivers/irqchip/irq-brcmstb-l2.c                   |  3 --
 drivers/irqchip/irq-gic-v2m.c                      | 46 +++++++++++-----------
 drivers/irqchip/irq-gic-v3-its-pci-msi.c           |  2 +
 drivers/irqchip/irq-gic-v3-its-platform-msi.c      |  2 +
 drivers/irqchip/irq-gic-v3-its.c                   |  2 +
 drivers/irqchip/irq-gic-v3.c                       |  4 +-
 drivers/irqchip/irq-mips-gic.c                     |  2 -
 .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |  2 +
 kernel/irq/irqdomain.c                             | 18 ++-------
 11 files changed, 36 insertions(+), 51 deletions(-)
