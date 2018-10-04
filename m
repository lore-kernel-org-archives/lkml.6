Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B123FC65BA7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860372087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860372087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeJEARW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:17:22 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36369 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727523AbeJEARV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:17:21 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2139322|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03292;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.CzPk0qt_1538673752;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CzPk0qt_1538673752)
          by smtp.aliyun-inc.com(10.147.42.198);
          Fri, 05 Oct 2018 01:22:32 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        daniel.lezcano@linaro.org, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V10 0/8] C-SKY(csky) Linux Kernel Driver
Date:   Fri,  5 Oct 2018 01:22:20 +0800
Message-Id: <cover.1538672812.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is about 10th patchset for C-SKY linux drivers. All patches have
been checked by checkpatch.pl.

Any feedback is welcome, thx for all people review my patchset.

If you finish the review for the patchset, please give a Reviewed-By
/ Acked-By and I'll record it in the commit-msg.

Guo Ren (8):
  irqchip: add C-SKY SMP interrupt controller
  dt-bindings: interrupt-controller: C-SKY SMP intc
  irqchip: add C-SKY APB bus interrupt controller
  dt-bindings: interrupt-controller: C-SKY APB intc
  clocksource: add C-SKY SMP timer
  dt-bindings: timer: C-SKY Multi-processor timer
  clocksource: add gx6605s SOC system timer
  dt-bindings: timer: gx6605s SOC timer

 .../interrupt-controller/csky,apb-intc.txt         |  62 +++++
 .../bindings/interrupt-controller/csky,mpintc.txt  |  40 +++
 .../bindings/timer/csky,gx6605s-timer.txt          |  42 ++++
 .../devicetree/bindings/timer/csky,mptimer.txt     |  42 ++++
 drivers/clocksource/Kconfig                        |  18 ++
 drivers/clocksource/Makefile                       |   2 +
 drivers/clocksource/timer-gx6605s.c                | 154 ++++++++++++
 drivers/clocksource/timer-mp-csky.c                | 173 +++++++++++++
 drivers/irqchip/Kconfig                            |  17 ++
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-csky-apb-intc.c                | 274 +++++++++++++++++++++
 drivers/irqchip/irq-csky-mpintc.c                  | 197 +++++++++++++++
 include/linux/cpuhotplug.h                         |   1 +
 13 files changed, 1024 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
 create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt
 create mode 100644 drivers/clocksource/timer-gx6605s.c
 create mode 100644 drivers/clocksource/timer-mp-csky.c
 create mode 100644 drivers/irqchip/irq-csky-apb-intc.c
 create mode 100644 drivers/irqchip/irq-csky-mpintc.c

-- 
2.7.4

