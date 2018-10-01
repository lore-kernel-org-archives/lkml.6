Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20B8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975E22145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="JYpM9c8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975E22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeJBAiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:38:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45596 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJBAiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:38:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id t70-v6so9980462pgd.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jn1CvemxeYjFr3HnKh8g7N/aFB2ivLzlaWIOdkbU1Ps=;
        b=JYpM9c8aYeIC8IgU0zmtjJYVVqhu+w6HUlrg4U9dpB3MqJxrvU2L2fcdWsYH86mUBz
         lo4zDA5mCaJ2v+tZtqGt6NUQFiR2YLYN6zckJNt8K38Amhtplzn4BEHjDalP6JRjW9ev
         ACdQdgihFgXYMCN5nOXqKbxdGSA+an7bRvysWdlyRBlt8bdy2UbyEa1dL+SAojgpJrOT
         urA1nYy/CVsZfE0c7jJbr90lzQ6ZmOHVsMpVYSpK/EpZG+E5Mu77aqr00j68JPg6+oEg
         CDKzuMre68jGFCULjK22H3LgVhDmIq5p+cy1ORMfFG7urICuVDgNTJ8KzcW1XQYUPJIg
         i0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jn1CvemxeYjFr3HnKh8g7N/aFB2ivLzlaWIOdkbU1Ps=;
        b=ns33LL4i3TR71+H/bqMw0XM9Fw3LhXI2dUzFWBfi4YAnUrQI1k6FW6KMVsQpnrwHrF
         u4Demzu8S7hkNGmsya8eR2WXaqbsGXPSQ4jnkM5mIg8KoQYwGfD/TFcvVMEPvQnXq0tQ
         QcyEoEfXNTQ9+cM/WQOueolFSdG2YJsAPcMBMmquTvd6BQHOhW/UyFt3MEdXvoqPc06L
         l2EQtTER/sSmu4wadutDHCHC/FBQyg22ZnManlu1rrDyQkSHOUV/ZscnG8FP3XR96h09
         U3GLoNgG7xVPCkMbZ/QZAUzMOS/qB01fny6Ld7gUPlpJwt3nP/yC6gDdEAuXW+bFlElC
         BQaA==
X-Gm-Message-State: ABuFfohc4YOkOnpiIKdhfu7LZZfYpF3q0hdL1sIBJWNLD+qXS8H9mcOu
        444VOi7Qk2zqpS2Cqwoctc1EqZzc45c=
X-Google-Smtp-Source: ACcGV631kxCOA3y7ZPN0lDwI791Gppj5wkS1fk+FHxcoCIT1uhE8TqeJYOtq67puYA9odNEBaHUBnQ==
X-Received: by 2002:a17:902:162:: with SMTP id 89-v6mr12768078plb.91.1538416761191;
        Mon, 01 Oct 2018 10:59:21 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.10.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 10:59:20 -0700 (PDT)
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
Subject: RESEND [PATCH v5 01/12] arm: vdso: rename vdso_datapage variables
Date:   Mon,  1 Oct 2018 10:58:21 -0700
Message-Id: <20181001175845.168430-2-salyzyn@android.com>
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

Rename seq_count to tb_seq_count. Rename tk_is_cntvct to use_syscall.
Rename cs_mult to cs_mono_mult. All to align with the variables in the
arm64 vdso datapage. Rework vdso_read_begin() and vdso_read_retry()
functions to reflect modern access patterns for tb_seq_count field.

Update copyright message to reflect the start of the contributions in
this series.

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
- split first CL into 1 of 7 pieces

v4:
- update commit message to reflect reasoning

v5:
- rebase
---
 arch/arm/include/asm/vdso_datapage.h |  6 +--
 arch/arm/kernel/vdso.c               | 17 ++++----
 arch/arm/vdso/vgettimeofday.c        | 61 +++++++++++++++-------------
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/arch/arm/include/asm/vdso_datapage.h b/arch/arm/include/asm/vdso_datapage.h
index 9be259442fca..fa3e1856244d 100644
--- a/arch/arm/include/asm/vdso_datapage.h
+++ b/arch/arm/include/asm/vdso_datapage.h
@@ -29,8 +29,8 @@
  * 32 bytes.
  */
 struct vdso_data {
-	u32 seq_count;		/* sequence count - odd during updates */
-	u16 tk_is_cntvct;	/* fall back to syscall if false */
+	u32 tb_seq_count;	/* sequence count - odd during updates */
+	u16 use_syscall;	/* fall back to syscall if true */
 	u16 cs_shift;		/* clocksource shift */
 	u32 xtime_coarse_sec;	/* coarse time */
 	u32 xtime_coarse_nsec;
@@ -38,7 +38,7 @@ struct vdso_data {
 	u32 wtm_clock_sec;	/* wall to monotonic offset */
 	u32 wtm_clock_nsec;
 	u32 xtime_clock_sec;	/* CLOCK_REALTIME - seconds */
-	u32 cs_mult;		/* clocksource multiplier */
+	u32 cs_mono_mult;	/* clocksource multiplier */
 
 	u64 cs_cycle_last;	/* last cycle value */
 	u64 cs_mask;		/* clocksource mask */
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index f4dd7f9663c1..c2c57f6b8c60 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -276,14 +276,14 @@ void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
 
 static void vdso_write_begin(struct vdso_data *vdata)
 {
-	++vdso_data->seq_count;
+	++vdso_data->tb_seq_count;
 	smp_wmb(); /* Pairs with smp_rmb in vdso_read_retry */
 }
 
 static void vdso_write_end(struct vdso_data *vdata)
 {
 	smp_wmb(); /* Pairs with smp_rmb in vdso_read_begin */
-	++vdso_data->seq_count;
+	++vdso_data->tb_seq_count;
 }
 
 static bool tk_is_cntvct(const struct timekeeper *tk)
@@ -307,10 +307,10 @@ static bool tk_is_cntvct(const struct timekeeper *tk)
  * counter again, making it even, indicating to userspace that the
  * update is finished.
  *
- * Userspace is expected to sample seq_count before reading any other
- * fields from the data page.  If seq_count is odd, userspace is
+ * Userspace is expected to sample tb_seq_count before reading any other
+ * fields from the data page.  If tb_seq_count is odd, userspace is
  * expected to wait until it becomes even.  After copying data from
- * the page, userspace must sample seq_count again; if it has changed
+ * the page, userspace must sample tb_seq_count again; if it has changed
  * from its previous value, userspace must retry the whole sequence.
  *
  * Calls to update_vsyscall are serialized by the timekeeping core.
@@ -328,18 +328,19 @@ void update_vsyscall(struct timekeeper *tk)
 
 	vdso_write_begin(vdso_data);
 
-	vdso_data->tk_is_cntvct			= tk_is_cntvct(tk);
+	vdso_data->use_syscall			= !tk_is_cntvct(tk);
 	vdso_data->xtime_coarse_sec		= tk->xtime_sec;
 	vdso_data->xtime_coarse_nsec		= (u32)(tk->tkr_mono.xtime_nsec >>
 							tk->tkr_mono.shift);
 	vdso_data->wtm_clock_sec		= wtm->tv_sec;
 	vdso_data->wtm_clock_nsec		= wtm->tv_nsec;
 
-	if (vdso_data->tk_is_cntvct) {
+	if (!vdso_data->use_syscall) {
 		vdso_data->cs_cycle_last	= tk->tkr_mono.cycle_last;
 		vdso_data->xtime_clock_sec	= tk->xtime_sec;
 		vdso_data->xtime_clock_snsec	= tk->tkr_mono.xtime_nsec;
-		vdso_data->cs_mult		= tk->tkr_mono.mult;
+		vdso_data->cs_mono_mult		= tk->tkr_mono.mult;
+		/* tkr_mono.shift == tkr_raw.shift */
 		vdso_data->cs_shift		= tk->tkr_mono.shift;
 		vdso_data->cs_mask		= tk->tkr_mono.mask;
 	}
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index a9dd619c6c29..8cf13af1323c 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -1,18 +1,25 @@
 /*
- * Copyright 2015 Mentor Graphics Corporation.
+ * Userspace implementations of gettimeofday() and friends.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2 of the
- * License.
+ * Copyright (C) 2017 Cavium, Inc.
+ * Copyright (C) 2015 Mentor Graphics Corporation
+ * Copyright (C) 2012 ARM Limited
  *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ * Rewriten from arch64 version into C by: Andrew Pinski <apinski@cavium.com>
+ * Reworked and rebased over arm version by: Mark Salyzyn <salyzyn@android.com>
  */
 
 #include <linux/compiler.h>
@@ -31,32 +38,30 @@
 
 extern struct vdso_data *__get_datapage(void);
 
-static notrace u32 __vdso_read_begin(const struct vdso_data *vdata)
-{
-	u32 seq;
-repeat:
-	seq = READ_ONCE(vdata->seq_count);
-	if (seq & 1) {
-		cpu_relax();
-		goto repeat;
-	}
-	return seq;
-}
-
 static notrace u32 vdso_read_begin(const struct vdso_data *vdata)
 {
 	u32 seq;
 
-	seq = __vdso_read_begin(vdata);
+	do {
+		seq = READ_ONCE(vdata->tb_seq_count);
+
+		if ((seq & 1) == 0)
+			break;
 
-	smp_rmb(); /* Pairs with smp_wmb in vdso_write_end */
+		cpu_relax();
+	} while (true);
+
+	smp_rmb(); /* Pairs with second smp_wmb in update_vsyscall */
 	return seq;
 }
 
 static notrace int vdso_read_retry(const struct vdso_data *vdata, u32 start)
 {
-	smp_rmb(); /* Pairs with smp_wmb in vdso_write_begin */
-	return vdata->seq_count != start;
+	u32 seq;
+
+	smp_rmb(); /* Pairs with first smp_wmb in update_vsyscall */
+	seq = READ_ONCE(vdata->tb_seq_count);
+	return seq != start;
 }
 
 static notrace long clock_gettime_fallback(clockid_t _clkid,
@@ -127,7 +132,7 @@ static notrace u64 get_ns(struct vdso_data *vdata)
 
 	cycle_delta = (cycle_now - vdata->cs_cycle_last) & vdata->cs_mask;
 
-	nsec = (cycle_delta * vdata->cs_mult) + vdata->xtime_clock_snsec;
+	nsec = (cycle_delta * vdata->cs_mono_mult) + vdata->xtime_clock_snsec;
 	nsec >>= vdata->cs_shift;
 
 	return nsec;
@@ -141,7 +146,7 @@ static notrace int do_realtime(struct timespec *ts, struct vdso_data *vdata)
 	do {
 		seq = vdso_read_begin(vdata);
 
-		if (!vdata->tk_is_cntvct)
+		if (vdata->use_syscall)
 			return -1;
 
 		ts->tv_sec = vdata->xtime_clock_sec;
@@ -164,7 +169,7 @@ static notrace int do_monotonic(struct timespec *ts, struct vdso_data *vdata)
 	do {
 		seq = vdso_read_begin(vdata);
 
-		if (!vdata->tk_is_cntvct)
+		if (vdata->use_syscall)
 			return -1;
 
 		ts->tv_sec = vdata->xtime_clock_sec;
-- 
2.19.0.605.g01d371f741-goog

