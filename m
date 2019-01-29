Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6768CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FC420880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfA2TNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:13:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59521 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfA2TNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:13:52 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0TJDYwQ2062021
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 29 Jan 2019 11:13:34 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0TJDYRs2062018;
        Tue, 29 Jan 2019 11:13:34 -0800
Date:   Tue, 29 Jan 2019 11:13:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-75b710af7139768fd4ba2d4e05335d2344796279@git.kernel.org>
Cc:     gustavo@embeddedor.com, sboyd@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        tglx@linutronix.de, john.stultz@linaro.org, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, john.stultz@linaro.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org, fweisbec@gmail.com,
          sboyd@kernel.org, gustavo@embeddedor.com
In-Reply-To: <20190123081413.GA3949@embeddedor>
References: <20190123081413.GA3949@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timers: Mark expected switch fall-throughs
Git-Commit-ID: 75b710af7139768fd4ba2d4e05335d2344796279
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

Commit-ID:  75b710af7139768fd4ba2d4e05335d2344796279
Gitweb:     https://git.kernel.org/tip/75b710af7139768fd4ba2d4e05335d2344796279
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Wed, 23 Jan 2019 02:14:13 -0600
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 29 Jan 2019 20:08:42 +0100

timers: Mark expected switch fall-throughs

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where fall through is indeed expected.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Link: https://lkml.kernel.org/r/20190123081413.GA3949@embeddedor

---
 kernel/time/hrtimer.c        | 2 +-
 kernel/time/tick-broadcast.c | 1 +
 kernel/time/timer.c          | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f5cfa1b73d6f..6418e1bdc549 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -364,7 +364,7 @@ static bool hrtimer_fixup_activate(void *addr, enum debug_obj_state state)
 	switch (state) {
 	case ODEBUG_STATE_ACTIVE:
 		WARN_ON(1);
-
+		/* fall through */
 	default:
 		return false;
 	}
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 803fa67aace9..ee834d4fb814 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -375,6 +375,7 @@ void tick_broadcast_control(enum tick_broadcast_mode mode)
 	switch (mode) {
 	case TICK_BROADCAST_FORCE:
 		tick_broadcast_forced = 1;
+		/* fall through */
 	case TICK_BROADCAST_ON:
 		cpumask_set_cpu(cpu, tick_broadcast_on);
 		if (!cpumask_test_and_set_cpu(cpu, tick_broadcast_mask)) {
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 444156debfa0..167e71f9ed3c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -647,7 +647,7 @@ static bool timer_fixup_activate(void *addr, enum debug_obj_state state)
 
 	case ODEBUG_STATE_ACTIVE:
 		WARN_ON(1);
-
+		/* fall through */
 	default:
 		return false;
 	}
