Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15899C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD34208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="PPzPkDoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD34208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeJBAmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:42:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37058 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeJBAmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:42:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id j23-v6so453309pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sAg4sPW371XoUS8BgWwdN7mYJ3LZ3I5Z3B6wtVLhU0I=;
        b=PPzPkDoc3wQh3ufJMNTfIXs8cVit+nBkS+IzKbwnkmDl+OhvrA1FMBmJHh9cGfJ5Ff
         f1p4D9505pRZr6PMSy3mZ2BJxCyvVO1Uu2mbyE4t/MP+w/WidvXCkwIechtXmqDZfD7N
         hx0amM6kso1wakct4Gh+aNZ0I+nOt5Omg49IgHp+3EjXP8Vbvy624UNTYzAuliFtzEcT
         YAlWxdQROUaUuJ5QPWhwOXvxKBxaf7Hw5Ll3EvOhuhaWCdeV3vhGyxXY9jMS8VIyD5Iw
         smb3C9jsqlAB7vlKURwUPfEuu6OQovxuMLJw6owQ156tzsnbZuGJmZZseJ28B1BVkXgM
         Z8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sAg4sPW371XoUS8BgWwdN7mYJ3LZ3I5Z3B6wtVLhU0I=;
        b=W9+Phot4thshfvYwmcq4EfTcv9pUOc9NwqYRzRUq1ik1c6aYqAVcmYQtkl0Q4JqLrk
         QUFXJBOGc/QzLuZ4eCYcgpU2zYPL1gycP88sSiy8dK1lHCPz5gn5eX1GyBiUBAokcSVR
         0HTECo9AKTlb44GSOeYwwp//0LF0dKwWa3FLFcyI7xrjMlezVOSf9I4UA/RcNUcs65HZ
         H/D16CxtZJp6fJXWbOrWNnzmDzDYOZFjClLDE+2g9IatI91w4fZg4RatNH+20dVzU+GX
         zNiFopQE6aDKVr8FsSURUET5uUdj99AQTt1W9fnB/G7ixvnbM7a1oYMUvOXMQU0W4wfr
         /UEw==
X-Gm-Message-State: ABuFfog0tcYiglhskwlKvdPwDe4qpKFCgJmjfwtl8LJkU2oCUgKZeBVZ
        0tUwtS8c3V2GDV+sKTXqLHRilXpFgUA=
X-Google-Smtp-Source: ACcGV63JwjWf+GPvZlI1Nsu3bgtpnVvJZbDB/roylukpcO5GsYOf7ELGp8CumUl0p82NxIz3iOfkVg==
X-Received: by 2002:a62:f909:: with SMTP id o9-v6mr12724905pfh.160.1538416988212;
        Mon, 01 Oct 2018 11:03:08 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:03:07 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salyzyn <salyzyn@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
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
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: RESEND [PATCH] lib: vdso: add support for time
Date:   Mon,  1 Oct 2018 10:58:33 -0700
Message-Id: <20181001175845.168430-14-salyzyn@android.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Salyzyn <salyzyn@google.com>

Add time() vdso support to match up with existing support in the x86's
vdso.  Currently benefitting arm and arm64 which uses the common
vgettimeofday.c implementation.  On arm provides about a ~14 fold
improvement in speed over the straight syscall, and about a ~5 fold
improvement in speed over an alternate library implementation that
relies on the vdso call to gettimeofday to fulfill the request.

We can provide __vdso_time even if we can not provide a speed
enhanced __vdso_gettimeofday. (arm, virtual counters).

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
---
 arch/arm/kernel/vdso.c            |  1 +
 arch/arm/vdso/vdso.lds.S          |  1 +
 arch/arm64/kernel/vdso/compiler.h |  1 +
 arch/arm64/kernel/vdso/vdso.lds.S |  1 +
 lib/vdso/vgettimeofday.c          | 10 ++++++++++
 5 files changed, 14 insertions(+)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 51d8dcbd9952..6721854c5ae6 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -192,6 +192,7 @@ static void __init patch_vdso(void *ehdr)
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_getres");
+		/* do not zero out __vdso_time, no cntvct_ok dependency */
 	}
 }
 
diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 1d81e8c3acf6..1eb577091d1f 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -83,6 +83,7 @@ VERSION
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_clock_getres;
+		__vdso_time;
 	local: *;
 	};
 }
diff --git a/arch/arm64/kernel/vdso/compiler.h b/arch/arm64/kernel/vdso/compiler.h
index 921a7191b497..fb27545640f2 100644
--- a/arch/arm64/kernel/vdso/compiler.h
+++ b/arch/arm64/kernel/vdso/compiler.h
@@ -65,5 +65,6 @@ static __always_inline notrace u64 arch_vdso_read_counter(void)
 #define __vdso_clock_gettime __kernel_clock_gettime
 #define __vdso_gettimeofday __kernel_gettimeofday
 #define __vdso_clock_getres __kernel_clock_getres
+#define __vdso_time __kernel_time
 
 #endif /* __VDSO_COMPILER_H */
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index beca249bc2f3..9de0ffc369c5 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -88,6 +88,7 @@ VERSION
 		__kernel_gettimeofday;
 		__kernel_clock_gettime;
 		__kernel_clock_getres;
+		__kernel_time;
 	local: *;
 	};
 }
diff --git a/lib/vdso/vgettimeofday.c b/lib/vdso/vgettimeofday.c
index 54e519c99c4b..dfced9608cd3 100644
--- a/lib/vdso/vgettimeofday.c
+++ b/lib/vdso/vgettimeofday.c
@@ -386,3 +386,13 @@ int __vdso_clock_getres(clockid_t clock, struct timespec *res)
 
 	return 0;
 }
+
+notrace time_t __vdso_time(time_t *t)
+{
+	const struct vdso_data *vd = __get_datapage();
+	time_t result = READ_ONCE(vd->xtime_coarse_sec);
+
+	if (t)
+		*t = result;
+	return result;
+}
-- 
2.19.0.605.g01d371f741-goog

