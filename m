Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A4CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48243208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48243208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeH0Xdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:33:47 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:46339 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0Xdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:33:46 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MZljq-1gDYzh3UKM-00LZLh; Mon, 27 Aug 2018 21:45:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     tglx@linutronix.de
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, deepa.kernel@gmail.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 01/14] y2038: Remove unused time interfaces
Date:   Mon, 27 Aug 2018 21:45:18 +0200
Message-Id: <20180827194531.3796559-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827194531.3796559-1-arnd@arndb.de>
References: <20180827194531.3796559-1-arnd@arndb.de>
X-Provags-ID: V03:K1:l9pGtEXy1VJl8YSXRlfHMeRcd21+uBL57ojDLqzrsbSNEdodMPu
 wRM+cgro+ox9QO6MSThrmojQwWSX5z1wDhF5/IU3mRzDPQMOFGmFE15UcKgdufaz+dZ8pEq
 0pzWkh1vq7Fxgn/QfIq6fHKrFEpqy1zqcAEd7wMbdRq8oExZPkdKxW/pFtq5nXlwXuO1eJM
 1dRcCPvvM6itA3b74ijVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mt5D8JkHFCw=:lpowqU3NLfdNL9Rp+EPizm
 St4wXoEud4ZGPnEtiI1BUpOsj8MV/uiAujcqk8Y9J74KAOKgJP8wr7gxNLSPDl3Z4+DgSSFx9
 biv85KUZPVa4h2xTXBeBWs2mYpKn4+H3PWk5JZ1AFk0Pj5mtInFKioFF33JLxtQVmphLhx9o/
 DUIAcIF8j+qZhE/CXlq44ISWsUOh6oH4S+ohpSHnsEV+ZF7PMcdGweschGIo8xA3VT5+BZkd6
 y0XIeEwt0WdnPB8LTJqzSBJeBYD8KtCGBFHjeCpBlKBrXh1LN90NFtOig1BGMhlHgF7h5IwhG
 i+fOYo5g1gtogZ/gSpzHIRWeqFOBBb8N8KG2UcuQ/FmN4qtJbL3f46n7LVxP2eqw0WqeaJFHs
 rmf6yiyRfEg5B/pOrTKSU7juKMF19gqMS3uhoc16/Yd5rHcpCtpxPfsG3ajVK3YO+2zlZeYAA
 3QrXiiyRS3RdOY1+uE6Dh9iereDSnBT5JiM5clO7bY5telzKPh+6GK1NqrUh0IfFDNUGm+A5G
 Q4DsI0WALnEvGgkFOqNrtNfisK7JXCVAuEIIafCOkjVGb2d6WXpE+TRHW+YEtv03ctSZwD80z
 i1M9NTdAH9cChIESrbiGXg1IZJnPykeZH6n5GQ6QHXnzhj/3hnaSg2RdUxfy2e83Z9Nd9OGUy
 NWKFOOHr6GTgxeehHZ1uCO0xbcOambvHBOBhE37svGLMgL2KwpdxouLFhKmZ8WW/LL7g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After many small patches, at least some of the deprecated interfaces
have no remaining users any more and can be removed:

  current_kernel_time
  do_settimeofday
  get_monotonic_boottime
  get_monotonic_boottime64
  get_monotonic_coarse
  get_monotonic_coarse64
  getrawmonotonic64
  ktime_get_real_ts
  timekeeping_clocktai
  timespec_trunc
  timespec_valid_strict
  time_to_tm

For many of the remaining time functions, we are missing one or
two patches that failed to make it into 4.19, they will be removed
in the following merge window.

The replacement functions for the removed interfaces are documented in
Documentation/core-api/timekeeping.rst.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/time32.h        | 25 ------------------
 include/linux/timekeeping.h   | 12 ---------
 include/linux/timekeeping32.h | 50 -----------------------------------
 kernel/time/time.c            | 24 -----------------
 4 files changed, 111 deletions(-)

diff --git a/include/linux/time32.h b/include/linux/time32.h
index d1ae43c13e25..92c0ca092d93 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -105,16 +105,6 @@ static inline bool timespec_valid(const struct timespec *ts)
 	return true;
 }
 
-static inline bool timespec_valid_strict(const struct timespec *ts)
-{
-	if (!timespec_valid(ts))
-		return false;
-	/* Disallow values that could overflow ktime_t */
-	if ((unsigned long long)ts->tv_sec >= KTIME_SEC_MAX)
-		return false;
-	return true;
-}
-
 /**
  * timespec_to_ns - Convert timespec to nanoseconds
  * @ts:		pointer to the timespec variable to be converted
@@ -149,19 +139,6 @@ static __always_inline void timespec_add_ns(struct timespec *a, u64 ns)
 	a->tv_nsec = ns;
 }
 
-/**
- * time_to_tm - converts the calendar time to local broken-down time
- *
- * @totalsecs	the number of seconds elapsed since 00:00:00 on January 1, 1970,
- *		Coordinated Universal Time (UTC).
- * @offset	offset seconds adding to totalsecs.
- * @result	pointer to struct tm variable to receive broken-down time
- */
-static inline void time_to_tm(time_t totalsecs, int offset, struct tm *result)
-{
-	time64_to_tm(totalsecs, offset, result);
-}
-
 static inline unsigned long mktime(const unsigned int year,
 			const unsigned int mon, const unsigned int day,
 			const unsigned int hour, const unsigned int min,
@@ -183,8 +160,6 @@ static inline bool timeval_valid(const struct timeval *tv)
 	return true;
 }
 
-extern struct timespec timespec_trunc(struct timespec t, unsigned int gran);
-
 /**
  * timeval_to_ns - Convert timeval to nanoseconds
  * @ts:		pointer to the timeval variable to be converted
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 5d738804e3d6..3faba06411aa 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -266,9 +266,6 @@ extern int update_persistent_clock64(struct timespec64 now);
  * deprecated aliases, don't use in new code
  */
 #define getnstimeofday64(ts)		ktime_get_real_ts64(ts)
-#define get_monotonic_boottime64(ts)	ktime_get_boottime_ts64(ts)
-#define getrawmonotonic64(ts)		ktime_get_raw_ts64(ts)
-#define timekeeping_clocktai64(ts)	ktime_get_clocktai_ts64(ts)
 
 static inline struct timespec64 current_kernel_time64(void)
 {
@@ -279,13 +276,4 @@ static inline struct timespec64 current_kernel_time64(void)
 	return ts;
 }
 
-static inline struct timespec64 get_monotonic_coarse64(void)
-{
-	struct timespec64 ts;
-
-	ktime_get_coarse_ts64(&ts);
-
-	return ts;
-}
-
 #endif
diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index 8762c2f45f8b..a4a4991160fb 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -9,26 +9,6 @@
 extern void do_gettimeofday(struct timeval *tv);
 unsigned long get_seconds(void);
 
-static inline struct timespec current_kernel_time(void)
-{
-	struct timespec64 ts64;
-
-	ktime_get_coarse_real_ts64(&ts64);
-
-	return timespec64_to_timespec(ts64);
-}
-
-/**
- * Deprecated. Use do_settimeofday64().
- */
-static inline int do_settimeofday(const struct timespec *ts)
-{
-	struct timespec64 ts64;
-
-	ts64 = timespec_to_timespec64(*ts);
-	return do_settimeofday64(&ts64);
-}
-
 static inline void getnstimeofday(struct timespec *ts)
 {
 	struct timespec64 ts64;
@@ -45,14 +25,6 @@ static inline void ktime_get_ts(struct timespec *ts)
 	*ts = timespec64_to_timespec(ts64);
 }
 
-static inline void ktime_get_real_ts(struct timespec *ts)
-{
-	struct timespec64 ts64;
-
-	ktime_get_real_ts64(&ts64);
-	*ts = timespec64_to_timespec(ts64);
-}
-
 static inline void getrawmonotonic(struct timespec *ts)
 {
 	struct timespec64 ts64;
@@ -61,15 +33,6 @@ static inline void getrawmonotonic(struct timespec *ts)
 	*ts = timespec64_to_timespec(ts64);
 }
 
-static inline struct timespec get_monotonic_coarse(void)
-{
-	struct timespec64 ts64;
-
-	ktime_get_coarse_ts64(&ts64);
-
-	return timespec64_to_timespec(ts64);
-}
-
 static inline void getboottime(struct timespec *ts)
 {
 	struct timespec64 ts64;
@@ -78,19 +41,6 @@ static inline void getboottime(struct timespec *ts)
 	*ts = timespec64_to_timespec(ts64);
 }
 
-/*
- * Timespec interfaces utilizing the ktime based ones
- */
-static inline void get_monotonic_boottime(struct timespec *ts)
-{
-	*ts = ktime_to_timespec(ktime_get_boottime());
-}
-
-static inline void timekeeping_clocktai(struct timespec *ts)
-{
-	*ts = ktime_to_timespec(ktime_get_clocktai());
-}
-
 /*
  * Persistent clock related interfaces
  */
diff --git a/kernel/time/time.c b/kernel/time/time.c
index ccdb351277ee..712543011106 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -342,30 +342,6 @@ unsigned int jiffies_to_usecs(const unsigned long j)
 }
 EXPORT_SYMBOL(jiffies_to_usecs);
 
-/**
- * timespec_trunc - Truncate timespec to a granularity
- * @t: Timespec
- * @gran: Granularity in ns.
- *
- * Truncate a timespec to a granularity. Always rounds down. gran must
- * not be 0 nor greater than a second (NSEC_PER_SEC, or 10^9 ns).
- */
-struct timespec timespec_trunc(struct timespec t, unsigned gran)
-{
-	/* Avoid division in the common cases 1 ns and 1 s. */
-	if (gran == 1) {
-		/* nothing */
-	} else if (gran == NSEC_PER_SEC) {
-		t.tv_nsec = 0;
-	} else if (gran > 1 && gran < NSEC_PER_SEC) {
-		t.tv_nsec -= t.tv_nsec % gran;
-	} else {
-		WARN(1, "illegal file time granularity: %u", gran);
-	}
-	return t;
-}
-EXPORT_SYMBOL(timespec_trunc);
-
 /*
  * mktime64 - Converts date to seconds.
  * Converts Gregorian date to seconds since 1970-01-01 00:00:00.
-- 
2.18.0

