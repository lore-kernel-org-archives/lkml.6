Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4008C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A149F208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="aripGAga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A149F208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965503AbeFRPHb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:07:31 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45869 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964906AbeFRPHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:07:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id a22-v6so8316279pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B6Z2Yxp10H9ZUhz2OCbIS04Vyjh/4MN4jba+2LuzTic=;
        b=aripGAgagar7hqzH98wR/kmvzN8nmgmUw7cLY5GLA8xzgi/YdqOy1YyB6AELAp2Kr/
         HZJ9wrbW8b9Y5uymLDrPsYR5Sg2C4HMwSa3ZlBeS4NMV+4Ug8FwzAy+i3qE64uKt/FpU
         WngxhyovqlHfbjdG/U7K/rEBsUq8TbeZ8o0nCqRPZ2KAcXj0otw6ShcisNdyAlwi5hpc
         mJ6HxsmycgMyBGSqZRp5OJ7kmrW8AhxQgvpcHz/pIpJatU055U/e9BGK8eA1kGvdsY7S
         BwbateZAB50LTI1B8x4Wl7CGGEAt6JqLAZYIPsmURRyyVO3mkuA7vVLFBeuo8wflmX5v
         h6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B6Z2Yxp10H9ZUhz2OCbIS04Vyjh/4MN4jba+2LuzTic=;
        b=dwSnVWecicOpSJ09dJvkxR3fb6wyav3CFrzB9AXAri1+Z+QobFkPM50wqPDq1qx/py
         SHhGD8+jD/SrAQtq8vDM/iJ0Kz42tXo5G+bx0bvLiV6Nzz5ktNqEVhPa6eWhw+pUqLIW
         8VjPM0ILXjidmQhJ5q6Wt7F2VM0FzrhTIsHg+KixzHo8hc91NkLLCAdrCgbqR3+PUiIP
         RuswCxBQGXTEGrpx3EOr8eTBFReNi1sMDKQfwf6bwE5/u9tso/sX/XvH/8TuOXgWDfmj
         mXwNmI76UsN6k1SQv1VNBHwsVi1XWTGaJBHdfHyBHBhdEXv5THZ5a2icpRxodugr+eBv
         LAiw==
X-Gm-Message-State: APt69E2sy3g9MRfv0+7gWKGV4ZYECSJ5h/6sDM8YbwpG3ttZJauVeZXp
        Bf2Z28GG17ahjfyRY0LhtAeO8UtfYRA=
X-Google-Smtp-Source: ADUXVKKpztKg/Qq5SsJ4vRI9oyD5IkHNF0Aku6gyslsuxt/Z1BShQ0hHHJUpXs7qxFeDHtv1hOOZEQ==
X-Received: by 2002:a63:7b0e:: with SMTP id w14-v6mr11159950pgc.165.1529334444882;
        Mon, 18 Jun 2018 08:07:24 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:07:24 -0700 (PDT)
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
        Jinbum Park <jinb.park7@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: RESEND [PATCH v5 06/12] arm: vdso: add support for clock_getres
Date:   Mon, 18 Jun 2018 08:05:52 -0700
Message-Id: <20180618150613.10322-7-salyzyn@android.com>
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

Add clock_getres vdso support to match up with existing support in
the arm64's vdso.

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
- split first CL into 7 of 7 pieces

v4:
- update commit message to reflect overall reasoning.
- replace typeof() with long for nsec
- replace clock_id with clock to match usage elsewhere.

v5:
- add linux/hrtimer.h to compiler.h to supply for LOW_RES_NSEC and
  MONOTONIC_RES_NSEC.
---
 arch/arm/kernel/vdso.c        |  1 +
 arch/arm/vdso/compiler.h      |  1 +
 arch/arm/vdso/vdso.lds.S      |  1 +
 arch/arm/vdso/vgettimeofday.c | 23 +++++++++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 9c13a32fa5f0..c299967df63c 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -191,6 +191,7 @@ static void __init patch_vdso(void *ehdr)
 	if (!cntvct_ok) {
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
+		vdso_nullpatch_one(&einfo, "__vdso_clock_getres");
 	}
 }
 
diff --git a/arch/arm/vdso/compiler.h b/arch/arm/vdso/compiler.h
index 3edddb705a1b..c7751019246a 100644
--- a/arch/arm/vdso/compiler.h
+++ b/arch/arm/vdso/compiler.h
@@ -27,6 +27,7 @@
 #include <asm/processor.h>	/* for cpu_relax()			*/
 #include <asm/unistd.h>
 #include <linux/compiler.h>
+#include <linux/hrtimer.h>	/* for LOW_RES_NSEC and MONOTONIC_RES_NSEC */
 #include <linux/time.h>		/* for NSEC_PER_SEC			*/
 
 #ifndef CONFIG_AEABI
diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 89ca89f12d23..1d81e8c3acf6 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -82,6 +82,7 @@ VERSION
 	global:
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
+		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index a2c4db83edc4..a354586f8a65 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -32,6 +32,7 @@
 
 DEFINE_FALLBACK(gettimeofday, struct timeval *, tv, struct timezone *, tz)
 DEFINE_FALLBACK(clock_gettime, clockid_t, clock, struct timespec *, ts)
+DEFINE_FALLBACK(clock_getres, clockid_t, clock, struct timespec *, ts)
 
 static notrace u32 vdso_read_begin(const struct vdso_data *vd)
 {
@@ -301,3 +302,25 @@ notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 
 	return 0;
 }
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

