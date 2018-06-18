Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5610CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB2C20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ULkwT27G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB2C20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965348AbeFRPHK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:07:10 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37908 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964906AbeFRPHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:07:08 -0400
Received: by mail-pf0-f195.google.com with SMTP id b74-v6so8319594pfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IOCMQs9PDylpUw8XXkDzoKtAKq73cUUVEhSK1X0A1xY=;
        b=ULkwT27GKAMqXZvDtlzfn6cRYtXUX9A8XoYxQVQngLhtHSGSrs4YMq5TOvIGNf4qMo
         O9iVYt3MlabauW7Rj2OlLZdnCCyGUqFqfd3uXjoJ6ZGdHdah90zHjQqKarQD/lz0DBh0
         MzBER6WxpDy2q1rGoRu1QQ0kvypGXW0ckzwTEuAGNrJMKSKrztbMKDkVd8A6g99uS/ih
         6SeXEZeH2ndmcEWqiW/OTgkEh09m3iZxbev5khphWr0IsWb3cBWxSulB+yrwwA82VHFB
         z/waoFp0m9k6jQBxMVcxYeZ7vxkVOfdvVKq5UuMHqMqRYhgYE8aljfpsJM7+LCnnlGIH
         Zi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IOCMQs9PDylpUw8XXkDzoKtAKq73cUUVEhSK1X0A1xY=;
        b=V1mA1ftThotGjM5+msIs3xuwn+lep/gGKMJ8M2mB1/ULX5NKkIc8GXO9pm6cl4NsDk
         PR30aUPEz/Wkj61z5n7gtAH3Q30sI8GZ4mDQeAm62UKyPnnMLV8L7E1EG+agq5ccG9vJ
         LorXA6tk3cchU5q3slBzDxijFzhEy+TWcM3SdGv7qPQBz4ehrQyLHzc2fvmqE9OdjB/c
         jek9VsEWGOxX/bhXHnHvv68vWHhifIUNkJu0+HDx4CQYNwNsWSl7OwauTc+fQzCQPXQ5
         bm7JGjNWGLZNnxi17QrpTXbNvlUCgkCg2IhmqcV/zLN/QCiaYXk8pHAZrOk+ThV0d+NF
         Lvgw==
X-Gm-Message-State: APt69E2h5Cw2z7oRKHbXmkZeluvUYYIWZIx1zv26/RswgbTYhnTmcKaW
        ObWu6jw5zFXoaYJPK3BBkMMC4xR7tV8=
X-Google-Smtp-Source: ADUXVKIrz4lei1Edp3vjnPTPyTrySOi4+GKT5lRs2vU4y+vW8TOY1hQvIZ/SVtqcicmqKt7pgurDvw==
X-Received: by 2002:a65:48c9:: with SMTP id o9-v6mr11537521pgs.262.1529334427301;
        Mon, 18 Jun 2018 08:07:07 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:07:06 -0700 (PDT)
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
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: RESEND [PATCH v5 04/12] arm: vdso: do calculations outside reader loops
Date:   Mon, 18 Jun 2018 08:05:50 -0700
Message-Id: <20180618150613.10322-5-salyzyn@android.com>
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

In variable timer reading loops, pick up just the values until all
are synchronized, then outside of loop pick up cntvct and perform
calculations to determine final offset, shifted and multiplied
output value.

This replaces get_ns with get_clock_shifted_nsec as cntvct reader.

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

v2:
- split first CL into 5 of 7 pieces

v4:
- split into two, moving ARCH_CLOCK_FIXED_MASK to later
- update commit message to reflect overall reasoning
- adjust for dropping forced inline
- replace typeof() with types vdso_wtm_clock_nsec_t,
  vdso_xtime_clock_sec and __kernel_time_t.

v5:
- drop including linux/time.h in favour of uapi/linux/time.h in
  vgettimeofday.c to limit architectural includes.
- add linux/time.h to compiler.h for NSEC_PER_SEC definition.
- replace last timespec_add_ns with __iter_div_u64_rem.
---
 arch/arm/include/asm/vdso_datapage.h | 18 +++++-
 arch/arm/vdso/compiler.h             |  1 +
 arch/arm/vdso/vgettimeofday.c        | 90 ++++++++++++++++++----------
 3 files changed, 76 insertions(+), 33 deletions(-)

diff --git a/arch/arm/include/asm/vdso_datapage.h b/arch/arm/include/asm/vdso_datapage.h
index fa3e1856244d..8dd7303db4ec 100644
--- a/arch/arm/include/asm/vdso_datapage.h
+++ b/arch/arm/include/asm/vdso_datapage.h
@@ -24,6 +24,16 @@
 
 #include <asm/page.h>
 
+#ifndef _VDSO_WTM_CLOCK_SEC_T
+#define _VDSO_WTM_CLOCK_SEC_T
+typedef u32 vdso_wtm_clock_nsec_t;
+#endif
+
+#ifndef _VDSO_XTIME_CLOCK_SEC_T
+#define _VDSO_XTIME_CLOCK_SEC_T
+typedef u32 vdso_xtime_clock_sec_t;
+#endif
+
 /* Try to be cache-friendly on systems that don't implement the
  * generic timer: fit the unconditionally updated fields in the first
  * 32 bytes.
@@ -35,9 +45,11 @@ struct vdso_data {
 	u32 xtime_coarse_sec;	/* coarse time */
 	u32 xtime_coarse_nsec;
 
-	u32 wtm_clock_sec;	/* wall to monotonic offset */
-	u32 wtm_clock_nsec;
-	u32 xtime_clock_sec;	/* CLOCK_REALTIME - seconds */
+	/* wall to monotonic offset */
+	u32 wtm_clock_sec;
+	vdso_wtm_clock_nsec_t	wtm_clock_nsec;
+	/* CLOCK_REALTIME - seconds */
+	vdso_xtime_clock_sec_t	xtime_clock_sec;
 	u32 cs_mono_mult;	/* clocksource multiplier */
 
 	u64 cs_cycle_last;	/* last cycle value */
diff --git a/arch/arm/vdso/compiler.h b/arch/arm/vdso/compiler.h
index af24502797e8..3edddb705a1b 100644
--- a/arch/arm/vdso/compiler.h
+++ b/arch/arm/vdso/compiler.h
@@ -27,6 +27,7 @@
 #include <asm/processor.h>	/* for cpu_relax()			*/
 #include <asm/unistd.h>
 #include <linux/compiler.h>
+#include <linux/time.h>		/* for NSEC_PER_SEC			*/
 
 #ifndef CONFIG_AEABI
 #error This code depends on AEABI system call conventions
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 522094b147a2..59893fca03b3 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -24,7 +24,8 @@
 
 #include <asm/barrier.h>
 #include <linux/compiler.h>	/* for notrace				*/
-#include <linux/time.h>
+#include <linux/math64.h>	/* for __iter_div_u64_rem()		*/
+#include <uapi/linux/time.h>	/* for struct timespec			*/
 
 #include "compiler.h"
 #include "datapage.h"
@@ -79,6 +80,7 @@ static notrace int do_monotonic_coarse(const struct vdso_data *vd,
 {
 	struct timespec tomono;
 	u32 seq;
+	u64 nsec;
 
 	do {
 		seq = vdso_read_begin(vd);
@@ -92,33 +94,41 @@ static notrace int do_monotonic_coarse(const struct vdso_data *vd,
 	} while (vdso_read_retry(vd, seq));
 
 	ts->tv_sec += tomono.tv_sec;
-	timespec_add_ns(ts, tomono.tv_nsec);
+	/* open coding timespec_add_ns */
+	ts->tv_sec += __iter_div_u64_rem(ts->tv_nsec + tomono.tv_nsec,
+					 NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
 
 	return 0;
 }
 
 #ifdef CONFIG_ARM_ARCH_TIMER
 
-static notrace u64 get_ns(const struct vdso_data *vd)
+/*
+ * Returns the clock delta, in nanoseconds left-shifted by the clock
+ * shift.
+ */
+static notrace u64 get_clock_shifted_nsec(const u64 cycle_last,
+					  const u32 mult,
+					  const u64 mask)
 {
-	u64 cycle_delta;
-	u64 cycle_now;
-	u64 nsec;
-
-	cycle_now = arch_vdso_read_counter();
+	u64 res;
 
-	cycle_delta = (cycle_now - vd->cs_cycle_last) & vd->cs_mask;
+	/* Read the virtual counter. */
+	res = arch_vdso_read_counter();
 
-	nsec = (cycle_delta * vd->cs_mono_mult) + vd->xtime_clock_snsec;
-	nsec >>= vd->cs_shift;
+	res = res - cycle_last;
 
-	return nsec;
+	res &= mask;
+	return res * mult;
 }
 
 static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
 {
-	u64 nsecs;
-	u32 seq;
+	u32 seq, mult, shift;
+	u64 nsec, cycle_last;
+	u64 mask;
+	vdso_xtime_clock_sec_t sec;
 
 	do {
 		seq = vdso_read_begin(vd);
@@ -126,22 +136,33 @@ static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
 		if (vd->use_syscall)
 			return -1;
 
-		ts->tv_sec = vd->xtime_clock_sec;
-		nsecs = get_ns(vd);
+		cycle_last = vd->cs_cycle_last;
 
-	} while (vdso_read_retry(vd, seq));
+		mult = vd->cs_mono_mult;
+		shift = vd->cs_shift;
+		mask = vd->cs_mask;
+
+		sec = vd->xtime_clock_sec;
+		nsec = vd->xtime_clock_snsec;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
 
-	ts->tv_nsec = 0;
-	timespec_add_ns(ts, nsecs);
+	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
+	nsec >>= shift;
+	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
 
 	return 0;
 }
 
 static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
 {
-	struct timespec tomono;
-	u64 nsecs;
-	u32 seq;
+	u32 seq, mult, shift;
+	u64 nsec, cycle_last;
+	u64 mask;
+	vdso_wtm_clock_nsec_t wtm_nsec;
+	__kernel_time_t sec;
 
 	do {
 		seq = vdso_read_begin(vd);
@@ -149,17 +170,26 @@ static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
 		if (vd->use_syscall)
 			return -1;
 
-		ts->tv_sec = vd->xtime_clock_sec;
-		nsecs = get_ns(vd);
+		cycle_last = vd->cs_cycle_last;
 
-		tomono.tv_sec = vd->wtm_clock_sec;
-		tomono.tv_nsec = vd->wtm_clock_nsec;
+		mult = vd->cs_mono_mult;
+		shift = vd->cs_shift;
+		mask = vd->cs_mask;
 
-	} while (vdso_read_retry(vd, seq));
+		sec = vd->xtime_clock_sec;
+		nsec = vd->xtime_clock_snsec;
 
-	ts->tv_sec += tomono.tv_sec;
-	ts->tv_nsec = 0;
-	timespec_add_ns(ts, nsecs + tomono.tv_nsec);
+		sec += vd->wtm_clock_sec;
+		wtm_nsec = vd->wtm_clock_nsec;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
+	nsec >>= shift;
+	nsec += wtm_nsec;
+	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
 
 	return 0;
 }
-- 
2.18.0.rc1.244.gcf134e6275-goog

