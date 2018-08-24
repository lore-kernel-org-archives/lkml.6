Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1304C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DC721564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DC721564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeHXRhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:37:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57778 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbeHXRhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:37:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3653ED1;
        Fri, 24 Aug 2018 07:02:22 -0700 (PDT)
Received: from approximate.Emea.Arm.com (approximate.emea.arm.com [10.4.13.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59B8D3F5BC;
        Fri, 24 Aug 2018 07:02:20 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
        Biju Das <biju.das@bp.renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Rob Herring <robh@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [GIT PULL] irqchip updates for 4.19, take 2
Date:   Fri, 24 Aug 2018 15:02:03 +0100
Message-Id: <20180824140203.12448-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

This is the last few irqchip updates for this merge window before I
disappear for a couple of weeks without much access to email. Nothing
major this time around, just a few random odd fixes.

Please pull,

	M.

The following changes since commit a8db74564b0c634667e1722264bde303d296f566:

  irqchip/gic-v3-its: Make its_lock a raw_spin_lock_t (2018-08-06 09:16:19 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-4.19-2

for you to fetch changes up to 4110b5cbb014ebaaeb3d18ac8b98470b7251847d:

  irqchip/gic-v3: Allow interrupt to be configured as wake-up sources (2018-08-20 09:54:44 +0100)

----------------------------------------------------------------
irqchip updates for 4.19, take #2

- bcm7038: compilation fix for !SMP
- stm32: fix teardown on probe error
- s3c24xx: fix compilation warning
- renesas-irqc: r8a774a1 support
- tango: chained irq setup simplification
- gic-v3: allow wake-up sources

----------------------------------------------------------------
Dan Carpenter (1):
      irqchip/stm32: Fix init error handling

Fabrizio Castro (1):
      dt-bindings: irqchip: renesas-irqc: Document r8a774a1 support

Jonas Gorski (1):
      irqchip/bcm7038-l1: Hide cpu offline callback when building for !SMP

Krzysztof Kozlowski (1):
      irqchip/s3c24xx: Remove unneeded comparison of unsigned long to 0

Marc Zyngier (1):
      irqchip/gic-v3: Allow interrupt to be configured as wake-up sources

Martin Kaiser (1):
      irqchip/tango: Set irq handler and data in one go

 .../bindings/interrupt-controller/renesas,irqc.txt |  1 +
 drivers/irqchip/irq-bcm7038-l1.c                   |  4 ++++
 drivers/irqchip/irq-gic-v3.c                       |  8 +++++--
 drivers/irqchip/irq-s3c24xx.c                      |  2 +-
 drivers/irqchip/irq-stm32-exti.c                   | 25 +++++++++++-----------
 drivers/irqchip/irq-tango.c                        |  3 +--
 6 files changed, 26 insertions(+), 17 deletions(-)
