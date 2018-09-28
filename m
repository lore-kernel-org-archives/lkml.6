Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D11C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9B0206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9B0206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeI2C7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:59:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60919 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeI2C7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:59:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8SKXrKB553906
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 28 Sep 2018 13:33:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8SKXq7h553903;
        Fri, 28 Sep 2018 13:33:52 -0700
Date:   Fri, 28 Sep 2018 13:33:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peng Hao <tipbot@zytor.com>
Message-ID: <tip-dc6253108f0fbff4a634055d5b8a91958ec2af81@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peng.hao2@zte.com.cn, mingo@kernel.org, hpa@zytor.com
Reply-To: peng.hao2@zte.com.cn, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <1538150608-2599-1-git-send-email-penghao122@sina.com.cn>
References: <1538150608-2599-1-git-send-email-penghao122@sina.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] tick/broadcast: Remove redundant check
Git-Commit-ID: dc6253108f0fbff4a634055d5b8a91958ec2af81
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  dc6253108f0fbff4a634055d5b8a91958ec2af81
Gitweb:     https://git.kernel.org/tip/dc6253108f0fbff4a634055d5b8a91958ec2af81
Author:     Peng Hao <peng.hao2@zte.com.cn>
AuthorDate: Fri, 28 Sep 2018 12:03:28 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Sep 2018 22:29:35 +0200

tick/broadcast: Remove redundant check

tick_device_is_functional() is called early in tick_broadcast_control(), so
no need to call it again later.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fweisbec@gmail.com
Link: https://lkml.kernel.org/r/1538150608-2599-1-git-send-email-penghao122@sina.com.cn

---
 kernel/time/tick-broadcast.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index aa2094d5dd27..be0aac2b4300 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -400,8 +400,6 @@ void tick_broadcast_control(enum tick_broadcast_mode mode)
 		if (tick_broadcast_forced)
 			break;
 		cpumask_clear_cpu(cpu, tick_broadcast_on);
-		if (!tick_device_is_functional(dev))
-			break;
 		if (cpumask_test_and_clear_cpu(cpu, tick_broadcast_mask)) {
 			if (tick_broadcast_device.mode ==
 			    TICKDEV_MODE_PERIODIC)
