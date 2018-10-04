Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512D1C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CADA2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CADA2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeJEEB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:01:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37657 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeJEEB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:01:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94L5eTH2884739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 14:05:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94L5euT2884736;
        Thu, 4 Oct 2018 14:05:40 -0700
Date:   Thu, 4 Oct 2018 14:05:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-77e9c678c54f2d9214796c1c5bd0c7c7ccedd932@git.kernel.org>
Cc:     mingo@kernel.org, jgross@suse.com, hpa@zytor.com,
        peterz@infradead.org, tglx@linutronix.de, fweimer@redhat.com,
        pbonzini@redhat.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, sboyd@kernel.org, vkuznets@redhat.com,
        matt@softrans.com.au, kys@microsoft.com, john.stultz@linaro.org
Reply-To: sboyd@kernel.org, vkuznets@redhat.com, matt@softrans.com.au,
          linux-kernel@vger.kernel.org, arnd@arndb.de,
          john.stultz@linaro.org, kys@microsoft.com, mingo@kernel.org,
          tglx@linutronix.de, fweimer@redhat.com, pbonzini@redhat.com,
          luto@kernel.org, peterz@infradead.org, jgross@suse.com,
          hpa@zytor.com
In-Reply-To: <20180917130707.236250416@linutronix.de>
References: <20180917130707.236250416@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86/vdso: Use unsigned int consistently for
 vsyscall_gtod_data:: Seq
Git-Commit-ID: 77e9c678c54f2d9214796c1c5bd0c7c7ccedd932
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

Commit-ID:  77e9c678c54f2d9214796c1c5bd0c7c7ccedd932
Gitweb:     https://git.kernel.org/tip/77e9c678c54f2d9214796c1c5bd0c7c7ccedd932
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 14:45:37 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 4 Oct 2018 23:00:25 +0200

x86/vdso: Use unsigned int consistently for vsyscall_gtod_data:: Seq

The sequence count in vgtod_data is unsigned int, but the call sites use
unsigned long, which is a pointless exercise. Fix the call sites and
replace 'unsigned' with unsinged 'int' while at it.

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
Link: https://lkml.kernel.org/r/20180917130707.236250416@linutronix.de

---
 arch/x86/entry/vdso/vclock_gettime.c |  8 ++++----
 arch/x86/include/asm/vgtod.h         | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 6a950854034f..b50ee064beff 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -208,7 +208,7 @@ notrace static inline u64 vgetsns(int *mode)
 /* Code size doesn't matter (vdso is 4k anyway) and this is faster. */
 notrace static int __always_inline do_realtime(struct timespec *ts)
 {
-	unsigned long seq;
+	unsigned int seq;
 	u64 ns;
 	int mode;
 
@@ -229,7 +229,7 @@ notrace static int __always_inline do_realtime(struct timespec *ts)
 
 notrace static int __always_inline do_monotonic(struct timespec *ts)
 {
-	unsigned long seq;
+	unsigned int seq;
 	u64 ns;
 	int mode;
 
@@ -250,7 +250,7 @@ notrace static int __always_inline do_monotonic(struct timespec *ts)
 
 notrace static void do_realtime_coarse(struct timespec *ts)
 {
-	unsigned long seq;
+	unsigned int seq;
 	do {
 		seq = gtod_read_begin(gtod);
 		ts->tv_sec = gtod->wall_time_coarse_sec;
@@ -260,7 +260,7 @@ notrace static void do_realtime_coarse(struct timespec *ts)
 
 notrace static void do_monotonic_coarse(struct timespec *ts)
 {
-	unsigned long seq;
+	unsigned int seq;
 	do {
 		seq = gtod_read_begin(gtod);
 		ts->tv_sec = gtod->monotonic_time_coarse_sec;
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 53748541c487..91cad1f01027 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -15,9 +15,9 @@ typedef unsigned long gtod_long_t;
  * so be carefull by modifying this structure.
  */
 struct vsyscall_gtod_data {
-	unsigned seq;
+	unsigned int seq;
 
-	int vclock_mode;
+	int	vclock_mode;
 	u64	cycle_last;
 	u64	mask;
 	u32	mult;
@@ -44,9 +44,9 @@ static inline bool vclock_was_used(int vclock)
 	return READ_ONCE(vclocks_used) & (1 << vclock);
 }
 
-static inline unsigned gtod_read_begin(const struct vsyscall_gtod_data *s)
+static inline unsigned int gtod_read_begin(const struct vsyscall_gtod_data *s)
 {
-	unsigned ret;
+	unsigned int ret;
 
 repeat:
 	ret = READ_ONCE(s->seq);
@@ -59,7 +59,7 @@ repeat:
 }
 
 static inline int gtod_read_retry(const struct vsyscall_gtod_data *s,
-					unsigned start)
+				  unsigned int start)
 {
 	smp_rmb();
 	return unlikely(s->seq != start);
