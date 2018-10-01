Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93443C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BB82083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BB82083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeJAIM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 04:12:29 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42541 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728643AbeJAIM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 04:12:28 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4106112|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e04486;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.Cy2mF2K_1538357790;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cy2mF2K_1538357790)
          by smtp.aliyun-inc.com(10.147.40.2);
          Mon, 01 Oct 2018 09:36:30 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        daniel.lezcano@linaro.org, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, f.fainelli@gmail.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V9 0/8] C-SKY(csky) Linux Kernel Drivers
Date:   Mon,  1 Oct 2018 09:35:55 +0800
Message-Id: <cover.1538355281.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From "PATCH V5 00/30] C-SKY(csky) Linux Kernel Port" I seperated the
drivers from the patchset. I've sent driver patches with "V5 V6 V7 V8".

Now is V9. The changelog is in every patch.

Perhaps I should seperate driver patchset earlier and the csky port patchset
is too big now.

Any feedback is welcome, thx for all people review my patchset.

Best Regards

Guo Ren (8):
  irqchip: add C-SKY SMP interrupt controller
  dt-bindings: interrupt-controller: C-SKY SMP intc
  clocksource: add C-SKY SMP timer
  dt-bindings: timer: C-SKY Multi-processor timer
  dt-bindings: interrupt-controller: C-SKY APB intc
  irqchip: add C-SKY APB bus interrupt controller
  dt-bindings: timer: gx6605s SOC timer
  clocksource: add gx6605s SOC system timer

 .../interrupt-controller/csky,apb-intc.txt         |  62 +++++
 .../bindings/interrupt-controller/csky,mpintc.txt  |  40 ++++
 .../bindings/timer/csky,gx6605s-timer.txt          |  42 ++++
 .../devicetree/bindings/timer/csky,mptimer.txt     |  42 ++++
 drivers/clocksource/Kconfig                        |  16 ++
 drivers/clocksource/Makefile                       |   2 +
 drivers/clocksource/csky_mptimer.c                 | 176 ++++++++++++++
 drivers/clocksource/timer-gx6605s.c                | 150 ++++++++++++
 drivers/irqchip/Kconfig                            |  16 ++
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-csky-apb-intc.c                | 260 +++++++++++++++++++++
 drivers/irqchip/irq-csky-mpintc.c                  | 195 ++++++++++++++++
 include/linux/cpuhotplug.h                         |   1 +
 13 files changed, 1004 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
 create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt
 create mode 100644 drivers/clocksource/csky_mptimer.c
 create mode 100644 drivers/clocksource/timer-gx6605s.c
 create mode 100644 drivers/irqchip/irq-csky-apb-intc.c
 create mode 100644 drivers/irqchip/irq-csky-mpintc.c

-- 
2.7.4

