Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE790C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD3E208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD3E208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935827AbeFRPJt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:09:49 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37515 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935783AbeFRPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:09:45 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MDr1W-1fR7t63QvW-00H8FZ; Mon, 18 Jun 2018 17:09:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>
Cc:     y2038@lists.linaro.org, Riley Andrews <riandrews@android.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alistair Strachan <astrachan@google.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: android/vsoc: stop using 'timespec'
Date:   Mon, 18 Jun 2018 17:09:09 +0200
Message-Id: <20180618150933.1130612-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:epIpnDGNxThKxTKXqv+3YABcHqa2ID3BYxNR4H1TqAQBWT3HyHf
 ksfuZfrRMT4tn6rzVBThFkIrz1SgBudxm9ijg981BBC/mzxF1yeHyJ3mX5v2r1ilxG2Kdfb
 stJg38fGIre5CGF7eBon2YR1FarlKQEdsSCYX7Ovwcdq376IWbqfZzUCGxJobG+FTkS0coA
 H8DM9hZggTJ8frLKN/IEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dd36o3RPJ0E=:OFY6/mpqescaHELkLLM3GL
 4jjQ/eToHpCJ/2UWzCXuvPNiqBsRTeEoj5u6Yv0rx5OrI8gj3bAW97JZPwONJiyEJk36o17DV
 A3SV7GfGhKJ9PDUHPyHweXypx4vmpOBzp5p42JmJyuRiE6p+LBPtGxuTnmJAVE2+7LsFeNPED
 AQ6sFVwBvN4Svnbu31HUSvzvJO79k1sXtEslwuOtHOQ/poH0O0RJzcVGSC7WTSiXnyGu5cBFs
 vqd2MIDTsOnNVrN4D5vOIm5XTHJfQYGg+X3HWHYtFkVwv07/tobqlRzLfbGdDc/gNKBn014r3
 w/GKWbffc0mFHm3YRqw0cOOLPpP4qBn3Q58yrv+wPb97QxmIEt/N5bM1dlo9fJ3XYDX6zIr4o
 kLk3Vl4YCdmzAAEYAmg8wh7Br7k1mR9uMVLPd+12gfXbRG4N+4KQpMnN5TcLskwo6CQ04TGcF
 2bdt1vnd9wnxC5G5MPrJ7v4BlXTR0vSqhvyr/rqcbwk1++JDx7BdbODxk55t/2atwf+fT9ZA+
 wdAD7FWODbt+5jDrB86JQqvWo2MIYGkBUEHhCE058/nbjh+BwfebQCXjltRpHAfCbGqWNmraP
 2xbnTVMWTx0hWnGOl2k2zMDaQ1lInB0r4V9DW6hMJKsI3fjNbJC1I8T6tUnsi6bBjtHHao7t8
 FlJrHq4RTqHjiF6mGOj17Bv/i+BBWWRaDmLLvYblduf55dAvdcCbQQsp6uVIM8ztXt2Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timespec structure suffers from the y2038 overflow and should not
be used. This changes handle_vsoc_cond_wait() to use ktime_t directly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/android/vsoc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 806beda1040b..22571abcaa4e 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -405,7 +405,7 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 	int ret = 0;
 	struct vsoc_device_region *region_p = vsoc_region_from_filep(filp);
 	atomic_t *address = NULL;
-	struct timespec ts;
+	ktime_t wake_time;
 
 	/* Ensure that the offset is aligned */
 	if (arg->offset & (sizeof(uint32_t) - 1))
@@ -433,14 +433,13 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 		 * We do things this way to flatten differences between 32 bit
 		 * and 64 bit timespecs.
 		 */
-		ts.tv_sec = arg->wake_time_sec;
-		ts.tv_nsec = arg->wake_time_nsec;
-
-		if (!timespec_valid(&ts))
+		if (arg->wake_time_nsec >= NSEC_PER_SEC)
 			return -EINVAL;
+		wake_time = ktime_set(arg->wake_time_sec, arg->wake_time_nsec);
+
 		hrtimer_init_on_stack(&to->timer, CLOCK_MONOTONIC,
 				      HRTIMER_MODE_ABS);
-		hrtimer_set_expires_range_ns(&to->timer, timespec_to_ktime(ts),
+		hrtimer_set_expires_range_ns(&to->timer, wake_time,
 					     current->timer_slack_ns);
 
 		hrtimer_init_sleeper(to, current);
-- 
2.9.0

