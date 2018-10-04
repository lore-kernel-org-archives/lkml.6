Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B890C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1362087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1362087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeJEECg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:02:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41411 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJEECf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:02:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94L6jpl2884979
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 14:06:45 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94L6jYk2884976;
        Thu, 4 Oct 2018 14:06:45 -0700
Date:   Thu, 4 Oct 2018 14:06:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-e9a62f76f93c6f28b6c7e908eb12e5f1313870a2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        john.stultz@linaro.org, kys@microsoft.com, pbonzini@redhat.com,
        peterz@infradead.org, fweimer@redhat.com, matt@softrans.com.au,
        jgross@suse.com, hpa@zytor.com, vkuznets@redhat.com, arnd@arndb.de,
        luto@kernel.org, tglx@linutronix.de, mingo@kernel.org
Reply-To: pbonzini@redhat.com, kys@microsoft.com, peterz@infradead.org,
          fweimer@redhat.com, linux-kernel@vger.kernel.org,
          sboyd@kernel.org, john.stultz@linaro.org, jgross@suse.com,
          matt@softrans.com.au, vkuznets@redhat.com, hpa@zytor.com,
          mingo@kernel.org, luto@kernel.org, arnd@arndb.de,
          tglx@linutronix.de
In-Reply-To: <20180917130707.407955860@linutronix.de>
References: <20180917130707.407955860@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86/vdso: Collapse high resolution functions
Git-Commit-ID: e9a62f76f93c6f28b6c7e908eb12e5f1313870a2
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

Commit-ID:  e9a62f76f93c6f28b6c7e908eb12e5f1313870a2
Gitweb:     https://git.kernel.org/tip/e9a62f76f93c6f28b6c7e908eb12e5f1313870a2
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 14:45:39 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 4 Oct 2018 23:00:25 +0200

x86/vdso: Collapse high resolution functions

do_realtime() and do_monotonic() are now the same except for the storage
array index. Hand the index in as an argument and collapse the functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Matt Rickard <matt@softrans.com.au>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: devel@linuxdriverproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Juergen Gross <jgross@suse.com>
Link: https://lkml.kernel.org/r/20180917130707.407955860@linutronix.de

---
 arch/x86/entry/vdso/vclock_gettime.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 2c73e7f57316..1351b76638fb 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -205,35 +205,12 @@ notrace static inline u64 vgetsns(int *mode)
 	return v * gtod->mult;
 }
 
-/* Code size doesn't matter (vdso is 4k anyway) and this is faster. */
-notrace static int __always_inline do_realtime(struct timespec *ts)
+notrace static int do_hres(clockid_t clk, struct timespec *ts)
 {
-	struct vgtod_ts *base = &gtod->basetime[CLOCK_REALTIME];
+	struct vgtod_ts *base = &gtod->basetime[clk];
 	unsigned int seq;
-	u64 ns;
 	int mode;
-
-	do {
-		seq = gtod_read_begin(gtod);
-		mode = gtod->vclock_mode;
-		ts->tv_sec = base->sec;
-		ns = base->nsec;
-		ns += vgetsns(&mode);
-		ns >>= gtod->shift;
-	} while (unlikely(gtod_read_retry(gtod, seq)));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return mode;
-}
-
-notrace static int __always_inline do_monotonic(struct timespec *ts)
-{
-	struct vgtod_ts *base = &gtod->basetime[CLOCK_MONOTONIC];
-	unsigned int seq;
 	u64 ns;
-	int mode;
 
 	do {
 		seq = gtod_read_begin(gtod);
@@ -278,11 +255,11 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 {
 	switch (clock) {
 	case CLOCK_REALTIME:
-		if (do_realtime(ts) == VCLOCK_NONE)
+		if (do_hres(CLOCK_REALTIME, ts) == VCLOCK_NONE)
 			goto fallback;
 		break;
 	case CLOCK_MONOTONIC:
-		if (do_monotonic(ts) == VCLOCK_NONE)
+		if (do_hres(CLOCK_MONOTONIC, ts) == VCLOCK_NONE)
 			goto fallback;
 		break;
 	case CLOCK_REALTIME_COARSE:
@@ -305,7 +282,9 @@ int clock_gettime(clockid_t, struct timespec *)
 notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
 	if (likely(tv != NULL)) {
-		if (unlikely(do_realtime((struct timespec *)tv) == VCLOCK_NONE))
+		struct timespec *ts = (struct timespec *) tv;
+
+		if (unlikely(do_hres(CLOCK_REALTIME, ts) == VCLOCK_NONE))
 			return vdso_fallback_gtod(tv, tz);
 		tv->tv_usec /= 1000;
 	}
