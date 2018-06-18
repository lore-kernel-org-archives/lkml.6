Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C87DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058F2208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="WWhAkhU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058F2208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935585AbeFRPH6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:07:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40774 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935155AbeFRPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:07:53 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so8320376pfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wF/f8ql0m5soMaAKlzHoVGTjxQiag6xytepBhPa4C0Q=;
        b=WWhAkhU3uGAHVbRq4aibZGY2T7enLKO5FI3tFgyxaUyy7PC7ldYu6GOiaLne4i1g6j
         KIU8ZF02ZnqUjMC1LYFUYeY8qnHLU64U6Nw4FT4oJ1blbFyr4h4hoK0Dx3l7xwJaHHa+
         BC11ZKj6pCAdBJqqtr4It879h0hvf9DrpdiGzy50sPS/fMAUc8aqylMJ5CbUSgUDwOAK
         2Ucas7tG+aq41ATuVDFg6CHZbjK7CsMLMLzkFDf5ntfdVTm6K1+jXawgkWfgo9ickYyV
         59DrpXErsaUX5ZZs6i3KAhj8x3OtDHGAPNbSjOmDe8eF8q+w4nHPu6z160IfmiilCvRY
         EhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wF/f8ql0m5soMaAKlzHoVGTjxQiag6xytepBhPa4C0Q=;
        b=TDL4jSWCkXiBO7Dbhvze451p7RF3ehjxNa+V5h+DbZP536ImZ0I/yPFPSt5psnlAiS
         4BOZuanWjEDwEfm0ZcW639eypJ1mmmZU/XNlpAfyhCihO6m92btNnISD9NhnfjoMJd9c
         MHBOyzjkFRIVCO9QeoNJdfHJstAnnU74caw75N3v5FhA4N5/lE3CikHGCqwrHd8wriIi
         hby4cdFTpmn6bYHJWpoK4Tns51oGBuxQXwyyc5pR8Ka42ToSq4a2xZECH0dj82cwEQ3j
         2xT/lrybqqxCEVIYA1XnDlDIzp0Cf6aPe8CrsmL6q/zy9DQKL4us6GmKXNpgrUeC4ogM
         YkBw==
X-Gm-Message-State: APt69E1riNLLpb7c48XV25Ao30ntxXjs2zbfV0V463cqmjA0CFZb3Ppx
        K7UblvB2Df1lLRHixTxConP6WqgPMQE=
X-Google-Smtp-Source: ADUXVKLe6If+uAKt4dNOEgRRfA9d+Eb2nyq/OtEHmUVQvwqzGGuaFrn70auPhawVEmtW2hT4xXPFYg==
X-Received: by 2002:a63:a319:: with SMTP id s25-v6mr11417507pge.62.1529334472447;
        Mon, 18 Jun 2018 08:07:52 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:07:51 -0700 (PDT)
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
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RESEND [PATCH v5 09/12] arm: vdso: move vgettimeofday.c to lib/vdso/
Date:   Mon, 18 Jun 2018 08:05:55 -0700
Message-Id: <20180618150613.10322-10-salyzyn@android.com>
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

Declare arch/arm/vdso/vgettimeofday.c to be a candidate for a global
implementation of the vdso timer calls.  The hope is that new
architectures can take advantage of the current unification of
arm and arm64 implementations.

We urge future efforts to merge their implementations into the
global vgettimeofday.c file and thus provide functional parity.

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
- added this change
- move arch/arm/vdso/vgettimeofday.c to lib/vdso/vgettimeofday.c
- adjust vgettimeofday.c to be a better global candidate, switch to
  using ARCH_PROVIDES_TIMER and __arch_counter_get() as more generic.

v4:
- update commit message to reflect overall reasoning
- adjust to reflect dropping of any forced inline

v5:
- rebase
---
 arch/arm/vdso/compiler.h      |   4 +
 arch/arm/vdso/vgettimeofday.c | 343 +--------------------------------
 lib/vdso/compiler.h           |  24 +++
 lib/vdso/datapage.h           |  24 +++
 lib/vdso/vgettimeofday.c      | 344 ++++++++++++++++++++++++++++++++++
 5 files changed, 397 insertions(+), 342 deletions(-)
 create mode 100644 lib/vdso/compiler.h
 create mode 100644 lib/vdso/datapage.h
 create mode 100644 lib/vdso/vgettimeofday.c

diff --git a/arch/arm/vdso/compiler.h b/arch/arm/vdso/compiler.h
index c7751019246a..6fd88be2ff0e 100644
--- a/arch/arm/vdso/compiler.h
+++ b/arch/arm/vdso/compiler.h
@@ -34,6 +34,10 @@
 #error This code depends on AEABI system call conventions
 #endif
 
+#ifdef CONFIG_ARM_ARCH_TIMER
+#define ARCH_PROVIDES_TIMER
+#endif
+
 #define DEFINE_FALLBACK(name, type_arg1, name_arg1, type_arg2, name_arg2) \
 static notrace long name##_fallback(type_arg1 _##name_arg1,		  \
 				    type_arg2 _##name_arg2)		  \
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 3005479efbe8..4b241fe60d17 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -1,344 +1,3 @@
-/*
- * Userspace implementations of gettimeofday() and friends.
- *
- * Copyright (C) 2017 Cavium, Inc.
- * Copyright (C) 2015 Mentor Graphics Corporation
- * Copyright (C) 2012 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * Author: Will Deacon <will.deacon@arm.com>
- * Rewriten from arch64 version into C by: Andrew Pinski <apinski@cavium.com>
- * Reworked and rebased over arm version by: Mark Salyzyn <salyzyn@android.com>
- */
-
-#include <asm/barrier.h>
-#include <linux/compiler.h>	/* for notrace				*/
-#include <linux/math64.h>	/* for __iter_div_u64_rem()		*/
-#include <uapi/linux/time.h>	/* for struct timespec			*/
-
 #include "compiler.h"
 #include "datapage.h"
-
-DEFINE_FALLBACK(gettimeofday, struct timeval *, tv, struct timezone *, tz)
-DEFINE_FALLBACK(clock_gettime, clockid_t, clock, struct timespec *, ts)
-DEFINE_FALLBACK(clock_getres, clockid_t, clock, struct timespec *, ts)
-
-static notrace u32 vdso_read_begin(const struct vdso_data *vd)
-{
-	u32 seq;
-
-	do {
-		seq = READ_ONCE(vd->tb_seq_count);
-
-		if ((seq & 1) == 0)
-			break;
-
-		cpu_relax();
-	} while (true);
-
-	smp_rmb(); /* Pairs with second smp_wmb in update_vsyscall */
-	return seq;
-}
-
-static notrace int vdso_read_retry(const struct vdso_data *vd, u32 start)
-{
-	u32 seq;
-
-	smp_rmb(); /* Pairs with first smp_wmb in update_vsyscall */
-	seq = READ_ONCE(vd->tb_seq_count);
-	return seq != start;
-}
-
-static notrace int do_realtime_coarse(const struct vdso_data *vd,
-				      struct timespec *ts)
-{
-	u32 seq;
-
-	do {
-		seq = vdso_read_begin(vd);
-
-		ts->tv_sec = vd->xtime_coarse_sec;
-		ts->tv_nsec = vd->xtime_coarse_nsec;
-
-	} while (vdso_read_retry(vd, seq));
-
-	return 0;
-}
-
-static notrace int do_monotonic_coarse(const struct vdso_data *vd,
-				       struct timespec *ts)
-{
-	struct timespec tomono;
-	u32 seq;
-	u64 nsec;
-
-	do {
-		seq = vdso_read_begin(vd);
-
-		ts->tv_sec = vd->xtime_coarse_sec;
-		ts->tv_nsec = vd->xtime_coarse_nsec;
-
-		tomono.tv_sec = vd->wtm_clock_sec;
-		tomono.tv_nsec = vd->wtm_clock_nsec;
-
-	} while (vdso_read_retry(vd, seq));
-
-	ts->tv_sec += tomono.tv_sec;
-	/* open coding timespec_add_ns */
-	ts->tv_sec += __iter_div_u64_rem(ts->tv_nsec + tomono.tv_nsec,
-					 NSEC_PER_SEC, &nsec);
-	ts->tv_nsec = nsec;
-
-	return 0;
-}
-
-#ifdef CONFIG_ARM_ARCH_TIMER
-
-/*
- * Returns the clock delta, in nanoseconds left-shifted by the clock
- * shift.
- */
-static notrace u64 get_clock_shifted_nsec(const u64 cycle_last,
-					  const u32 mult,
-					  const u64 mask)
-{
-	u64 res;
-
-	/* Read the virtual counter. */
-	res = arch_vdso_read_counter();
-
-	res = res - cycle_last;
-
-	res &= mask;
-	return res * mult;
-}
-
-static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
-{
-	u32 seq, mult, shift;
-	u64 nsec, cycle_last;
-#ifdef ARCH_CLOCK_FIXED_MASK
-	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
-#else
-	u64 mask;
-#endif
-	vdso_xtime_clock_sec_t sec;
-
-	do {
-		seq = vdso_read_begin(vd);
-
-		if (vd->use_syscall)
-			return -1;
-
-		cycle_last = vd->cs_cycle_last;
-
-		mult = vd->cs_mono_mult;
-		shift = vd->cs_shift;
-#ifndef ARCH_CLOCK_FIXED_MASK
-		mask = vd->cs_mask;
-#endif
-
-		sec = vd->xtime_clock_sec;
-		nsec = vd->xtime_clock_snsec;
-
-	} while (unlikely(vdso_read_retry(vd, seq)));
-
-	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
-	nsec >>= shift;
-	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
-	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
-	ts->tv_nsec = nsec;
-
-	return 0;
-}
-
-static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
-{
-	u32 seq, mult, shift;
-	u64 nsec, cycle_last;
-#ifdef ARCH_CLOCK_FIXED_MASK
-	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
-#else
-	u64 mask;
-#endif
-	vdso_wtm_clock_nsec_t wtm_nsec;
-	__kernel_time_t sec;
-
-	do {
-		seq = vdso_read_begin(vd);
-
-		if (vd->use_syscall)
-			return -1;
-
-		cycle_last = vd->cs_cycle_last;
-
-		mult = vd->cs_mono_mult;
-		shift = vd->cs_shift;
-#ifndef ARCH_CLOCK_FIXED_MASK
-		mask = vd->cs_mask;
-#endif
-
-		sec = vd->xtime_clock_sec;
-		nsec = vd->xtime_clock_snsec;
-
-		sec += vd->wtm_clock_sec;
-		wtm_nsec = vd->wtm_clock_nsec;
-
-	} while (unlikely(vdso_read_retry(vd, seq)));
-
-	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
-	nsec >>= shift;
-	nsec += wtm_nsec;
-	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
-	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
-	ts->tv_nsec = nsec;
-
-	return 0;
-}
-
-static notrace int do_monotonic_raw(const struct vdso_data *vd,
-				    struct timespec *ts)
-{
-	u32 seq, mult, shift;
-	u64 nsec, cycle_last;
-#ifdef ARCH_CLOCK_FIXED_MASK
-	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
-#else
-	u64 mask;
-#endif
-	vdso_raw_time_sec_t sec;
-
-	do {
-		seq = vdso_read_begin(vd);
-
-		if (vd->use_syscall)
-			return -1;
-
-		cycle_last = vd->cs_cycle_last;
-
-		mult = vd->cs_raw_mult;
-		shift = vd->cs_shift;
-#ifndef ARCH_CLOCK_FIXED_MASK
-		mask = vd->cs_mask;
-#endif
-
-		sec = vd->raw_time_sec;
-		nsec = vd->raw_time_nsec;
-
-	} while (unlikely(vdso_read_retry(vd, seq)));
-
-	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
-	nsec >>= shift;
-	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
-	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
-	ts->tv_nsec = nsec;
-
-	return 0;
-}
-
-#else /* CONFIG_ARM_ARCH_TIMER */
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
-#endif /* CONFIG_ARM_ARCH_TIMER */
-
-notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
-{
-	const struct vdso_data *vd = __get_datapage();
-
-	switch (clock) {
-	case CLOCK_REALTIME_COARSE:
-		do_realtime_coarse(vd, ts);
-		break;
-	case CLOCK_MONOTONIC_COARSE:
-		do_monotonic_coarse(vd, ts);
-		break;
-	case CLOCK_REALTIME:
-		if (do_realtime(vd, ts))
-			goto fallback;
-		break;
-	case CLOCK_MONOTONIC:
-		if (do_monotonic(vd, ts))
-			goto fallback;
-		break;
-	case CLOCK_MONOTONIC_RAW:
-		if (do_monotonic_raw(vd, ts))
-			goto fallback;
-		break;
-	default:
-		goto fallback;
-	}
-
-	return 0;
-fallback:
-	return clock_gettime_fallback(clock, ts);
-}
-
-notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
-{
-	const struct vdso_data *vd = __get_datapage();
-
-	if (likely(tv != NULL)) {
-		struct timespec ts;
-
-		if (do_realtime(vd, &ts))
-			return gettimeofday_fallback(tv, tz);
-
-		tv->tv_sec = ts.tv_sec;
-		tv->tv_usec = ts.tv_nsec / 1000;
-	}
-
-	if (unlikely(tz != NULL)) {
-		tz->tz_minuteswest = vd->tz_minuteswest;
-		tz->tz_dsttime = vd->tz_dsttime;
-	}
-
-	return 0;
-}
-
-int __vdso_clock_getres(clockid_t clock, struct timespec *res)
-{
-	long nsec;
-
-	if (clock == CLOCK_REALTIME ||
-	    clock == CLOCK_MONOTONIC ||
-	    clock == CLOCK_MONOTONIC_RAW)
-		nsec = MONOTONIC_RES_NSEC;
-	else if (clock == CLOCK_REALTIME_COARSE ||
-		 clock == CLOCK_MONOTONIC_COARSE)
-		nsec = LOW_RES_NSEC;
-	else
-		return clock_getres_fallback(clock, res);
-
-	if (likely(res != NULL)) {
-		res->tv_sec = 0;
-		res->tv_nsec = nsec;
-	}
-
-	return 0;
-}
+#include "../../../lib/vdso/vgettimeofday.c"
diff --git a/lib/vdso/compiler.h b/lib/vdso/compiler.h
new file mode 100644
index 000000000000..0e618b73e064
--- /dev/null
+++ b/lib/vdso/compiler.h
@@ -0,0 +1,24 @@
+/*
+ * Userspace implementations of fallback calls
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __VDSO_COMPILER_H
+#define __VDSO_COMPILER_H
+
+#error	"vdso: Provide architectural overrides such as ARCH_PROVIDES_TIMER,"
+#error	"      DEFINE_FALLBACK and __arch_counter_get or any overrides. eg:"
+#error	"      vdso entry points or compilation time helpers."
+
+#endif /* __VDSO_COMPILER_H */
diff --git a/lib/vdso/datapage.h b/lib/vdso/datapage.h
new file mode 100644
index 000000000000..df4427e42d51
--- /dev/null
+++ b/lib/vdso/datapage.h
@@ -0,0 +1,24 @@
+/*
+ * Userspace implementations of __get_datapage
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __VDSO_DATAPAGE_H
+#define __VDSO_DATAPAGE_H
+
+#error	"vdso: Provide a user space architecture specific definition or"
+#error	"prototype for struct vdso_data *__get_datapage(void).  Also define"
+#error	"ARCH_CLOCK_FIXED_MASK if not provided by cs_mask."
+
+#endif /* __VDSO_DATAPAGE_H */
diff --git a/lib/vdso/vgettimeofday.c b/lib/vdso/vgettimeofday.c
new file mode 100644
index 000000000000..33c5917fe9f8
--- /dev/null
+++ b/lib/vdso/vgettimeofday.c
@@ -0,0 +1,344 @@
+/*
+ * Userspace implementations of gettimeofday() and friends.
+ *
+ * Copyright (C) 2017 Cavium, Inc.
+ * Copyright (C) 2015 Mentor Graphics Corporation
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ * Rewriten from arch64 version into C by: Andrew Pinski <apinski@cavium.com>
+ * Reworked and rebased over arm version by: Mark Salyzyn <salyzyn@android.com>
+ */
+
+#include <asm/barrier.h>
+#include <linux/compiler.h>	/* for notrace				*/
+#include <linux/math64.h>		/* for __iter_div_u64_rem()	*/
+#include <uapi/linux/time.h>		/* for struct timespec		*/
+
+#include "compiler.h"
+#include "datapage.h"
+
+DEFINE_FALLBACK(gettimeofday, struct timeval *, tv, struct timezone *, tz)
+DEFINE_FALLBACK(clock_gettime, clockid_t, clock, struct timespec *, ts)
+DEFINE_FALLBACK(clock_getres, clockid_t, clock, struct timespec *, ts)
+
+static notrace u32 vdso_read_begin(const struct vdso_data *vd)
+{
+	u32 seq;
+
+	do {
+		seq = READ_ONCE(vd->tb_seq_count);
+
+		if ((seq & 1) == 0)
+			break;
+
+		cpu_relax();
+	} while (true);
+
+	smp_rmb(); /* Pairs with second smp_wmb in update_vsyscall */
+	return seq;
+}
+
+static notrace int vdso_read_retry(const struct vdso_data *vd, u32 start)
+{
+	u32 seq;
+
+	smp_rmb(); /* Pairs with first smp_wmb in update_vsyscall */
+	seq = READ_ONCE(vd->tb_seq_count);
+	return seq != start;
+}
+
+static notrace int do_realtime_coarse(const struct vdso_data *vd,
+				      struct timespec *ts)
+{
+	u32 seq;
+
+	do {
+		seq = vdso_read_begin(vd);
+
+		ts->tv_sec = vd->xtime_coarse_sec;
+		ts->tv_nsec = vd->xtime_coarse_nsec;
+
+	} while (vdso_read_retry(vd, seq));
+
+	return 0;
+}
+
+static notrace int do_monotonic_coarse(const struct vdso_data *vd,
+				       struct timespec *ts)
+{
+	struct timespec tomono;
+	u32 seq;
+	u64 nsec;
+
+	do {
+		seq = vdso_read_begin(vd);
+
+		ts->tv_sec = vd->xtime_coarse_sec;
+		ts->tv_nsec = vd->xtime_coarse_nsec;
+
+		tomono.tv_sec = vd->wtm_clock_sec;
+		tomono.tv_nsec = vd->wtm_clock_nsec;
+
+	} while (vdso_read_retry(vd, seq));
+
+	ts->tv_sec += tomono.tv_sec;
+	/* open coding timespec_add_ns */
+	ts->tv_sec += __iter_div_u64_rem(ts->tv_nsec + tomono.tv_nsec,
+					 NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
+
+	return 0;
+}
+
+#ifdef ARCH_PROVIDES_TIMER
+
+/*
+ * Returns the clock delta, in nanoseconds left-shifted by the clock
+ * shift.
+ */
+static notrace u64 get_clock_shifted_nsec(const u64 cycle_last,
+					  const u32 mult,
+					  const u64 mask)
+{
+	u64 res;
+
+	/* Read the virtual counter. */
+	res = arch_vdso_read_counter();
+
+	res = res - cycle_last;
+
+	res &= mask;
+	return res * mult;
+}
+
+static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
+{
+	u32 seq, mult, shift;
+	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
+	u64 mask;
+#endif
+	vdso_xtime_clock_sec_t sec;
+
+	do {
+		seq = vdso_read_begin(vd);
+
+		if (vd->use_syscall)
+			return -1;
+
+		cycle_last = vd->cs_cycle_last;
+
+		mult = vd->cs_mono_mult;
+		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
+		mask = vd->cs_mask;
+#endif
+
+		sec = vd->xtime_clock_sec;
+		nsec = vd->xtime_clock_snsec;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
+	nsec >>= shift;
+	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
+
+	return 0;
+}
+
+static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
+{
+	u32 seq, mult, shift;
+	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
+	u64 mask;
+#endif
+	vdso_wtm_clock_nsec_t wtm_nsec;
+	__kernel_time_t sec;
+
+	do {
+		seq = vdso_read_begin(vd);
+
+		if (vd->use_syscall)
+			return -1;
+
+		cycle_last = vd->cs_cycle_last;
+
+		mult = vd->cs_mono_mult;
+		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
+		mask = vd->cs_mask;
+#endif
+
+		sec = vd->xtime_clock_sec;
+		nsec = vd->xtime_clock_snsec;
+
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
+
+	return 0;
+}
+
+static notrace int do_monotonic_raw(const struct vdso_data *vd,
+				    struct timespec *ts)
+{
+	u32 seq, mult, shift;
+	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
+	u64 mask;
+#endif
+	vdso_raw_time_sec_t sec;
+
+	do {
+		seq = vdso_read_begin(vd);
+
+		if (vd->use_syscall)
+			return -1;
+
+		cycle_last = vd->cs_cycle_last;
+
+		mult = vd->cs_raw_mult;
+		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
+		mask = vd->cs_mask;
+#endif
+
+		sec = vd->raw_time_sec;
+		nsec = vd->raw_time_nsec;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
+	nsec >>= shift;
+	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
+
+	return 0;
+}
+
+#else /* ARCH_PROVIDES_TIMER */
+
+static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
+{
+	return -1;
+}
+
+static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
+{
+	return -1;
+}
+
+static notrace int do_monotonic_raw(const struct vdso_data *vd,
+				    struct timespec *ts)
+{
+	return -1;
+}
+
+#endif /* ARCH_PROVIDES_TIMER */
+
+notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
+{
+	const struct vdso_data *vd = __get_datapage();
+
+	switch (clock) {
+	case CLOCK_REALTIME_COARSE:
+		do_realtime_coarse(vd, ts);
+		break;
+	case CLOCK_MONOTONIC_COARSE:
+		do_monotonic_coarse(vd, ts);
+		break;
+	case CLOCK_REALTIME:
+		if (do_realtime(vd, ts))
+			goto fallback;
+		break;
+	case CLOCK_MONOTONIC:
+		if (do_monotonic(vd, ts))
+			goto fallback;
+		break;
+	case CLOCK_MONOTONIC_RAW:
+		if (do_monotonic_raw(vd, ts))
+			goto fallback;
+		break;
+	default:
+		goto fallback;
+	}
+
+	return 0;
+fallback:
+	return clock_gettime_fallback(clock, ts);
+}
+
+notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	const struct vdso_data *vd = __get_datapage();
+
+	if (likely(tv != NULL)) {
+		struct timespec ts;
+
+		if (do_realtime(vd, &ts))
+			return gettimeofday_fallback(tv, tz);
+
+		tv->tv_sec = ts.tv_sec;
+		tv->tv_usec = ts.tv_nsec / 1000;
+	}
+
+	if (unlikely(tz != NULL)) {
+		tz->tz_minuteswest = vd->tz_minuteswest;
+		tz->tz_dsttime = vd->tz_dsttime;
+	}
+
+	return 0;
+}
+
+int __vdso_clock_getres(clockid_t clock, struct timespec *res)
+{
+	long nsec;
+
+	if (clock == CLOCK_REALTIME ||
+	    clock == CLOCK_MONOTONIC ||
+	    clock == CLOCK_MONOTONIC_RAW)
+		nsec = MONOTONIC_RES_NSEC;
+	else if (clock == CLOCK_REALTIME_COARSE ||
+		 clock == CLOCK_MONOTONIC_COARSE)
+		nsec = LOW_RES_NSEC;
+	else
+		return clock_getres_fallback(clock, res);
+
+	if (likely(res != NULL)) {
+		res->tv_sec = 0;
+		res->tv_nsec = nsec;
+	}
+
+	return 0;
+}
-- 
2.18.0.rc1.244.gcf134e6275-goog

