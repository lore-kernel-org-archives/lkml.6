Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeCPOzX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:55:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57178 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753444AbeCPOzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:55:20 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 0/2] irqchip/gic*: Complain about the use of IRQ_TYPE_NONE
Date: Fri, 16 Mar 2018 14:55:09 +0000
Message-Id: <20180316145511.28362-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grepping through the dts files, the documentation, and reviewing
patches, one can only notice the use of IRQ_TYPE_NONE in interrupt
specifiers. At least for the GIC, this doesn't mean anything. The
unsuspecting driver will end-up with whatever was there before, and
there is a 50% probability that it is not what it wants.

I'd love to fix it myself, but I also have a 50% probability of
getting it wrong. In order to make the user aware they are walking on
thin ice, let's add some warnings. Hopefully, they'll be annoying
enough that people will fix their firmware. Croudsourcing debugging...

If nobody complains louder than the warnings, I plan to get this into
4.17.

Marc Zyngier (2):
  irqchip/gic: Loudly complain about the use of IRQ_TYPE_NONE
  irqchip/gic-v3: Loudly complain about the use of IRQ_TYPE_NONE

 drivers/irqchip/irq-gic-v3.c | 5 +++++
 drivers/irqchip/irq-gic.c    | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.14.2
