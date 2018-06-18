Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC43C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9915B20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="SW2qgV9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9915B20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935531AbeFRPHi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:07:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36721 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964863AbeFRPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:07:35 -0400
Received: by mail-pf0-f193.google.com with SMTP id a12-v6so8331772pfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PsEKIth0yuD0OAInqjn4dCvytZqYsNPOy0i7kE2wFdY=;
        b=SW2qgV9gUxmDo8BceOqZTHEWjBg/suiS5a7jTJo/EWYcUC0OXUYjrZPfen1kCnkc26
         dp9GczJ8UAZ3dmOI9uq32bjuFwAPY9cNLr00O83I6cPq3/yOlQ9izrm637Wahvj2WVsM
         3L+7F/+Peqi58miC4BzumJdEtvKrL9dkDGmBMrN3VHTtEcymtGISCZVL6Bqrq1fekZ8e
         iZAm3quaThXyLy52QnoZ0N7U3hl89LXM8S71mEpIJEqJjz62RlVjX0YLHZ9eS3MbnDR7
         zrFX6jjALPmGjp3ImIvw+HCF/QavxrAyVyYilK0WhkUZNzVLSL5PLnmEyDxaEHxaszah
         gvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PsEKIth0yuD0OAInqjn4dCvytZqYsNPOy0i7kE2wFdY=;
        b=BhnGUZrhMM4WzUK4tbcEqTghihwX24XM5E1n+7rMZim86T/O3/ljAa1BiKW8IDkT9+
         eap+stYo4+s1ryNLpVx5eJzuKrBs3JpaH/S7AQwP48S6ur6gbsQyNrU29hrET5Qrot/h
         TszvVsZYktTSlSqXUl5/ZglM18HjlCVvaCOmUCJoWbYDG83Y7bdxlopPjzszH94asI1U
         tgQ/vJ6ytBzdytW4lDSeNP89BC46muEUmhI+cG7fJkL+EiF09a/e6YPb8zdT4Dd/Y6NP
         +nakVXblLDBnbQVIrqIPrdvJQh4cbMOULw7TqxaP3tbjAcx/jV6hSGT0ecIUZUpYGRFS
         DvSg==
X-Gm-Message-State: APt69E24ch8ITRMUXeZqkMBYCxboaOfd5qd4jNlFKtz2JfBOTdufMITG
        PFtrqix1NQvx/53mznnE/ehwR1/GDyg=
X-Google-Smtp-Source: ADUXVKKvauPfsprBPn4pSqSYshRoQzPtEbYkDnktZUfqGDCjWOLOa1VDiuG6muFFlokKncMOwrqYAw==
X-Received: by 2002:a63:ba56:: with SMTP id l22-v6mr11398232pgu.161.1529334454265;
        Mon, 18 Jun 2018 08:07:34 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:07:33 -0700 (PDT)
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
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: RESEND [PATCH v5 08/12] arm: vdso: Add ARCH_CLOCK_FIXED_MASK
Date:   Mon, 18 Jun 2018 08:05:54 -0700
Message-Id: <20180618150613.10322-9-salyzyn@android.com>
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

Add ARCH_CLOCK_FIXED_MASK as an efficiency since arm64 has no
purpose for cs_mask vdso_data variable.

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

v4:
- New in series, split off from earlier.

v5:
- rebase
---
 arch/arm/vdso/vgettimeofday.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index a354586f8a65..3005479efbe8 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -128,7 +128,11 @@ static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
 {
 	u32 seq, mult, shift;
 	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
 	u64 mask;
+#endif
 	vdso_xtime_clock_sec_t sec;
 
 	do {
@@ -141,7 +145,9 @@ static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
 
 		mult = vd->cs_mono_mult;
 		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
 		mask = vd->cs_mask;
+#endif
 
 		sec = vd->xtime_clock_sec;
 		nsec = vd->xtime_clock_snsec;
@@ -161,7 +167,11 @@ static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
 {
 	u32 seq, mult, shift;
 	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
 	u64 mask;
+#endif
 	vdso_wtm_clock_nsec_t wtm_nsec;
 	__kernel_time_t sec;
 
@@ -175,7 +185,9 @@ static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
 
 		mult = vd->cs_mono_mult;
 		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
 		mask = vd->cs_mask;
+#endif
 
 		sec = vd->xtime_clock_sec;
 		nsec = vd->xtime_clock_snsec;
@@ -200,7 +212,11 @@ static notrace int do_monotonic_raw(const struct vdso_data *vd,
 {
 	u32 seq, mult, shift;
 	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
 	u64 mask;
+#endif
 	vdso_raw_time_sec_t sec;
 
 	do {
@@ -213,7 +229,9 @@ static notrace int do_monotonic_raw(const struct vdso_data *vd,
 
 		mult = vd->cs_raw_mult;
 		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
 		mask = vd->cs_mask;
+#endif
 
 		sec = vd->raw_time_sec;
 		nsec = vd->raw_time_nsec;
-- 
2.18.0.rc1.244.gcf134e6275-goog

