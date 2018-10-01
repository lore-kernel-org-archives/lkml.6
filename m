Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF74C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60274208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="mlP92VlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60274208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbeJBAie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:38:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41952 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJBAie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:38:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23-v6so1095765pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZOtf7ah3p60a8nucj+K3KxH/R2xiRaSEqaXYCRrbhg=;
        b=mlP92VlVxrtlA3qN0Qt9QmXLcg5GML1geEcKZI0WAAa25dwC8ay1zUQ5onqO8SybjO
         +ZXKL4E9tfLkFIE+vcRTkCjeCoaJf4wp+rKbNgrj6OFiq2G2bpAVDFfCqp3B+b7/KCkC
         l2m35ntxGwX9K36ZchHEPrXsovkUK24uoD7WdfDF7rwGqE320jH4maAlR8pw0zMMdjdl
         PQc/f0myc0Ta6vuuJU7ylm6fOgW9iGJh8Y6X/fgzWvOJ5zvQdxxFgq0ovNb7VYGhXOui
         ltUiECcecwwKusS0gQaDVAP6tKnROJAys/DUJbVP0XWb0Z+iq5jLk4UKFR0Zy/v4pDpD
         HP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZOtf7ah3p60a8nucj+K3KxH/R2xiRaSEqaXYCRrbhg=;
        b=nUF8a+/snxO1EKdrEyccJs+THhR07a5haPmdFHjccvyxBc3ln9bvChn9B+P7l05e2E
         4jNfDNNSyBcHxg7FdMIcNErqwK1kXxDplBZuIFMVGtmxdzHx2HoVsNeVTLPt2VUBKEJr
         d9994cAeYN4O0leyHmoWAgeWmFdauF+nU0qjHyLAAlFojhILXXYB1eeQnhiBHRIWHMB2
         hDuf1+/ip44+99bpoxO2QxDPUT+yL/8A4cH8sw7r6OU1LfR6a2KjeAPMGxJ40nHbELdI
         pqpmFEG7RsfCiWyKlCPNLvzWfxDUzDf9OfIXD+VlvTm/3zKovvJc9iO9jxct7ZiK+6U2
         opBw==
X-Gm-Message-State: ABuFfojNYaOQfEQQp5PgusCKdDfpW/Ysxq46giWzIiJT0OBmPpJ6KDv/
        eKVc8W82a4q3mTVeF5LFrDkctRqIOyk=
X-Google-Smtp-Source: ACcGV61h/YWYpx1QbW5aaYI2jGJFY/YwssINhNnjkfcf83aYo/BsX5UOeajvZSutNoeeXfBkQ23xQg==
X-Received: by 2002:a63:5d03:: with SMTP id r3-v6mr11346828pgb.445.1538416776120;
        Mon, 01 Oct 2018 10:59:36 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.10.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 10:59:35 -0700 (PDT)
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
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: RESEND [PATCH v5 02/12] arm: vdso: add include file defining __get_datapage()
Date:   Mon,  1 Oct 2018 10:58:22 -0700
Message-Id: <20181001175845.168430-3-salyzyn@android.com>
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

Define the prototype for __get_datapage() in local datapage.h header.
Rename all vdata variable that point to the datapage shortened to vd
to relect a consistent and concise style. Make sure that all
references to the datapage in vdso operations are readonly (const).
Make sure datapage is first parameter to all subroutines to also
be consistent.

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
- split first CL into 2 of 7 pieces

v4:
- update commit message to reflect overall reasoning

v5:
- rebase
---
 arch/arm/vdso/datapage.h      | 25 +++++++++
 arch/arm/vdso/vgettimeofday.c | 99 +++++++++++++++++------------------
 2 files changed, 73 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm/vdso/datapage.h

diff --git a/arch/arm/vdso/datapage.h b/arch/arm/vdso/datapage.h
new file mode 100644
index 000000000000..e3088bdfb946
--- /dev/null
+++ b/arch/arm/vdso/datapage.h
@@ -0,0 +1,25 @@
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
+#include <linux/types.h>
+#include <asm/vdso_datapage.h>
+
+extern const struct vdso_data *__get_datapage(void);
+
+#endif /* __VDSO_DATAPAGE_H */
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 8cf13af1323c..2474c17dc356 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -30,20 +30,19 @@
 #include <asm/bug.h>
 #include <asm/page.h>
 #include <asm/unistd.h>
-#include <asm/vdso_datapage.h>
 
 #ifndef CONFIG_AEABI
 #error This code depends on AEABI system call conventions
 #endif
 
-extern struct vdso_data *__get_datapage(void);
+#include "datapage.h"
 
-static notrace u32 vdso_read_begin(const struct vdso_data *vdata)
+static notrace u32 vdso_read_begin(const struct vdso_data *vd)
 {
 	u32 seq;
 
 	do {
-		seq = READ_ONCE(vdata->tb_seq_count);
+		seq = READ_ONCE(vd->tb_seq_count);
 
 		if ((seq & 1) == 0)
 			break;
@@ -55,12 +54,12 @@ static notrace u32 vdso_read_begin(const struct vdso_data *vdata)
 	return seq;
 }
 
-static notrace int vdso_read_retry(const struct vdso_data *vdata, u32 start)
+static notrace int vdso_read_retry(const struct vdso_data *vd, u32 start)
 {
 	u32 seq;
 
 	smp_rmb(); /* Pairs with first smp_wmb in update_vsyscall */
-	seq = READ_ONCE(vdata->tb_seq_count);
+	seq = READ_ONCE(vd->tb_seq_count);
 	return seq != start;
 }
 
@@ -81,38 +80,38 @@ static notrace long clock_gettime_fallback(clockid_t _clkid,
 	return ret;
 }
 
-static notrace int do_realtime_coarse(struct timespec *ts,
-				      struct vdso_data *vdata)
+static notrace int do_realtime_coarse(const struct vdso_data *vd,
+				      struct timespec *ts)
 {
 	u32 seq;
 
 	do {
-		seq = vdso_read_begin(vdata);
+		seq = vdso_read_begin(vd);
 
-		ts->tv_sec = vdata->xtime_coarse_sec;
-		ts->tv_nsec = vdata->xtime_coarse_nsec;
+		ts->tv_sec = vd->xtime_coarse_sec;
+		ts->tv_nsec = vd->xtime_coarse_nsec;
 
-	} while (vdso_read_retry(vdata, seq));
+	} while (vdso_read_retry(vd, seq));
 
 	return 0;
 }
 
-static notrace int do_monotonic_coarse(struct timespec *ts,
-				       struct vdso_data *vdata)
+static notrace int do_monotonic_coarse(const struct vdso_data *vd,
+				       struct timespec *ts)
 {
 	struct timespec tomono;
 	u32 seq;
 
 	do {
-		seq = vdso_read_begin(vdata);
+		seq = vdso_read_begin(vd);
 
-		ts->tv_sec = vdata->xtime_coarse_sec;
-		ts->tv_nsec = vdata->xtime_coarse_nsec;
+		ts->tv_sec = vd->xtime_coarse_sec;
+		ts->tv_nsec = vd->xtime_coarse_nsec;
 
-		tomono.tv_sec = vdata->wtm_clock_sec;
-		tomono.tv_nsec = vdata->wtm_clock_nsec;
+		tomono.tv_sec = vd->wtm_clock_sec;
+		tomono.tv_nsec = vd->wtm_clock_nsec;
 
-	} while (vdso_read_retry(vdata, seq));
+	} while (vdso_read_retry(vd, seq));
 
 	ts->tv_sec += tomono.tv_sec;
 	timespec_add_ns(ts, tomono.tv_nsec);
@@ -122,7 +121,7 @@ static notrace int do_monotonic_coarse(struct timespec *ts,
 
 #ifdef CONFIG_ARM_ARCH_TIMER
 
-static notrace u64 get_ns(struct vdso_data *vdata)
+static notrace u64 get_ns(const struct vdso_data *vd)
 {
 	u64 cycle_delta;
 	u64 cycle_now;
@@ -130,29 +129,29 @@ static notrace u64 get_ns(struct vdso_data *vdata)
 
 	cycle_now = arch_counter_get_cntvct();
 
-	cycle_delta = (cycle_now - vdata->cs_cycle_last) & vdata->cs_mask;
+	cycle_delta = (cycle_now - vd->cs_cycle_last) & vd->cs_mask;
 
-	nsec = (cycle_delta * vdata->cs_mono_mult) + vdata->xtime_clock_snsec;
-	nsec >>= vdata->cs_shift;
+	nsec = (cycle_delta * vd->cs_mono_mult) + vd->xtime_clock_snsec;
+	nsec >>= vd->cs_shift;
 
 	return nsec;
 }
 
-static notrace int do_realtime(struct timespec *ts, struct vdso_data *vdata)
+static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
 {
 	u64 nsecs;
 	u32 seq;
 
 	do {
-		seq = vdso_read_begin(vdata);
+		seq = vdso_read_begin(vd);
 
-		if (vdata->use_syscall)
+		if (vd->use_syscall)
 			return -1;
 
-		ts->tv_sec = vdata->xtime_clock_sec;
-		nsecs = get_ns(vdata);
+		ts->tv_sec = vd->xtime_clock_sec;
+		nsecs = get_ns(vd);
 
-	} while (vdso_read_retry(vdata, seq));
+	} while (vdso_read_retry(vd, seq));
 
 	ts->tv_nsec = 0;
 	timespec_add_ns(ts, nsecs);
@@ -160,25 +159,25 @@ static notrace int do_realtime(struct timespec *ts, struct vdso_data *vdata)
 	return 0;
 }
 
-static notrace int do_monotonic(struct timespec *ts, struct vdso_data *vdata)
+static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
 {
 	struct timespec tomono;
 	u64 nsecs;
 	u32 seq;
 
 	do {
-		seq = vdso_read_begin(vdata);
+		seq = vdso_read_begin(vd);
 
-		if (vdata->use_syscall)
+		if (vd->use_syscall)
 			return -1;
 
-		ts->tv_sec = vdata->xtime_clock_sec;
-		nsecs = get_ns(vdata);
+		ts->tv_sec = vd->xtime_clock_sec;
+		nsecs = get_ns(vd);
 
-		tomono.tv_sec = vdata->wtm_clock_sec;
-		tomono.tv_nsec = vdata->wtm_clock_nsec;
+		tomono.tv_sec = vd->wtm_clock_sec;
+		tomono.tv_nsec = vd->wtm_clock_nsec;
 
-	} while (vdso_read_retry(vdata, seq));
+	} while (vdso_read_retry(vd, seq));
 
 	ts->tv_sec += tomono.tv_sec;
 	ts->tv_nsec = 0;
@@ -189,12 +188,12 @@ static notrace int do_monotonic(struct timespec *ts, struct vdso_data *vdata)
 
 #else /* CONFIG_ARM_ARCH_TIMER */
 
-static notrace int do_realtime(struct timespec *ts, struct vdso_data *vdata)
+static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
 {
 	return -1;
 }
 
-static notrace int do_monotonic(struct timespec *ts, struct vdso_data *vdata)
+static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
 {
 	return -1;
 }
@@ -203,23 +202,22 @@ static notrace int do_monotonic(struct timespec *ts, struct vdso_data *vdata)
 
 notrace int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
 {
-	struct vdso_data *vdata;
 	int ret = -1;
 
-	vdata = __get_datapage();
+	const struct vdso_data *vd = __get_datapage();
 
 	switch (clkid) {
 	case CLOCK_REALTIME_COARSE:
-		ret = do_realtime_coarse(ts, vdata);
+		ret = do_realtime_coarse(vd, ts);
 		break;
 	case CLOCK_MONOTONIC_COARSE:
-		ret = do_monotonic_coarse(ts, vdata);
+		ret = do_monotonic_coarse(vd, ts);
 		break;
 	case CLOCK_REALTIME:
-		ret = do_realtime(ts, vdata);
+		ret = do_realtime(vd, ts);
 		break;
 	case CLOCK_MONOTONIC:
-		ret = do_monotonic(ts, vdata);
+		ret = do_monotonic(vd, ts);
 		break;
 	default:
 		break;
@@ -251,12 +249,11 @@ static notrace long gettimeofday_fallback(struct timeval *_tv,
 notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
 	struct timespec ts;
-	struct vdso_data *vdata;
 	int ret;
 
-	vdata = __get_datapage();
+	const struct vdso_data *vd = __get_datapage();
 
-	ret = do_realtime(&ts, vdata);
+	ret = do_realtime(vd, &ts);
 	if (ret)
 		return gettimeofday_fallback(tv, tz);
 
@@ -265,8 +262,8 @@ notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 		tv->tv_usec = ts.tv_nsec / 1000;
 	}
 	if (tz) {
-		tz->tz_minuteswest = vdata->tz_minuteswest;
-		tz->tz_dsttime = vdata->tz_dsttime;
+		tz->tz_minuteswest = vd->tz_minuteswest;
+		tz->tz_dsttime = vd->tz_dsttime;
 	}
 
 	return ret;
-- 
2.19.0.605.g01d371f741-goog

