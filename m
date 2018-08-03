Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650A8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0979F2174D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0979F2174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbeHCMVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:21:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52017 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeHCMVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:21:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w73AOrSB3851038
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Aug 2018 03:24:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w73AOoMY3851035;
        Fri, 3 Aug 2018 03:24:50 -0700
Date:   Fri, 3 Aug 2018 03:24:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sinan Kaya <tipbot@zytor.com>
Message-ID: <tip-1b6266ebe3da8198e9a02fbad77bbb56e2f7ce2e@git.kernel.org>
Cc:     colin.king@canonical.com, mingo@kernel.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        dzickus@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, peterz@infradead.org, okaya@kernel.org
Reply-To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
          dzickus@redhat.com, kstewart@linuxfoundation.org,
          colin.king@canonical.com, mingo@kernel.org, okaya@kernel.org,
          peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20180803060943.2643-1-okaya@kernel.org>
References: <20180803060943.2643-1-okaya@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] watchdog: Reduce message verbosity
Git-Commit-ID: 1b6266ebe3da8198e9a02fbad77bbb56e2f7ce2e
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

Commit-ID:  1b6266ebe3da8198e9a02fbad77bbb56e2f7ce2e
Gitweb:     https://git.kernel.org/tip/1b6266ebe3da8198e9a02fbad77bbb56e2f7ce2e
Author:     Sinan Kaya <okaya@kernel.org>
AuthorDate: Thu, 2 Aug 2018 23:09:41 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 3 Aug 2018 12:19:08 +0200

watchdog: Reduce message verbosity

Code is emitting the following error message during boot on systems
without PMU hardware support while probing NMI capability.

 NMI watchdog: Perf event create on CPU 0 failed with -2

This error is emitted as the perf subsystem returns -ENOENT due to lack of
PMUs in the system.

It is followed by the warning that NMI watchdog is disabled:

  NMI watchdog: Perf NMI watchdog permanently disabled

While NMI disabled information is useful for ordinary users, seeing a PERF
event create failed with error code -2 is not.

Reduce the message severity to debug so that if debugging is still possible
in case the error code returned by perf is required for analysis.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Don Zickus <dzickus@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=599368
Link: https://lkml.kernel.org/r/20180803060943.2643-1-okaya@kernel.org

---
 kernel/watchdog_hld.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index e449a23e9d59..1f7020d65d0a 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -175,8 +175,8 @@ static int hardlockup_detector_event_create(void)
 	evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
 					       watchdog_overflow_callback, NULL);
 	if (IS_ERR(evt)) {
-		pr_info("Perf event create on CPU %d failed with %ld\n", cpu,
-			PTR_ERR(evt));
+		pr_debug("Perf event create on CPU %d failed with %ld\n", cpu,
+			 PTR_ERR(evt));
 		return PTR_ERR(evt);
 	}
 	this_cpu_write(watchdog_ev, evt);
