Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7AFC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FADF2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FADF2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbeGSQKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:10:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51216 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbeGSQKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:10:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13ED27A9;
        Thu, 19 Jul 2018 08:26:41 -0700 (PDT)
Received: from approximate.cambridge.arm.com (approximate.cambridge.arm.com [10.1.206.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48F513F93D;
        Thu, 19 Jul 2018 08:26:39 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ludovic Barre <ludovic.barre@st.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 0/4] irqchip updates for 4.18-rc6
Date:   Thu, 19 Jul 2018 16:26:18 +0100
Message-Id: <20180719152618.8019-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

Here's a handfull of very minor updates for 4.18, which is all I plan
on sending for that release. Random DT updates, one actual fix for
stm32mp1.

Please pull,

	M.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-4.18-3

for you to fetch changes up to d5fd14803573e57941100d11dd9cf3e84d17e180:

  dt-bindings: irqchip: renesas-irqc: Document r8a77980 support (2018-07-19 16:12:28 +0100)

----------------------------------------------------------------
irqchip updates for 4.18, take #3

- DT binding updates for Renesas r8a77470 and r8a77980 SoCs
- DT binding update for Ingenic JZ4725B SoC
- Fix stm32mp1's exti0 pin routing

----------------------------------------------------------------
Biju Das (1):
      dt-bindings: irqchip: renesas-irqc: Document r8a77470 support

Ludovic Barre (1):
      irqchip/stm32: Add exti0 translation for stm32mp1

Paul Cercueil (1):
      irqchip/ingenic: Add support for the JZ4725B SoC

Sergei Shtylyov (1):
      dt-bindings: irqchip: renesas-irqc: Document r8a77980 support

 Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt | 1 +
 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt | 2 ++
 drivers/irqchip/irq-ingenic.c                                           | 1 +
 drivers/irqchip/irq-stm32-exti.c                                        | 1 +
 4 files changed, 5 insertions(+)
