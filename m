Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE2C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DBC2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DBC2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbeGZO6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:58:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59288 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbeGZO6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E3AC120893; Thu, 26 Jul 2018 15:41:24 +0200 (CEST)
Received: from localhost (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1EBD9209C0;
        Thu, 26 Jul 2018 15:41:02 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6/8] rtc: unexport rtc_irq_set_*
Date:   Thu, 26 Jul 2018 15:40:54 +0200
Message-Id: <20180726134056.18273-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the rtc_irq_set interface internale to the RTC subsystem.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 76eb3a2957cc..d0983ed6c842 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -758,7 +758,6 @@ int rtc_irq_set_state(struct rtc_device *rtc, int enabled)
 	trace_rtc_irq_set_state(enabled, err);
 	return err;
 }
-EXPORT_SYMBOL_GPL(rtc_irq_set_state);
 
 /**
  * rtc_irq_set_freq - set 2^N Hz periodic IRQ frequency for IRQ
@@ -784,7 +783,6 @@ int rtc_irq_set_freq(struct rtc_device *rtc, int freq)
 	trace_rtc_irq_set_freq(freq, err);
 	return err;
 }
-EXPORT_SYMBOL_GPL(rtc_irq_set_freq);
 
 /**
  * rtc_timer_enqueue - Adds a rtc_timer to the rtc_device timerqueue
-- 
2.18.0

