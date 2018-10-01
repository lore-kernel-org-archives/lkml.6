Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A23C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561C5208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="AsYBu5rK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561C5208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeJBAlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:41:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41242 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBAlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:41:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so9785028pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmc2XUv+P+1oW72zR9jzXh3J8nwxNSWUYNvYRc9H7YM=;
        b=AsYBu5rK4tBFneEGirRjn94Wl+QfMspE/iNaTm0mIuNKeR7+GbU77IyCGjcsycnW9P
         wfZVs71nuUyiriMxX8LGyflJMF4NehoE/daOAnLt4opapb8Yo/gQ9OyjBJR4c+ZhF9po
         7V0BxtW7i//q6X3HPe08zDJxB+tu8e/utP/UturaWa3QCUxgCfiKhBF0YLSw2EZQHken
         gMxnfPfDr+ubnPXYIHfnGpe/FckqIgVadPVzxE8fe74aHSBvDgUlDA+2+9TqNrjWNNrT
         tCEysIdUq3LdFierSUO9efPQ6SGdco5QAsdD5G+l30z1cI18BnskS16N5ino6XixcHXn
         LWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmc2XUv+P+1oW72zR9jzXh3J8nwxNSWUYNvYRc9H7YM=;
        b=KmdSjRuEVjNFdCJkIioUqWCinN4VFY+DdOlIyDEzY9UcPIkVH3hErYpAiSbiEvPHUx
         2WMeC1MqvxTwTk95ouQDTaW0Axzrt7Uich352XR+7nVXtpiY3vE6BQ0bEnbI30qUpAi1
         2HjzIZTS5rytw9hwwt4UF5WWvfInJjQBjwt+sjQP5tpRVmSMVI2rG3QCIUTFcg92DwzV
         OWBWhKVXwtrtte81w2PTGNXMUUzXmYlhvGWzkXswD1pSDz4EmrAjTGwhtDHUU6/4gn3V
         RmuNZr7UarmpDi+fwtiU6qnxpIrfgLLKzy8fGVkNM+CGzWPENfs7ZEU6a6I24Lu2xpoy
         xwGg==
X-Gm-Message-State: ABuFfohcwYYqqnCT+PpehUjwMBA4Ohf16e8fys3TgQdN9l5zaHyEE9mU
        DqMxmg5NOQBEGq+0J7xAkOj5YQ6S9p0=
X-Google-Smtp-Source: ACcGV607qp09x0eTHqM1eLgMXGYQ5Wi4CUra6lnRryJJ2F8LfRP/h3UtJ9y2KzXieXhQgMwiSUH2Zg==
X-Received: by 2002:a65:47cb:: with SMTP id f11-v6mr11405197pgs.166.1538416966352;
        Mon, 01 Oct 2018 11:02:46 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:02:45 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salyzyn <salyzyn@android.com>,
        James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        android-kernel@android.com, Mark Salyzyn <salyzyn@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: RESEND [PATCH v5 12/12] lib: vdso: do not expose gettimeofday, if no arch supported timer
Date:   Mon,  1 Oct 2018 10:58:32 -0700
Message-Id: <20181001175845.168430-13-salyzyn@android.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take an effort to recode the arm64 vdso code from assembler to C
previously submitted by Andrew Pinski <apinski@cavium.com>, rework
it for use in both arm and arm64, overlapping any optimizations
for each architecture. But instead of landing it in arm64, land the
result into lib/vdso and unify both implementations to simplify
future maintenance.

If ARCH_PROVIDES_TIMER is not defined, do not expose gettimeofday.
libc will default directly to syscall.  Also ifdef clock_gettime
switch cases and stubs if not supported and other unused components.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Tested-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: android-kernel@android.com

v3:
- do not expose gettimeofday if arch does not support user space timer.

v4:
- update commit message to reflect overall reasoning of patch series.

v5:
- rebase
---
 lib/vdso/vgettimeofday.c | 52 ++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/lib/vdso/vgettimeofday.c b/lib/vdso/vgettimeofday.c
index 4c3af7bc6499..54e519c99c4b 100644
--- a/lib/vdso/vgettimeofday.c
+++ b/lib/vdso/vgettimeofday.c
@@ -30,7 +30,9 @@
 #include "compiler.h"
 #include "datapage.h"
 
+#ifdef ARCH_PROVIDES_TIMER
 DEFINE_FALLBACK(gettimeofday, struct timeval *, tv, struct timezone *, tz)
+#endif
 DEFINE_FALLBACK(clock_gettime, clockid_t, clock, struct timespec *, ts)
 DEFINE_FALLBACK(clock_getres, clockid_t, clock, struct timespec *, ts)
 
@@ -292,30 +294,6 @@ static notrace int do_boottime(const struct vdso_data *vd, struct timespec *ts)
 	return 0;
 }
 
-#else /* ARCH_PROVIDES_TIMER */
-
-static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
-{
-	return -1;
-}
-
-static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
-{
-	return -1;
-}
-
-static notrace int do_monotonic_raw(const struct vdso_data *vd,
-				    struct timespec *ts)
-{
-	return -1;
-}
-
-static notrace int do_boottime(const struct vdso_data *vd,
-			       struct timespec *ts)
-{
-	return -1;
-}
-
 #endif /* ARCH_PROVIDES_TIMER */
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
@@ -329,6 +307,7 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 	case CLOCK_MONOTONIC_COARSE:
 		do_monotonic_coarse(vd, ts);
 		break;
+#ifdef ARCH_PROVIDES_TIMER
 	case CLOCK_REALTIME:
 		if (do_realtime(vd, ts))
 			goto fallback;
@@ -345,6 +324,7 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 		if (do_boottime(vd, ts))
 			goto fallback;
 		break;
+#endif
 	default:
 		goto fallback;
 	}
@@ -354,6 +334,7 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 	return clock_gettime_fallback(clock, ts);
 }
 
+#ifdef ARCH_PROVIDES_TIMER
 notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
 	const struct vdso_data *vd = __get_datapage();
@@ -375,21 +356,28 @@ notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 
 	return 0;
 }
+#endif
 
 int __vdso_clock_getres(clockid_t clock, struct timespec *res)
 {
 	long nsec;
 
-	if (clock == CLOCK_REALTIME ||
-	    clock == CLOCK_BOOTTIME ||
-	    clock == CLOCK_MONOTONIC ||
-	    clock == CLOCK_MONOTONIC_RAW)
-		nsec = MONOTONIC_RES_NSEC;
-	else if (clock == CLOCK_REALTIME_COARSE ||
-		 clock == CLOCK_MONOTONIC_COARSE)
+	switch (clock) {
+	case CLOCK_REALTIME_COARSE:
+	case CLOCK_MONOTONIC_COARSE:
 		nsec = LOW_RES_NSEC;
-	else
+		break;
+#ifdef ARCH_PROVIDES_TIMER
+	case CLOCK_REALTIME:
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+	case CLOCK_BOOTTIME:
+		nsec = MONOTONIC_RES_NSEC;
+		break;
+#endif
+	default:
 		return clock_getres_fallback(clock, res);
+	}
 
 	if (likely(res != NULL)) {
 		res->tv_sec = 0;
-- 
2.19.0.605.g01d371f741-goog

