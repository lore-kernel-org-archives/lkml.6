Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614A1C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235FF20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235FF20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeILT65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:58:57 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57421 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728405AbeILT65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:58:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3635928|-1;CH=blue;FP=13622391009037904581|1|1|11|0|-1|-1|-1;HT=e02c03298;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.CpxPATv_1536764011;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CpxPATv_1536764011)
          by smtp.aliyun-inc.com(10.147.44.118);
          Wed, 12 Sep 2018 22:53:31 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org,
        andrea.parri@amarulasolutions.com, peterz@infradead.org
Cc:     c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com,
        green.hu@gmail.com
Subject: [PATCH V4 25/27] clocksource: add C-SKY timers' build infrastructure
Date:   Wed, 12 Sep 2018 22:52:07 +0800
Message-Id: <39d2536275535bf072cd9d93133b785c40dd978f.1536758961.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
References: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536758961.git.ren_guo@c-sky.com>
References: <cover.1536758961.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 drivers/clocksource/Kconfig  | 15 +++++++++++++++
 drivers/clocksource/Makefile |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index dec0dd8..6ff0a25 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -609,4 +609,19 @@ config ATCPIT100_TIMER
 	help
 	  This option enables support for the Andestech ATCPIT100 timers.
 
+config CSKY_MPTIMER
+	bool "C-SKY mptimer driver"
+	depends on CSKY
+	select TIMER_OF
+	help
+	  This option enables support for C-SKY mptimer.
+
+config GX6605S_TIMER
+	bool "Gx6605s SOC system timer driver"
+	depends on CSKY
+	select CLKSRC_MMIO
+	select TIMER_OF
+	help
+	  This option enables support for gx6605s timer.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 00caf37..764a45a 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -78,3 +78,5 @@ obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
+obj-$(CONFIG_CSKY_MPTIMER)		+= csky_mptimer.o
+obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
-- 
2.7.4

