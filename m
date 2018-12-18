Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A07C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B99217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeLRREb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:04:31 -0500
Received: from foss.arm.com ([217.140.101.70]:49872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeLRREb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:04:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFA3EA78;
        Tue, 18 Dec 2018 09:04:30 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8EEF3F5C0;
        Tue, 18 Dec 2018 09:04:26 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Rob Herring <robh@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [GIT PULL] irqchip updates for 4.21
Date:   Tue, 18 Dec 2018 17:04:06 +0000
Message-Id: <20181218170406.188119-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

This is the set of patches I've accumulated during the 4.20
cycle. Although it is larger than some of the previous drops, the
content is relatively straightforward. A few new irqchip drivers
(because life would be boring without them), random fixes, cleanups
and workarounds for stupid firmware implementations.

Please pull.

	M.

The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-4.21

for you to fetch changes up to fb94109b764e7676fa63834b9033ba97175877a0:

  irqchip/stm32: protect configuration registers with hwspinlock (2018-12-18 15:38:31 +0000)

----------------------------------------------------------------
irqchip updates for 4.21

- A bunch of new irqchip drivers (RDA8810PL, Madera, imx-irqsteer)
- Updates for new (and old) platforms (i.MX8MQ, F1C100s)
- A number of SPDX cleanups
- A workaround for a very broken GICv3 implementation
- A platform-msi fix
- Various cleanups

----------------------------------------------------------------
Andrey Smirnov (5):
      irqchip/irq-imx-gpcv2: Remove unused code
      irqchip/irq-imx-gpcv2: Share reg offset calculation code
      irqchip/irq-imx-gpcv2: Make use of BIT() macro
      irqchip/irq-imx-gpcv2: Make error messages more consistent
      irqchip/irq-imx-gpcv2: Add support for i.MX8MQ

Bartosz Golaszewski (1):
      irq/irq_sim: Store multiple interrupt offsets in a bitmap

Benjamin Gaignard (2):
      dt-bindings: interrupt-controller: stm32: Document hwlock properties
      irqchip/stm32: protect configuration registers with hwspinlock

Kuninori Morimoto (2):
      irqchip/irq-renesas-irqc: Convert to SPDX identifiers
      irqchip/irq-renesas-intc-irqpin: Convert to SPDX identifiers

Lucas Stach (3):
      irqchip/irq-imx-gpcv2: Add IRQCHIP_DECLARE for i.MX8MQ compatible
      dt-bindings/irq: Add binding for Freescale IRQSTEER multiplexer
      irqchip: Add driver for imx-irqsteer controller

Manivannan Sadhasivam (2):
      dt-bindings: interrupt-controller: Document RDA8810PL intc
      irqchip: Add RDA8810PL interrupt driver

Marc Zyngier (1):
      irqchip/irq-imx-gpcv2: Silence "fall through" warning

Mesih Kilinc (4):
      dt-bindings: interrupt-controller: Add suniv interrupt-controller
      irqchip/sun4i: Add a struct to hold global variables
      irqchip/sun4i: Move IC specific register offsets to struct
      irqchip/sun4i: Add support for Allwinner ARMv5 F1C100s

Miquel Raynal (1):
      platform-msi: Free descriptors in platform_msi_domain_free()

Richard Fitzgerald (1):
      irqchip: Add driver for Cirrus Logic Madera codecs

Srinivas Kandagatla (3):
      dt-bindings/gic-v3: Add msm8996 compatible string
      irqchip/gic: Add support to device tree based quirks
      irqchip/gic-v3: Add quirk for msm8996 broken registers

Stefan Wahren (1):
      irqchip: bcm283x: Switch to SPDX identifier

Wei Yongjun (1):
      irqchip/irq-rda-intc: Fix return value check in rda8810_intc_init()

Yangtao Li (1):
      irqchhip: Convert to using %pOFn instead of device_node.name

 .../interrupt-controller/allwinner,sun4i-ic.txt    |   4 +-
 .../bindings/interrupt-controller/arm,gic-v3.txt   |   4 +-
 .../bindings/interrupt-controller/fsl,irqsteer.txt |  34 +++
 .../interrupt-controller/rda,8810pl-intc.txt       |  61 +++++
 .../interrupt-controller/st,stm32-exti.txt         |   4 +
 MAINTAINERS                                        |   2 +
 drivers/base/platform-msi.c                        |   6 +-
 drivers/irqchip/Kconfig                            |  15 ++
 drivers/irqchip/Makefile                           |   3 +
 drivers/irqchip/irq-bcm2835.c                      |  11 +-
 drivers/irqchip/irq-bcm2836.c                      |  11 +-
 drivers/irqchip/irq-gic-common.c                   |  12 +
 drivers/irqchip/irq-gic-common.h                   |   3 +
 drivers/irqchip/irq-gic-v3.c                       |  27 +++
 drivers/irqchip/irq-imx-gpcv2.c                    |  65 +++--
 drivers/irqchip/irq-imx-irqsteer.c                 | 261 +++++++++++++++++++++
 drivers/irqchip/irq-madera.c                       | 256 ++++++++++++++++++++
 drivers/irqchip/irq-mscc-ocelot.c                  |   6 +-
 drivers/irqchip/irq-rda-intc.c                     | 107 +++++++++
 drivers/irqchip/irq-renesas-intc-irqpin.c          |  14 +-
 drivers/irqchip/irq-renesas-irqc.c                 |  14 +-
 drivers/irqchip/irq-stm32-exti.c                   | 122 ++++++++--
 drivers/irqchip/irq-sun4i.c                        | 106 ++++++---
 drivers/irqchip/irq-tango.c                        |  10 +-
 include/linux/irq_sim.h                            |   2 +-
 include/linux/irqchip/irq-madera.h                 | 132 +++++++++++
 include/linux/msi.h                                |   2 +
 kernel/irq/irq_sim.c                               |  23 +-
 28 files changed, 1190 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
 create mode 100644 drivers/irqchip/irq-imx-irqsteer.c
 create mode 100644 drivers/irqchip/irq-madera.c
 create mode 100644 drivers/irqchip/irq-rda-intc.c
 create mode 100644 include/linux/irqchip/irq-madera.h
