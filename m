Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C1DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB4D2064E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB4D2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeJES2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:28:44 -0400
Received: from foss.arm.com ([217.140.101.70]:50284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbeJES2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:28:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74D427A9;
        Fri,  5 Oct 2018 04:30:22 -0700 (PDT)
Received: from filthy-habits.Emea.Arm.com (filthy-habits.emea.arm.com [10.4.13.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4D9A3F5A0;
        Fri,  5 Oct 2018 04:30:18 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Haim Boot <hayim@marvell.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Lei Zhang <zhang.lei@jp.fujitsu.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Rob Herring <robh@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 4.20
Date:   Fri,  5 Oct 2018 12:29:56 +0100
Message-Id: <20181005112956.70943-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's the set of irqchip updates for 4.20. On the menu this time,
support for the Marvell SEI and Cirrus Logic Madera interrupt
controllers, support for kexec on GICv3 system, as well as a few
fixes and cleanups.

Note that the GICv3/kexec stuff depends on some EFI updates. The whole
branch is thus based on tip/efi/irqchip which Ingo has created for
this purpose.

Please pull,

       M.

The following changes since commit a23d3bb05ccbd815c79293d2207fedede0b3515d:

  efi: add API to reserve memory persistently across kexec reboot (2018-09-26 12:03:57 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-4.20

for you to fetch changes up to b817ff5c95095afe8bc04d125838ad520ecb8767:

  irqchip: Add driver for Cirrus Logic Madera codecs (2018-10-05 10:46:41 +0100)

----------------------------------------------------------------
irqchip updates for 4.20

- kexec/kdump support for EFI-based GICv3 platforms
- Marvell SEI support
- Cirrus Logic Madera support
- QC PDC fixes
- GIC cleanups and optimizations
- DT updates

----------------------------------------------------------------
Biju Das (1):
      dt-bindings: irqchip: renesas-irqc: Document r8a7744 support

Geert Uytterhoeven (1):
      dt-bindings: irqchip: renesas-irqc: Document R-Car E3 support

Julien Thierry (2):
      irqchip/gic-v3: Remove acknowledge loop
      irqchip/gic: Unify GIC priority definitions

Lina Iyer (1):
      irqchip/pdc: Setup all edge interrupts as rising edge at GIC

Marc Zyngier (11):
      irqchip/gic-v3-its: Change initialization ordering for LPIs
      irqchip/gic-v3-its: Simplify LPI_PENDBASE_SZ usage
      irqchip/gic-v3-its: Split property table clearing from allocation
      irqchip/gic-v3-its: Move pending table allocation to init time
      irqchip/gic-v3-its: Keep track of property table's PA and VA
      irqchip/gic-v3-its: Allow use of pre-programmed LPI tables
      irqchip/gic-v3-its: Use pre-programmed redistributor tables with kdump kernels
      irqchip/gic-v3-its: Check that all RDs have the same property table
      irqchip/gic-v3-its: Register LPI tables with EFI config table
      irqchip/gic-v3-its: Allow use of LPI tables in reserved memory
      genirq/msi: Allow creation of a tree-based irqdomain for platform-msi

Miquel Raynal (10):
      dt-bindings/interrupt-controller: Fix Marvell ICU length in the example
      irqchip/irq-mvebu-icu: Fix wrong private data retrieval
      irqchip/irq-mvebu-icu: Clarify the reset operation of configured interrupts
      irqchip/irq-mvebu-icu: Disociate ICU and NSR
      irqchip/irq-mvebu-icu: Support ICU subnodes
      irqchip/irq-mvebu-sei: Add new driver for Marvell SEI
      arm64: marvell: Enable SEI driver
      irqchip/irq-mvebu-icu: Add support for System Error Interrupts (SEI)
      dt-bindings/interrupt-controller: Update Marvell ICU bindings
      dt-bindings/interrupt-controller: Add documentation for Marvell SEI controller

Richard Fitzgerald (1):
      irqchip: Add driver for Cirrus Logic Madera codecs

 .../bindings/interrupt-controller/marvell,icu.txt  |  85 +++-
 .../bindings/interrupt-controller/marvell,sei.txt  |  36 ++
 .../bindings/interrupt-controller/renesas,irqc.txt |   5 +-
 MAINTAINERS                                        |   2 +
 arch/arm64/Kconfig.platforms                       |   1 +
 drivers/base/platform-msi.c                        |  14 +-
 drivers/irqchip/Kconfig                            |   6 +
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-gic-v3-its.c                   | 249 +++++++---
 drivers/irqchip/irq-gic-v3.c                       |  85 ++--
 drivers/irqchip/irq-madera.c                       | 256 +++++++++++
 drivers/irqchip/irq-mvebu-icu.c                    | 253 +++++++---
 drivers/irqchip/irq-mvebu-sei.c                    | 507 +++++++++++++++++++++
 drivers/irqchip/qcom-pdc.c                         |   1 +
 include/linux/irqchip/arm-gic-common.h             |   6 +
 include/linux/irqchip/arm-gic-v3.h                 |   4 +-
 include/linux/irqchip/arm-gic.h                    |   5 -
 include/linux/irqchip/irq-madera.h                 | 132 ++++++
 include/linux/irqdomain.h                          |   1 +
 include/linux/msi.h                                |  17 +-
 20 files changed, 1474 insertions(+), 193 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
 create mode 100644 drivers/irqchip/irq-madera.c
 create mode 100644 drivers/irqchip/irq-mvebu-sei.c
 create mode 100644 include/linux/irqchip/irq-madera.h
