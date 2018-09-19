Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1DEECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D2121533
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fEac+gJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D2121533
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733198AbeITCbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:31:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40435 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733021AbeITCan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id j62-v6so6018911edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7uOjBHO7Lrm52O0tbCG82wfS7n8jMKfvrIot6rE79ss=;
        b=fEac+gJbwc70BUi+TQv4ChHED/hfPZxUtEuIplGMLRbQmJ1/zw5xvOqaHM44Ys6sYa
         F1t+xkV+SjjwgfHvjw6iMcEfFLV2NDf4py+Fj+pWC3pOvIJTI9vHcswtwtmMItiJmuMN
         9HiT/rq+ivi0HrUSgdpl0T1gg6pRm6zCURdqKwUCw3rP9Agb83nQ5P+pJc4LO7bz+p+U
         zFGfQVYzM/M4VUf0QR5sMDZ4ngW1JXxOFNG7BQUs95YhV3aVtkAQmlX5hoWZC9RrluOK
         Wyht3lcYmsCKrRTQdVCUO6m/EQJ/SnPIbTyf7ZzgA6BMxW5HkRHPHhJJ45jPalHhN5VV
         yaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7uOjBHO7Lrm52O0tbCG82wfS7n8jMKfvrIot6rE79ss=;
        b=ihFQyk9/netpcfLeUNDw1n5vV9D3fzAduze6Ksg3q7CXeneBTHv5ZzTcwMtkkcHUnF
         SlMxqOk4ueKixfvg2J+oi/OlDbhKwSXcvLOKcmS6kCi8a2mzNDtj/NGWHrK8v0dPCrTr
         83RyAti4XQSVW9eIvXPSlbKCUWVq1Q0wlyviPTOSXK86ZmZCEpjcVeclndSibYsR15g5
         TSudpjHgKFpBkNimJpapln6ohRnlEqPi/bgkqaUL4mrx3At1tJg/D8rC29U91OGvH5qj
         tJsmugkTRVzgJ+282wSGLP7whH9TEla2HYYKAm2IP0KSyEE/rMG9U5yNBmL11q1FA7m+
         5Gkw==
X-Gm-Message-State: APzg51CgTGWy2/qVM1LZSK000EjIJ+B0UWusg7HYCmvOEajHtIyeRqVG
        zCyO8XKuEbCEIsXyAg8KXri02Qb74C0=
X-Google-Smtp-Source: ANB0VdZPAdtSGlptPeJ7tS4cRn9ERsACYu+R9HHufOdAypsrfQcsfJFiAczzjwmZeDloWAvYK99uCw==
X-Received: by 2002:a50:eb96:: with SMTP id y22-v6mr59898154edr.38.1537390261475;
        Wed, 19 Sep 2018 13:51:01 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:51:00 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: [RFC 15/20] timens: Optimize zero-offsets
Date:   Wed, 19 Sep 2018 21:50:32 +0100
Message-Id: <20180919205037.9574-16-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fall through on host or in ns without time set.
Add TIMENS_FALLBACK_SYSCALL which might be wired up if timens offsets
should be unknown for userspace (will result in fall-back to syscalls).

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vclock_gettime.c | 17 +++++++++++++----
 include/linux/timens_offsets.h       | 12 ++++++++++--
 kernel/time/posix-timers.c           | 21 ++++++++++++---------
 kernel/time_namespace.c              |  2 +-
 4 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index a265e2737a9a..458cb1992e2e 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -252,17 +252,25 @@ notrace void set_normalized_timespec(struct timespec *ts, time_t sec, s64 nsec)
 	ts->tv_nsec = nsec;
 }
 
-notrace static __always_inline void monotonic_to_ns(struct timespec *ts)
+notrace static __always_inline int monotonic_to_ns(struct timespec *ts)
 {
 #ifdef CONFIG_TIME_NS
 	struct timens_offsets *timens = (struct timens_offsets *) &timens_page;
 	struct timespec offset;
 
+	/* Optimization: time is the same as on host, return right away */
+	if (!(timens->flags & TIMENS_USE_OFFSETS))
+		return 0;
+
+	if (timens->flags & TIMENS_FALLBACK_SYSCALL)
+		return -1;
+
 	offset = timespec64_to_timespec(timens->monotonic_time_offset);
 
 	*ts = timespec_add(*ts, offset);
 
 #endif
+	return 0;
 }
 
 notrace static int __always_inline do_monotonic(struct timespec *ts)
@@ -283,8 +291,6 @@ notrace static int __always_inline do_monotonic(struct timespec *ts)
 	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
-	monotonic_to_ns(ts);
-
 	return mode;
 }
 
@@ -306,7 +312,6 @@ notrace static void do_monotonic_coarse(struct timespec *ts)
 		ts->tv_sec = gtod->monotonic_time_coarse_sec;
 		ts->tv_nsec = gtod->monotonic_time_coarse_nsec;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
-	monotonic_to_ns(ts);
 }
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
@@ -319,12 +324,16 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 	case CLOCK_MONOTONIC:
 		if (do_monotonic(ts) == VCLOCK_NONE)
 			goto fallback;
+		if (monotonic_to_ns(ts))
+			goto fallback;
 		break;
 	case CLOCK_REALTIME_COARSE:
 		do_realtime_coarse(ts);
 		break;
 	case CLOCK_MONOTONIC_COARSE:
 		do_monotonic_coarse(ts);
+		if (monotonic_to_ns(ts))
+			goto fallback;
 		break;
 	default:
 		goto fallback;
diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index 92a8ea5601eb..8c43e7c3e632 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -2,6 +2,13 @@
 #ifndef _LINUX_TIME_OFFSETS_H
 #define _LINUX_TIME_OFFSETS_H
 
+enum {
+	/* We're in namespace - add offsets from vvar */
+	TIMENS_USE_OFFSETS	= 1,
+	/* Don't expose host's offsets, fall back to syscall - slow */
+	TIMENS_FALLBACK_SYSCALL	= 2, /* TODO if anyone actually interested */
+};
+
 /*
  * Time offsets need align as they're placed on vvar page,
  * which should have tail paddings on ia32 vdso.
@@ -10,8 +17,9 @@
  * to timespec because of a padding occuring between the fields.
  */
 struct timens_offsets {
-	struct timespec64  monotonic_time_offset __aligned(8);
-	struct timespec64  monotonic_boottime_offset __aligned(8);
+	u64		  flags;
+	struct timespec64 monotonic_time_offset __aligned(8);
+	struct timespec64 monotonic_boottime_offset __aligned(8);
 };
 
 #endif
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 701cb0602b7a..576dbd24c498 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -210,7 +210,7 @@ static void common_timens_adjust(clockid_t which_clock, struct timespec64 *tp)
 {
 	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
 
-	if (!ns_offsets)
+	if (!ns_offsets || !(ns_offsets->flags & TIMENS_USE_OFFSETS))
 		return;
 
 	switch (which_clock) {
@@ -234,15 +234,16 @@ static int posix_ktime_set_ts(clockid_t which_clock,
 	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
 	struct timespec64 ktp;
 
+	if (!ns_offsets)
+		return -EINVAL;
+
 	if (!ns_capable(current->nsproxy->time_ns->user_ns, CAP_SYS_TIME))
 		return -EPERM;
 
 	ktime_get_ts64(&ktp);
 
-	if (ns_offsets)
-		ns_offsets->monotonic_time_offset = timespec64_sub(*tp, ktp);
-	else
-		return -EINVAL;
+	ns_offsets->monotonic_time_offset = timespec64_sub(*tp, ktp);
+	ns_offsets->flags |= TIMENS_USE_OFFSETS;
 
 	return 0;
 }
@@ -296,15 +297,17 @@ static int posix_set_boottime(clockid_t which_clock, const struct timespec64 *tp
 	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
 	struct timespec64 ktp;
 
+	if (!ns_offsets)
+		return -EINVAL;
+
 	if (!ns_capable(current->nsproxy->time_ns->user_ns, CAP_SYS_TIME))
 		return -EPERM;
 
 	ktime_get_boottime_ts64(&ktp);
 
-	if (ns_offsets)
-		ns_offsets->monotonic_boottime_offset = timespec64_sub(*tp, ktp);
-	else
-		return -EINVAL;
+	ns_offsets->monotonic_boottime_offset = timespec64_sub(*tp, ktp);
+	ns_offsets->flags |= TIMENS_USE_OFFSETS;
+
 	return 0;
 }
 
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index f88ae0e17d92..4052bdcec110 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -171,7 +171,7 @@ static void clock_timens_fixup(int clockid, struct timespec64 *val, bool to_ns)
 	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
 	struct timespec64 *offsets = NULL;
 
-	if (!ns_offsets)
+	if (!ns_offsets || !(ns_offsets->flags & TIMENS_USE_OFFSETS))
 		return;
 
 	if (val->tv_sec == 0 && val->tv_nsec == 0)
-- 
2.13.6

