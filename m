Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3054C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E8420666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E8420666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbeI1Whp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:37:45 -0400
Received: from mail78-59.sinamail.sina.com.cn ([219.142.78.59]:58698 "HELO
        mail78-59.sinamail.sina.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1728643AbeI1Whp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:37:45 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Sep 2018 18:37:45 EDT
Received: from unknown (HELO localhost.localdomain.localdomain)([110.184.35.163])
        by sina.com with ESMTP
        id 5BAE50D300004B8A; Fri, 29 Sep 2018 00:03:39 +0800 (CST)
X-Sender: penghao122@sina.com.cn
X-Auth-ID: penghao122@sina.com.cn
X-SMAIL-MID: 565916394183
From:   Peng Hao <penghao122@sina.com.cn>
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  tick: remove unnecssary check
Date:   Fri, 28 Sep 2018 12:03:28 -0400
Message-Id: <1538150608-2599-1-git-send-email-penghao122@sina.com.cn>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peng Hao <peng.hao2@zte.com.cn>

tick_device_is_functional() has been called in the front of
tick_broadcast_control, so don't need call it again.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 kernel/time/tick-broadcast.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index aa2094d..74637c2 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -399,9 +399,7 @@ void tick_broadcast_control(enum tick_broadcast_mode mode)
 	case TICK_BROADCAST_OFF:
 		if (tick_broadcast_forced)
 			break;
-		cpumask_clear_cpu(cpu, tick_broadcast_on);
-		if (!tick_device_is_functional(dev))
-			break;
+		cpumask_clear_cpu(cpu, tick_broadcast_on);
 		if (cpumask_test_and_clear_cpu(cpu, tick_broadcast_mask)) {
 			if (tick_broadcast_device.mode ==
 			    TICKDEV_MODE_PERIODIC)
-- 
1.8.3.1


