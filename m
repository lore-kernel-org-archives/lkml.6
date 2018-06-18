Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977FAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BF020852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="f0kcZLXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BF020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935708AbeFRPIm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:08:42 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38933 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935469AbeFRPIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:08:39 -0400
Received: by mail-pf0-f194.google.com with SMTP id r11-v6so8321582pfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=49j1iPAN3lGCmW9h/UZLYMoEo97FvFLn1KGgxCvlTkw=;
        b=f0kcZLXUMZcaSZwalkzDlDYwVhULX4TpkaMlTpcw6ftH5C/yiKeJuos33so0GaCgyv
         pCSsPogMBij8vs8tXZPP7WUjzoBddo4QqaFQLGw8ORxleAt2qYJ/MNYAM0GlnupgSB3v
         V4gG5dF8MviBO+urLPPW2YoXup7YTqOO04v4qTwpmdgfuof19D8CRkifGvSX8kOSzGIT
         1HhHRn1gKitzKkIa+fWPFLYIcJgOhVw07TbpfpoZ5lVCZXhnMA5QrFu7rjuOLpfzjSMM
         /e6BYtg8UZ6kWVhDzAOxYqAiBe4eSKBA6irjpTSJsijjfNMw8uCkhGFsTW/KNhX+z5vQ
         gr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=49j1iPAN3lGCmW9h/UZLYMoEo97FvFLn1KGgxCvlTkw=;
        b=DW9CXMpW3IbAkatnkSNeodPSk+Hz6CfJii1WaCiOAE7+t3zY0D3Ty1wtLfJX7DOiE7
         0bcBCSerGvG8w2dxJdjWtoigk5WA155XxZ+GP2kAAPVJYkvCbnpUwcE4No+WsRAjBwEf
         8ugr9Hmqc4v5JRtCG8X3W3dTvGKR1NR0QX1mnXsECFUM0f3EpqkbvNcZ8IUP2P90Wrrk
         iDNwGFRYpxX04Lg29aD4QJkp6oXOVX6fM/8eOraS8y1b2rD6tT2jSnOglAUWObUVViAO
         +uqR6AtIsnDn23O5/PaRwYEP35D1up0hqjlU85C505XMDPIwvyTfZ0SuYcS/ohhFR8RU
         g/1g==
X-Gm-Message-State: APt69E2z+W/m89s8my6HXOyRi6PzvmjWJTsGwLd5iXofCxCGgSD1ePdi
        FGJKCXzQIjCLLNIGbApHI0ufKBT16V8=
X-Google-Smtp-Source: ADUXVKI8MT1ODJlafUnT8XhHSYO0Do0ruWCNEtSvyeIkeuk5qhdcuGX2shKp5Vtq0lOm3Q8UE/V/EQ==
X-Received: by 2002:a63:a05d:: with SMTP id u29-v6mr11226843pgn.80.1529334518582;
        Mon, 18 Jun 2018 08:08:38 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:08:37 -0700 (PDT)
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
        Mark Salyzyn <salyzyn@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: RESEND [PATCH v5 12/12] lib: vdso: do not expose gettimeofday, if no arch supported timer
Date:   Mon, 18 Jun 2018 08:05:58 -0700
Message-Id: <20180618150613.10322-13-salyzyn@android.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618150613.10322-1-salyzyn@android.com>
References: <20180618150613.10322-1-salyzyn@android.com>
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
2.18.0.rc1.244.gcf134e6275-goog

