Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73EAECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6057121524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dTUtpW96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6057121524
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbeITCal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43365 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732982AbeITCaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id z27-v6so6012169edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/My90qQYivh+ggnDkzV7nIXKz/st4P1p9Q6cxQyPS9Y=;
        b=dTUtpW96x8E2guWneUGZkMU7Q3mhcUAu/7M5f/Acp/9HYODk1PvEOiB47Pq1eWmWdh
         FHBZT8dWcdDbK4LBPVOsLTfmBxM0CxlZVqJf+47/uEtyWIbC0BjSlH6yVAeg0ojjbc22
         hKp1gLGwJ6n08j2NhwsbK/N10xjgGSG5MxTUvEDCSNiicNJeT1BmkLAAVeh/cDy/Dclq
         brocTeWDd06EKnIK2ObeKMe3VQsJ2OTmDrzEyTF2bT50WCJxCfMvV74Q+qw/WmLX9teO
         35a0ub0qwjBNvTdSVhgdfSE0C9XFTp3//JgJmSbJDtjSnKvbcMyzy+fsy+pmrHzEDX2r
         NXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/My90qQYivh+ggnDkzV7nIXKz/st4P1p9Q6cxQyPS9Y=;
        b=LnWPwXCgzfI4s5RHS23B99idrSwkU9+Jf++IH3yqiS33zx5msxnGj3akW6479yfyFd
         UYiPy4iy5y9c9J0u9pcf93+wX23vq3/XAh0AO7yaXcTvYQMBpDo9bwkktfOLRGVQrHvT
         9YUAGJdnKVOZxYk2Uy7XlaEjk6MD071yBKOi4n9f+9joBxERJVcdVLjehmHJuSZiNnlf
         t6J9vVz7jxbb+/VgKHmkdV7spNs+R83mp18rBt/DU4j+IQGUSLxipaJW6d+Kx+ojDZrP
         eFDW/Q65E/GSbpO9ksrIGeCoYTTRjd2dT5gUAXQoH3VXth9OmsHsj7XjJj2/J9T8x7xq
         JAlA==
X-Gm-Message-State: APzg51AeN4XZiwK44aqBVgwRi3ekQWawsWAEgwt6UTMQNz/qORbNXWBy
        eBK3C/g0Lf3V2puKQzW31XdqUS6n0Xg=
X-Google-Smtp-Source: ANB0VdbvJr9LSayRqpI+QxcTHvMk8sM2IcR4E5dt03SYiw92Xh4iJ56P38GnR4HTVH7g8VUYmBfNEw==
X-Received: by 2002:aa7:c314:: with SMTP id l20-v6mr61308355edq.53.1537390258514;
        Wed, 19 Sep 2018 13:50:58 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:50:57 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [RFC 13/20] posix-timers/timens: Take into account clock offsets
Date:   Wed, 19 Sep 2018 21:50:30 +0100
Message-Id: <20180919205037.9574-14-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Provide a helper that will convert clocks to time namespace.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/posix-timers.c | 52 +++++++++++++++++++++++++++++++---------------
 kernel/time/posix-timers.h |  2 ++
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d38835a21c5d..701cb0602b7a 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -206,12 +206,26 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
 	return do_adjtimex(t);
 }
 
-static void timens_adjust_monotonic(struct timespec64 *tp)
+static void common_timens_adjust(clockid_t which_clock, struct timespec64 *tp)
 {
 	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
 
-	if (ns_offsets)
+	if (!ns_offsets)
+		return;
+
+	switch (which_clock) {
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+	case CLOCK_MONOTONIC_COARSE:
 		*tp = timespec64_add(*tp, ns_offsets->monotonic_time_offset);
+		break;
+	case CLOCK_BOOTTIME:
+		*tp = timespec64_add(*tp, ns_offsets->monotonic_boottime_offset);
+		break;
+	default:
+		WARN_ONCE(1, "Time Namespace offset for %d is not realized",
+				which_clock);
+	}
 }
 
 static int posix_ktime_set_ts(clockid_t which_clock,
@@ -239,7 +253,6 @@ static int posix_ktime_set_ts(clockid_t which_clock,
 static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
-	timens_adjust_monotonic(tp);
 	return 0;
 }
 
@@ -249,7 +262,6 @@ static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_raw_ts64(tp);
-	timens_adjust_monotonic(tp);
 	return 0;
 }
 
@@ -264,7 +276,6 @@ static int posix_get_monotonic_coarse(clockid_t which_clock,
 						struct timespec64 *tp)
 {
 	ktime_get_coarse_ts64(tp);
-	timens_adjust_monotonic(tp);
 	return 0;
 }
 
@@ -276,15 +287,7 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 
 static int posix_get_boottime(const clockid_t which_clock, struct timespec64 *tp)
 {
-	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
-
 	ktime_get_boottime_ts64(tp);
-
-	if (!ns_offsets)
-		return 0;
-
-	*tp = timespec64_add(*tp, ns_offsets->monotonic_boottime_offset);
-
 	return 0;
 }
 
@@ -933,10 +936,6 @@ static int do_timer_settime(timer_t timer_id, int flags,
 	unsigned long flag;
 	int error = 0;
 
-	if (!timespec64_valid(&new_spec64->it_interval) ||
-	    !timespec64_valid(&new_spec64->it_value))
-		return -EINVAL;
-
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
 retry:
@@ -944,6 +943,15 @@ static int do_timer_settime(timer_t timer_id, int flags,
 	if (!timr)
 		return -EINVAL;
 
+	if (flags & TIMER_ABSTIME)
+		timens_clock_to_host(timr->it_clock, &new_spec64->it_value);
+
+	if (!timespec64_valid(&new_spec64->it_interval) ||
+	    !timespec64_valid(&new_spec64->it_value)) {
+		unlock_timer(timr, flag);
+		return -EINVAL;
+	}
+
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;
@@ -1121,6 +1129,9 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 
 	error = kc->clock_get(which_clock, &kernel_tp);
 
+	if (!error && kc->clock_timens_adjust)
+		kc->clock_timens_adjust(which_clock, &kernel_tp);
+
 	if (!error && put_timespec64(&kernel_tp, tp))
 		error = -EFAULT;
 
@@ -1197,6 +1208,9 @@ COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
 
 	err = kc->clock_get(which_clock, &ts);
 
+	if (!err && kc->clock_timens_adjust)
+		kc->clock_timens_adjust(which_clock, &ts);
+
 	if (!err && compat_put_timespec64(&ts, tp))
 		err = -EFAULT;
 
@@ -1340,6 +1354,7 @@ static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get		= posix_ktime_get_ts,
 	.clock_set		= posix_ktime_set_ts,
+	.clock_timens_adjust	= common_timens_adjust,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1356,6 +1371,7 @@ static const struct k_clock clock_monotonic_raw = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get		= posix_get_monotonic_raw,
 	.clock_set		= posix_ktime_set_ts,
+	.clock_timens_adjust	= common_timens_adjust,
 };
 
 static const struct k_clock clock_realtime_coarse = {
@@ -1367,6 +1383,7 @@ static const struct k_clock clock_monotonic_coarse = {
 	.clock_getres		= posix_get_coarse_res,
 	.clock_get		= posix_get_monotonic_coarse,
 	.clock_set		= posix_ktime_set_ts,
+	.clock_timens_adjust	= common_timens_adjust,
 };
 
 static const struct k_clock clock_tai = {
@@ -1388,6 +1405,7 @@ static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get		= posix_get_boottime,
 	.clock_set		= posix_set_boottime,
+	.clock_timens_adjust	= common_timens_adjust,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index ddb21145211a..308774bea32a 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -8,6 +8,8 @@ struct k_clock {
 			     const struct timespec64 *tp);
 	int	(*clock_get)(const clockid_t which_clock,
 			     struct timespec64 *tp);
+	void	(*clock_timens_adjust)(const clockid_t which_clock,
+			     struct timespec64 *tp);
 	int	(*clock_adj)(const clockid_t which_clock, struct timex *tx);
 	int	(*timer_create)(struct k_itimer *timer);
 	int	(*nsleep)(const clockid_t which_clock, int flags,
-- 
2.13.6

