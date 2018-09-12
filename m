Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02DCC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EA12146F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EA12146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeIMBtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:49:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40246 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbeIMBtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:49:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4034D2072F; Wed, 12 Sep 2018 22:43:20 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 14B05206F6;
        Wed, 12 Sep 2018 22:43:10 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: remove irq_task from kerneldoc
Date:   Wed, 12 Sep 2018 22:43:07 +0200
Message-Id: <20180912204307.16373-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stale mentions of irq_task are left in the kerneldoc after its removal.
Remove them.

There is still one indirect mention left but commit 3c8bb90efb6e ("rtc: Fix
hrtimer deadlock") can probably be reverted now.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 3d577e259e91..612a83d3ddcc 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -596,7 +596,6 @@ EXPORT_SYMBOL_GPL(rtc_update_irq_enable);
  * This function is called when an AIE, UIE or PIE mode interrupt
  * has occurred (or been emulated).
  *
- * Triggers the registered irq_task function callback.
  */
 void rtc_handle_legacy_irq(struct rtc_device *rtc, int num, int mode)
 {
@@ -741,7 +740,6 @@ static int rtc_update_hrtimer(struct rtc_device *rtc, int enabled)
 /**
  * rtc_irq_set_state - enable/disable 2^N Hz periodic IRQs
  * @rtc: the rtc device
- * @task: currently registered with rtc_irq_register()
  * @enabled: true to enable periodic IRQs
  * Context: any
  *
@@ -764,7 +762,6 @@ int rtc_irq_set_state(struct rtc_device *rtc, int enabled)
 /**
  * rtc_irq_set_freq - set 2^N Hz periodic IRQ frequency for IRQ
  * @rtc: the rtc device
- * @task: currently registered with rtc_irq_register()
  * @freq: positive frequency
  * Context: any
  *
-- 
2.19.0.rc2

