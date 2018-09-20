Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C718C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1C221522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1C221522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbeITLVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 07:21:48 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60110 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726994AbeITLVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 07:21:48 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1004978|-1;CH=green;FP=3410651511292485117|1|1|1|0|-1|-1|-1;HT=e01l07423;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.CtH3bxm_1537421976;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CtH3bxm_1537421976)
          by smtp.aliyun-inc.com(10.147.41.178);
          Thu, 20 Sep 2018 13:39:36 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        robh@kernel.org, sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, green.hu@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 0/6] C-SKY(csky) Linux Kernel Port
Date:   Thu, 20 Sep 2018 13:39:26 +0800
Message-Id: <cover.1537417413.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because I've sent to Stephen Roth with the linux-4.19-rc3 git-tree for
linux-next, I shouldn't rebase any more.
https://github.com/c-sky/csky-linux.git#linux-next

This patchset include mptimer and mpintc drivers and fixup:

 - Fixup smp IPI's problems found by Marc Zyngier
 - Add irq-csky-mpintc.c patch in this patchset
 - Add mptimer.c patch in this patchset 
 - Fixup dma_sync_for_cpu/device in dma-mapping.c

Guo Ren (6):
  csky/dma: bugfix dma_sync_for_cpu/device
  csky: remove irq_mapping from smp.c
  irqchip: add C-SKY SMP interrupt controller
  dt-bindings: interrupt-controller: C-SKY SMP intc
  clocksource: add C-SKY SMP timer
  dt-bindings: timer: C-SKY Multi-processor timer

 .../bindings/interrupt-controller/csky,mpintc.txt  |  40 +++++
 .../devicetree/bindings/timer/csky,mptimer.txt     |  46 +++++
 arch/csky/include/asm/smp.h                        |   4 +-
 arch/csky/kernel/smp.c                             |  27 ++-
 arch/csky/mm/dma-mapping.c                         |   5 +-
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/csky_mptimer.c                 | 178 +++++++++++++++++++
 drivers/irqchip/Kconfig                            |   8 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-csky-mpintc.c                  | 195 +++++++++++++++++++++
 include/linux/cpuhotplug.h                         |   1 +
 12 files changed, 503 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
 create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt
 create mode 100644 drivers/clocksource/csky_mptimer.c
 create mode 100644 drivers/irqchip/irq-csky-mpintc.c

-- 
2.7.4

