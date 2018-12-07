Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22B0C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7320620868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7320620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeLGNuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:50:19 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:57529 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:49:26 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MD9jV-1geJ3d3Uqf-009BCl; Fri, 07 Dec 2018 14:49:00 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6/8] timekeeping: remove timespec_add/timespec_del
Date:   Fri,  7 Dec 2018 14:48:22 +0100
Message-Id: <20181207134824.300024-7-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181207134824.300024-1-arnd@arndb.de>
References: <20181207134824.300024-1-arnd@arndb.de>
X-Provags-ID: V03:K1:n5iXzgH3nz5j9ExoE7qeuRv71WW7HzR6W7USLlnDWkgVtakGuZV
 ulpq/wbfp699MXOSqTyLpFkgJOmlJr+/311bmNo4Rs7Ov77JnwLxlftbYWaKDpKvWF3JpAM
 i1vPFM7N5qyXy33KHSkH0qS0MX0z7ZqWIX+Zfj/otckG+fjKDXQ+ufRbvIMQv8lGfkf7gNQ
 2BrMmZoZr9cdVlqAo6Q5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NvnXQW6PUSU=:EHXeZBX2RY6J18BcziALTu
 Vg3NPc6w5qYSOTM5UNR8TNXi6jYQh5ASIupGaqhjkylS/gnpkQrled9WsSDg4W4000gvNbsxl
 d/HHm42gNV7PeRiQd0edvWA9sE9A8lVLd6aIu6C1850rdIvY6fuKo+y2V6dBp7t1ie36Ie6CS
 P6Q8aOfNKoFL81No4AVsekuL5MCU1cFv76RC/dziFQgsSoGDem+/oQlyD7W8jU2YxjNNs/jCE
 HX7KKtV5WCi7OLm91Z7cw9PRoZFQv9i/GCX9AK8OSfzK/3rQx2vIKT4yHky3Mt/hccfLiMFw7
 OrOKwPq3MIiPyRrEqO0qLwnTQGKrVHOjaFz003tFE/+IxK8rekpOwcdI1ycMtksnMQ1o33kQY
 z+ZgELeoOHTCFxp2Gew6kWQ/1MwMWPf2/22mcxLMJYeGcMS2JiOVKvqidjKEARaPfmAEY6CxJ
 8EakQk0w5xz/851VDJ1TrCWNC7h19V/7g6sd7uRXsgy+QjB2TbMqqUlLr9zCNzIyHSgg+/xSr
 AbrtJ3Sewkaj1BmC6BTqzDduU80dNKnbA79AGmSylltyYEI2kcPRY4o3RFKjStUUHSfsDuVES
 EJys4wmfMdyNDJsttXtKqSb9X93CT426rdJs5QOhjUTW8dVMOHrSToV/WVRdbYG8qIPln5JMm
 MK5DLI4tqqricrQwL0DsiNaIDYJbPc81ldhY7MFLzOLbt/ETLCk/iJ/p+WDXV1s+FW1NyXl48
 s2Qw5bmsr3cNWhJcg0yr/Y+1CG6xpkXOIsHDjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last users were removed a while ago since everyone moved to ktime_t,
so we can remove the two unused interfaces for old timespec structures.

With those two gone, set_normalized_timespec() is also unused, so
remove that as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/time32.h | 25 -------------------------
 kernel/time/time.c     | 36 ------------------------------------
 2 files changed, 61 deletions(-)

diff --git a/include/linux/time32.h b/include/linux/time32.h
index 61904a6c098f..118b9977080c 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -96,31 +96,6 @@ static inline int timespec_compare(const struct timespec *lhs, const struct time
 	return lhs->tv_nsec - rhs->tv_nsec;
 }
 
-extern void set_normalized_timespec(struct timespec *ts, time_t sec, s64 nsec);
-
-static inline struct timespec timespec_add(struct timespec lhs,
-						struct timespec rhs)
-{
-	struct timespec ts_delta;
-
-	set_normalized_timespec(&ts_delta, lhs.tv_sec + rhs.tv_sec,
-				lhs.tv_nsec + rhs.tv_nsec);
-	return ts_delta;
-}
-
-/*
- * sub = lhs - rhs, in normalized form
- */
-static inline struct timespec timespec_sub(struct timespec lhs,
-						struct timespec rhs)
-{
-	struct timespec ts_delta;
-
-	set_normalized_timespec(&ts_delta, lhs.tv_sec - rhs.tv_sec,
-				lhs.tv_nsec - rhs.tv_nsec);
-	return ts_delta;
-}
-
 /*
  * Returns true if the timespec is norm, false if denorm:
  */
diff --git a/kernel/time/time.c b/kernel/time/time.c
index ad204cf6d001..532bb560252d 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -386,42 +386,6 @@ time64_t mktime64(const unsigned int year0, const unsigned int mon0,
 }
 EXPORT_SYMBOL(mktime64);
 
-/**
- * set_normalized_timespec - set timespec sec and nsec parts and normalize
- *
- * @ts:		pointer to timespec variable to be set
- * @sec:	seconds to set
- * @nsec:	nanoseconds to set
- *
- * Set seconds and nanoseconds field of a timespec variable and
- * normalize to the timespec storage format
- *
- * Note: The tv_nsec part is always in the range of
- *	0 <= tv_nsec < NSEC_PER_SEC
- * For negative values only the tv_sec field is negative !
- */
-void set_normalized_timespec(struct timespec *ts, time_t sec, s64 nsec)
-{
-	while (nsec >= NSEC_PER_SEC) {
-		/*
-		 * The following asm() prevents the compiler from
-		 * optimising this loop into a modulo operation. See
-		 * also __iter_div_u64_rem() in include/linux/time.h
-		 */
-		asm("" : "+rm"(nsec));
-		nsec -= NSEC_PER_SEC;
-		++sec;
-	}
-	while (nsec < 0) {
-		asm("" : "+rm"(nsec));
-		nsec += NSEC_PER_SEC;
-		--sec;
-	}
-	ts->tv_sec = sec;
-	ts->tv_nsec = nsec;
-}
-EXPORT_SYMBOL(set_normalized_timespec);
-
 /**
  * ns_to_timespec - Convert nanoseconds to timespec
  * @nsec:       the nanoseconds value to be converted
-- 
2.18.0

