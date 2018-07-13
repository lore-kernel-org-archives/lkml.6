Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188EFECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE283208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE283208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbeGMMUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:20:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53103 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729699AbeGMMUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:20:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so2665255wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 05:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PUj3+hel6wyKT1bEV5KzDiuoetRFVWYB7TO77TFVJR4=;
        b=WmHDx19Bb6uv9uZAEGCKlPoFbLYYLH6q8FW4eL6ub52gPGR04dym9aDh76c9IskpNs
         uUhAl660HKQQ7/KJm1RFzUUUzPsAQGFQv53jRwQIU01SDBLntQKqqDh5M9uJTm5hDU2w
         Yi4XfZBg/x6uUqxoLKnX7Ncvn+t4X3gAhC9UHtxAlDb/E5cz02KyI+rri7+uH818OerA
         zxJlncujZwPpmv1KTYtIpRQGkDEjoTNJN0nMJIynjpNYKnFMxygWp5p4ZqB7Z5VqIrl9
         g3NjEKkk59BuHOZUfp0f+Q8FHY3UQQu3+hPlwTBMB/J8IDF/HLTlrlTpmE9jlF+dJL6v
         ilww==
X-Gm-Message-State: AOUpUlEr5Z7Zt61ue3uKsGgstmIXDdOvT0dcFVpeEni51E7WelqmC5Ly
        Xl/zocWP/G4KOmTblAJcjgiBTtKCpVMLMw==
X-Google-Smtp-Source: AAOMgpcoE6PzepgD97H+wcDw28o4L7NJSTWUTk45Uv/a4t2JMyBvXLVZZcU/D/oCCVNYwgnOYq2ulg==
X-Received: by 2002:a1c:57c1:: with SMTP id l184-v6mr1484570wmb.16.1531483582755;
        Fri, 13 Jul 2018 05:06:22 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i6-v6sm23316328wrr.10.2018.07.13.05.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 05:06:22 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 3/3] timekeeping/ntp: Constify some function arguments
Date:   Fri, 13 Jul 2018 14:06:42 +0200
Message-Id: <20180713120642.22147-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180713120642.22147-1-omosnace@redhat.com>
References: <20180713120642.22147-1-omosnace@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'const' to some function arguments and variables to make it easier
to read the code.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/timekeeping.h        |  2 +-
 kernel/time/ntp.c                  |  6 +++---
 kernel/time/ntp_internal.h         |  2 +-
 kernel/time/timekeeping.c          | 29 +++++++++++++++--------------
 kernel/time/timekeeping_debug.c    |  2 +-
 kernel/time/timekeeping_internal.h |  2 +-
 6 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 86bc2026efce..edace6b656e9 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -177,7 +177,7 @@ static inline time64_t ktime_get_clocktai_seconds(void)
 extern bool timekeeping_rtc_skipsuspend(void);
 extern bool timekeeping_rtc_skipresume(void);
 
-extern void timekeeping_inject_sleeptime64(struct timespec64 *delta);
+extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
 /*
  * struct system_time_snapshot - simultaneous raw/real time capture with
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 6c764addef3e..f2c7bbf65db8 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -642,7 +642,7 @@ void ntp_notify_cmos_timer(void)
 /*
  * Propagate a new txc->status value into the NTP state:
  */
-static inline void process_adj_status(struct timex *txc)
+static inline void process_adj_status(const struct timex *txc)
 {
 	if ((time_status & STA_PLL) && !(txc->status & STA_PLL)) {
 		time_state = TIME_OK;
@@ -665,7 +665,7 @@ static inline void process_adj_status(struct timex *txc)
 }
 
 
-static inline void process_adjtimex_modes(struct timex *txc, s32 *time_tai)
+static inline void process_adjtimex_modes(const struct timex *txc, s32 *time_tai)
 {
 	if (txc->modes & ADJ_STATUS)
 		process_adj_status(txc);
@@ -716,7 +716,7 @@ static inline void process_adjtimex_modes(struct timex *txc, s32 *time_tai)
  * adjtimex mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
-int __do_adjtimex(struct timex *txc, struct timespec64 *ts, s32 *time_tai)
+int __do_adjtimex(struct timex *txc, const struct timespec64 *ts, s32 *time_tai)
 {
 	int result;
 
diff --git a/kernel/time/ntp_internal.h b/kernel/time/ntp_internal.h
index 909bd1f1bfb1..21292c7c56a1 100644
--- a/kernel/time/ntp_internal.h
+++ b/kernel/time/ntp_internal.h
@@ -8,6 +8,6 @@ extern void ntp_clear(void);
 extern u64 ntp_tick_length(void);
 extern ktime_t ntp_get_next_leap(void);
 extern int second_overflow(time64_t secs);
-extern int __do_adjtimex(struct timex *, struct timespec64 *, s32 *);
+extern int __do_adjtimex(struct timex *, const struct timespec64 *, s32 *);
 extern void __hardpps(const struct timespec64 *, const struct timespec64 *);
 #endif /* _LINUX_NTP_INTERNAL_H */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4786df904c22..6253bb21c3bf 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -97,7 +97,7 @@ static inline void tk_normalize_xtime(struct timekeeper *tk)
 	}
 }
 
-static inline struct timespec64 tk_xtime(struct timekeeper *tk)
+static inline struct timespec64 tk_xtime(const struct timekeeper *tk)
 {
 	struct timespec64 ts;
 
@@ -154,7 +154,7 @@ static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
  * a read of the fast-timekeeper tkrs (which is protected by its own locking
  * and update logic).
  */
-static inline u64 tk_clock_read(struct tk_read_base *tkr)
+static inline u64 tk_clock_read(const struct tk_read_base *tkr)
 {
 	struct clocksource *clock = READ_ONCE(tkr->clock);
 
@@ -203,7 +203,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 }
 
-static inline u64 timekeeping_get_delta(struct tk_read_base *tkr)
+static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	u64 now, last, mask, max, delta;
@@ -247,7 +247,7 @@ static inline u64 timekeeping_get_delta(struct tk_read_base *tkr)
 static inline void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 {
 }
-static inline u64 timekeeping_get_delta(struct tk_read_base *tkr)
+static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
 {
 	u64 cycle_now, delta;
 
@@ -344,7 +344,7 @@ u32 (*arch_gettimeoffset)(void) = default_arch_gettimeoffset;
 static inline u32 arch_gettimeoffset(void) { return 0; }
 #endif
 
-static inline u64 timekeeping_delta_to_ns(struct tk_read_base *tkr, u64 delta)
+static inline u64 timekeeping_delta_to_ns(const struct tk_read_base *tkr, u64 delta)
 {
 	u64 nsec;
 
@@ -355,7 +355,7 @@ static inline u64 timekeeping_delta_to_ns(struct tk_read_base *tkr, u64 delta)
 	return nsec + arch_gettimeoffset();
 }
 
-static inline u64 timekeeping_get_ns(struct tk_read_base *tkr)
+static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
 {
 	u64 delta;
 
@@ -363,7 +363,7 @@ static inline u64 timekeeping_get_ns(struct tk_read_base *tkr)
 	return timekeeping_delta_to_ns(tkr, delta);
 }
 
-static inline u64 timekeeping_cycles_to_ns(struct tk_read_base *tkr, u64 cycles)
+static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles)
 {
 	u64 delta;
 
@@ -386,7 +386,8 @@ static inline u64 timekeeping_cycles_to_ns(struct tk_read_base *tkr, u64 cycles)
  * slightly wrong timestamp (a few nanoseconds). See
  * @ktime_get_mono_fast_ns.
  */
-static void update_fast_timekeeper(struct tk_read_base *tkr, struct tk_fast *tkf)
+static void update_fast_timekeeper(const struct tk_read_base *tkr,
+				   struct tk_fast *tkf)
 {
 	struct tk_read_base *base = tkf->base;
 
@@ -541,10 +542,10 @@ EXPORT_SYMBOL_GPL(ktime_get_real_fast_ns);
  * number of cycles every time until timekeeping is resumed at which time the
  * proper readout base for the fast timekeeper will be restored automatically.
  */
-static void halt_fast_timekeeper(struct timekeeper *tk)
+static void halt_fast_timekeeper(const struct timekeeper *tk)
 {
 	static struct tk_read_base tkr_dummy;
-	struct tk_read_base *tkr = &tk->tkr_mono;
+	const struct tk_read_base *tkr = &tk->tkr_mono;
 
 	memcpy(&tkr_dummy, tkr, sizeof(tkr_dummy));
 	cycles_at_suspend = tk_clock_read(tkr);
@@ -1269,7 +1270,7 @@ EXPORT_SYMBOL(do_settimeofday64);
  *
  * Adds or subtracts an offset value from the current time.
  */
-static int timekeeping_inject_offset(struct timespec64 *ts)
+static int timekeeping_inject_offset(const struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned long flags;
@@ -1577,7 +1578,7 @@ static struct timespec64 timekeeping_suspend_time;
  * adds the sleep offset to the timekeeping variables.
  */
 static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
-					   struct timespec64 *delta)
+					   const struct timespec64 *delta)
 {
 	if (!timespec64_valid_strict(delta)) {
 		printk_deferred(KERN_WARNING
@@ -1638,7 +1639,7 @@ bool timekeeping_rtc_skipsuspend(void)
  * This function should only be called by rtc_resume(), and allows
  * a suspend offset to be injected into the timekeeping values.
  */
-void timekeeping_inject_sleeptime64(struct timespec64 *delta)
+void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned long flags;
@@ -2220,7 +2221,7 @@ ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
 /**
  * timekeeping_validate_timex - Ensures the timex is ok for use in do_adjtimex
  */
-static int timekeeping_validate_timex(struct timex *txc)
+static int timekeeping_validate_timex(const struct timex *txc)
 {
 	if (txc->modes & ADJ_ADJTIME) {
 		/* singleshot must not be used with any other mode bits */
diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index 0754cadfa9e6..238e4be60229 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -70,7 +70,7 @@ static int __init tk_debug_sleep_time_init(void)
 }
 late_initcall(tk_debug_sleep_time_init);
 
-void tk_debug_account_sleep_time(struct timespec64 *t)
+void tk_debug_account_sleep_time(const struct timespec64 *t)
 {
 	/* Cap bin index so we don't overflow the array */
 	int bin = min(fls(t->tv_sec), NUM_BINS-1);
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index cf5c0828ee31..bcbb52db2256 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -8,7 +8,7 @@
 #include <linux/time.h>
 
 #ifdef CONFIG_DEBUG_FS
-extern void tk_debug_account_sleep_time(struct timespec64 *t);
+extern void tk_debug_account_sleep_time(const struct timespec64 *t);
 #else
 #define tk_debug_account_sleep_time(x)
 #endif
-- 
2.17.1

