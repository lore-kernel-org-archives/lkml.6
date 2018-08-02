Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC61C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E5C21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E5C21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbeHBOtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:49:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60849 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbeHBOtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:49:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w72CwJWY3506697
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 05:58:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w72CwI113506694;
        Thu, 2 Aug 2018 05:58:18 -0700
Date:   Thu, 2 Aug 2018 05:58:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sudeep Holla <tipbot@zytor.com>
Message-ID: <tip-234b3840d73430564a03f53973a311b7a83a95a9@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        sudeep.holla@arm.com, hpa@zytor.com
Reply-To: sudeep.holla@arm.com, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1531308264-24220-2-git-send-email-sudeep.holla@arm.com>
References: <1531308264-24220-2-git-send-email-sudeep.holla@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] tick/broadcast-hrtimer: Use cpu_possible_mask for
 ce_broadcast_hrtimer
Git-Commit-ID: 234b3840d73430564a03f53973a311b7a83a95a9
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

Commit-ID:  234b3840d73430564a03f53973a311b7a83a95a9
Gitweb:     https://git.kernel.org/tip/234b3840d73430564a03f53973a311b7a83a95a9
Author:     Sudeep Holla <sudeep.holla@arm.com>
AuthorDate: Wed, 11 Jul 2018 12:24:23 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 2 Aug 2018 14:55:52 +0200

tick/broadcast-hrtimer: Use cpu_possible_mask for ce_broadcast_hrtimer

This is the last instance of cpu_all_mask usage in the core framework.

Replace it with cpu_possible_mask like all other instances in the
clockevent drivers. This makes it possible to add a warning in the core
clockevents_register_device on usage of cpu_all_mask from any clockevent
drivers in the future.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lkml.kernel.org/r/1531308264-24220-2-git-send-email-sudeep.holla@arm.com

---
 kernel/time/tick-broadcast-hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index 58045eb976c3..a59641fb88b6 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -90,7 +90,7 @@ static struct clock_event_device ce_broadcast_hrtimer = {
 	.max_delta_ticks	= ULONG_MAX,
 	.mult			= 1,
 	.shift			= 0,
-	.cpumask		= cpu_all_mask,
+	.cpumask		= cpu_possible_mask,
 };
 
 static enum hrtimer_restart bc_handler(struct hrtimer *t)
