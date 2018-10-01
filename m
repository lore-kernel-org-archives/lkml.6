Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53853C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153E02089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ZdMmVsOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153E02089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJBAkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:40:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38783 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeJBAkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:40:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so9793262pfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jl8w66ZtkNhdtips3F7dVSeZ+uWCx+HUDA6gL1nWgkw=;
        b=ZdMmVsOjMl0Mci3QDghHncrw69hbwShEz1oz7N5JX6u3/qtbzHg1vzAwugBp239Btu
         bhWQnaQUUQvD9pG02/zICNMGB49Us5yYc1qZYn7Q1GTL879z8NznUuO38EGrhkPsS20H
         4e5nPfgln5RWwxqD7EF9I9P9B4SnSsHxDIwSqW4maujJn7wFG2SWqnP/y3Eymsw7Zy29
         4VdrD6TRFnjfR3q9Y4NRhabszohjWfhja8zBb95ys9P/GPdlKKdpw3VHKZhv3aamiabN
         9y2RFlXvrzwSpERxEGhSiXenNVMU/OugEwyWB/W2sVUsopKrv9vMOhAoIhhgm5EBmriM
         vOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jl8w66ZtkNhdtips3F7dVSeZ+uWCx+HUDA6gL1nWgkw=;
        b=aTP/lyJaNmNwIs4ah265Oy8pywei5AAM3y0+hggsJZDEo2mPXD7lFPq6vyxljbc/9O
         fQ0xujqD1kEjTXMsCgcGN4gDrHQAAY2qnEx3z+NH0TJS1G307IhK+aSozKzgSe8fNVAJ
         OFEuL0E+In/t0o1jvi6e8vFsUYuSvlg9IepM3ybK1lR3LVNeabsEQmwc6hBSstVsxK+2
         Jgr6+le6lqPhDgymKHVuDjIGcpFtuxJ8eO9Xb0SMxc+TnvkNXEOYtiYNA69CJyaUuonR
         yPZLqTo2kv38wbkLOVNjNnBfQkrTCYN27DPdcXUQlGQAMa5QGdTyQ7h3/wcjDi9ZMV9H
         +0Bw==
X-Gm-Message-State: ABuFfojOgKjlpjhwPTT/UY8c2bQuPyR1YSZLL9sR9K2c8fZxHveQXE+S
        cHaVsNTXshSBRoh/2b1IaGdSq/QGxHE=
X-Google-Smtp-Source: ACcGV61iwPwDR6ZP0gShH7leGkat+WLLsOD2olYo0JlUPLtUpSHofa3vvN0fGEvOt1pZFEa0FxlPQQ==
X-Received: by 2002:a17:902:7c85:: with SMTP id y5-v6mr9826718pll.200.1538416873771;
        Mon, 01 Oct 2018 11:01:13 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:01:13 -0700 (PDT)
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
        android-kernel@android.com, Mark Salyzyn <salyzyn@google.com>,
        Jinbum Park <jinb.park7@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: RESEND [PATCH v5 06/12] arm: vdso: add support for clock_getres
Date:   Mon,  1 Oct 2018 10:58:26 -0700
Message-Id: <20181001175845.168430-7-salyzyn@android.com>
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

Add clock_getres vdso support to match up with existing support in
the arm64's vdso.

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
2.19.0.605.g01d371f741-goog

