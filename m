Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653F2C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9482081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9482081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeKHQU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:20:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52203 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeKHQU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:20:57 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA86jrAS1805135
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Nov 2018 22:45:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA86jppg1805132;
        Wed, 7 Nov 2018 22:45:51 -0800
Date:   Wed, 7 Nov 2018 22:45:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-e6a2d72c10405b30ddba5af2e44a9d3d925a56d3@git.kernel.org>
Cc:     hpa@zytor.com, mathieu.poirier@linaro.org, tglx@linutronix.de,
        rostedt@goodmis.org, bristot@redhat.com, claudio@evidence.eu.com,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it
Reply-To: mathieu.poirier@linaro.org, hpa@zytor.com, bristot@redhat.com,
          rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
          juri.lelli@redhat.com, claudio@evidence.eu.com, mingo@kernel.org,
          luca.abeni@santannapisa.it, linux-kernel@vger.kernel.org
In-Reply-To: <20181107111032.32291-1-juri.lelli@redhat.com>
References: <20181107111032.32291-1-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] posix-cpu-timers: Remove useless call to
 check_dl_overrun()
Git-Commit-ID: e6a2d72c10405b30ddba5af2e44a9d3d925a56d3
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

Commit-ID:  e6a2d72c10405b30ddba5af2e44a9d3d925a56d3
Gitweb:     https://git.kernel.org/tip/e6a2d72c10405b30ddba5af2e44a9d3d925a56d3
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Wed, 7 Nov 2018 12:10:32 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Nov 2018 07:43:35 +0100

posix-cpu-timers: Remove useless call to check_dl_overrun()

check_dl_overrun() is used to send a SIGXCPU to users that asked to be
informed when a SCHED_DEADLINE runtime overruns occur.

The function is called by check_thread_timers() already, so the call in
check_process_timers() is redundant/wrong (even though harmless).

Remove it.

Fixes: 34be39305a77 ("sched/deadline: Implement "runtime overrun signal" support")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: linux-rt-users@vger.kernel.org
Cc: mtk.manpages@gmail.com
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Claudio Scordino <claudio@evidence.eu.com>
Link: https://lkml.kernel.org/r/20181107111032.32291-1-juri.lelli@redhat.com

---
 kernel/time/posix-cpu-timers.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index ce32cf741b25..8f0644af40be 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -917,9 +917,6 @@ static void check_process_timers(struct task_struct *tsk,
 	struct task_cputime cputime;
 	unsigned long soft;
 
-	if (dl_task(tsk))
-		check_dl_overrun(tsk);
-
 	/*
 	 * If cputimer is not running, then there are no active
 	 * process wide timers (POSIX 1.b, itimers, RLIMIT_CPU).
