Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FF9C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D20217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfBFKs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:48:56 -0500
Received: from foss.arm.com ([217.140.101.70]:51248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfBFKsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:48:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65681A78;
        Wed,  6 Feb 2019 02:48:55 -0800 (PST)
Received: from big-swifty.cambridge.arm.com (big-swifty.cambridge.arm.com [10.1.30.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B8073F719;
        Wed,  6 Feb 2019 02:48:52 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Heyi Guo <guoheyi@huawei.com>, Heyi Guo <heyi.guo@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Zheng Xiang <zhengxiang9@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] irqchip updates for 5.0-rc6
Date:   Wed,  6 Feb 2019 10:48:43 +0000
Message-Id: <20190206104848.12580-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

This is the final set of 5.0 updates from the irqchip department. This
time, an embarassingly large number of GICv3/GICv4 buglets (VLPI drop,
MSI allocation race on device sharing the same DevID, LPI pool
exhaustion and other cleanups), as well as a fix for PJ4-based systems
that apparently never worked correctly until now.

Please pull,

	M.

The following changes since commit 8208d1708b88b412ca97f50a6d951242c88cbbac:

  irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size (2019-01-18 14:35:38 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.0-3

for you to fetch changes up to 56841070ccc87b463ac037d2d1f2beb8e5e35f0c:

  irqchip/gic-v3-its: Fix ITT_entry_size accessor (2019-01-31 12:51:33 +0000)

----------------------------------------------------------------
irqchip update for 5.0-rc6

- Another GICv3 ITS fix for devices sharing the same DevID
- Don't return invalid data on exhaustion of the GICv3 LPI pool
- Fix a GICv3 field decoding bug leading to memory over-allocation
- Init GICv4 at boot time instead of lazy init
- Fix interrupt masking on PJ4

----------------------------------------------------------------
Heyi Guo (1):
      irqchip/gic-v4: Fix occasional VLPI drop

Lubomir Rintel (1):
      irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable

Marc Zyngier (2):
      irqchip/gic-v3-its: Plug allocation race for devices sharing a DevID
      irqchip/gic-v3-its: Gracefully fail on LPI exhaustion

Zenghui Yu (1):
      irqchip/gic-v3-its: Fix ITT_entry_size accessor

 drivers/irqchip/irq-gic-v3-its.c   | 101 +++++++++++++++++++++++++++++--------
 drivers/irqchip/irq-mmp.c          |   6 ++-
 include/linux/irqchip/arm-gic-v3.h |   2 +-
 3 files changed, 85 insertions(+), 24 deletions(-)
