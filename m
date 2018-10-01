Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574CEC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EBA2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="SdCFEUYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EBA2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeJBAjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:39:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35684 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeJBAjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:39:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id v133-v6so10021634pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZW+J2uHfbW8E5yTGNvzEAl3iCk9YwcdDxuB33ic4RTc=;
        b=SdCFEUYC8wRoAM79NCTbeVEpCs40i9LiCX1h9R535SDDF/JElvTZT7iCdFXf2it6kB
         MYEPbnDvEA2McO71e4BAe6baoSXhoANCP3PZ8/Brsf29+qIGLrYUuYx2voHKaABSNOSY
         i+U/z8eLxUVmdfXTFhBwn2e277tX9YmnLatSAkI/gnXk5rCtyzJu9O0QrovZd0hKVudZ
         V3Ce7aFI8Ija52AsBOPPQIFa7s9+6zpdrsXDXGecZvwgxBxd9qL5ccnJmT/kbQzYmK3f
         TajjjXKeTIIuPeoOQzOGlAu+LD3wQB9o8HoA4BgIw/kywZ7ppe8zYLdjNBBy+ef9dx6h
         5EUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZW+J2uHfbW8E5yTGNvzEAl3iCk9YwcdDxuB33ic4RTc=;
        b=bQO4RiN69TK++BlGf7J3tb1r/wjKeVHr1kJWVCmnQl5nYSeH1K8LOzCCOallI8exYn
         MzRQjNHpULp3GezFUOxRZNZPU8TWxUa8LS5gIo/CsIJX1VZi4DN2S7YsHu4G5bm3pkVU
         umbNEyEThbWHNpJLQy42KxvoQpR0gVGgOfYYyCimXusj3NzuCIIOq1GOYsFzM6S4xrow
         98uxw8Kh68u5+VxVQAa+jAMOmK30mPobtVGvhqAKM9Lg/9rmkSR5dP78YWjS23fXWwfp
         /iGcx7xedJCtMO2jVUehn7qDTsPmyaqvXcy2LyMzsl29ss4RzDttmOX7IfBnvZHcu4qV
         DOfQ==
X-Gm-Message-State: ABuFfoiD7i4PeUZ4HtoxoZf4NQ4rqM2KIK4jvP6VVfIbyz1FhvtFqVEd
        CDEI2YMN7eJIpbzU6rdgmqtrE7VGAnk=
X-Google-Smtp-Source: ACcGV63d0TRbtG7P9JepMO8nsyO35brgz1kk+2AkK579gNH7YYo73vednHof02g/EdFJ/Oz5ykkcAA==
X-Received: by 2002:a62:db46:: with SMTP id f67-v6mr12493954pfg.1.1538416856617;
        Mon, 01 Oct 2018 11:00:56 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:00:56 -0700 (PDT)
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
        android-kernel@android.com, Jinbum Park <jinb.park7@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: RESEND [PATCH v6 05/12] arm: vdso: Add support for CLOCK_MONOTONIC_RAW
Date:   Mon,  1 Oct 2018 10:58:25 -0700
Message-Id: <20181001175845.168430-6-salyzyn@android.com>
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

Add a case for CLOCK_MONOTONIC_RAW to match up with support that
is available in arm64's vdso.

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

v2:
- split first CL into 6 of 7 pieces

v4:
- Move out ARCH_CLOCK_FIXED_MASK to later adjustment.
- update commit message to reflect overall reasoning.
- replace typeof() with type vdso_raw_time_sec_t.

v5:
- replace erroneous tk->raw_time.shift with tk->tkr_raw.shift

v6:
- fixup raw_time_sec and raw_time_nsec in vdso.c
---
 arch/arm/include/asm/vdso_datapage.h | 11 +++++++
 arch/arm/kernel/vdso.c               |  3 ++
 arch/arm/vdso/vgettimeofday.c        | 44 ++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/arch/arm/include/asm/vdso_datapage.h b/arch/arm/include/asm/vdso_datapage.h
index 8dd7303db4ec..1c6e6a5d5d9d 100644
--- a/arch/arm/include/asm/vdso_datapage.h
+++ b/arch/arm/include/asm/vdso_datapage.h
@@ -34,6 +34,11 @@ typedef u32 vdso_wtm_clock_nsec_t;
 typedef u32 vdso_xtime_clock_sec_t;
 #endif
 
+#ifndef _VDSO_RAW_TIME_SEC_T
+#define _VDSO_RAW_TIME_SEC_T
+typedef u32 vdso_raw_time_sec_t;
+#endif
+
 /* Try to be cache-friendly on systems that don't implement the
  * generic timer: fit the unconditionally updated fields in the first
  * 32 bytes.
@@ -58,6 +63,12 @@ struct vdso_data {
 	u64 xtime_clock_snsec;	/* CLOCK_REALTIME sub-ns base */
 	u32 tz_minuteswest;	/* timezone info for gettimeofday(2) */
 	u32 tz_dsttime;
+
+	/* Raw clocksource multipler */
+	u32 cs_raw_mult;
+	/* Raw time */
+	vdso_raw_time_sec_t raw_time_sec;
+	u32 raw_time_nsec;
 };
 
 union vdso_data_store {
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index c2c57f6b8c60..9c13a32fa5f0 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -337,9 +337,12 @@ void update_vsyscall(struct timekeeper *tk)
 
 	if (!vdso_data->use_syscall) {
 		vdso_data->cs_cycle_last	= tk->tkr_mono.cycle_last;
+		vdso_data->raw_time_sec		= tk->raw_sec;
+		vdso_data->raw_time_nsec	= tk->tkr_raw.xtime_nsec;
 		vdso_data->xtime_clock_sec	= tk->xtime_sec;
 		vdso_data->xtime_clock_snsec	= tk->tkr_mono.xtime_nsec;
 		vdso_data->cs_mono_mult		= tk->tkr_mono.mult;
+		vdso_data->cs_raw_mult		= tk->tkr_raw.mult;
 		/* tkr_mono.shift == tkr_raw.shift */
 		vdso_data->cs_shift		= tk->tkr_mono.shift;
 		vdso_data->cs_mask		= tk->tkr_mono.mask;
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 59893fca03b3..a2c4db83edc4 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -194,6 +194,40 @@ static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
 	return 0;
 }
 
+static notrace int do_monotonic_raw(const struct vdso_data *vd,
+				    struct timespec *ts)
+{
+	u32 seq, mult, shift;
+	u64 nsec, cycle_last;
+	u64 mask;
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
+		mask = vd->cs_mask;
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
 #else /* CONFIG_ARM_ARCH_TIMER */
 
 static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
@@ -206,6 +240,12 @@ static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
 	return -1;
 }
 
+static notrace int do_monotonic_raw(const struct vdso_data *vd,
+				    struct timespec *ts)
+{
+	return -1;
+}
+
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
@@ -227,6 +267,10 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 		if (do_monotonic(vd, ts))
 			goto fallback;
 		break;
+	case CLOCK_MONOTONIC_RAW:
+		if (do_monotonic_raw(vd, ts))
+			goto fallback;
+		break;
 	default:
 		goto fallback;
 	}
-- 
2.19.0.605.g01d371f741-goog

