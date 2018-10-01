Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA29C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5342145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="JAPp+6tP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5342145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeJBAkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:40:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43836 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeJBAkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:40:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id 80-v6so2059026pgh.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7vaA2MA8EQ1d2Vcn1d4fxUkppIy3o0RYXj7Io3jPUYw=;
        b=JAPp+6tPtdnSk7VyFz78LpsVxKwjQs9mSL/bf7A1eDSRYG9otVaO8+16CaBlLtVAmk
         jD2XB1DmYUtPLZUQXkYaM3yxpYNsPEWCsrcJyrgR7xCNvQvh6wn5deCjABE/AHxf6RT1
         7T/r71+oSqsR2ras5m0zdH13SQdnNoFpzofZDw3CZeSlxZn20EUMYNQ404oOJ6EU8/UY
         OQlD7ymz2/7aJMwyE8S/KYRF+MQdmhH+JQLCiCQMYeP0xc5/zuu/pj8lhi2CGOy6QOtz
         r7IAJLe/wLelhr9jjZAGzn6/dSu57EGoHDbUkZDMVeBRFSu4eNcWm3xnkv1Gotmqpp+F
         hG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7vaA2MA8EQ1d2Vcn1d4fxUkppIy3o0RYXj7Io3jPUYw=;
        b=BQpjX34ur6oGZJd9eChKn5IAtBXE3rEqwGvjgquUXl2zQO3fTG4FDr3OXxQ4Lgf9yA
         Bu1b/0ntWxqciWqBQa5yOhnVa0S4Yj9hW9bMYr7mM6m5myWNA89oLWaOnNuAeu+pZMmP
         c30YYi61VYHzclj94jDDUmKzayL5e7rYNpRnX6iIOsfotR5AQGagbe5hsO0/lODukGaE
         Uu2qjqOo0oxLinc7TPwTsdRuPBCu3C3wJGkq3ItEez122lXgOwXNElweJtJtXN0REpSN
         eoqF9KtK0G15duYYrMrySxmnrMIqwAPNDDIixFLuyvb3F3o+7XQ6PHsJQ6BvnKNIT+O7
         L8Bg==
X-Gm-Message-State: ABuFfoi5jCS+1zaSXPW0LhG2WXxFHPBW7Nra701xi/9FJ5tZWslcqnQA
        YEoUoisUZOXlU1Wyc3SotCNCX3JN188=
X-Google-Smtp-Source: ACcGV62Cdp4S5Y3bitpAoz3QJF/L1dkkKhsuoLOPnerR7TjAuPG9pOLzPpDiLFOd9/MTPba57sJSUA==
X-Received: by 2002:a17:902:b598:: with SMTP id a24-v6mr5870438pls.40.1538416883414;
        Mon, 01 Oct 2018 11:01:23 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:01:22 -0700 (PDT)
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
        android-kernel@android.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: RESEND [PATCH v5 08/12] arm: vdso: Add ARCH_CLOCK_FIXED_MASK
Date:   Mon,  1 Oct 2018 10:58:28 -0700
Message-Id: <20181001175845.168430-9-salyzyn@android.com>
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

Add ARCH_CLOCK_FIXED_MASK as an efficiency since arm64 has no
purpose for cs_mask vdso_data variable.

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
2.19.0.605.g01d371f741-goog

