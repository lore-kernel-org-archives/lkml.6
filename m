Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED21C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC532087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfARO6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:58:03 -0500
Received: from foss.arm.com ([217.140.101.70]:59222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfARO6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:58:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FB02EBD;
        Fri, 18 Jan 2019 06:58:02 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8EB13F6A8;
        Fri, 18 Jan 2019 06:58:00 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>
Subject: [GIT PULL] irqchip updates for 5.0-rc3
Date:   Fri, 18 Jan 2019 14:57:46 +0000
Message-Id: <20190118145746.132508-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a handful of irqchip fixes for 5.0-rc3. Only the menu, an
uninitialised mutex, an interesting MSI allocation corner case in the ITS, a
stm32 DT parsing fix, and some cleanups.

Please pull,

	M.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.0-2

for you to fetch changes up to 8208d1708b88b412ca97f50a6d951242c88cbbac:

  irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size (2019-01-18 14:35:38 +0000)

----------------------------------------------------------------
irqchip updates for 5.0-rc3

- Add missing DT translation call in stm32-exti
- Fix uninitialized mutex in the GICv3 MBI support code
- Drop useless GPIO includes from the madera driver
- Fix PCI Multi-MSI allocation with aliasing devices on GICv3 ITS

----------------------------------------------------------------
Linus Walleij (1):
      irqchip/madera: Drop GPIO includes

Loic Pallardy (1):
      irqchip/stm32-exti: Add domain translate function

Marc Zyngier (1):
      irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size

Yang Yingliang (1):
      irqchip/gic-v3-mbi: Fix uninitialized mbi_lock

 drivers/irqchip/irq-gic-v3-its.c | 25 +++++++++++++------------
 drivers/irqchip/irq-gic-v3-mbi.c |  2 +-
 drivers/irqchip/irq-madera.c     |  2 --
 drivers/irqchip/irq-stm32-exti.c |  1 +
 4 files changed, 15 insertions(+), 15 deletions(-)
