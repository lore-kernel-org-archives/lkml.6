Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED56BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17EA20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17EA20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757215AbeFSL4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:56:08 -0400
Received: from foss.arm.com ([217.140.101.70]:48372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756814AbeFSL4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:56:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AD471435;
        Tue, 19 Jun 2018 04:56:07 -0700 (PDT)
Received: from approximate.cambridge.arm.com (approximate.cambridge.arm.com [10.1.206.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F04E53F557;
        Tue, 19 Jun 2018 04:56:05 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 0/6] irqchip: v4.18-rc1 fixes
Date:   Tue, 19 Jun 2018 12:55:40 +0100
Message-Id: <20180619115546.12196-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a handful of patches I've accumulated over the merge
window. The only interesting thing is the issue that Yang found on a
bizarrely configured NUMA system, which prompted me to add more code
to detect similar situations (just in case). The rest is pretty dull.

Thanks,

	M.

Marc Zyngier (5):
  genirq/debugfs: Add missing IRQCHIP_SUPPORTS_LEVEL_MSI debug
  irqchip/ls-scfg-msi: Fix MSI affinity handling
  irqchip/gic-v2m: Fix SPI release on error path
  irqchip/gic-v3-its: Only emit SYNC if targetting a valid collection
  irqchip/gic-v3-its: Only emit VSYNC if targetting a valid collection

Yang Yingliang (1):
  irqchip/gic-v3-its: Don't bind LPI to unavailable NUMA node

 drivers/irqchip/irq-gic-v2m.c     |  2 +-
 drivers/irqchip/irq-gic-v3-its.c  | 52 ++++++++++++++++++++++++-------
 drivers/irqchip/irq-ls-scfg-msi.c |  3 +-
 include/linux/irq.h               |  1 +
 kernel/irq/debugfs.c              |  1 +
 5 files changed, 45 insertions(+), 14 deletions(-)

-- 
2.17.1

