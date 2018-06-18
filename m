Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1323EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B1E20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ejh2by3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B1E20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964824AbeFRPI6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:08:58 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43772 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935277AbeFRPIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:08:55 -0400
Received: by mail-pl0-f66.google.com with SMTP id c41-v6so9188658plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JuvxweFTcRzmxkzWcSbXPEqCe+2P0+NqBKtnGp9jj+k=;
        b=ejh2by3C3GoZQfZUQBH8SjS9wHcIQ0brv8ziSas15/DMUO9ahLj6G139MMTFsTNukM
         amo70KnSKvNCR40rG8V04Znbuuxy5tWMkbvZP5k1JW4yDubFPv7N7HK9oe62L3Wr3B5Y
         kYgvd0SxszOhRhPkF3VMJRE/JSlTvSA/LxJYH+sfSZFrKxyO0+RpvkXHz4Lcyj4rF4IW
         NNZZ9zUzHD6E9Z78uPFUF/oe+18mBEkgd7V+dJw42HkaQR1onLsF82X168PX9tSd22HV
         wlaNsg+WaM/CIti1KZNjkFkZ5H67/WDppgI6BCQURLqpexOk+QnuT8cqECrO7dwOvXk4
         57Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JuvxweFTcRzmxkzWcSbXPEqCe+2P0+NqBKtnGp9jj+k=;
        b=uZyBKYZ6+cPQSusUBL9YJ4Rm4uIBJHzTQ2zxGCEEPMN4gGs380aHP6Tg0VivCtTnuY
         4PIONMhpB9dV+4nM4x7XYupxXgzNF39lmUb241YUXF+7dkIGR1MMyOyFVvnJIQSVHb5q
         sdq8Yw689C2w5tH/g3MhIbEKFnisRJzCJ/MRHvch5Z/RzZdY5L5ldQN3W2MvaF5S8mI9
         zpCcH1ZnJ/C5uBA5gYSGenWh5yuLkd6X8pgyFFn1aXs0142pKzIkYW5b82QqPOqZTD3q
         4OCaWQfOoYo67N3m9mACcTg6N8AZandPfCEFUL+m9DkJ5rvNmvnq2v/WwuDoZeJVncgY
         xrPA==
X-Gm-Message-State: APt69E1CM6ciD6sYBsUs9y0/19wolDxMLgaTn5+u3sTewGpgmo3SzR6O
        QM7QZ4GHosZMo5oPLAh0LJYq+IhGPXY=
X-Google-Smtp-Source: ADUXVKJ53ifwjLYnJ5qcqXYb5JETAwCfDTJpGkr0I33/QwM3QjmHoXT8AkDvoR/2iVh6rTuVKl22EQ==
X-Received: by 2002:a17:902:ba8a:: with SMTP id k10-v6mr14493245pls.338.1529334534977;
        Mon, 18 Jun 2018 08:08:54 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:08:54 -0700 (PDT)
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
        Jinbum Park <jinb.park7@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: RESEND [PATCH] lib: vdso: add support for time
Date:   Mon, 18 Jun 2018 08:05:59 -0700
Message-Id: <20180618150613.10322-14-salyzyn@android.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618150613.10322-1-salyzyn@android.com>
References: <20180618150613.10322-1-salyzyn@android.com>
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
2.18.0.rc1.244.gcf134e6275-goog

