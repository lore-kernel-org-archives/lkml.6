Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBCFC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF69C2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF69C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJEEDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:03:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43585 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeJEEDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:03:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94L7LkV2885035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 14:07:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94L7KRx2885032;
        Thu, 4 Oct 2018 14:07:20 -0700
Date:   Thu, 4 Oct 2018 14:07:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-6deec5bdef4518bd6524a47be9d621ff650d3ba4@git.kernel.org>
Cc:     kys@microsoft.com, tglx@linutronix.de, sboyd@kernel.org,
        pbonzini@redhat.com, fweimer@redhat.com, hpa@zytor.com,
        matt@softrans.com.au, arnd@arndb.de, mingo@kernel.org,
        jgross@suse.com, luto@kernel.org, john.stultz@linaro.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        peterz@infradead.org
Reply-To: vkuznets@redhat.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, john.stultz@linaro.org,
          jgross@suse.com, luto@kernel.org, mingo@kernel.org,
          arnd@arndb.de, matt@softrans.com.au, hpa@zytor.com,
          fweimer@redhat.com, pbonzini@redhat.com, kys@microsoft.com,
          sboyd@kernel.org, tglx@linutronix.de
In-Reply-To: <20180917130707.490733779@linutronix.de>
References: <20180917130707.490733779@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86/vdso: Collapse coarse functions
Git-Commit-ID: 6deec5bdef4518bd6524a47be9d621ff650d3ba4
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

Commit-ID:  6deec5bdef4518bd6524a47be9d621ff650d3ba4
Gitweb:     https://git.kernel.org/tip/6deec5bdef4518bd6524a47be9d621ff650d3ba4
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 14:45:40 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 4 Oct 2018 23:00:26 +0200

x86/vdso: Collapse coarse functions

do_realtime_coarse() and do_monotonic_coarse() are now the same except for
the storage array index. Hand the index in as an argument and collapse the
functions.

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
Link: https://lkml.kernel.org/r/20180917130707.490733779@linutronix.de

---
 arch/x86/entry/vdso/vclock_gettime.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 1351b76638fb..b27dea0e23af 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -227,21 +227,9 @@ notrace static int do_hres(clockid_t clk, struct timespec *ts)
 	return mode;
 }
 
-notrace static void do_realtime_coarse(struct timespec *ts)
+notrace static void do_coarse(clockid_t clk, struct timespec *ts)
 {
-	struct vgtod_ts *base = &gtod->basetime[CLOCK_REALTIME_COARSE];
-	unsigned int seq;
-
-	do {
-		seq = gtod_read_begin(gtod);
-		ts->tv_sec = base->sec;
-		ts->tv_nsec = base->nsec;
-	} while (unlikely(gtod_read_retry(gtod, seq)));
-}
-
-notrace static void do_monotonic_coarse(struct timespec *ts)
-{
-	struct vgtod_ts *base = &gtod->basetime[CLOCK_MONOTONIC_COARSE];
+	struct vgtod_ts *base = &gtod->basetime[clk];
 	unsigned int seq;
 
 	do {
@@ -263,10 +251,10 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 			goto fallback;
 		break;
 	case CLOCK_REALTIME_COARSE:
-		do_realtime_coarse(ts);
+		do_coarse(CLOCK_REALTIME_COARSE, ts);
 		break;
 	case CLOCK_MONOTONIC_COARSE:
-		do_monotonic_coarse(ts);
+		do_coarse(CLOCK_MONOTONIC_COARSE, ts);
 		break;
 	default:
 		goto fallback;
