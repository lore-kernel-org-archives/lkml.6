Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A836C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBE7208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="MLCQr/BQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBE7208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965386AbeFRPHT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:07:19 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45853 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964868AbeFRPHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:07:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id a22-v6so8316036pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EZFagnmCmPK0jrqUJhwS419qQ/3Q5gFAyyKlvnDaAhc=;
        b=MLCQr/BQaCnVGuJPlPTrde1inIyPbrwSQSqChFmPikEz6AsmTtrKv32TL/DFiNpgQB
         m5IRvqo2kfgJK13x3vjfBzppMv9HFTa53DDZeQoDTfDUzXylEj/f24F/oqnV39xkKxh7
         qS4b3+xY94Etbi7Ky1Io4IdtOp3MmSQ2zSoVANkLUjI/70+hFpKR+qCHlrd1TFVi/dE8
         m7QmHhPuF/rryS0HSziAV7pd4GrI/tG8NT4qHebfF5vn1ZMMiceBvHP7N5y5vdqszatk
         60C80ix/21EbOmtcRITV9QnwTzyKR5bT3cXSe66FsQ/B9FA1P+h7p4m8cDOvZQKfMHth
         4koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EZFagnmCmPK0jrqUJhwS419qQ/3Q5gFAyyKlvnDaAhc=;
        b=Rhz77S0vROG0hCznABb8uLK+6mpdXfCU318mRXY+JvskyEawg+e8fgAYiNL+jPKImt
         b7/KoQMd5OxkfFE6zCTzFJhcLkUvcvj409EgagjQm+Nfktl+q+1yiwLKGtdq0MkNKNAo
         kXjK8kuhCiZEYBIZ6SkxvXSy5XzD4Cyy7zJ/ebfTk3nxy2LOFi42zUPyweOS7F5b4nFB
         dq8Q0Px0OGXTmIGpLUzoqOTCQ8R1tvX5RSMpD0m4Feb4t7H3KMPmJlwMen6qxlyb3e8I
         5VeysCXvOBrI3Bs5rJly/3uqRFuRQ+KQXE/En9ely0ancD3r/oJN5kV8ruiXdig+97Wm
         U7rw==
X-Gm-Message-State: APt69E0QUrl1Y7QeOSHidKdzB//Y84dfpT/W5tO0BfDRJtFRn5tckfYR
        agvDHxhDxqgOzNhuXWeXbgRMBRSy3h8=
X-Google-Smtp-Source: ADUXVKIWYc11sW82eHt+xorGYHDiwUO9A1AjDU7VsVX2ugiQ+izmbEIMJymxw5oxwdGAQnbRGYwMrA==
X-Received: by 2002:a62:8f8c:: with SMTP id n134-v6mr14052821pfd.66.1529334434735;
        Mon, 18 Jun 2018 08:07:14 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:07:14 -0700 (PDT)
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
        Jinbum Park <jinb.park7@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: RESEND [PATCH v6 05/12] arm: vdso: Add support for CLOCK_MONOTONIC_RAW
Date:   Mon, 18 Jun 2018 08:05:51 -0700
Message-Id: <20180618150613.10322-6-salyzyn@android.com>
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

Add a case for CLOCK_MONOTONIC_RAW to match up with support that
is available in arm64's vdso.

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
2.18.0.rc1.244.gcf134e6275-goog

